From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l52: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:43:44 +0000
Message-ID: <E1elDSS-00054d-65@debutante>
References: <87a7wx1fo2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BA3A2675B2
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:43:46 +0100 (CET)
In-Reply-To: <87a7wx1fo2.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: cs42l52: replace codec to component

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

>From 9665a74944b321d060ca626b9a8bee579466ba29 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:57:55 +0000
Subject: [PATCH] ASoC: cs42l52: replace codec to component

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
 sound/soc/codecs/cs42l52.c | 146 +++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 77 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 9731e5dff291..3d83c1be1292 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -42,7 +42,7 @@ struct sp_config {
 
 struct  cs42l52_private {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct device *dev;
 	struct sp_config config;
 	struct cs42l52_platform_data pdata;
@@ -473,17 +473,17 @@ static const struct snd_kcontrol_new cs42l52_micb_controls[] = {
 	SOC_ENUM("MICB Select", micb_enum),
 };
 
-static int cs42l52_add_mic_controls(struct snd_soc_codec *codec)
+static int cs42l52_add_mic_controls(struct snd_soc_component *component)
 {
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 	struct cs42l52_platform_data *pdata = &cs42l52->pdata;
 
 	if (!pdata->mica_diff_cfg)
-		snd_soc_add_codec_controls(codec, cs42l52_mica_controls,
+		snd_soc_add_component_controls(component, cs42l52_mica_controls,
 				     ARRAY_SIZE(cs42l52_mica_controls));
 
 	if (!pdata->micb_diff_cfg)
-		snd_soc_add_codec_controls(codec, cs42l52_micb_controls,
+		snd_soc_add_component_controls(component, cs42l52_micb_controls,
 				     ARRAY_SIZE(cs42l52_micb_controls));
 
 	return 0;
@@ -716,13 +716,13 @@ static int cs42l52_get_clk(int mclk, int rate)
 static int cs42l52_set_sysclk(struct snd_soc_dai *codec_dai,
 			int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 
 	if ((freq >= CS42L52_MIN_CLK) && (freq <= CS42L52_MAX_CLK)) {
 		cs42l52->sysclk = freq;
 	} else {
-		dev_err(codec->dev, "Invalid freq parameter\n");
+		dev_err(component->dev, "Invalid freq parameter\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -730,8 +730,8 @@ static int cs42l52_set_sysclk(struct snd_soc_dai *codec_dai,
 
 static int cs42l52_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 	u8 iface = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -783,21 +783,21 @@ static int cs42l52_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 	cs42l52->config.format = iface;
-	snd_soc_write(codec, CS42L52_IFACE_CTL1, cs42l52->config.format);
+	snd_soc_component_write(component, CS42L52_IFACE_CTL1, cs42l52->config.format);
 
 	return 0;
 }
 
 static int cs42l52_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
 	if (mute)
-		snd_soc_update_bits(codec, CS42L52_PB_CTL1,
+		snd_soc_component_update_bits(component, CS42L52_PB_CTL1,
 				    CS42L52_PB_CTL1_MUTE_MASK,
 				CS42L52_PB_CTL1_MUTE);
 	else
-		snd_soc_update_bits(codec, CS42L52_PB_CTL1,
+		snd_soc_component_update_bits(component, CS42L52_PB_CTL1,
 				    CS42L52_PB_CTL1_MUTE_MASK,
 				CS42L52_PB_CTL1_UNMUTE);
 
@@ -808,8 +808,8 @@ static int cs42l52_pcm_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params,
 				     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 	u32 clk = 0;
 	int index;
 
@@ -823,36 +823,36 @@ static int cs42l52_pcm_hw_params(struct snd_pcm_substream *substream,
 		(clk_map_table[index].ratio << CLK_RATIO_SHIFT) |
 		clk_map_table[index].mclkdiv2;
 
-		snd_soc_write(codec, CS42L52_CLK_CTL, clk);
+		snd_soc_component_write(component, CS42L52_CLK_CTL, clk);
 	} else {
-		dev_err(codec->dev, "can't get correct mclk\n");
+		dev_err(component->dev, "can't get correct mclk\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int cs42l52_set_bias_level(struct snd_soc_codec *codec,
+static int cs42l52_set_bias_level(struct snd_soc_component *component,
 					enum snd_soc_bias_level level)
 {
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		snd_soc_update_bits(codec, CS42L52_PWRCTL1,
+		snd_soc_component_update_bits(component, CS42L52_PWRCTL1,
 				    CS42L52_PWRCTL1_PDN_CODEC, 0);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_cache_only(cs42l52->regmap, false);
 			regcache_sync(cs42l52->regmap);
 		}
-		snd_soc_write(codec, CS42L52_PWRCTL1, CS42L52_PWRCTL1_PDN_ALL);
+		snd_soc_component_write(component, CS42L52_PWRCTL1, CS42L52_PWRCTL1_PDN_ALL);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, CS42L52_PWRCTL1, CS42L52_PWRCTL1_PDN_ALL);
+		snd_soc_component_write(component, CS42L52_PWRCTL1, CS42L52_PWRCTL1_PDN_ALL);
 		regcache_cache_only(cs42l52->regmap, true);
 		break;
 	}
@@ -902,8 +902,8 @@ static void cs42l52_beep_work(struct work_struct *work)
 {
 	struct cs42l52_private *cs42l52 =
 		container_of(work, struct cs42l52_private, beep_work);
-	struct snd_soc_codec *codec = cs42l52->codec;
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = cs42l52->component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int i;
 	int val = 0;
 	int best = 0;
@@ -915,18 +915,18 @@ static void cs42l52_beep_work(struct work_struct *work)
 				best = i;
 		}
 
-		dev_dbg(codec->dev, "Set beep rate %dHz for requested %dHz\n",
+		dev_dbg(component->dev, "Set beep rate %dHz for requested %dHz\n",
 			beep_rates[best], cs42l52->beep_rate);
 
 		val = (best << CS42L52_BEEP_RATE_SHIFT);
 
 		snd_soc_dapm_enable_pin(dapm, "Beep");
 	} else {
-		dev_dbg(codec->dev, "Disabling beep\n");
+		dev_dbg(component->dev, "Disabling beep\n");
 		snd_soc_dapm_disable_pin(dapm, "Beep");
 	}
 
-	snd_soc_update_bits(codec, CS42L52_BEEP_FREQ,
+	snd_soc_component_update_bits(component, CS42L52_BEEP_FREQ,
 			    CS42L52_BEEP_RATE_MASK, val);
 
 	snd_soc_dapm_sync(dapm);
@@ -938,10 +938,10 @@ static void cs42l52_beep_work(struct work_struct *work)
 static int cs42l52_beep_event(struct input_dev *dev, unsigned int type,
 			     unsigned int code, int hz)
 {
-	struct snd_soc_codec *codec = input_get_drvdata(dev);
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = input_get_drvdata(dev);
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "Beep event %x %x\n", code, hz);
+	dev_dbg(component->dev, "Beep event %x %x\n", code, hz);
 
 	switch (code) {
 	case SND_BELL:
@@ -978,14 +978,14 @@ static ssize_t cs42l52_beep_set(struct device *dev,
 
 static DEVICE_ATTR(beep, 0200, NULL, cs42l52_beep_set);
 
-static void cs42l52_init_beep(struct snd_soc_codec *codec)
+static void cs42l52_init_beep(struct snd_soc_component *component)
 {
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	cs42l52->beep = devm_input_allocate_device(codec->dev);
+	cs42l52->beep = devm_input_allocate_device(component->dev);
 	if (!cs42l52->beep) {
-		dev_err(codec->dev, "Failed to allocate beep device\n");
+		dev_err(component->dev, "Failed to allocate beep device\n");
 		return;
 	}
 
@@ -993,49 +993,49 @@ static void cs42l52_init_beep(struct snd_soc_codec *codec)
 	cs42l52->beep_rate = 0;
 
 	cs42l52->beep->name = "CS42L52 Beep Generator";
-	cs42l52->beep->phys = dev_name(codec->dev);
+	cs42l52->beep->phys = dev_name(component->dev);
 	cs42l52->beep->id.bustype = BUS_I2C;
 
 	cs42l52->beep->evbit[0] = BIT_MASK(EV_SND);
 	cs42l52->beep->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
 	cs42l52->beep->event = cs42l52_beep_event;
-	cs42l52->beep->dev.parent = codec->dev;
-	input_set_drvdata(cs42l52->beep, codec);
+	cs42l52->beep->dev.parent = component->dev;
+	input_set_drvdata(cs42l52->beep, component);
 
 	ret = input_register_device(cs42l52->beep);
 	if (ret != 0) {
 		cs42l52->beep = NULL;
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
 
-static void cs42l52_free_beep(struct snd_soc_codec *codec)
+static void cs42l52_free_beep(struct snd_soc_component *component)
 {
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 
-	device_remove_file(codec->dev, &dev_attr_beep);
+	device_remove_file(component->dev, &dev_attr_beep);
 	cancel_work_sync(&cs42l52->beep_work);
 	cs42l52->beep = NULL;
 
-	snd_soc_update_bits(codec, CS42L52_BEEP_TONE_CTL,
+	snd_soc_component_update_bits(component, CS42L52_BEEP_TONE_CTL,
 			    CS42L52_BEEP_EN_MASK, 0);
 }
 
-static int cs42l52_probe(struct snd_soc_codec *codec)
+static int cs42l52_probe(struct snd_soc_component *component)
 {
-	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l52_private *cs42l52 = snd_soc_component_get_drvdata(component);
 
 	regcache_cache_only(cs42l52->regmap, true);
 
-	cs42l52_add_mic_controls(codec);
+	cs42l52_add_mic_controls(component);
 
-	cs42l52_init_beep(codec);
+	cs42l52_init_beep(component);
 
 	cs42l52->sysclk = CS42L52_DEFAULT_CLK;
 	cs42l52->config.format = CS42L52_DEFAULT_FORMAT;
@@ -1043,27 +1043,26 @@ static int cs42l52_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int cs42l52_remove(struct snd_soc_codec *codec)
+static void cs42l52_remove(struct snd_soc_component *component)
 {
-	cs42l52_free_beep(codec);
-
-	return 0;
+	cs42l52_free_beep(component);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_cs42l52 = {
-	.probe = cs42l52_probe,
-	.remove = cs42l52_remove,
-	.set_bias_level = cs42l52_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= cs42l52_snd_controls,
-		.num_controls		= ARRAY_SIZE(cs42l52_snd_controls),
-		.dapm_widgets		= cs42l52_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(cs42l52_dapm_widgets),
-		.dapm_routes		= cs42l52_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(cs42l52_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_cs42l52 = {
+	.probe			= cs42l52_probe,
+	.remove			= cs42l52_remove,
+	.set_bias_level		= cs42l52_set_bias_level,
+	.controls		= cs42l52_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs42l52_snd_controls),
+	.dapm_widgets		= cs42l52_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs42l52_dapm_widgets),
+	.dapm_routes		= cs42l52_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(cs42l52_audio_map),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 /* Current and threshold powerup sequence Pg37 */
@@ -1202,19 +1201,13 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 				   CS42L52_IFACE_CTL2_BIAS_LVL,
 				cs42l52->pdata.micbias_lvl);
 
-	ret =  snd_soc_register_codec(&i2c_client->dev,
-			&soc_codec_dev_cs42l52, &cs42l52_dai, 1);
+	ret =  devm_snd_soc_register_component(&i2c_client->dev,
+			&soc_component_dev_cs42l52, &cs42l52_dai, 1);
 	if (ret < 0)
 		return ret;
 	return 0;
 }
 
-static int cs42l52_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct of_device_id cs42l52_of_match[] = {
 	{ .compatible = "cirrus,cs42l52", },
 	{},
@@ -1235,7 +1228,6 @@ static struct i2c_driver cs42l52_i2c_driver = {
 	},
 	.id_table = cs42l52_id,
 	.probe =    cs42l52_i2c_probe,
-	.remove =   cs42l52_i2c_remove,
 };
 
 module_i2c_driver(cs42l52_i2c_driver);
-- 
2.16.1
