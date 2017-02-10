From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH 1/4] ASoC: sun8i-codec: Remove analog "HP"
	widget
Date: Fri, 10 Feb 2017 10:41:30 +0100
Message-ID: <20170210094133.11382-2-mylene.josserand@free-electrons.com>
References: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 373BF266CCD
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 10:42:19 +0100 (CET)
In-Reply-To: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, mylene.josserand@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

VGhlICJIUCIgd2lkZ2V0IGlzIGFscmVhZHkgcHJlc2VudCBhbmQgdGFrZSBwYXJ0IHRvCnRoZSBh
bmFsb2cgcGFydCAoc3VuOGktY29kZWMtYW5hbG9nKS4KClJlbW92ZSBpdCBmcm9tIHRoZSBkaWdp
dGFsIHBhcnQgYXMgaXQgaXMgdW5uZWNlc3NhcnkuCgpTaWduZWQtb2ZmLWJ5OiBNeWzDqG5lIEpv
c3NlcmFuZCA8bXlsZW5lLmpvc3NlcmFuZEBmcmVlLWVsZWN0cm9ucy5jb20+Ci0tLQogc291bmQv
c29jL3N1bnhpL3N1bjhpLWNvZGVjLmMgfCA2IC0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3N1bnhpL3N1bjhpLWNvZGVjLmMgYi9z
b3VuZC9zb2Mvc3VueGkvc3VuOGktY29kZWMuYwppbmRleCBiOTJiZGM4MzYxYWYuLmQ2MGY2ZmJk
MzZhMiAxMDA2NDQKLS0tIGEvc291bmQvc29jL3N1bnhpL3N1bjhpLWNvZGVjLmMKKysrIGIvc291
bmQvc29jL3N1bnhpL3N1bjhpLWNvZGVjLmMKQEAgLTMyMSw4ICszMjEsNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgc3VuOGlfY29kZWNfZGFwbV93aWRnZXRzW10g
PSB7CiAJCQkgICAgU1VOOElfTU9EX1JTVF9DVExfQUlGMSwgMCwgTlVMTCwgMCksCiAJU05EX1NP
Q19EQVBNX1NVUFBMWSgiUlNUIERBQyIsIFNVTjhJX01PRF9SU1RfQ1RMLAogCQkJICAgIFNVTjhJ
X01PRF9SU1RfQ1RMX0RBQywgMCwgTlVMTCwgMCksCi0KLQlTTkRfU09DX0RBUE1fT1VUUFVUKCJI
UCIpLAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fcm91dGUgc3VuOGlf
Y29kZWNfZGFwbV9yb3V0ZXNbXSA9IHsKQEAgLTM0NCwxMCArMzQyLDYgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBzbmRfc29jX2RhcG1fcm91dGUgc3VuOGlfY29kZWNfZGFwbV9yb3V0ZXNbXSA9IHsK
IAkvKiBEQUMgTWl4ZXIgUm91dGVzICovCiAJeyAiTGVmdCBEQUMgTWl4ZXIiLCAiTFNsb3QgMCIs
ICJEaWdpdGFsIExlZnQgREFDIn0sCiAJeyAiUmlnaHQgREFDIE1peGVyIiwgIlJTbG90IDAiLCAi
RGlnaXRhbCBSaWdodCBEQUMifSwKLQotCS8qIEVuZCBvZiByb3V0ZSA6IEhQIG91dCAqLwotCXsg
IkhQIiwgTlVMTCwgIkxlZnQgREFDIE1peGVyIiB9LAotCXsgIkhQIiwgTlVMTCwgIlJpZ2h0IERB
QyBNaXhlciIgfSwKIH07CiAKIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfb3BzIHN1bjhpX2Nv
ZGVjX2RhaV9vcHMgPSB7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
