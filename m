From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V3 3/4] ASoC: SAMSUNG: Modify I2S driver to
	support idma
Date: Sun, 26 Jun 2011 14:27:14 +0530
Message-ID: <BANLkTim9+b6Pi7gtfMTMgab7iapmyaUadA@mail.gmail.com>
References: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
	<1308555381-4419-3-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0FADB246E2
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jun 2011 10:57:16 +0200 (CEST)
Received: by bwa18 with SMTP id 18so729670bwa.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2011 01:57:14 -0700 (PDT)
In-Reply-To: <1308555381-4419-3-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKdW4gMjAsIDIwMTEgYXQgMTowNiBQTSwgU2FuZ2Jlb20gS2ltIDxzYmtpbTczQHNh
bXN1bmcuY29tPiB3cm90ZToKPiArCj4gKyDCoCDCoCDCoCBpZiAoaXNfc2Vjb25kYXJ5KGkycykp
IHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFoYiB8PSAoQUhCX0RNQVJMRCB8IEFIQl9JTlRN
QVNLKTsKCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtb2QgfD0gTU9EX1RYU19JRE1BOwpUaGlz
IHVuY29uZGl0aW9uYWwgc2V0dGluZyBzdGVhbHRoaWx5IHN3aXRjaGVzIHRvIHVzaW5nIGlETUEu
IFNvcnJ5IEkKZGlkbid0IG5vdGljZSBpdCBpbiBsYXN0IHJldmlzaW9uLgoKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHdyaXRlbChhaGIsIGkycy0+YWRkciArIEkyU0FIQik7Cj4gKyDCoCDCoCDC
oCB9Cj4gKwpJIG1lYW50LCB0aGlzIGlzIF9kbWFfIHJlbGF0ZWQgc2V0dGluZyBvZiBwb3N0LTI0
eHgKU28gaXQgaGFkIGJldHRlciBiZSBkb25lIGluIGh3X3BhcmFtcyBvZiBpZG1hLmMKCj4gQEAg
LTEwNjgsNiArMTA3OSw4IEBAIHN0YXRpYyBfX2RldmluaXQgaW50IHNhbXN1bmdfaTJzX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXQgPSAtRU5PTUVNOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ290byBlcnIyOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaWRtYV9yZWdfYWRkcl9pbml0KCh2b2lkICopaW9yZW1hcChyZWdzX2Jhc2Us
IDB4MTAwKSwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGkyc19jZmctPmlkbWFfYWRkcik7CgpPaCBkZWFyISBOb3QgYSBncmVhdCBp
ZGVhIHRvIGRvIG11bHRpcGxlIG1hcHBpbmcsIGV2ZW4gd29yc2UgaXMgZG9pbmcKaXQgdHJhbnNp
ZW50bHkgZHVyaW5nIGEgZnVuY3Rpb24gY2FsbC4KUGVyaGFwcyBwcm92aWRlIGJhc2UgYW5kIGlC
dWZmIGFkZHJlc3MgdmlhIHBsYXRmb3JtIGRhdGEgb2Ygc2Ftc3VuZy1pZG1hCmFuZCBwYXNzIG9u
bHkgX29uY2VfIGlvcmVtYXAnZWQgYWRkcmVzcyBmcm9tIGhlcmUuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
