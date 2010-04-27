From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 01/11] ASoC: S3C: I2Sv2: Move defines
	closer to driver
Date: Tue, 27 Apr 2010 16:07:38 +0900
Message-ID: <m2z1b68c6791004270007ya60e534emd7ba724b724a3d14@mail.gmail.com>
References: <1272351321-3688-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id E4DAE2482E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:07:39 +0200 (CEST)
Received: by vws19 with SMTP id 19so640664vws.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 00:07:39 -0700 (PDT)
In-Reply-To: <1272351321-3688-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBcHIgMjcsIDIwMTAgYXQgMzo1NSBQTSwgSmFzc2kgQnJhciA8amFzc2kuYnJhckBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4gVGhlIGhlYWRlciBmb3IgSTJTdjIKPiDCoCBsaW51eC9hcmNo
L2FybS9wbGF0LXMzYy9pbmNsdWRlL3BsYXQvcmVncy1zM2MyNDEyLWlpcy5oCj4gY29udGFpbnMg
b25seSBjb250cm9sbGVyIHNwZWNpZmljIGRlZmluaXRpb25zIGFuZCBub3RoaW5nCj4gU29DIHNw
ZWNpZmljLiBTbywgaXQgY291bGQgYmUgbW92ZWQgdG8gc291bmQvc29jL3MzYzI0eHgvCj4KPiBT
aWduZWQtb2ZmLWJ5OiBKYXNzaSBCcmFyIDxqYXNzaS5icmFyQHNhbXN1bmcuY29tPgo+IC0tLQo+
IMKgLi4uL3BsYXQtc2Ftc3VuZy9pbmNsdWRlL3BsYXQvcmVncy1zM2MyNDEyLWlpcy5oIMKgIHwg
wqAgODIgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiDCoHNvdW5kL3NvYy9zM2MyNHh4L3JlZ3MtaTJz
LXYyLmggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIDgyICsrKysrKysrKysrKysr
KysrKysrCj4gwqBzb3VuZC9zb2MvczNjMjR4eC9zM2MtaTJzLXYyLmMgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfCDCoCDCoDMgKy0KPiDCoHNvdW5kL3NvYy9zM2MyNHh4L3MzYzI0MTIt
aTJzLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMyArLQo+IMKgc291bmQv
c29jL3MzYzI0eHgvczNjNjR4eC1pMnMuYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwg
wqAgwqAyICstCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDg3IGRlbGV0
aW9ucygtKQo+IMKgZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL3BsYXQtc2Ftc3VuZy9pbmNs
dWRlL3BsYXQvcmVncy1zM2MyNDEyLWlpcy5oCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgc291bmQv
c29jL3MzYzI0eHgvcmVncy1pMnMtdjIuaAo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQt
c2Ftc3VuZy9pbmNsdWRlL3BsYXQvcmVncy1zM2MyNDEyLWlpcy5oIGIvYXJjaC9hcm0vcGxhdC1z
YW1zdW5nL2luY2x1ZGUvcGxhdC9yZWdzLXMzYzI0MTItaWlzLmgKPiBkZWxldGVkIGZpbGUgbW9k
ZSAxMDA2NDQKClRoZSBoZWFkZXIgaGFzIGJlZW4gbW92ZWQgYnkgJ2dpdCBtdicgc28gdGhlcmUg
aXMgYWJzb2x1dGVseSBubyBjaGFuZ2UuCkkganVzdCBmb3Jnb3QgdG8gZ2l2ZSAtTSBvcHRpb24g
dG8gZm9ybWF0LXBhdGNoLiBTb3JyeS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
