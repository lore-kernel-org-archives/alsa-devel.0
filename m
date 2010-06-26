From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Sat, 26 Jun 2010 21:09:39 +0100
Message-ID: <877258B5-0752-473E-920C-CFD529858C4B@opensource.wolfsonmicro.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<1277565285-11563-2-git-send-email-anarsoul@gmail.com>
	<F58F893B-1539-4999-817E-8B2C4E871FB7@opensource.wolfsonmicro.com>
	<201006261953.43884.anarsoul@gmail.com>
	(sfid-20100626_175353_751336_FB277FA1)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 155342448F
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 22:09:44 +0200 (CEST)
In-Reply-To: <201006261953.43884.anarsoul@gmail.com>
	(sfid-20100626_175353_751336_FB277FA1)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gMjYgSnVuIDIwMTAsIGF0IDE3OjUzLCBWYXNpbHkgS2hvcnV6aGljayB3cm90ZToKCj4g0JIg
0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjYg0LjRjtC90Y8gMjAxMCAxOTo0MDozNyDQsNCy0YLQ
vtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cgo+PiBUaGlzIGlzIGZpbmUgYnV0IGl0J2Qg
YmUgcmVhbGx5IG5pY2UgdG8gcHJlc2VydmUgdGhlIHVzZSBvZiBHUElPcyBzaW5jZQo+PiB0aGF0
IHdpbGwgY292ZXIgdGhlIG1ham9yaXR5IG9mIG1hY2hpbmVzIC0gZm9yIGV4YW1wbGUsIGJ5IHBy
b3ZpZGluZyBhCj4+IGRlZmF1bHQgY2FsbGJhY2sgaWYgbm9uZSBpcyBwcm92aWRlZCBhbmQgR1BJ
T3MgYXJlLiBUaGlzIHdpbGwgYWxzbwo+PiBhdm9pZCB0aGUgbmVlZCB0byB1cGRhdGUgZXhpc3Rp
bmcgbWFjaGluZSBkcml2ZXJzICh3aGljaCBuZWVkcyB0byBiZQo+PiBkb25lIG90aGVyd2lzZSku
Cgo+IFRoZSBvbmx5IG1hY2hpbmUgdGhhdCB1c2VzIHVkYTEzODAgYW5kIHN1cHBvcnRlZCBieSBt
YWlubGluZSBrZXJuZWwgaXMgCj4gbWFnaWNpYW4sIHJ4MTk1MCBhbmQgaDE5NDAgc291bmQgc3Vw
cG9ydCBpcyBub3QgbWVyZ2VkIHlldCwgc28gdGhhdCdzIG5vdCBhIAo+IHByb2JsZW0gdG8gcGVy
Zm9ybSB0aGF0IGNoYW5nZS4KCkl0J3Mgbm90IGp1c3QgdGhlIGhhc3NsZSwgaXQncyBhbHNvIHRo
ZSBmYWN0IHRoYXQgYWxsIHRoZXNlIG1hY2hpbmUgZHJpdmVycyB3aWxsIGVuZAp1cCBkdXBsaWNh
dGluZyB0aGUgY29kZS4gVGhpcyBmZWVscyBsaWtlIGEgc3RlcCBiYWNrIGZvciBtYWNoaW5lcyBv
dGhlciB0aGFuCnlvdXJzLgoKPj4gSG93ZXZlciwgSSBkbyB3b25kZXIgaWYgdGhlIG1vcmUgY29t
cGxleCBzZXRfcG93ZXIoKSBjYWxsYmFja3MgbWlnaHQKPj4gbm90IGp1c3QgZW5kIHVwIGFzIHJl
Z3VsYXRvciBBUEkgY29uc3VtZXJzPwoKPiBJcyBpdCByZWFsbHkgbmVjZXNzYXJ5PyBQbGFpbiBj
YWxsYmFjayBwZXJmZWN0bHkgZml0cyBoZXJlLCBhbmQgc2FtZSBhcHByb2FjaCAKPiBpcyB1c2Vk
IGZvciBzM2NtY2kgZHJpdmVyLiBGb3IgZXhhbXBsZSwgcngxOTUwX3VkYTEzODBfc2V0X3Bvd2Vy
IGlzIG5vdCAKPiBjb21wbGV4IGFuZCBsb29rcyBsaWtlIHRoaXM6CgpUaGUgcmVndWxhdG9yIEFQ
SSBpc24ndCBtYXNzaXZlbHkgY29tcGxleCBlaXRoZXIgYW5kIGl0IGRvZXMgcHJvdmlkZSBhIHN0
YW5kYXJkCmFic3RyYWN0aW9uIGZvciBjb250cm9sbGluZyBwb3dlciB3aGljaCBzZWVtcyBsaWtl
IGl0IG1pZ2h0IGJlIHVzZWZ1bCBoZXJlLAp0aG91Z2ggZ2l2ZW4gdGhlIChmcmFua2x5IHJhdGhl
ciBvZGQpIGZpZGRsaW5nIHdpdGggY2xvY2tzIHlvdXIgY2FsbGJhY2sgZG9lcwpwZXJoYXBzIGl0
IHdvbid0IGhlbHAuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
