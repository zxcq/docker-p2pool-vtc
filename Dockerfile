FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y ca-certificates git python-rrdtool python-pygame python-scipy python-twisted python-twisted-web python-imaging && \
    git clone https://github.com/vertcoin/p2pool-vtc.git && \
    cd p2pool-vtc/lyra2re-hash-python && \
    git submodule init && \
    git submodule update && \
    python setup.py install && \
    cd /p2pool-vtc/web-static && rm -rf * &&  git clone http://github.com/justino/p2pool-ui-punchy.git . && \
    apt-get purge -y ca-certificates git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

COPY ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*
ADD config.json /p2pool-vtc/web-static/js	
ADD custom_content.html /p2pool-vtc/web-static
VOLUME ["/data"]
ENV HOME /data
WORKDIR /data

EXPOSE 9171 9346

ENTRYPOINT ["init"]
