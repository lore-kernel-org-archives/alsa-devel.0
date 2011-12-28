From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: mxs: Add .owner to struct snd_soc_card
Date: Wed, 28 Dec 2011 20:06:21 +0800
Message-ID: <1325073981.3037.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 990BA244F9
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 13:06:36 +0100 (CET)
Received: by iaae16 with SMTP id e16so21243715iaa.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 04:06:34 -0800 (PST)
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClNpZ25lZC1vZmYtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4K
U2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGdtYWlsLmNvbT4KLS0tCkhpIE1hcmss
CkkgZm91bmQgTG90aGFyJ3MgcGF0Y2ggaXMgbm90IG1lcmdlZCBub3cuCk5vdCBzdXJlIGlmIHlv
dSBzdGlsbCBoYXZlIExvdGhhcidzIHBhdGNoLiBJZiBub3QsIHlvdSBjYW4gYXBwbHkgdGhpcyBv
bmUuCgpSZWdhcmRzLApBeGVsCiBzb3VuZC9zb2MvbXhzL214cy1zZ3RsNTAwMC5jIHwgICAgMSAr
CiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvbXhzL214cy1zZ3RsNTAwMC5jIGIvc291bmQvc29jL214cy9teHMt
c2d0bDUwMDAuYwppbmRleCAyNTkyNzhmLi42MGYwNTJiIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mv
bXhzL214cy1zZ3RsNTAwMC5jCisrKyBiL3NvdW5kL3NvYy9teHMvbXhzLXNndGw1MDAwLmMKQEAg
LTEwNSw2ICsxMDUsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgbXhzX3NndGw1
MDAwX2RhaVtdID0gewogCiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfY2FyZCBteHNfc2d0bDUwMDAg
PSB7CiAJLm5hbWUJCT0gIm14c19zZ3RsNTAwMCIsCisJLm93bmVyCQk9IFRISVNfTU9EVUxFLAog
CS5kYWlfbGluawk9IG14c19zZ3RsNTAwMF9kYWksCiAJLm51bV9saW5rcwk9IEFSUkFZX1NJWkUo
bXhzX3NndGw1MDAwX2RhaSksCiB9OwotLSAKMS43LjUuNAoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
