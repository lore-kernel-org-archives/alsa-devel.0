From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:43:29 +0000
Message-ID: <E1elDSD-00053k-0u@debutante>
References: <878tch1fn9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 496CB26787B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:43:31 +0100 (CET)
In-Reply-To: <878tch1fn9.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: cs42l56: replace codec to component

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

>From e48f7466f9d93232da3f33ca722aa23a0a892f9e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:58:25 +0000
Subject: [PATCH] ASoC: cs42l56: replace codec to component

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
 sound/soc/codecs/cs42l56.c | 158 ++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 80 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index fd7b8d32c2b2..a5c8736fad77 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -45,7 +45,7 @@ static const char *const cs42l56_supply_names[CS42L56_NUM_SUPPLIES] = {
 
 struct  cs42l56_private {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct device *dev;
 	struct cs42l56_platform_data pdata;
 	struct regulator_bulk_data supplies[CS42L56_NUM_SUPPLIES];
@@ -726,8 +726,8 @@ static int cs42l56_get_mclk_ratio(int mclk, int rate)
 static int cs42l56_set_sysclk(struct snd_soc_dai *codec_dai,
 			int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 
 	switch (freq) {
 	case CS42L56_MCLK_5P6448MHZ:
@@ -753,10 +753,10 @@ static int cs42l56_set_sysclk(struct snd_soc_dai *codec_dai,
 	}
 	cs42l56->mclk = freq;
 
-	snd_soc_update_bits(codec, CS42L56_CLKCTL_1,
+	snd_soc_component_update_bits(component, CS42L56_CLKCTL_1,
 			    CS42L56_MCLK_PREDIV_MASK,
 				cs42l56->mclk_prediv);
-	snd_soc_update_bits(codec, CS42L56_CLKCTL_1,
+	snd_soc_component_update_bits(component, CS42L56_CLKCTL_1,
 			    CS42L56_MCLK_DIV2_MASK,
 				cs42l56->mclk_div2);
 
@@ -765,8 +765,8 @@ static int cs42l56_set_sysclk(struct snd_soc_dai *codec_dai,
 
 static int cs42l56_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -803,22 +803,22 @@ static int cs42l56_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, CS42L56_CLKCTL_1,
+	snd_soc_component_update_bits(component, CS42L56_CLKCTL_1,
 			    CS42L56_MS_MODE_MASK, cs42l56->iface);
-	snd_soc_update_bits(codec, CS42L56_SERIAL_FMT,
+	snd_soc_component_update_bits(component, CS42L56_SERIAL_FMT,
 			    CS42L56_DIG_FMT_MASK, cs42l56->iface_fmt);
-	snd_soc_update_bits(codec, CS42L56_CLKCTL_1,
+	snd_soc_component_update_bits(component, CS42L56_CLKCTL_1,
 			    CS42L56_SCLK_INV_MASK, cs42l56->iface_inv);
 	return 0;
 }
 
 static int cs42l56_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
 	if (mute) {
 		/* Hit the DSP Mixer first */
-		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
+		snd_soc_component_update_bits(component, CS42L56_DSP_MUTE_CTL,
 				    CS42L56_ADCAMIX_MUTE_MASK |
 				    CS42L56_ADCBMIX_MUTE_MASK |
 				    CS42L56_PCMAMIX_MUTE_MASK |
@@ -827,21 +827,21 @@ static int cs42l56_digital_mute(struct snd_soc_dai *dai, int mute)
 				    CS42L56_MSTA_MUTE_MASK,
 				    CS42L56_MUTE_ALL);
 		/* Mute ADC's */
-		snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
+		snd_soc_component_update_bits(component, CS42L56_MISC_ADC_CTL,
 				    CS42L56_ADCA_MUTE_MASK |
 				    CS42L56_ADCB_MUTE_MASK,
 				    CS42L56_MUTE_ALL);
 		/* HP And LO */
-		snd_soc_update_bits(codec, CS42L56_HPA_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_HPA_VOLUME,
 				    CS42L56_HP_MUTE_MASK, CS42L56_MUTE_ALL);
-		snd_soc_update_bits(codec, CS42L56_HPB_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_HPB_VOLUME,
 				    CS42L56_HP_MUTE_MASK, CS42L56_MUTE_ALL);
-		snd_soc_update_bits(codec, CS42L56_LOA_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_LOA_VOLUME,
 				    CS42L56_LO_MUTE_MASK, CS42L56_MUTE_ALL);
-		snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_LOB_VOLUME,
 				    CS42L56_LO_MUTE_MASK, CS42L56_MUTE_ALL);
 	} else {
-		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
+		snd_soc_component_update_bits(component, CS42L56_DSP_MUTE_CTL,
 				    CS42L56_ADCAMIX_MUTE_MASK |
 				    CS42L56_ADCBMIX_MUTE_MASK |
 				    CS42L56_PCMAMIX_MUTE_MASK |
@@ -850,18 +850,18 @@ static int cs42l56_digital_mute(struct snd_soc_dai *dai, int mute)
 				    CS42L56_MSTA_MUTE_MASK,
 				    CS42L56_UNMUTE);
 
-		snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
+		snd_soc_component_update_bits(component, CS42L56_MISC_ADC_CTL,
 				    CS42L56_ADCA_MUTE_MASK |
 				    CS42L56_ADCB_MUTE_MASK,
 				    CS42L56_UNMUTE);
 
-		snd_soc_update_bits(codec, CS42L56_HPA_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_HPA_VOLUME,
 				    CS42L56_HP_MUTE_MASK, CS42L56_UNMUTE);
-		snd_soc_update_bits(codec, CS42L56_HPB_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_HPB_VOLUME,
 				    CS42L56_HP_MUTE_MASK, CS42L56_UNMUTE);
-		snd_soc_update_bits(codec, CS42L56_LOA_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_LOA_VOLUME,
 				    CS42L56_LO_MUTE_MASK, CS42L56_UNMUTE);
-		snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
+		snd_soc_component_update_bits(component, CS42L56_LOB_VOLUME,
 				    CS42L56_LO_MUTE_MASK, CS42L56_UNMUTE);
 	}
 	return 0;
@@ -871,39 +871,39 @@ static int cs42l56_pcm_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params,
 				     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 	int ratio;
 
 	ratio = cs42l56_get_mclk_ratio(cs42l56->mclk, params_rate(params));
 	if (ratio >= 0) {
-		snd_soc_update_bits(codec, CS42L56_CLKCTL_2,
+		snd_soc_component_update_bits(component, CS42L56_CLKCTL_2,
 				    CS42L56_CLK_RATIO_MASK, ratio);
 	} else {
-		dev_err(codec->dev, "unsupported mclk/sclk/lrclk ratio\n");
+		dev_err(component->dev, "unsupported mclk/sclk/lrclk ratio\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int cs42l56_set_bias_level(struct snd_soc_codec *codec,
+static int cs42l56_set_bias_level(struct snd_soc_component *component,
 					enum snd_soc_bias_level level)
 {
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		snd_soc_update_bits(codec, CS42L56_CLKCTL_1,
+		snd_soc_component_update_bits(component, CS42L56_CLKCTL_1,
 				    CS42L56_MCLK_DIS_MASK, 0);
-		snd_soc_update_bits(codec, CS42L56_PWRCTL_1,
+		snd_soc_component_update_bits(component, CS42L56_PWRCTL_1,
 				    CS42L56_PDN_ALL_MASK, 0);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_cache_only(cs42l56->regmap, false);
 			regcache_sync(cs42l56->regmap);
 			ret = regulator_bulk_enable(ARRAY_SIZE(cs42l56->supplies),
@@ -915,13 +915,13 @@ static int cs42l56_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 		}
-		snd_soc_update_bits(codec, CS42L56_PWRCTL_1,
+		snd_soc_component_update_bits(component, CS42L56_PWRCTL_1,
 				    CS42L56_PDN_ALL_MASK, 1);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, CS42L56_PWRCTL_1,
+		snd_soc_component_update_bits(component, CS42L56_PWRCTL_1,
 				    CS42L56_PDN_ALL_MASK, 1);
-		snd_soc_update_bits(codec, CS42L56_CLKCTL_1,
+		snd_soc_component_update_bits(component, CS42L56_CLKCTL_1,
 				    CS42L56_MCLK_DIS_MASK, 1);
 		regcache_cache_only(cs42l56->regmap, true);
 		regulator_bulk_disable(ARRAY_SIZE(cs42l56->supplies),
@@ -974,8 +974,8 @@ static void cs42l56_beep_work(struct work_struct *work)
 {
 	struct cs42l56_private *cs42l56 =
 		container_of(work, struct cs42l56_private, beep_work);
-	struct snd_soc_codec *codec = cs42l56->codec;
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = cs42l56->component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int i;
 	int val = 0;
 	int best = 0;
@@ -987,18 +987,18 @@ static void cs42l56_beep_work(struct work_struct *work)
 				best = i;
 		}
 
-		dev_dbg(codec->dev, "Set beep rate %dHz for requested %dHz\n",
+		dev_dbg(component->dev, "Set beep rate %dHz for requested %dHz\n",
 			beep_freq[best], cs42l56->beep_rate);
 
 		val = (best << CS42L56_BEEP_RATE_SHIFT);
 
 		snd_soc_dapm_enable_pin(dapm, "Beep");
 	} else {
-		dev_dbg(codec->dev, "Disabling beep\n");
+		dev_dbg(component->dev, "Disabling beep\n");
 		snd_soc_dapm_disable_pin(dapm, "Beep");
 	}
 
-	snd_soc_update_bits(codec, CS42L56_BEEP_FREQ_ONTIME,
+	snd_soc_component_update_bits(component, CS42L56_BEEP_FREQ_ONTIME,
 			    CS42L56_BEEP_FREQ_MASK, val);
 
 	snd_soc_dapm_sync(dapm);
@@ -1010,10 +1010,10 @@ static void cs42l56_beep_work(struct work_struct *work)
 static int cs42l56_beep_event(struct input_dev *dev, unsigned int type,
 			     unsigned int code, int hz)
 {
-	struct snd_soc_codec *codec = input_get_drvdata(dev);
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = input_get_drvdata(dev);
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "Beep event %x %x\n", code, hz);
+	dev_dbg(component->dev, "Beep event %x %x\n", code, hz);
 
 	switch (code) {
 	case SND_BELL:
@@ -1050,14 +1050,14 @@ static ssize_t cs42l56_beep_set(struct device *dev,
 
 static DEVICE_ATTR(beep, 0200, NULL, cs42l56_beep_set);
 
-static void cs42l56_init_beep(struct snd_soc_codec *codec)
+static void cs42l56_init_beep(struct snd_soc_component *component)
 {
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	cs42l56->beep = devm_input_allocate_device(codec->dev);
+	cs42l56->beep = devm_input_allocate_device(component->dev);
 	if (!cs42l56->beep) {
-		dev_err(codec->dev, "Failed to allocate beep device\n");
+		dev_err(component->dev, "Failed to allocate beep device\n");
 		return;
 	}
 
@@ -1065,68 +1065,67 @@ static void cs42l56_init_beep(struct snd_soc_codec *codec)
 	cs42l56->beep_rate = 0;
 
 	cs42l56->beep->name = "CS42L56 Beep Generator";
-	cs42l56->beep->phys = dev_name(codec->dev);
+	cs42l56->beep->phys = dev_name(component->dev);
 	cs42l56->beep->id.bustype = BUS_I2C;
 
 	cs42l56->beep->evbit[0] = BIT_MASK(EV_SND);
 	cs42l56->beep->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
 	cs42l56->beep->event = cs42l56_beep_event;
-	cs42l56->beep->dev.parent = codec->dev;
-	input_set_drvdata(cs42l56->beep, codec);
+	cs42l56->beep->dev.parent = component->dev;
+	input_set_drvdata(cs42l56->beep, component);
 
 	ret = input_register_device(cs42l56->beep);
 	if (ret != 0) {
 		cs42l56->beep = NULL;
-		dev_err(codec->dev, "Failed to register beep device\n");
+		dev_err(component->dev, "Failed to register beep device\n");
 	}
 
-	ret = device_create_file(codec->dev, &dev_attr_beep);
+	ret = device_create_file(component->dev, &dev_attr_beep);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to create keyclick file: %d\n",
+		dev_err(component->dev, "Failed to create keyclick file: %d\n",
 			ret);
 	}
 }
 
-static void cs42l56_free_beep(struct snd_soc_codec *codec)
+static void cs42l56_free_beep(struct snd_soc_component *component)
 {
-	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l56_private *cs42l56 = snd_soc_component_get_drvdata(component);
 
-	device_remove_file(codec->dev, &dev_attr_beep);
+	device_remove_file(component->dev, &dev_attr_beep);
 	cancel_work_sync(&cs42l56->beep_work);
 	cs42l56->beep = NULL;
 
-	snd_soc_update_bits(codec, CS42L56_BEEP_TONE_CFG,
+	snd_soc_component_update_bits(component, CS42L56_BEEP_TONE_CFG,
 			    CS42L56_BEEP_EN_MASK, 0);
 }
 
-static int cs42l56_probe(struct snd_soc_codec *codec)
+static int cs42l56_probe(struct snd_soc_component *component)
 {
-	cs42l56_init_beep(codec);
+	cs42l56_init_beep(component);
 
 	return 0;
 }
 
-static int cs42l56_remove(struct snd_soc_codec *codec)
+static void cs42l56_remove(struct snd_soc_component *component)
 {
-	cs42l56_free_beep(codec);
-
-	return 0;
+	cs42l56_free_beep(component);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_cs42l56 = {
-	.probe = cs42l56_probe,
-	.remove = cs42l56_remove,
-	.set_bias_level = cs42l56_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= cs42l56_snd_controls,
-		.num_controls		= ARRAY_SIZE(cs42l56_snd_controls),
-		.dapm_widgets		= cs42l56_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(cs42l56_dapm_widgets),
-		.dapm_routes		= cs42l56_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(cs42l56_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_cs42l56 = {
+	.probe			= cs42l56_probe,
+	.remove			= cs42l56_remove,
+	.set_bias_level		= cs42l56_set_bias_level,
+	.controls		= cs42l56_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs42l56_snd_controls),
+	.dapm_widgets		= cs42l56_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs42l56_dapm_widgets),
+	.dapm_routes		= cs42l56_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(cs42l56_audio_map),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config cs42l56_regmap = {
@@ -1315,8 +1314,8 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 				   CS42L56_ADAPT_PWR_MASK,
 				cs42l56->pdata.adaptive_pwr);
 
-	ret =  snd_soc_register_codec(&i2c_client->dev,
-			&soc_codec_dev_cs42l56, &cs42l56_dai, 1);
+	ret =  devm_snd_soc_register_component(&i2c_client->dev,
+			&soc_component_dev_cs42l56, &cs42l56_dai, 1);
 	if (ret < 0)
 		return ret;
 
@@ -1332,7 +1331,6 @@ static int cs42l56_i2c_remove(struct i2c_client *client)
 {
 	struct cs42l56_private *cs42l56 = i2c_get_clientdata(client);
 
-	snd_soc_unregister_codec(&client->dev);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l56->supplies),
 			       cs42l56->supplies);
 	return 0;
-- 
2.16.1
