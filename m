From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1701: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:27:16 +0000
Message-ID: <E1elDCW-0002k5-3z@debutante>
References: <878tchz4ng.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F92D2672A7
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:27:20 +0100 (CET)
In-Reply-To: <878tchz4ng.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: adau1701: replace codec to component

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

>From 4bb83cf0a034cbe83c413a69705d315f5660bdb9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:11:56 +0000
Subject: [PATCH] ASoC: adau1701: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1701.c | 101 ++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 805afac8146b..b5a61741c800 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -298,10 +298,10 @@ static const struct sigmadsp_ops adau1701_sigmadsp_ops = {
 	.safeload = adau1701_safeload,
 };
 
-static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv,
+static int adau1701_reset(struct snd_soc_component *component, unsigned int clkdiv,
 	unsigned int rate)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	sigmadsp_reset(adau1701->sigmadsp);
@@ -348,7 +348,7 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv,
 	if (clkdiv != ADAU1707_CLKDIV_UNSET) {
 		ret = sigmadsp_setup(adau1701->sigmadsp, rate);
 		if (ret) {
-			dev_warn(codec->dev, "Failed to load firmware\n");
+			dev_warn(component->dev, "Failed to load firmware\n");
 			return ret;
 		}
 	}
@@ -362,10 +362,10 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv,
 	return 0;
 }
 
-static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
+static int adau1701_set_capture_pcm_format(struct snd_soc_component *component,
 					   struct snd_pcm_hw_params *params)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	unsigned int mask = ADAU1701_SEROCTL_WORD_LEN_MASK;
 	unsigned int val;
 
@@ -403,10 +403,10 @@ static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adau1701_set_playback_pcm_format(struct snd_soc_codec *codec,
+static int adau1701_set_playback_pcm_format(struct snd_soc_component *component,
 					    struct snd_pcm_hw_params *params)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (adau1701->dai_fmt != SND_SOC_DAIFMT_RIGHT_J)
@@ -435,8 +435,8 @@ static int adau1701_set_playback_pcm_format(struct snd_soc_codec *codec,
 static int adau1701_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	unsigned int clkdiv = adau1701->sysclk / params_rate(params);
 	unsigned int val;
 	int ret;
@@ -447,7 +447,7 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 	 * firmware upload.
 	 */
 	if (clkdiv != adau1701->pll_clkdiv) {
-		ret = adau1701_reset(codec, clkdiv, params_rate(params));
+		ret = adau1701_reset(component, clkdiv, params_rate(params));
 		if (ret < 0)
 			return ret;
 	}
@@ -470,16 +470,16 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 		ADAU1701_DSPCTRL_SR_MASK, val);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return adau1701_set_playback_pcm_format(codec, params);
+		return adau1701_set_playback_pcm_format(component, params);
 	else
-		return adau1701_set_capture_pcm_format(codec, params);
+		return adau1701_set_capture_pcm_format(component, params);
 }
 
 static int adau1701_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	unsigned int serictl = 0x00, seroctl = 0x00;
 	bool invert_lrclk;
 
@@ -548,11 +548,11 @@ static int adau1701_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int adau1701_set_bias_level(struct snd_soc_codec *codec,
+static int adau1701_set_bias_level(struct snd_soc_component *component,
 		enum snd_soc_bias_level level)
 {
 	unsigned int mask = ADAU1701_AUXNPOW_VBPD | ADAU1701_AUXNPOW_VRPD;
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -576,9 +576,9 @@ static int adau1701_set_bias_level(struct snd_soc_codec *codec,
 
 static int adau1701_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int mask = ADAU1701_DSPCTRL_DAM;
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (mute)
@@ -591,11 +591,11 @@ static int adau1701_digital_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+static int adau1701_set_sysclk(struct snd_soc_component *component, int clk_id,
 	int source, unsigned int freq, int dir)
 {
 	unsigned int val;
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case ADAU1701_CLK_SRC_OSC:
@@ -618,7 +618,7 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 static int adau1701_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(dai->codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(dai->component);
 
 	return sigmadsp_restrict_params(adau1701->sigmadsp, substream);
 }
@@ -664,20 +664,20 @@ static const struct of_device_id adau1701_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
 #endif
 
-static int adau1701_probe(struct snd_soc_codec *codec)
+static int adau1701_probe(struct snd_soc_component *component)
 {
 	int i, ret;
 	unsigned int val;
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 
-	ret = sigmadsp_attach(adau1701->sigmadsp, &codec->component);
+	ret = sigmadsp_attach(adau1701->sigmadsp, component);
 	if (ret)
 		return ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(adau1701->supplies),
 				    adau1701->supplies);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		dev_err(component->dev, "Failed to enable regulators: %d\n", ret);
 		return ret;
 	}
 
@@ -690,7 +690,7 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	adau1701->pll_clkdiv = ADAU1707_CLKDIV_UNSET;
 
 	/* initalize with pre-configured pll mode settings */
-	ret = adau1701_reset(codec, adau1701->pll_clkdiv, 0);
+	ret = adau1701_reset(component, adau1701->pll_clkdiv, 0);
 	if (ret < 0)
 		goto exit_regulators_disable;
 
@@ -715,22 +715,20 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int adau1701_remove(struct snd_soc_codec *codec)
+static void adau1701_remove(struct snd_soc_component *component)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 
 	if (gpio_is_valid(adau1701->gpio_nreset))
 		gpio_set_value_cansleep(adau1701->gpio_nreset, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies), adau1701->supplies);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
-static int adau1701_suspend(struct snd_soc_codec *codec)
+static int adau1701_suspend(struct snd_soc_component *component)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 
 	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies),
 			       adau1701->supplies);
@@ -738,42 +736,41 @@ static int adau1701_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int adau1701_resume(struct snd_soc_codec *codec)
+static int adau1701_resume(struct snd_soc_component *component)
 {
-	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	int ret;
 
         ret = regulator_bulk_enable(ARRAY_SIZE(adau1701->supplies),
 				    adau1701->supplies);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		dev_err(component->dev, "Failed to enable regulators: %d\n", ret);
 		return ret;
 	}
 
-	return adau1701_reset(codec, adau1701->pll_clkdiv, 0);
+	return adau1701_reset(component, adau1701->pll_clkdiv, 0);
 }
 #else
 #define adau1701_resume 	NULL
 #define adau1701_suspend 	NULL
 #endif /* CONFIG_PM */
 
-static const struct snd_soc_codec_driver adau1701_codec_drv = {
+static const struct snd_soc_component_driver adau1701_component_drv = {
 	.probe			= adau1701_probe,
 	.remove			= adau1701_remove,
 	.resume			= adau1701_resume,
 	.suspend		= adau1701_suspend,
 	.set_bias_level		= adau1701_set_bias_level,
-	.idle_bias_off		= true,
-
-	.component_driver = {
-		.controls		= adau1701_controls,
-		.num_controls		= ARRAY_SIZE(adau1701_controls),
-		.dapm_widgets		= adau1701_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(adau1701_dapm_widgets),
-		.dapm_routes		= adau1701_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(adau1701_dapm_routes),
-	},
+	.controls		= adau1701_controls,
+	.num_controls		= ARRAY_SIZE(adau1701_controls),
+	.dapm_widgets		= adau1701_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(adau1701_dapm_widgets),
+	.dapm_routes		= adau1701_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(adau1701_dapm_routes),
 	.set_sysclk		= adau1701_set_sysclk,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config adau1701_regmap = {
@@ -889,7 +886,8 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 		goto exit_regulators_disable;
 	}
 
-	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
+	ret = devm_snd_soc_register_component(&client->dev,
+			&adau1701_component_drv,
 			&adau1701_dai, 1);
 
 exit_regulators_disable:
@@ -898,12 +896,6 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int adau1701_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id adau1701_i2c_id[] = {
 	{ "adau1401", 0 },
 	{ "adau1401a", 0 },
@@ -919,7 +911,6 @@ static struct i2c_driver adau1701_i2c_driver = {
 		.of_match_table	= of_match_ptr(adau1701_dt_ids),
 	},
 	.probe		= adau1701_i2c_probe,
-	.remove		= adau1701_i2c_remove,
 	.id_table	= adau1701_i2c_id,
 };
 
-- 
2.16.1
