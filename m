From: =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: [PATCH] fix format type mismatch in
	sound/pci/lola/lola_proc.c
Date: Tue, 20 May 2014 19:22:17 +0200
Message-ID: <1400606537-22073-1-git-send-email-toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D26A264EF3
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 19:22:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogVG9yYWxmIEbDtnJzdGVyIDx0b3JhbGYuZm9lcnN0ZXJAZ214LmRlPgot
LS0KIHNvdW5kL3BjaS9sb2xhL2xvbGFfcHJvYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2xvbGEv
bG9sYV9wcm9jLmMgYi9zb3VuZC9wY2kvbG9sYS9sb2xhX3Byb2MuYwppbmRleCAwNGRmODNkLi5j
MjQxZGMwIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvbG9sYS9sb2xhX3Byb2MuYworKysgYi9zb3Vu
ZC9wY2kvbG9sYS9sb2xhX3Byb2MuYwpAQCAtMTUxLDcgKzE1MSw3IEBAIHN0YXRpYyB2b2lkIGxv
bGFfcHJvY19jb2RlY19yd193cml0ZShzdHJ1Y3Qgc25kX2luZm9fZW50cnkgKmVudHJ5LAogCWNo
YXIgbGluZVs2NF07CiAJdW5zaWduZWQgaW50IGlkLCB2ZXJiLCBkYXRhLCBleHRkYXRhOwogCXdo
aWxlICghc25kX2luZm9fZ2V0X2xpbmUoYnVmZmVyLCBsaW5lLCBzaXplb2YobGluZSkpKSB7Ci0J
CWlmIChzc2NhbmYobGluZSwgIiVpICVpICVpICVpIiwgJmlkLCAmdmVyYiwgJmRhdGEsICZleHRk
YXRhKSAhPSA0KQorCQlpZiAoc3NjYW5mKGxpbmUsICIldSAldSAldSAldSIsICZpZCwgJnZlcmIs
ICZkYXRhLCAmZXh0ZGF0YSkgIT0gNCkKIAkJCWNvbnRpbnVlOwogCQlsb2xhX2NvZGVjX3JlYWQo
Y2hpcCwgaWQsIHZlcmIsIGRhdGEsIGV4dGRhdGEsCiAJCQkJJmNoaXAtPmRlYnVnX3JlcywKLS0g
CjEuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
