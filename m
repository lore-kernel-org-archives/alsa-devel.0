From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 6/7] ASoC: S3C64XX: Pass I2S base address
	from platform data
Date: Wed, 9 Dec 2009 20:14:24 +0900
Message-ID: <1b68c6790912090314v379883deofaf71199e9d1bcb3@mail.gmail.com>
References: <1260332994-11535-1-git-send-email-jassisinghbrar@gmail.com>
	<20091209110900.GE19851@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 29B2C103873
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:14:25 +0100 (CET)
Received: by pwi11 with SMTP id 11so3721692pwi.32
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 03:14:25 -0800 (PST)
In-Reply-To: <20091209110900.GE19851@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBEZWMgOSwgMjAwOSBhdCA4OjA5IFBNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBEZWMgMDksIDIwMDkgYXQg
MDE6Mjk6NTRQTSArMDkwMCwgamFzc2lzaW5naGJyYXJAZ21haWwuY29tIHdyb3RlOgo+Cj4+ICsK
Pj4gKyDCoCDCoCBpZiAoIXJlcXVlc3RfbWVtX3JlZ2lvbihyZXMtPnN0YXJ0LCByZXNvdXJjZV9z
aXplKHJlcyksCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgInMzYzY0eHgtaTJzIikpIHsKPj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyKCZwZGV2LT5kZXYsICJVbmFibGUgdG8gcmVxdWVz
dCBTRlIgcmVnaW9uXG4iKTsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVCVVNZOwo+
PiArIMKgIMKgIH0KPj4gKwo+Cj4gVGhpcyBmZWVscyBsaWtlIGl0IHNob3VsZCBiZSBpbiB0aGUg
cGF0Y2ggdGhhdCByZXF1ZXN0ZWQgdGhlIHJlc291cmNlCj4gcmF0aGVyIHRoYW4gaGVyZS4gwqBQ
cm9iYWJseSBvdWdodCB0byBoYXZlIGEgdmVyc2lvbiB0aGF0IGRvZXMgdGhlCj4gcmVxdWVzdCBp
biAyLjYuMzMgdG9vIGlmIHdlIGNhbi4uLgp0aGF0IHBhdGNoIGlzIG9ubHkgZm9yIHNldHRpbmcg
RE1BIGNoYW5uZWwgYW5kIGRzdCBhZGRyZXNzZXMsIHNvIHdlCnJlcXVlc3QgTUVNIHJlc291cmNl
IHRoZXJlLgoKPj4gQEAgLTE5MSw3ICsxOTgsOCBAQCBzdGF0aWMgX19kZXZpbml0IGludCBzM2M2
NHh4X2lpc19kZXZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4KPj4gwqAg
wqAgwqAgY2xrX2VuYWJsZShpMnMtPmlpc19jY2xrKTsKPj4KPj4gLSDCoCDCoCByZXQgPSBzM2Nf
aTJzdjJfcHJvYmUocGRldiwgZGFpLCBpMnMsIDApOwo+PiArIMKgIMKgIHJldCA9IHMzY19pMnN2
Ml9wcm9iZShwZGV2LCBkYWksIGkycywKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpMnMtPmRtYV9wbGF5YmFjay0+ZG1hX2FkZHIgLSBTM0MyNDEyX0lJU1RYRCk7Cj4+IMKgIMKg
IMKgIGlmIChyZXQpCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyX2NsazsKPgo+IEEg
Y29tbWVudCBleHBsYWluaW5nIHdoeSB3ZSdyZSBkb2luZyB0aGUgc3VidHJhY3Rpb24gd291bGRu
J3QgaHVydDsgdGhlCj4gY29kZSBpcyBPSy4KaXRzIGp1c3QgdGhhdCBpIGRpZG4ndCB3YW50IHRv
IHJlb3JkZXIgdGhlIGNvZGUgYW5kIE1FTSByZXNvdXJjZSB3YXMgcmVxdWVzdGVkCmludG8gYSB0
ZW1wb3JhcnkgdmFyaWFibGUgJ3Jlcycgbm90IGltbWVkaWF0ZWx5IGJlZm9yZSB0aGlzIGNhbGwu
IEF0IHRoaXMgcG9pbnQKcmVzLT5zdGFydCBzaG91bGQgZG8gdG9vIHRob3VnaC4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
