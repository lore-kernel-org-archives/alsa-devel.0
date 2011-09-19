From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove bitrotted wm8962_resume()
Date: Mon, 19 Sep 2011 23:34:20 +0100
Message-ID: <1316471660-17892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0252C24BA6
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 11:49:42 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This functionality is now subsumed within the bias management, using the
standard cache management functionality, without assuming the cache type.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ae7a263..ac2a859 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3680,31 +3680,6 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(wm8962_mic_detect);
 
-#ifdef CONFIG_PM
-static int wm8962_resume(struct snd_soc_codec *codec)
-{
-	u16 *reg_cache = codec->reg_cache;
-	int i;
-
-	/* Restore the registers */
-	for (i = 1; i < codec->driver->reg_cache_size; i++) {
-		switch (i) {
-		case WM8962_SOFTWARE_RESET:
-			continue;
-		default:
-			break;
-		}
-
-		if (reg_cache[i] != wm8962_reg[i])
-			snd_soc_write(codec, i, reg_cache[i]);
-	}
-
-	return 0;
-}
-#else
-#define wm8962_resume NULL
-#endif
-
 #if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
 static int beep_rates[] = {
 	500, 1000, 2000, 4000,
@@ -4228,7 +4203,6 @@ static int wm8962_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 	.probe =	wm8962_probe,
 	.remove =	wm8962_remove,
-	.resume =	wm8962_resume,
 	.set_bias_level = wm8962_set_bias_level,
 	.reg_cache_size = WM8962_MAX_REGISTER + 1,
 	.reg_word_size = sizeof(u16),
-- 
1.7.6.3
