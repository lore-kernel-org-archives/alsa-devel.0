From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: wm8904: Rely entirely on the core
	for bias level management
Date: Mon, 11 Jun 2012 13:10:45 +0800
Message-ID: <1339391447-8721-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 604301040AD
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:11:19 +0200 (CEST)
In-Reply-To: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Even though the WM8904 is able to use idle_bias_off during both probe
and resume we were needlessly leaving the device in standby mode. Instead
power the device down as soon as we've confirmed that we can talk to it
and don't manage the bias level at all over suspend and resume, the core
will take us down to our minimum power level.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8904.c |   30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 5417b11..ecab871 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1945,25 +1945,6 @@ static struct snd_soc_dai_driver wm8904_dai = {
 	.symmetric_rates = 1,
 };
 
-#ifdef CONFIG_PM
-static int wm8904_suspend(struct snd_soc_codec *codec)
-{
-	wm8904_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int wm8904_resume(struct snd_soc_codec *codec)
-{
-	wm8904_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define wm8904_suspend NULL
-#define wm8904_resume NULL
-#endif
-
 static void wm8904_handle_retune_mobile_pdata(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
@@ -2143,7 +2124,10 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 		goto err_enable;
 	}
 
+	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
+	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
+
 	/* Change some default settings - latch VU and enable ZC */
 	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_LEFT,
 			    WM8904_ADC_VU, WM8904_ADC_VU);
@@ -2198,11 +2182,6 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
-	wm8904_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* Bias level configuration will have done an extra enable */
-	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-
 	wm8904_handle_pdata(codec);
 
 	wm8904_add_widgets(codec);
@@ -2220,7 +2199,6 @@ static int wm8904_remove(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 
-	wm8904_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_free(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 	kfree(wm8904->retune_mobile_texts);
 	kfree(wm8904->drc_texts);
@@ -2231,8 +2209,6 @@ static int wm8904_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm8904 = {
 	.probe =	wm8904_probe,
 	.remove =	wm8904_remove,
-	.suspend =	wm8904_suspend,
-	.resume =	wm8904_resume,
 	.set_bias_level = wm8904_set_bias_level,
 	.idle_bias_off = true,
 };
-- 
1.7.10
