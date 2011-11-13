From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: Remove unused control_data and mutex
 fields from struct alc5632_priv
Date: Sun, 13 Nov 2011 21:47:59 +0200
Message-ID: <CALq1K=KZVhVMXWhrq0MeBOvr7kXjdRe7yxVdqdCg4HBuD3FB-g@mail.gmail.com>
References: <1321156588.23115.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 502AC2439F
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 20:48:21 +0100 (CET)
Received: by wyg36 with SMTP id 36so2858460wyg.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 11:48:20 -0800 (PST)
In-Reply-To: <1321156588.23115.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBOb3YgMTMsIDIwMTEgYXQgMDU6NTYsIEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5j
b20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+
Cj4gLS0tCj4gwqBzb3VuZC9zb2MvY29kZWNzL2FsYzU2MzIuYyB8IMKgIMKgNCAtLS0tCj4gwqAx
IGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL2FsYzU2MzIuYyBiL3NvdW5kL3NvYy9jb2RlY3MvYWxj
NTYzMi5jCj4gaW5kZXggZWU2YTQ5Ny4uYmZiNDhiYSAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2Mv
Y29kZWNzL2FsYzU2MzIuYwo+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3MvYWxjNTYzMi5jCj4gQEAg
LTY4LDggKzY4LDYgQEAgc3RhdGljIGNvbnN0IHUxNiBhbGM1NjMyX3JlZ19kZWZhdWx0c1tdID0g
ewo+IMKgLyogY29kZWMgcHJpdmF0ZSBkYXRhICovCj4gwqBzdHJ1Y3QgYWxjNTYzMl9wcml2IHsK
PiDCoCDCoCDCoCDCoGVudW0gc25kX3NvY19jb250cm9sX3R5cGUgY29udHJvbF90eXBlOwo+IC0g
wqAgwqAgwqAgdm9pZCAqY29udHJvbF9kYXRhOwo+IC0gwqAgwqAgwqAgc3RydWN0IG11dGV4IG11
dGV4Owo+IMKgIMKgIMKgIMKgdTggaWQ7Cj4gwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgc3lzY2xr
Owo+IMKgfTsKPiBAQCAtMTA5Miw5ICsxMDkwLDcgQEAgc3RhdGljIGludCBhbGM1NjMyX2kyY19w
cm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LAo+IMKgIMKgIMKgIMKgfQo+Cj4gwqAgwqAg
wqAgwqBpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBhbGM1NjMyKTsKPiAtIMKgIMKgIMKgIGFs
YzU2MzItPmNvbnRyb2xfZGF0YSA9IGNsaWVudDsKPiDCoCDCoCDCoCDCoGFsYzU2MzItPmNvbnRy
b2xfdHlwZSA9IFNORF9TT0NfSTJDOwo+IC0gwqAgwqAgwqAgbXV0ZXhfaW5pdCgmYWxjNTYzMi0+
bXV0ZXgpOwo+Cj4gwqAgwqAgwqAgwqByZXQgPSDCoHNuZF9zb2NfcmVnaXN0ZXJfY29kZWMoJmNs
aWVudC0+ZGV2LAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnNvY19jb2RlY19kZXZpY2VfYWxj
NTYzMiwgJmFsYzU2MzJfZGFpLCAxKTsKPiAtLQo+IDEuNy41LjQKVGhhbmtzLAoKTWFyaywgTGlh
bSBkbyBJIG5lZWQgdG8gc2lnbiBBY2tlZC1PZmYtQnkgb24gdGhpcyB0eXBlIG9mIHBhdGNoPwoK
CgotLSAKTGVvbiBSb21hbm92c2t5IHwgSW5kZXBlbmRlbnQgTGludXggQ29uc3VsdGFudArCoCDC
oCDCoCDCoMKgd3d3Lmxlb24ubnXCoHwgbGVvbkBsZW9uLm51Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
