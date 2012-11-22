From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] ASoC: mxs-saif: export mxs_saif_put_mclk,mxs_saif_get_mclk
Date: Thu, 22 Nov 2012 13:31:09 +0100
Message-ID: <1353587470-11994-4-git-send-email-LW@KARO-electronics.de>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/mxs/mxs-saif.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c294fbb..f1d1f9e 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -229,6 +229,7 @@ int mxs_saif_put_mclk(unsigned int saif_id)
 	saif->mclk_in_use =3D 0;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mxs_saif_put_mclk);
=20
 /*
  * Get MCLK and set clock rate, then enable it
@@ -282,6 +283,7 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigne=
d int mclk,
=20
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mxs_saif_get_mclk);
=20
 /*
  * SAIF DAI format configuration.
--=20
1.7.2.5
