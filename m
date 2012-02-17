From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: wm8962: Clean up register dump cruft
Date: Thu, 16 Feb 2012 22:30:07 -0800
Message-ID: <1329460209-30495-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E902E103A5A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:30:47 +0100 (CET)
In-Reply-To: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensourc.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

No longer needed with regmap.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index deeaffe..d2a68d6 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3655,20 +3655,11 @@ static int wm8962_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm8962_soc_volatile(struct snd_soc_codec *codec,
-			       unsigned int reg)
-{
-	return true;
-}
-
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 	.probe =	wm8962_probe,
 	.remove =	wm8962_remove,
 	.set_bias_level = wm8962_set_bias_level,
 	.set_pll = wm8962_set_fll,
-	.reg_cache_size	= WM8962_MAX_REGISTER,
-	.volatile_register = wm8962_soc_volatile,
 	.idle_bias_off = true,
 };
 
-- 
1.7.9.rc1
