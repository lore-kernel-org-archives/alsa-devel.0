From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 05/17] ASoC: Ux500: Minor coding layout
	changes
Date: Mon, 10 Sep 2012 17:44:49 +0100
Message-ID: <20120910164448.GD24506@gmail.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2662650F1
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 18:44:53 +0200 (CEST)
Received: by eaa13 with SMTP id 13so825386eaa.38
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 09:44:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345816913-4113-6-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, roger.xr.nilsson@stericsson.com, broonie@opensource.wolfsonmicro.com, STEricsson_nomadik_linux@list.st.com
List-Id: alsa-devel@alsa-project.org

T2xhIHBva2UuCgpPbiBGcmksIEF1ZyAyNCwgMjAxMiBhdCAwMzowMTo0MVBNICswMTAwLCBMZWUg
Sm9uZXMgd3JvdGU6Cj4gSW5jbHVkZXMgcmVtb3ZhbCBvZiBkdXBsaWNhdGUgZGVidWcgcHJpbnQg
YWZmaXJtaW5nIGVudHJ5IGludG8KPiB0aGUgcHJvYmUgZnVuY3Rpb24sIGFuIHVubmVjZXNzYXJ5
IGxpbmUgYnJlYWsgb2YgYSBjb2RpbmcgbGluZQo+IDw4MCBjaGFycyBhbmQgYSB3aGl0ZSBzcGFj
ZSBjaGFuZ2UgKHVuaW50ZW50aW9uYWwgdGFiKS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBzb3VuZC9zb2MvdXg1MDAvbW9wNTAw
LmMgfCAgICA3ICsrLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3V4NTAwL21vcDUwMC5jIGIv
c291bmQvc29jL3V4NTAwL21vcDUwMC5jCj4gaW5kZXggNjg0MGRmNy4uMzU2NjExZCAxMDA2NDQK
PiAtLS0gYS9zb3VuZC9zb2MvdXg1MDAvbW9wNTAwLmMKPiArKysgYi9zb3VuZC9zb2MvdXg1MDAv
bW9wNTAwLmMKPiBAQCAtODgsOCArODgsNiBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBtb3A1MDBf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsKPiAgCWludCByZXQ7Cj4gIAo+IC0JcHJfZGVidWco
IiVzOiBFbnRlci5cbiIsIF9fZnVuY19fKTsKPiAtCj4gIAlkZXZfZGJnKCZwZGV2LT5kZXYsICIl
czogRW50ZXIuXG4iLCBfX2Z1bmNfXyk7Cj4gIAo+ICAJbW9wNTAwX2NhcmQuZGV2ID0gJnBkZXYt
PmRldjsKPiBAQCAtMTE3LDggKzExNSw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IG1vcDUwMF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAJcmV0ID0gc25kX3NvY19yZWdp
c3Rlcl9jYXJkKCZtb3A1MDBfY2FyZCk7Cj4gIAlpZiAocmV0KQo+ICAJCWRldl9lcnIoJnBkZXYt
PmRldiwKPiAtCQkJIkVycm9yOiBzbmRfc29jX3JlZ2lzdGVyX2NhcmQgZmFpbGVkICglZCkhXG4i
LAo+IC0JCQlyZXQpOwo+ICsJCQkiRXJyb3I6IHNuZF9zb2NfcmVnaXN0ZXJfY2FyZCBmYWlsZWQg
KCVkKSFcbiIsIHJldCk7Cj4gIAo+ICAJcmV0dXJuIHJldDsKPiAgfQo+IEBAIC0xMzEsNyArMTI4
LDcgQEAgc3RhdGljIGludCBfX2RldmV4aXQgbW9wNTAwX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQo+ICAKPiAgCXNuZF9zb2NfdW5yZWdpc3Rlcl9jYXJkKG1vcDUwMF9jYXJk
KTsKPiAgCW1vcDUwMF9hYjg1MDBfcmVtb3ZlKG1vcDUwMF9jYXJkKTsKPiAtCQo+ICsKPiAgCXJl
dHVybiAwOwo+ICB9Cj4gIAo+IC0tIAo+IDEuNy45LjUKPiAKCi0tIApMZWUgSm9uZXMKTGluYXJv
IFNULUVyaWNzc29uIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIg
fCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
