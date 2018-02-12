From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9712: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:42 +0000
Message-ID: <E1elDVK-0005XB-BD@debutante>
References: <87o9ld2wf5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A3BBC267DD7
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:44 +0100 (CET)
In-Reply-To: <87o9ld2wf5.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm9712: replace codec to component

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

>From 164c976a9493991ebe7e838931ff895e6e04d7c2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:10:45 +0000
Subject: [PATCH] ASoC: wm9712: replace codec to component

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
 sound/soc/codecs/wm9712.c | 109 ++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 4f6d1a442bc4..7aeeeec8adbd 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -220,8 +220,8 @@ static int wm9712_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	unsigned int val = ucontrol->value.integer.value[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -264,8 +264,8 @@ static int wm9712_hp_mixer_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int shift, mixer;
@@ -527,33 +527,33 @@ static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int reg;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x1, 0x1);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x1, 0x1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return snd_soc_write(codec, reg, runtime->rate);
+	return snd_soc_component_write(component, reg, runtime->rate);
 }
 
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x1, 0x1);
-	snd_soc_update_bits(codec, AC97_PCI_SID, 0x8000, 0x8000);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x1, 0x1);
+	snd_soc_component_update_bits(component, AC97_PCI_SID, 0x8000, 0x8000);
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 
-	return snd_soc_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	return snd_soc_component_write(component, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
 #define WM9712_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
@@ -597,7 +597,7 @@ static struct snd_soc_dai_driver wm9712_dai[] = {
 }
 };
 
-static int wm9712_set_bias_level(struct snd_soc_codec *codec,
+static int wm9712_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
 	switch (level) {
@@ -605,20 +605,20 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_component_write(component, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
-		snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_component_write(component, AC97_EXTENDED_MSTATUS, 0xffff);
+		snd_soc_component_write(component, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
 }
 
-static int wm9712_soc_resume(struct snd_soc_codec *codec)
+static int wm9712_soc_resume(struct snd_soc_component *component)
 {
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = snd_ac97_reset(wm9712->ac97, true, WM9712_VENDOR_ID,
@@ -626,17 +626,17 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	if (ret == 0)
-		regcache_sync(codec->component.regmap);
+		snd_soc_component_cache_sync(component);
 
 	return ret;
 }
 
-static int wm9712_soc_probe(struct snd_soc_codec *codec)
+static int wm9712_soc_probe(struct snd_soc_component *component)
 {
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap;
 	int ret;
 
@@ -645,59 +645,59 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 		regmap = wm9712->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
-		wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
+		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
 						      WM9712_VENDOR_ID_MASK);
 		if (IS_ERR(wm9712->ac97)) {
 			ret = PTR_ERR(wm9712->ac97);
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Failed to register AC97 codec: %d\n", ret);
 			return ret;
 		}
 
 		regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
 		if (IS_ERR(regmap)) {
-			snd_soc_free_ac97_codec(wm9712->ac97);
+			snd_soc_free_ac97_component(wm9712->ac97);
 			return PTR_ERR(regmap);
 		}
 #endif
 	}
 
-	snd_soc_codec_init_regmap(codec, regmap);
+	snd_soc_component_init_regmap(component, regmap);
 
 	/* set alc mux to none */
-	snd_soc_update_bits(codec, AC97_VIDEO, 0x3000, 0x3000);
+	snd_soc_component_update_bits(component, AC97_VIDEO, 0x3000, 0x3000);
 
 	return 0;
 }
 
-static int wm9712_soc_remove(struct snd_soc_codec *codec)
+static void wm9712_soc_remove(struct snd_soc_component *component)
 {
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 
 	if (!wm9712->mfd_pdata) {
-		snd_soc_codec_exit_regmap(codec);
-		snd_soc_free_ac97_codec(wm9712->ac97);
+		snd_soc_component_exit_regmap(component);
+		snd_soc_free_ac97_component(wm9712->ac97);
 	}
 #endif
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
-	.probe = 	wm9712_soc_probe,
-	.remove = 	wm9712_soc_remove,
-	.resume =	wm9712_soc_resume,
-	.set_bias_level = wm9712_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm9712_snd_ac97_controls,
-		.num_controls		= ARRAY_SIZE(wm9712_snd_ac97_controls),
-		.dapm_widgets		= wm9712_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm9712_dapm_widgets),
-		.dapm_routes		= wm9712_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(wm9712_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm9712 = {
+	.probe			= wm9712_soc_probe,
+	.remove			= wm9712_soc_remove,
+	.resume			= wm9712_soc_resume,
+	.set_bias_level		= wm9712_set_bias_level,
+	.controls		= wm9712_snd_ac97_controls,
+	.num_controls		= ARRAY_SIZE(wm9712_snd_ac97_controls),
+	.dapm_widgets		= wm9712_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm9712_dapm_widgets),
+	.dapm_routes		= wm9712_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(wm9712_audio_map),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm9712_probe(struct platform_device *pdev)
@@ -713,26 +713,19 @@ static int wm9712_probe(struct platform_device *pdev)
 	wm9712->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9712);
 
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
-}
-
-static int wm9712_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
 }
 
-static struct platform_driver wm9712_codec_driver = {
+static struct platform_driver wm9712_component_driver = {
 	.driver = {
-		.name = "wm9712-codec",
+		.name = "wm9712-component",
 	},
 
 	.probe = wm9712_probe,
-	.remove = wm9712_remove,
 };
 
-module_platform_driver(wm9712_codec_driver);
+module_platform_driver(wm9712_component_driver);
 
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
-- 
2.16.1
