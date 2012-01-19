From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [PATCH] Fix bint check version check
Date: Thu, 19 Jan 2012 17:25:10 +0200
Message-ID: <1326986710-12389-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 36FAC103C0F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 16:25:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

SXQgc2VlbXMgdGhhdCB0aGUgYmludCBzdHVmZiBpcyBub3QgYSBwYXJ0IG9mIDMuMiBrZXJuZWwg
YXMgaXQncwpwdWxsZWQgYnkgTGludXMgb25seSBhIGZldyBkYXlzIGFnbywgc28gaW5jcmVtZW50
IHZlcnNpb24gY2hlY2sKdG8gMy4zLjA6Cgpjb21taXQgNjkxMTZmMjc5YTllYWY0YzU0MDkzNDI2
OTM0MmQ5MTQ5NTM4ZmM3OQpBdXRob3I6IFJ1c3R5IFJ1c3NlbGwgPHJ1c3R5QHJ1c3Rjb3JwLmNv
bS5hdT4KRGF0ZTogICBGcmkgSmFuIDEzIDA5OjMyOjE3IDIwMTIgKzEwMzAKCiAgICBtb2R1bGVf
cGFyYW06IGF2b2lkIGJvb2wgYWJ1c2UsIGFkZCBiaW50IGZvciBzcGVjaWFsIGNhc2VzLgoKU2ln
bmVkLW9mZi1ieTogT3phbiDDh2HEn2xheWFuIDxvemFuQHBhcmR1cy5vcmcudHI+Ci0tLQogaW5j
bHVkZS9hZHJpdmVyLmggfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2Fkcml2ZXIuaCBiL2luY2x1
ZGUvYWRyaXZlci5oCmluZGV4IGE2ZTZjYmMuLjliYzhjYTggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
YWRyaXZlci5oCisrKyBiL2luY2x1ZGUvYWRyaXZlci5oCkBAIC04MzAsNyArODMwLDcgQEAgc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBsb25nIG1zZWNzX3RvX2ppZmZpZXMoY29uc3QgdW5zaWduZWQg
aW50IG0pCiAjZW5kaWYKICNlbmRpZgogCi0jaWYgTElOVVhfVkVSU0lPTl9DT0RFIDw9IEtFUk5F
TF9WRVJTSU9OKDMsIDIsIDApCisjaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZFUlNJ
T04oMywgMywgMCkKICNpbmNsdWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPgogI2lmbmRlZiBwYXJh
bV9nZXRfYmludAogI2RlZmluZSBiaW50IGJvb2wKLS0gCjEuNy43LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
