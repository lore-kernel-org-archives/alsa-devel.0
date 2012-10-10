From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm8770: Remove unneeded bias level
	manipulation
Date: Wed, 10 Oct 2012 20:43:37 +0900
Message-ID: <1349869419-10357-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63B9E2625D4
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:11:05 +0200 (CEST)
In-Reply-To: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the device is now idle_bias_off these never have any useful effect,
the device will be brought to _OFF when idle, and will at best leave it
powered for longer.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8770.c |   22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 21ec563..8eefe42 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -572,23 +572,6 @@ static struct snd_soc_dai_driver wm8770_dai = {
 	.symmetric_rates = 1
 };
 
-#ifdef CONFIG_PM
-static int wm8770_suspend(struct snd_soc_codec *codec)
-{
-	wm8770_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8770_resume(struct snd_soc_codec *codec)
-{
-	wm8770_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-#else
-#define wm8770_suspend NULL
-#define wm8770_resume NULL
-#endif
-
 static int wm8770_probe(struct snd_soc_codec *codec)
 {
 	struct wm8770_priv *wm8770;
@@ -642,8 +625,6 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 		goto err_reg_enable;
 	}
 
-	wm8770_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	/* latch the volume update bits */
 	snd_soc_update_bits(codec, WM8770_MSDIGVOL, 0x100, 0x100);
 	snd_soc_update_bits(codec, WM8770_MSALGVOL, 0x100, 0x100);
@@ -680,7 +661,6 @@ static int wm8770_remove(struct snd_soc_codec *codec)
 	int i;
 
 	wm8770 = snd_soc_codec_get_drvdata(codec);
-	wm8770_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); ++i)
 		regulator_unregister_notifier(wm8770->supplies[i].consumer,
@@ -692,8 +672,6 @@ static int wm8770_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.probe = wm8770_probe,
 	.remove = wm8770_remove,
-	.suspend = wm8770_suspend,
-	.resume = wm8770_resume,
 	.set_bias_level = wm8770_set_bias_level,
 	.idle_bias_off = true,
 };
-- 
1.7.10.4
