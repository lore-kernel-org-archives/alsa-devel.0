From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ASoC: cs43130: Fix unused compiler
	warnings for PM runtime
Date: Mon,  4 Sep 2017 15:14:45 +0200
Message-ID: <20170904131445.32438-2-tiwai@suse.de>
References: <20170904131445.32438-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BF1A26705A
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 15:14:51 +0200 (CEST)
In-Reply-To: <20170904131445.32438-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QWRkIF9fbWF5YmVfdW51c2VkIHByZWZpeCBmb3IgYWRkcmVzc2luZyB0aGUgZm9sbG93aW5nIHdh
cm5pbmdzOgogIHNvdW5kL3NvYy9jb2RlY3MvY3M0MzEzMC5jOjI2MTU6MTI6IHdhcm5pbmc6IOKA
mGNzNDMxMzBfcnVudGltZV9yZXN1bWXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWZ1bmN0aW9uXQogIHNvdW5kL3NvYy9jb2RlY3MvY3M0MzEzMC5jOjI1OTY6MTI6IHdhcm5pbmc6
IOKAmGNzNDMxMzBfcnVudGltZV9zdXNwZW5k4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3Vu
dXNlZC1mdW5jdGlvbl0KCkZpeGVzOiA4ZjFlNWJmOWI0NDAgKCJBU29DOiBjczQzMTMwOiBBZGQg
c3VwcG9ydCBmb3IgQ1M0MzEzMCBjb2RlYyIpClNpZ25lZC1vZmYtYnk6IFRha2FzaGkgSXdhaSA8
dGl3YWlAc3VzZS5kZT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL2NzNDMxMzAuYyB8IDQgKystLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zb3VuZC9zb2MvY29kZWNzL2NzNDMxMzAuYyBiL3NvdW5kL3NvYy9jb2RlY3MvY3M0MzEz
MC5jCmluZGV4IDNmZTNiOGQ2NDRiNy4uNjZiYzJlYzhmZjI2IDEwMDY0NAotLS0gYS9zb3VuZC9z
b2MvY29kZWNzL2NzNDMxMzAuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL2NzNDMxMzAuYwpAQCAt
MjU2Myw3ICsyNTYzLDcgQEAgc3RhdGljIGludCBjczQzMTMwX2kyY19wcm9iZShzdHJ1Y3QgaTJj
X2NsaWVudCAqY2xpZW50LAogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgY3M0MzEzMF9p
MmNfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCitzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIGNzNDMxMzBfaTJjX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogewog
CXN0cnVjdCBjczQzMTMwX3ByaXZhdGUgKmNzNDMxMzAgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xp
ZW50KTsKIApAQCAtMjU5Nyw3ICsyNTk3LDcgQEAgc3RhdGljIGludCBjczQzMTMwX2kyY19yZW1v
dmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGlu
dCBjczQzMTMwX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW50
IF9fbWF5YmVfdW51c2VkIGNzNDMxMzBfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRl
dikKIHsKIAlzdHJ1Y3QgY3M0MzEzMF9wcml2YXRlICpjczQzMTMwID0gZGV2X2dldF9kcnZkYXRh
KGRldik7CiAKLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
