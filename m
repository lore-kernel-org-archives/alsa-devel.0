From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: cmi8328: Fix compile warnings
	without CONFIG_PM
Date: Wed,  6 Nov 2013 17:58:05 +0100
Message-ID: <1383757086-21220-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BC0D265284
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 17:58:06 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 44B01A6F04
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 17:58:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SnVzdCBhZGQgYW4gaWZkZWYgQ09ORklHX1BNIHRvIHNodXQgdXAgdGhlIHdhcm5pbmdzOgoKICBz
b3VuZC9pc2EvY21pODMyOC5jOjEyOToxMzogd2FybmluZzog4oCYc25kX2NtaTgzMjhfY2ZnX3Nh
dmXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQogIHNvdW5kL2lz
YS9jbWk4MzI4LmM6MTM2OjEzOiB3YXJuaW5nOiDigJhzbmRfY21pODMyOF9jZmdfcmVzdG9yZeKA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dCgpTaWduZWQtb2ZmLWJ5
OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0tLQogc291bmQvaXNhL2NtaTgzMjguYyB8
IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9pc2EvY21pODMyOC5jIGIvc291bmQvaXNhL2NtaTgzMjguYwppbmRleCBmODRmMDczZmMxZTgu
LmFiNmIyZGMwNDNmMSAxMDA2NDQKLS0tIGEvc291bmQvaXNhL2NtaTgzMjguYworKysgYi9zb3Vu
ZC9pc2EvY21pODMyOC5jCkBAIC0xMjYsNiArMTI2LDcgQEAgc3RhdGljIHZvaWQgc25kX2NtaTgz
MjhfY2ZnX3dyaXRlKHUxNiBwb3J0LCB1OCByZWcsIHU4IHZhbCkKIAlvdXRiKHZhbCwgcG9ydCAr
IDMpOwkvKiB5ZXMsIHZhbHVlIGdvZXMgdG8gdGhlIHNhbWUgcG9ydCBhcyBpbmRleCAqLwogfQog
CisjaWZkZWYgQ09ORklHX1BNCiBzdGF0aWMgdm9pZCBzbmRfY21pODMyOF9jZmdfc2F2ZSh1MTYg
cG9ydCwgdTggY2ZnW10pCiB7CiAJY2ZnWzBdID0gc25kX2NtaTgzMjhfY2ZnX3JlYWQocG9ydCwg
Q0ZHMSk7CkBAIC0xMzksNiArMTQwLDcgQEAgc3RhdGljIHZvaWQgc25kX2NtaTgzMjhfY2ZnX3Jl
c3RvcmUodTE2IHBvcnQsIHU4IGNmZ1tdKQogCXNuZF9jbWk4MzI4X2NmZ193cml0ZShwb3J0LCBD
RkcyLCBjZmdbMV0pOwogCXNuZF9jbWk4MzI4X2NmZ193cml0ZShwb3J0LCBDRkczLCBjZmdbMl0p
OwogfQorI2VuZGlmIC8qIENPTkZJR19QTSAqLwogCiBzdGF0aWMgaW50IHNuZF9jbWk4MzI4X21p
eGVyKHN0cnVjdCBzbmRfd3NzICpjaGlwKQogewotLSAKMS44LjQuMgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
