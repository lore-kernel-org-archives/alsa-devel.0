From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Sat, 26 Jun 2010 21:57:42 +0100
Message-ID: <8308AEB2-F7DB-4C48-AAED-719311AF7A42@opensource.wolfsonmicro.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006261953.43884.anarsoul@gmail.com>
	<877258B5-0752-473E-920C-CFD529858C4B@opensource.wolfsonmicro.com>
	<201006262353.58897.anarsoul@gmail.com>
	(sfid-20100626_215408_275919_C481DE9E)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1866A244DE
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 22:57:44 +0200 (CEST)
In-Reply-To: <201006262353.58897.anarsoul@gmail.com>
	(sfid-20100626_215408_275919_C481DE9E)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gMjYgSnVuIDIwMTAsIGF0IDIxOjUzLCBWYXNpbHkgS2hvcnV6aGljayB3cm90ZToKCj4g0JIg
0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjYg0LjRjtC90Y8gMjAxMCAyMzowOTozOSDQsNCy0YLQ
vtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cj4gCj4+IFRoZSByZWd1bGF0b3IgQVBJIGlz
bid0IG1hc3NpdmVseSBjb21wbGV4IGVpdGhlciBhbmQgaXQgZG9lcyBwcm92aWRlIGEKPj4gc3Rh
bmRhcmQgYWJzdHJhY3Rpb24gZm9yIGNvbnRyb2xsaW5nIHBvd2VyIHdoaWNoIHNlZW1zIGxpa2Ug
aXQgbWlnaHQgYmUKPj4gdXNlZnVsIGhlcmUsIHRob3VnaCBnaXZlbiB0aGUgKGZyYW5rbHkgcmF0
aGVyIG9kZCkgZmlkZGxpbmcgd2l0aCBjbG9ja3MKPj4geW91ciBjYWxsYmFjayBkb2VzIHBlcmhh
cHMgaXQgd29uJ3QgaGVscC4KPiAKPiBPaywgYnV0IEkgc3RpbGwgZG9uJ3QgbGlrZSBpZGVhIGFi
b3V0IGtlZXBpbmcgYm90aCByZWd1bGF0b3IgYW5kIGdwaW8gc3R1ZmYuIAoKSWYgeW91J3JlIGdv
aW5nIHRvIHRoZSByZWd1bGF0b3IgQVBJIGl0J3MgcHJvYmFibHkgT0sgdG8gcmVtb3ZlIHRoZSBH
UElPIHN0dWZmCnNpbmNlIHRoZSByZWd1bGF0b3IgQVBJIHN1cHBvcnRzIEdQSU8gY29udHJvbGxl
ZCByZWd1bGF0b3JzIGFscmVhZHkuIERvZXMKbWVhbiB0cmFuc2l0aW9uaW5nIHRoZSBleGlzdGlu
ZyBkcml2ZXJzIGJ1dCBpdCBtZWFucyBldmVyeW9uZSBzaGFyZXMgdGhlIHNhbWUKY29kZS4KCj4g
QnR3LCB0aGlzIHdlaXJkIGNsb2NrIHN0dWZmIGNhbiBiZSBtZXJnZWQgdG8gaTJjIGRyaXZlciwg
aS5lLiBrZWVwIGkyYyBtb2R1bGUgCj4gY2xvY2sgZW5hYmxlZCBvbmx5IG9uIGkyYyB0cmFuc2Zl
ciAoaXQncyBub3Qgc2NsIGxpbmUsIGl0J3MgbW9kdWxlIGNsb2NrKSAKPiAoSSd2ZSBzZW50IHBh
dGNoIGZvciBpMmMtczNjMjQxMCB+bW9udGggYWdvLCBjYW4gcmVzZW5kIGl0KSwgYW5kIHdlIGNh
biBhdm9pZCAKPiBtb2R5ZmluZyBwb3dlci9yZXNldCBjb250cm9sbGluZyBwYXJ0IG9mIHVkYTEz
ODAgZHJpdmVyLiBXaGF0IGRvIHlvdSB0aGluayAKPiBhYm91dCB0aGF0PwoKWW91IGRlZmluaXRl
bHkgc2hvdWxkIGJlIGRvaW5nIHRoaXMgaW4gdGhlIEkyQyBkcml2ZXIgbm90IHRoZSBDT0RFQyBk
cml2ZXIsCnlvdSdyZSBwZWVyaW5nIGluc2lkZSB0aGUgaW50ZXJuYWxzIG9mIHRoZSBJMkMgZHJp
dmVyIGFzIHRoaW5ncyBzdGFuZCBhbmQgYXJlCmxpa2VseSB0byBjYXVzZSBwcm9ibGVtcyBpZiBz
b21lb25lIGNvbWVzIGFsb25nIGFuZCBpbXBsZW1lbnRzIHRoaXMgaW4gdGhlCmRyaXZlci4gVGhl
cmUncyBhbHNvIHRoZSBmYWN0IHRoYXQgYWxsIHVzZXJzIG9mIHRoZSBJMkMgY29udHJvbGxlciB3
aWxsIGJlbmVmaXQgaWYKdGhlIGNvZGUgaXMgaW1wbGVtZW50ZWQgdGhlcmUsIG5vdCBqdXN0IHRo
aXMgb25lIGF1ZGlvIGRyaXZlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
