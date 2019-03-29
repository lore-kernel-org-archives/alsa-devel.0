From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 02/10] extcon: axp288: Convert to use
	acpi_dev_get_first_match_dev()
Date: Fri, 29 Mar 2019 23:58:47 +0100
Message-ID: <3488798.d5z7iexCG2@aspire.rjw.lan>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <20190328171729.44002-3-andriy.shevchenko@linux.intel.com>
 <c5090422-e707-a774-f3ab-b5bf49cd6851@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A53B1F80766
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2019 00:00:51 +0100 (CET)
In-Reply-To: <c5090422-e707-a774-f3ab-b5bf49cd6851@samsung.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpZGF5LCBNYXJjaCAyOSwgMjAxOSAxOjUzOjA5IEFNIENFVCBDaGFud29vIENob2kgd3Jv
dGU6Cj4gSGkgQW5keSwKPiAKPiBPbiAxOS4gMy4gMjkuIOyYpOyghCAyOjE3LCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6Cj4gPiBhY3BpX2Rldl9nZXRfZmlyc3RfbWF0Y2hfbmFtZSgpIGlzIGRlcHJl
Y2F0ZWQgYW5kIGdvaW5nIHRvIGJlIHJlbW92ZWQKPiA+IGJlY2F1c2UgaXQgbGVha3MgYSByZWZl
cmVuY2UuCj4gPiAKPiA+IENvbnZlcnQgdGhlIGRyaXZlciB0byB1c2UgYWNwaV9kZXZfZ2V0X2Zp
cnN0X21hdGNoX2RldigpIGluc3RlYWQuCj4gPiAKPiA+IENjOiBDaGFud29vIENob2kgPGN3MDAu
Y2hvaUBzYW1zdW5nLmNvbT4KPiA+IENjOiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1z
dW5nLmNvbT4KPiA+IENjOiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvZXh0Y29uL2V4dGNvbi1heHAyODguYyB8IDkgKysrKyst
LS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
PiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi1heHAyODguYyBiL2Ry
aXZlcnMvZXh0Y29uL2V4dGNvbi1heHAyODguYwo+ID4gaW5kZXggYTk4MzcwOGI3N2E2Li41MGY5
NDAyZmIzMjUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2V4dGNvbi9leHRjb24tYXhwMjg4LmMK
PiA+ICsrKyBiL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi1heHAyODguYwo+ID4gQEAgLTMzMyw3ICsz
MzMsNyBAQCBzdGF0aWMgaW50IGF4cDI4OF9leHRjb25fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKPiA+ICAJc3RydWN0IGF4cDI4OF9leHRjb25faW5mbyAqaW5mbzsKPiA+ICAJ
c3RydWN0IGF4cDIweF9kZXYgKmF4cDIweCA9IGRldl9nZXRfZHJ2ZGF0YShwZGV2LT5kZXYucGFy
ZW50KTsKPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKPiA+IC0JY29uc3Qg
Y2hhciAqbmFtZTsKPiA+ICsJc3RydWN0IGFjcGlfZGV2aWNlICphZGV2Owo+ID4gIAlpbnQgcmV0
LCBpLCBwaXJxOwo+ID4gIAo+ID4gIAlpbmZvID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNp
emVvZigqaW5mbyksIEdGUF9LRVJORUwpOwo+ID4gQEAgLTM1Nyw5ICszNTcsMTAgQEAgc3RhdGlj
IGludCBheHAyODhfZXh0Y29uX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4g
PiAgCQlpZiAocmV0KQo+ID4gIAkJCXJldHVybiByZXQ7Cj4gPiAgCj4gPiAtCQluYW1lID0gYWNw
aV9kZXZfZ2V0X2ZpcnN0X21hdGNoX25hbWUoIklOVDM0OTYiLCBOVUxMLCAtMSk7Cj4gPiAtCQlp
ZiAobmFtZSkgewo+ID4gLQkJCWluZm8tPmlkX2V4dGNvbiA9IGV4dGNvbl9nZXRfZXh0Y29uX2Rl
dihuYW1lKTsKPiA+ICsJCWFkZXYgPSBhY3BpX2Rldl9nZXRfZmlyc3RfbWF0Y2hfZGV2KCJJTlQz
NDk2IiwgTlVMTCwgLTEpOwo+ID4gKwkJaWYgKGFkZXYpIHsKPiA+ICsJCQlpbmZvLT5pZF9leHRj
b24gPSBleHRjb25fZ2V0X2V4dGNvbl9kZXYoYWNwaV9kZXZfbmFtZShhZGV2KSk7Cj4gPiArCQkJ
cHV0X2RldmljZSgmYWRldi0+ZGV2KTsKPiA+ICAJCQlpZiAoIWluZm8tPmlkX2V4dGNvbikKPiA+
ICAJCQkJcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4gPiAgCj4gPiAKPiAKPiBBcHBsaWVkIGl0LiBU
aGFua3MuCj4gCj4gCgpCdXQgaXQgd29uJ3QgYnVpbGQgd2l0aG91dCB0aGUgZmlyc3QgcGF0Y2gg
SSBzdXBwb3NlPwoKQUNLLCBwbGVhc2U/CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
