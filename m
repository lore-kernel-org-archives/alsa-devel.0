From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1/adau1761/adau1781: replace
	codec to component" to the asoc tree
Date: Mon, 12 Feb 2018 12:40:10 +0000
Message-ID: <E1elDP0-0004gB-0E@debutante>
References: <877es1z4mm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DAB3267445
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:40:12 +0100 (CET)
In-Reply-To: <877es1z4mm.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: adau17x1/adau1761/adau1781: replace codec to component

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

>From dd08102a9ff8aec720946f2b229a076b48bc8cf0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:12:24 +0000
Subject: [PATCH] ASoC: adau17x1/adau1761/adau1781: replace codec to component

Now we can replace Codec to Component. Let's do it.

Because there are many drivers which are using adau17x1,
we need to update these all related drivers in same time.
Otherwise compile error/warning happen

adau1761:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

adau1781:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761.c | 88 +++++++++++++++++++++++----------------------
 sound/soc/codecs/adau1781.c | 51 +++++++++++++-------------
 sound/soc/codecs/adau17x1.c | 67 +++++++++++++++++-----------------
 sound/soc/codecs/adau17x1.h |  8 ++---
 4 files changed, 108 insertions(+), 106 deletions(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 3bc3cc559dde..be136e981653 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -255,8 +255,8 @@ static const struct snd_kcontrol_new adau1761_input_mux_control =
 static int adau1761_dejitter_fixup(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	/* After any power changes have been made the dejitter circuit
 	 * has to be reinitialized. */
@@ -445,10 +445,10 @@ static const struct snd_soc_dapm_route adau1761_dapm_routes[] = {
 	{ "Digital Clock 1", NULL, "SYSCLK" },
 };
 
-static int adau1761_set_bias_level(struct snd_soc_codec *codec,
+static int adau1761_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -460,7 +460,7 @@ static int adau1761_set_bias_level(struct snd_soc_codec *codec,
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN);
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			regcache_sync(adau->regmap);
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -474,9 +474,9 @@ static int adau1761_set_bias_level(struct snd_soc_codec *codec,
 }
 
 static enum adau1761_output_mode adau1761_get_lineout_mode(
-	struct snd_soc_codec *codec)
+	struct snd_soc_component *component)
 {
-	struct adau1761_platform_data *pdata = codec->dev->platform_data;
+	struct adau1761_platform_data *pdata = component->dev->platform_data;
 
 	if (pdata)
 		return pdata->lineout_mode;
@@ -484,11 +484,11 @@ static enum adau1761_output_mode adau1761_get_lineout_mode(
 	return ADAU1761_OUTPUT_MODE_LINE;
 }
 
-static int adau1761_setup_digmic_jackdetect(struct snd_soc_codec *codec)
+static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau1761_platform_data *pdata = codec->dev->platform_data;
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau1761_platform_data *pdata = component->dev->platform_data;
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	enum adau1761_digmic_jackdet_pin_mode mode;
 	unsigned int val = 0;
 	int ret;
@@ -513,7 +513,7 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_codec *codec)
 		if (pdata->jackdetect_active_low)
 			val |= ADAU1761_DIGMIC_JACKDETECT_ACTIVE_LOW;
 
-		ret = snd_soc_add_codec_controls(codec,
+		ret = snd_soc_add_component_controls(component,
 			adau1761_jack_detect_controls,
 			ARRAY_SIZE(adau1761_jack_detect_controls));
 		if (ret)
@@ -546,11 +546,11 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int adau1761_setup_headphone_mode(struct snd_soc_codec *codec)
+static int adau1761_setup_headphone_mode(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
-	struct adau1761_platform_data *pdata = codec->dev->platform_data;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
+	struct adau1761_platform_data *pdata = component->dev->platform_data;
 	enum adau1761_output_mode mode;
 	int ret;
 
@@ -588,7 +588,7 @@ static int adau1761_setup_headphone_mode(struct snd_soc_codec *codec)
 			adau1761_capless_dapm_routes,
 			ARRAY_SIZE(adau1761_capless_dapm_routes));
 	} else {
-		ret = snd_soc_add_codec_controls(codec, adau1761_mono_controls,
+		ret = snd_soc_add_component_controls(component, adau1761_mono_controls,
 			ARRAY_SIZE(adau1761_mono_controls));
 		if (ret)
 			return ret;
@@ -640,14 +640,14 @@ static bool adau1761_readable_register(struct device *dev, unsigned int reg)
 	return adau17x1_readable_register(dev, reg);
 }
 
-static int adau1761_codec_probe(struct snd_soc_codec *codec)
+static int adau1761_component_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau1761_platform_data *pdata = codec->dev->platform_data;
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau1761_platform_data *pdata = component->dev->platform_data;
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	ret = adau17x1_add_widgets(codec);
+	ret = adau17x1_add_widgets(component);
 	if (ret < 0)
 		return ret;
 
@@ -658,20 +658,20 @@ static int adau1761_codec_probe(struct snd_soc_codec *codec)
 		regmap_update_bits(adau->regmap, ADAU1761_RIGHT_DIFF_INPUT_VOL,
 			ADAU1761_DIFF_INPUT_VOL_LDEN,
 			ADAU1761_DIFF_INPUT_VOL_LDEN);
-		ret = snd_soc_add_codec_controls(codec,
+		ret = snd_soc_add_component_controls(component,
 			adau1761_differential_mode_controls,
 			ARRAY_SIZE(adau1761_differential_mode_controls));
 		if (ret)
 			return ret;
 	} else {
-		ret = snd_soc_add_codec_controls(codec,
+		ret = snd_soc_add_component_controls(component,
 			adau1761_single_mode_controls,
 			ARRAY_SIZE(adau1761_single_mode_controls));
 		if (ret)
 			return ret;
 	}
 
-	switch (adau1761_get_lineout_mode(codec)) {
+	switch (adau1761_get_lineout_mode(component)) {
 	case ADAU1761_OUTPUT_MODE_LINE:
 		break;
 	case ADAU1761_OUTPUT_MODE_HEADPHONE:
@@ -686,11 +686,11 @@ static int adau1761_codec_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	ret = adau1761_setup_headphone_mode(codec);
+	ret = adau1761_setup_headphone_mode(component);
 	if (ret)
 		return ret;
 
-	ret = adau1761_setup_digmic_jackdetect(codec);
+	ret = adau1761_setup_digmic_jackdetect(component);
 	if (ret)
 		return ret;
 
@@ -706,27 +706,28 @@ static int adau1761_codec_probe(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	ret = adau17x1_add_routes(codec);
+	ret = adau17x1_add_routes(component);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver adau1761_codec_driver = {
-	.probe = adau1761_codec_probe,
-	.resume	= adau17x1_resume,
-	.set_bias_level	= adau1761_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= adau1761_controls,
-		.num_controls		= ARRAY_SIZE(adau1761_controls),
-		.dapm_widgets		= adau1x61_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(adau1x61_dapm_widgets),
-		.dapm_routes		= adau1x61_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(adau1x61_dapm_routes),
-	},
+static const struct snd_soc_component_driver adau1761_component_driver = {
+	.probe			= adau1761_component_probe,
+	.resume			= adau17x1_resume,
+	.set_bias_level		= adau1761_set_bias_level,
+	.controls		= adau1761_controls,
+	.num_controls		= ARRAY_SIZE(adau1761_controls),
+	.dapm_widgets		= adau1x61_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(adau1x61_dapm_widgets),
+	.dapm_routes		= adau1x61_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(adau1x61_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 #define ADAU1761_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
@@ -793,7 +794,8 @@ int adau1761_probe(struct device *dev, struct regmap *regmap,
 	 * reaches standby and the core clock is enabled */
 	regcache_cache_only(regmap, true);
 
-	return snd_soc_register_codec(dev, &adau1761_codec_driver, dai_drv, 1);
+	return devm_snd_soc_register_component(dev, &adau1761_component_driver,
+					       dai_drv, 1);
 }
 EXPORT_SYMBOL_GPL(adau1761_probe);
 
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index 546071c6c0d0..6a6655730cd4 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -174,8 +174,8 @@ static const struct snd_kcontrol_new adau1781_mono_mixer_controls[] = {
 static int adau1781_dejitter_fixup(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	/* After any power changes have been made the dejitter circuit
 	 * has to be reinitialized. */
@@ -314,10 +314,10 @@ static const struct snd_soc_dapm_route adau1781_dmic_dapm_routes[] = {
 	{ "Right Decimator", NULL, "DMIC Select" },
 };
 
-static int adau1781_set_bias_level(struct snd_soc_codec *codec,
+static int adau1781_set_bias_level(struct snd_soc_component *component,
 		enum snd_soc_bias_level level)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -380,14 +380,14 @@ static int adau1781_set_input_mode(struct adau *adau, unsigned int reg,
 		ADAU1781_INPUT_DIFFERNTIAL, val);
 }
 
-static int adau1781_codec_probe(struct snd_soc_codec *codec)
+static int adau1781_component_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau1781_platform_data *pdata = dev_get_platdata(codec->dev);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau1781_platform_data *pdata = dev_get_platdata(component->dev);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	ret = adau17x1_add_widgets(codec);
+	ret = adau17x1_add_widgets(component);
 	if (ret)
 		return ret;
 
@@ -419,27 +419,28 @@ static int adau1781_codec_probe(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	ret = adau17x1_add_routes(codec);
+	ret = adau17x1_add_routes(component);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver adau1781_codec_driver = {
-	.probe = adau1781_codec_probe,
-	.resume = adau17x1_resume,
-	.set_bias_level = adau1781_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= adau1781_controls,
-		.num_controls		= ARRAY_SIZE(adau1781_controls),
-		.dapm_widgets		= adau1781_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(adau1781_dapm_widgets),
-		.dapm_routes		= adau1781_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(adau1781_dapm_routes),
-	},
+static const struct snd_soc_component_driver adau1781_component_driver = {
+	.probe			= adau1781_component_probe,
+	.resume			= adau17x1_resume,
+	.set_bias_level		= adau1781_set_bias_level,
+	.controls		= adau1781_controls,
+	.num_controls		= ARRAY_SIZE(adau1781_controls),
+	.dapm_widgets		= adau1781_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(adau1781_dapm_widgets),
+	.dapm_routes		= adau1781_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(adau1781_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 #define ADAU1781_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
@@ -498,7 +499,7 @@ int adau1781_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	return snd_soc_register_codec(dev, &adau1781_codec_driver,
+	return devm_snd_soc_register_component(dev, &adau1781_component_driver,
 		&adau1781_dai_driver, 1);
 }
 EXPORT_SYMBOL_GPL(adau1781_probe);
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 6758f789b712..df3434982b43 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -63,8 +63,8 @@ static const struct snd_kcontrol_new adau17x1_controls[] = {
 static int adau17x1_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		adau->pll_regs[5] = 1;
@@ -93,8 +93,8 @@ static int adau17x1_pll_event(struct snd_soc_dapm_widget *w,
 static int adau17x1_adc_fixup(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	/*
 	 * If we are capturing, toggle the ADOSR bit in Converter Control 0 to
@@ -177,9 +177,9 @@ static const struct snd_soc_dapm_route adau17x1_dapm_pll_route = {
 static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update update = { 0 };
 	unsigned int stream = e->shift_l;
@@ -205,7 +205,7 @@ static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 	else
 		reg = ADAU17X1_SERIAL_OUTPUT_ROUTE;
 
-	change = snd_soc_test_bits(codec, reg, 0xff, val);
+	change = snd_soc_component_test_bits(component, reg, 0xff, val);
 	if (change) {
 		update.kcontrol = kcontrol;
 		update.mask = 0xff;
@@ -222,8 +222,8 @@ static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 static int adau17x1_dsp_mux_enum_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int stream = e->shift_l;
 	unsigned int reg, val;
@@ -328,8 +328,8 @@ EXPORT_SYMBOL_GPL(adau17x1_has_dsp);
 static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
 	int source, unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	if (freq_in < 8000000 || freq_in > 27000000)
@@ -353,8 +353,8 @@ static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
 static int adau17x1_set_dai_sysclk(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(dai->codec);
-	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(dai->component);
+	struct adau *adau = snd_soc_component_get_drvdata(dai->component);
 	bool is_pll;
 	bool was_pll;
 
@@ -438,8 +438,8 @@ static int adau17x1_auto_pll(struct snd_soc_dai *dai,
 static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	unsigned int val, div, dsp_div;
 	unsigned int freq;
 	int ret;
@@ -531,7 +531,7 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 		unsigned int fmt)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
+	struct adau *adau = snd_soc_component_get_drvdata(dai->component);
 	unsigned int ctrl0, ctrl1;
 	int lrclk_pol;
 
@@ -603,7 +603,7 @@ static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 static int adau17x1_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
+	struct adau *adau = snd_soc_component_get_drvdata(dai->component);
 	unsigned int ser_ctrl0, ser_ctrl1;
 	unsigned int conv_ctrl0, conv_ctrl1;
 
@@ -728,7 +728,7 @@ static int adau17x1_set_dai_tdm_slot(struct snd_soc_dai *dai,
 static int adau17x1_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
+	struct adau *adau = snd_soc_component_get_drvdata(dai->component);
 
 	if (adau->sigmadsp)
 		return sigmadsp_restrict_params(adau->sigmadsp, substream);
@@ -746,10 +746,10 @@ const struct snd_soc_dai_ops adau17x1_dai_ops = {
 };
 EXPORT_SYMBOL_GPL(adau17x1_dai_ops);
 
-int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
+int adau17x1_set_micbias_voltage(struct snd_soc_component *component,
 	enum adau17x1_micbias_voltage micbias)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	switch (micbias) {
 	case ADAU17X1_MICBIAS_0_90_AVDD:
@@ -858,13 +858,13 @@ int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
 }
 EXPORT_SYMBOL_GPL(adau17x1_setup_firmware);
 
-int adau17x1_add_widgets(struct snd_soc_codec *codec)
+int adau17x1_add_widgets(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	ret = snd_soc_add_codec_controls(codec, adau17x1_controls,
+	ret = snd_soc_add_component_controls(component, adau17x1_controls,
 		ARRAY_SIZE(adau17x1_controls));
 	if (ret)
 		return ret;
@@ -882,9 +882,9 @@ int adau17x1_add_widgets(struct snd_soc_codec *codec)
 		if (!adau->sigmadsp)
 			return 0;
 
-		ret = sigmadsp_attach(adau->sigmadsp, &codec->component);
+		ret = sigmadsp_attach(adau->sigmadsp, component);
 		if (ret) {
-			dev_err(codec->dev, "Failed to attach firmware: %d\n",
+			dev_err(component->dev, "Failed to attach firmware: %d\n",
 				ret);
 			return ret;
 		}
@@ -894,10 +894,10 @@ int adau17x1_add_widgets(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(adau17x1_add_widgets);
 
-int adau17x1_add_routes(struct snd_soc_codec *codec)
+int adau17x1_add_routes(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = snd_soc_dapm_add_routes(dapm, adau17x1_dapm_routes,
@@ -920,12 +920,12 @@ int adau17x1_add_routes(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(adau17x1_add_routes);
 
-int adau17x1_resume(struct snd_soc_codec *codec)
+int adau17x1_resume(struct snd_soc_component *component)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	struct adau *adau = snd_soc_component_get_drvdata(component);
 
 	if (adau->switch_mode)
-		adau->switch_mode(codec->dev);
+		adau->switch_mode(component->dev);
 
 	regcache_sync(adau->regmap);
 
@@ -998,7 +998,6 @@ void adau17x1_remove(struct device *dev)
 {
 	struct adau *adau = dev_get_drvdata(dev);
 
-	snd_soc_unregister_codec(dev);
 	if (adau->mclk)
 		clk_disable_unprepare(adau->mclk);
 }
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index eaf8f933bab8..a7b1cb770814 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -53,18 +53,18 @@ struct adau {
 	struct sigmadsp *sigmadsp;
 };
 
-int adau17x1_add_widgets(struct snd_soc_codec *codec);
-int adau17x1_add_routes(struct snd_soc_codec *codec);
+int adau17x1_add_widgets(struct snd_soc_component *component);
+int adau17x1_add_routes(struct snd_soc_component *component);
 int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev),
 	const char *firmware_name);
 void adau17x1_remove(struct device *dev);
-int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
+int adau17x1_set_micbias_voltage(struct snd_soc_component *component,
 	enum adau17x1_micbias_voltage micbias);
 bool adau17x1_readable_register(struct device *dev, unsigned int reg);
 bool adau17x1_volatile_register(struct device *dev, unsigned int reg);
 bool adau17x1_precious_register(struct device *dev, unsigned int reg);
-int adau17x1_resume(struct snd_soc_codec *codec);
+int adau17x1_resume(struct snd_soc_component *component);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
 
-- 
2.16.1
