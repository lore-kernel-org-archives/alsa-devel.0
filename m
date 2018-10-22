From: Hyperion <h1p8r10n@yandex.com>
Subject: Segfault in pulseaudio since Alsa 1.1.7
Date: Mon, 22 Oct 2018 23:30:30 +0200
Message-ID: <28620521540243830@myt3-4bff4d415901.qloud-c.yandex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward106o.mail.yandex.net (forward106o.mail.yandex.net
 [37.140.190.187])
 by alsa0.perex.cz (Postfix) with ESMTP id B935A2677D0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 23:30:31 +0200 (CEST)
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::114])
 by forward106o.mail.yandex.net (Yandex) with ESMTP id C4D9C786C37
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 00:30:30 +0300 (MSK)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

ICAgSGksCgogICDDggoKICAgU2luY2UgdGhlIHVwZ3JhZGUgdG8gQWxzYSAxLjEuNywgSSBnZXQg
YSBzZWdmYXVsdCBhdCBwdWxzZWF1ZGlvCiAgIHN0YXJ0dXAuIFRoaXMgaGF2ZSBiZWVuIGRpc2N1
c3NlZCBhbmQgZG9jdW1lbnRlZCBoZXJlIDoKICAgWzFdaHR0cHM6Ly93d3cubGludXhxdWVzdGlv
bnMub3JnL3F1ZXN0aW9ucy9zbGFja3dhcmUtMTQvY3VycmVudC1mcmktb2MKICAgdC0xOS1wdXNl
YXVkaW8tc2VnZmF1dHMtNDE3NTY0MDc3My8KCiAgIMOCCgogICBJdCBzZWVtcyB0aGF0IEkgZm91
bmQgdGhlIG9yaWdpbiBvZiB0aGUgYnVnIDogcmV2ZXJ0aW5nIHRoZXNlIDIgY29tbWl0cwogICBm
aXhlcyB0aGUgcHJvYmxlbSA6CiAgIFsyXWh0dHA6Ly9naXQuYWxzYS1wcm9qZWN0Lm9yZy8/cD1h
bHNhLS4uLjc5MmRjODA5YzkwOGNjCiAgIFszXWh0dHA6Ly9naXQuYWxzYS1wcm9qZWN0Lm9yZy8/
cD1hbHNhLS4uLjVkYzZlMTU5NDI5MWU3CgogICBUaGVuIG5vIG1vcmUgc2VnZmF1bHQgaW4gcHVs
c2VhdWRpbyB3aGVuIGFjY2Vzc2luZyB0aGUgVVNCIHNvdW5kY2FyZC4KCiAgIMOCCgogICBQbGVh
c2UgY291bGQgeW91IGZpeCBpdCA/CgogICDDggoKICAgUmVnYXJkcwoKICAganAKClJlZmVyZW5j
ZXMKCiAgIFZpc2libGUgbGlua3MKICAgMS4gaHR0cHM6Ly93d3cubGludXhxdWVzdGlvbnMub3Jn
L3F1ZXN0aW9ucy9zbGFja3dhcmUtMTQvY3VycmVudC1mcmktb2N0LTE5LXB1c2VhdWRpby1zZWdm
YXV0cy00MTc1NjQwNzczLwogICAyLiBodHRwOi8vZ2l0LmFsc2EtcHJvamVjdC5vcmcvP3A9YWxz
YS1wbHVnaW5zLmdpdDthPWNvbW1pdGRpZmY7aD1mYzNmNWQ1MTA2MmZmNDM4NzgwZTU2ODk5NTc5
MmRjODA5YzkwOGNjCiAgIDMuIGh0dHA6Ly9naXQuYWxzYS1wcm9qZWN0Lm9yZy8/cD1hbHNhLXBs
dWdpbnMuZ2l0O2E9Y29tbWl0ZGlmZjtoPTZiOTk2ODY1MTI2ZGQ1NTllZjE4NjAwMmU0NWRjNmUx
NTk0MjkxZTcKCiAgIEhpZGRlbiBsaW5rczoKICAgNC4gaHR0cHM6Ly93d3cubGludXhxdWVzdGlv
bnMub3JnL3F1ZXN0aW9ucy9zbGFja3dhcmUtMTQvY3VycmVudC1mcmktb2N0LTE5LXB1c2VhdWRp
by1zZWdmYXV0cy00MTc1NjQwNzczLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
