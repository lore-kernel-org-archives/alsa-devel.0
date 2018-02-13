From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9705: replace codec to component" to
	the asoc tree
Date: Tue, 13 Feb 2018 12:15:00 +0000
Message-ID: <E1elZUC-0005Q6-5n@debutante>
References: <87po5t2wfn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B64D1267716
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:15:02 +0100 (CET)
In-Reply-To: <87po5t2wfn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9705: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 28f898499f3306274c900ad85b579435f9e4c8b5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:10:29 +0000
Subject: [PATCH] ASoC: wm9705: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9705.c | 83 ++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 2c09f71fe433..ccdf088461b7 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -235,17 +235,17 @@ static const struct snd_soc_dapm_route wm9705_audio_map[] = {
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int reg;
 
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x1, 0x1);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x1, 0x1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return snd_soc_write(codec, reg, substream->runtime->rate);
+	return snd_soc_component_write(component, reg, substream->runtime->rate);
 }
 
 #define WM9705_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
@@ -289,18 +289,18 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 };
 
 #ifdef CONFIG_PM
-static int wm9705_soc_suspend(struct snd_soc_codec *codec)
+static int wm9705_soc_suspend(struct snd_soc_component *component)
 {
-	regcache_cache_bypass(codec->component.regmap, true);
-	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
-	regcache_cache_bypass(codec->component.regmap, false);
+	regcache_cache_bypass(component->regmap, true);
+	snd_soc_component_write(component, AC97_POWERDOWN, 0xffff);
+	regcache_cache_bypass(component->regmap, false);
 
 	return 0;
 }
 
-static int wm9705_soc_resume(struct snd_soc_codec *codec)
+static int wm9705_soc_resume(struct snd_soc_component *component)
 {
-	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
+	struct wm9705_priv *wm9705 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = snd_ac97_reset(wm9705->ac97, true, WM9705_VENDOR_ID,
@@ -308,7 +308,7 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	regcache_sync(codec->component.regmap);
+	snd_soc_component_cache_sync(component);
 
 	return 0;
 }
@@ -317,9 +317,9 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 #define wm9705_soc_resume NULL
 #endif
 
-static int wm9705_soc_probe(struct snd_soc_codec *codec)
+static int wm9705_soc_probe(struct snd_soc_component *component)
 {
-	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
+	struct wm9705_priv *wm9705 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap;
 
 	if (wm9705->mfd_pdata) {
@@ -327,54 +327,54 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 		regmap = wm9705->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
-		wm9705->ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
+		wm9705->ac97 = snd_soc_new_ac97_component(component, WM9705_VENDOR_ID,
 						      WM9705_VENDOR_ID_MASK);
 		if (IS_ERR(wm9705->ac97)) {
-			dev_err(codec->dev, "Failed to register AC97 codec\n");
+			dev_err(component->dev, "Failed to register AC97 codec\n");
 			return PTR_ERR(wm9705->ac97);
 		}
 
 		regmap = regmap_init_ac97(wm9705->ac97, &wm9705_regmap_config);
 		if (IS_ERR(regmap)) {
-			snd_soc_free_ac97_codec(wm9705->ac97);
+			snd_soc_free_ac97_component(wm9705->ac97);
 			return PTR_ERR(regmap);
 		}
 #endif
 	}
 
-	snd_soc_codec_set_drvdata(codec, wm9705->ac97);
-	snd_soc_codec_init_regmap(codec, regmap);
+	snd_soc_component_set_drvdata(component, wm9705->ac97);
+	snd_soc_component_init_regmap(component, regmap);
 
 	return 0;
 }
 
-static int wm9705_soc_remove(struct snd_soc_codec *codec)
+static void wm9705_soc_remove(struct snd_soc_component *component)
 {
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
+	struct wm9705_priv *wm9705 = snd_soc_component_get_drvdata(component);
 
 	if (!wm9705->mfd_pdata) {
-		snd_soc_codec_exit_regmap(codec);
-		snd_soc_free_ac97_codec(wm9705->ac97);
+		snd_soc_component_exit_regmap(component);
+		snd_soc_free_ac97_component(wm9705->ac97);
 	}
 #endif
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
-	.probe = 	wm9705_soc_probe,
-	.remove = 	wm9705_soc_remove,
-	.suspend =	wm9705_soc_suspend,
-	.resume =	wm9705_soc_resume,
-
-	.component_driver = {
-		.controls		= wm9705_snd_ac97_controls,
-		.num_controls		= ARRAY_SIZE(wm9705_snd_ac97_controls),
-		.dapm_widgets		= wm9705_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm9705_dapm_widgets),
-		.dapm_routes		= wm9705_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(wm9705_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm9705 = {
+	.probe			= wm9705_soc_probe,
+	.remove			= wm9705_soc_remove,
+	.suspend		= wm9705_soc_suspend,
+	.resume			= wm9705_soc_resume,
+	.controls		= wm9705_snd_ac97_controls,
+	.num_controls		= ARRAY_SIZE(wm9705_snd_ac97_controls),
+	.dapm_widgets		= wm9705_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm9705_dapm_widgets),
+	.dapm_routes		= wm9705_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(wm9705_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm9705_probe(struct platform_device *pdev)
@@ -388,14 +388,8 @@ static int wm9705_probe(struct platform_device *pdev)
 	wm9705->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9705);
 
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
-}
-
-static int wm9705_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
 }
 
 static struct platform_driver wm9705_codec_driver = {
@@ -404,7 +398,6 @@ static struct platform_driver wm9705_codec_driver = {
 	},
 
 	.probe = wm9705_probe,
-	.remove = wm9705_remove,
 };
 
 module_platform_driver(wm9705_codec_driver);
-- 
2.16.1
