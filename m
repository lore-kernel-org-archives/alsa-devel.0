From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 1/3] ASoC: sun8i-codec: Fix space on
	audio-routing widget
Date: Thu,  9 Mar 2017 10:56:00 +0100
Message-ID: <20170309095602.13809-2-mylene.josserand@free-electrons.com>
References: <20170309095602.13809-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C0B202671C7
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 10:56:22 +0100 (CET)
In-Reply-To: <20170309095602.13809-1-mylene.josserand@free-electrons.com>
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

QW4gdW53YW50ZWQgc3BhY2UgaXMgcHJlc2VudCBpbiBhbiBhdWRpbyB3aWRnZXQncyBuYW1lIG9u
IHRoZSBkYXBtCnJvdXRpbmcuIEl0IGNhdXNlcyBhbiBlcnJvciBvbiB0aGUgcmVjb2duaXRpb24g
b2YgdGhpcyB3aWRnZXQgKGVycm9yOgooIm5vIGRhcG0gbWF0Y2ggZm9yIEFJRjEgU2xvdCAwIFJp
Z2h0IikuCgpSZW1vdmUgdGhlIHNwYWNlIGZpeGVzIGl0LgoKU2lnbmVkLW9mZi1ieTogTXlsw6hu
ZSBKb3NzZXJhbmQgPG15bGVuZS5qb3NzZXJhbmRAZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIHNv
dW5kL3NvYy9zdW54aS9zdW44aS1jb2RlYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3N1bnhpL3N1
bjhpLWNvZGVjLmMgYi9zb3VuZC9zb2Mvc3VueGkvc3VuOGktY29kZWMuYwppbmRleCBhNzVhOTgz
OTc0ZDkuLjkwY2RhOTU2OTUwMyAxMDA2NDQKLS0tIGEvc291bmQvc29jL3N1bnhpL3N1bjhpLWNv
ZGVjLmMKKysrIGIvc291bmQvc29jL3N1bnhpL3N1bjhpLWNvZGVjLmMKQEAgLTMzNSw3ICszMzUs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfZGFwbV9yb3V0ZSBzdW44aV9jb2RlY19k
YXBtX3JvdXRlc1tdID0gewogCS8qIERBQyBNaXhlciBSb3V0ZXMgKi8KIAl7ICJMZWZ0IERpZ2l0
YWwgREFDIE1peGVyIiwgIkFJRjEgU2xvdCAwIERpZ2l0YWwgREFDIFBsYXliYWNrIFN3aXRjaCIs
CiAJICAiRGlnaXRhbCBMZWZ0IERBQyJ9LAotCXsgIlJpZ2h0IERpZ2l0YWwgREFDIE1peGVyIiwg
IkFJRjEgU2xvdCAwIERpZ2l0YWwgREFDIFBsYXliYWNrIFN3aXRjaCAiLAorCXsgIlJpZ2h0IERp
Z2l0YWwgREFDIE1peGVyIiwgIkFJRjEgU2xvdCAwIERpZ2l0YWwgREFDIFBsYXliYWNrIFN3aXRj
aCIsCiAJICAiRGlnaXRhbCBSaWdodCBEQUMifSwKIH07CiAKLS0gCjIuMTEuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
