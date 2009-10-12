From: Barry Song <21cnbao@gmail.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Mon, 12 Oct 2009 18:34:56 +0800
Message-ID: <3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id E222F103870
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 12:35:16 +0200 (CEST)
Received: by ywh33 with SMTP id 33so2972644ywh.23
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2009 03:35:16 -0700 (PDT)
In-Reply-To: <20091012093601.GA22233@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBPY3QgMTIsIDIwMDkgYXQgNTozNiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIE1vbiwgT2N0IDEyLCAyMDA5IGF0
IDEwOjI2OjA5QU0gKzA4MDAsIEJhcnJ5IFNvbmcgd3JvdGU6Cj4KPiBQbGVhc2UgZG9uJ3QgdG9w
IHBvc3QgYW5kIHBsZWFzZSBzdGFydCBuZXcgdGhyZWFkcyBmb3IgbmV3IHRvcGljcy4KPgo+PiBX
ZSB1c2UgbWFueSBnbG9iYWwgdmFyaWFibGVzIGluIGFzb2Mgbm93LCBleGNlcHQgZGVmaW5pbmcg
dHdvL211bHRpCj4+IGdyb3VwcyBvZiBnbG9iYWwgdmFyaWFibGVzIHRvIGZ1bGZpbGwgdHdvL211
bHRpIGNvZGVjcyB3b3JrIGF0IHRoZQo+PiBzYW1lIHRpbWUgaW4gb25lIHN5c3RlbSwgaXMgdGhl
cmUgYW55IG90aGVyIHdheT8KPgo+IENvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljIGFib3V0IHdo
aWNoIHZhcmlhYmxlcyB5b3UgYXJlIHRhbGtpbmcgYWJvdXQKPiBoZXJlPyDCoEluIGdlbmVyYWwg
eW91IHNob3VsZCBqdXN0IHVzZSB0aGUgc3RydWN0IGRldmljZSBkcml2ZXIgZGF0YSBvcgo+IGEg
cHJpdmF0ZSBkYXRhIGZpZWxkIGluIG9uZSBvZiB0aGUgQVNvQyBzdHJ1Y3R1cmVzIGZvciBhbnkg
cGVyLWRldmljZQo+IGRhdGEsIGluIG11Y2ggdGhlIHNhbWUgd2F5IGFzIHlvdSB3b3VsZCBkbyBm
b3IgYW55IG90aGVyIHN5c3RlbS4KPgpMZXQgbWUgdGFrZSB3bTg5MDMgYXMgYW4gZXhhbXBsZS4K
SW4gY29kZWM6CiJzdGF0aWMgc3RydWN0IHNuZF9zb2NfY29kZWMgKndtODkwM19jb2RlYyIgaXMg
YSBnbG9iYWwgdmFyaWFibGUgdG8KZGVzY3JpYmUgYSBjb2RlYy4gIFRoZSBnbG9iYWwgdmFyaWFi
bGUgbGltaXQgdGhlIGNvZGVjIGRyaXZlciBjYW4gb25seQpzdXBwb3J0IG9uZSB0byB3b3JrLgpJ
ZiB3ZSB1c2UgbnVtX2xpbmtzID0gMiwgaXQgc2VlbXMgY29kZWNfZGFpIGZvciB3bTg5MDMgc2hv
dWxkIGJlIGR1cGxpY2F0ZWQgdG9vLgoKSW4gQ1BVIGRhaToKaW4gY2FzZSB0aGVyZSBhcmUgdHdv
IHNhbWUgSTJTIGludGVyZmFjZXMgY29ubmVjdGluZyB0d28gc2FtZSB3bTg5MDMsCnRoZW4gYW4g
YXJyYXkgd2l0aCB0d28gZWxlbWVudHMgZm9yIENQVSBkYWkgaXMgbmVlZGVkLgpGb3IgdGhlIHR3
byBzdHJ1Y3Qgc25kX3NvY19kYWksIGFsbCBmaWVsZHMobGlrZSBwcm9iZSwgcmVtb3ZlKSBhcmUK
c2FtZSBleGNlcHQgcHJpdmF0ZV9kYXRhLgoKSW4gbWFjaGluIGRyaXZlcjoKc25kX3NvY19kYWlf
bGluayBjb25uZWN0IHRoZSBtdWx0aSBzYW1lIENQVSBkYWkgYW5kIGNvZGVjIGRhaSB0b2dldGhl
ci4KCklmIHdlIGRvbid0IHVzZSBudW1fbGlua3MgPTIsIHdlIG5lZWQgdG8gY2FsbApwbGF0Zm9y
bV9kZXZpY2VfYWxsb2MoInNvYy1hdWRpbyIsLi4uKS9wbGF0Zm9ybV9kZXZpY2VfYWRkKCkgdHdp
Y2UKd2l0aCBkdXBsaWNhdGVkIHN0cnVjdCBzbmRfc29jX2RldmljZS4KCkRvbid0IGtub3cgd2hl
dGhlciBJIGxvc3Qgc29tZXRoaW5nLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
