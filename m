From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Subject: [PATCH 09/10] ASoC: sta32x: correct bit shift value
	for IDE register.
Date: Thu, 22 Jan 2015 00:02:01 +0100
Message-ID: <1421881322-27806-10-git-send-email-niederp@physik.uni-kl.de>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
 by alsa0.perex.cz (Postfix) with ESMTP id D918526048D
 for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2015 00:00:30 +0100 (CET)
In-Reply-To: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, zonque@gmail.com, brandau@gmx.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

VGhlIElERSBiaXQgaW4gdGhlIENPTkZGIHJlZ2lzdGVyIGlzIHRoZSB0aGlyZCBiaXQgbm90IHRo
ZSBmb3VydGguCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgTmllZGVycHLDvG0gPG5pZWRlcnBAcGh5
c2lrLnVuaS1rbC5kZT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL3N0YTMyeC5oIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy9zdGEzMnguaCBiL3NvdW5kL3NvYy9jb2RlY3Mvc3RhMzJ4LmgKaW5k
ZXggNGNjYzcyMi4uMzZmYjM3MSAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9zdGEzMngu
aAorKysgYi9zb3VuZC9zb2MvY29kZWNzL3N0YTMyeC5oCkBAIC0xMzEsNyArMTMxLDcgQEAKICNk
ZWZpbmUgU1RBMzJYX0NPTkZGX09DRkdfTUFTSwkweDAzCiAjZGVmaW5lIFNUQTMyWF9DT05GRl9P
Q0ZHX1NISUZUCTAKICNkZWZpbmUgU1RBMzJYX0NPTkZGX0lERQkweDA0Ci0jZGVmaW5lIFNUQTMy
WF9DT05GRl9JREVfU0hJRlQJMworI2RlZmluZSBTVEEzMlhfQ09ORkZfSURFX1NISUZUCTIKICNk
ZWZpbmUgU1RBMzJYX0NPTkZGX0JDTEUJMHgwOAogI2RlZmluZSBTVEEzMlhfQ09ORkZfRUNMRQkw
eDIwCiAjZGVmaW5lIFNUQTMyWF9DT05GRl9QV0ROCTB4NDAKLS0gCjIuMS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
