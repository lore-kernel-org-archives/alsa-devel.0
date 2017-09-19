From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix an error handling
 path in 'davinci_mcasp_probe()'
Date: Tue, 19 Sep 2017 09:10:16 +0300
Message-ID: <5c531501-ecb9-3a04-fc67-ca3dabaff5bf@ti.com>
References: <20170916054029.27804-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id A28CF266EB8
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 08:10:15 +0200 (CEST)
In-Reply-To: <20170916054029.27804-1-christophe.jaillet@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

77u/CgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAx
ODAgSGVsc2lua2kuIFktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2Ev
RG9taWNpbGU6IEhlbHNpbmtpCgpPbiAyMDE3LTA5LTE2IDA4OjQwLCBDaHJpc3RvcGhlIEpBSUxM
RVQgd3JvdGU6Cj4gQWxsIGVycm9yIGhhbmRsaW5nIHBhdGhzIGluIHRoaXMgZnVuY3Rpb24gJ2dv
dG8gZXJyJyBleGNlcHQgdGhpcyBvbmUuCj4gCj4gSWYgb25lIG9mIHRoZSAyIHByZXZpb3VzIG1l
bW9yeSBhbGxvY2F0aW9ucyBmYWlscywgd2Ugc2hvdWxkIGdvIHRocm91Z2gKPiB0aGUgZXhpc3Rp
bmcgZXJyb3IgaGFuZGxpbmcgcGF0aC4gT3RoZXJ3aXNlIHRoZXJlIGlzIGFuIHVuYmFsYW5jZWQK
PiBwbV9ydW50aW1lX2VuYWJsZSgpL3BtX3J1bnRpbWVfZGlzYWJsZSgpLgoKQWNrZWQtYnk6IFBl
dGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5jb20+Cgo+IEZpeGVzOiBkZDU1ZmY4MzQ2
YTkgKCJBU29DOiBkYXZpbmNpLW1jYXNwOiBBZGQgc2V0X3RkbV9zbG90cygpIHN1cHBvcnQiKQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdh
bmFkb28uZnI+Cj4gLS0tCj4gIHNvdW5kL3NvYy9kYXZpbmNpL2RhdmluY2ktbWNhc3AuYyB8IDYg
KysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9kYXZpbmNpL2RhdmluY2ktbWNhc3AuYyBiL3Nv
dW5kL3NvYy9kYXZpbmNpL2RhdmluY2ktbWNhc3AuYwo+IGluZGV4IGYzOTViYmM3YzM1NC4uMjNi
MGRhN2RmMWYyIDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9kYXZpbmNpL2RhdmluY2ktbWNhc3Au
Ywo+ICsrKyBiL3NvdW5kL3NvYy9kYXZpbmNpL2RhdmluY2ktbWNhc3AuYwo+IEBAIC0xOTgyLDgg
KzE5ODIsMTAgQEAgc3RhdGljIGludCBkYXZpbmNpX21jYXNwX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCj4gIAkJCSAgICAgR0ZQX0tFUk5FTCk7Cj4gIAo+ICAJaWYgKCFtY2Fz
cC0+Y2hjb25zdHJbU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDS10ubGlzdCB8fAo+IC0JICAgICFt
Y2FzcC0+Y2hjb25zdHJbU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFXS5saXN0KQo+IC0JCXJldHVy
biAtRU5PTUVNOwo+ICsJICAgICFtY2FzcC0+Y2hjb25zdHJbU05EUlZfUENNX1NUUkVBTV9DQVBU
VVJFXS5saXN0KSB7Cj4gKwkJcmV0ID0gLUVOT01FTTsKPiArCQlnb3RvIGVycjsKPiArCX0KPiAg
Cj4gIAlyZXQgPSBkYXZpbmNpX21jYXNwX3NldF9jaF9jb25zdHJhaW50cyhtY2FzcCk7Cj4gIAlp
ZiAocmV0KQo+IAoKLSBQw6l0ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
