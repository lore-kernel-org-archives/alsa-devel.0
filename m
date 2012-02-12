From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm9081: Use idle_bias_off
Date: Sun, 12 Feb 2012 18:37:43 +0000
Message-ID: <1329071863-19064-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329071863-19064-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8DB7103C6A
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 17:07:14 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [108.60.121.130])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 2F640110695
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:07:14 +0000 (GMT)
In-Reply-To: <1329071863-19064-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The main role of the WM9081 is as a class D speaker amplifier so there
is no concern about pops. There are also very few registers and a fast
power up time so we can happily mark the driver as idle_bias_off.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |   35 ++++++++++-------------------------
 1 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 5f464ab..13bfcbd 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -824,6 +824,8 @@ static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -841,6 +843,9 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		/* Initial cold start */
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			regcache_cache_only(wm9081->regmap, false);
+			regcache_sync(wm9081->regmap);
+
 			/* Disable LINEOUT discharge */
 			snd_soc_update_bits(codec, WM9081_ANTI_POP_CONTROL,
 					    WM9081_LINEOUT_DISCH, 0);
@@ -892,6 +897,8 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, WM9081_ANTI_POP_CONTROL,
 				    WM9081_LINEOUT_DISCH,
 				    WM9081_LINEOUT_DISCH);
+
+		regcache_cache_only(wm9081->regmap, true);
 		break;
 	}
 
@@ -1289,38 +1296,15 @@ static int wm9081_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wm9081_suspend(struct snd_soc_codec *codec)
-{
-	wm9081_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int wm9081_resume(struct snd_soc_codec *codec)
-{
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
-
-	regcache_sync(wm9081->regmap);
-
-	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define wm9081_suspend NULL
-#define wm9081_resume NULL
-#endif
-
 static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.probe = 	wm9081_probe,
 	.remove = 	wm9081_remove,
-	.suspend =	wm9081_suspend,
-	.resume =	wm9081_resume,
 
 	.set_sysclk = wm9081_set_sysclk,
 	.set_bias_level = wm9081_set_bias_level,
 
+	.idle_bias_off = true,
+
 	.controls         = wm9081_snd_controls,
 	.num_controls     = ARRAY_SIZE(wm9081_snd_controls),
 	.dapm_widgets	  = wm9081_dapm_widgets,
@@ -1392,6 +1376,7 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(wm9081->regmap, WM9081_INTERRUPT_CONTROL,
 			   WM9081_IRQ_POL | WM9081_IRQ_OP_CTRL, reg);
 
+	regcache_cache_only(wm9081->regmap, true);
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9081, &wm9081_dai, 1);
-- 
1.7.9.rc1
