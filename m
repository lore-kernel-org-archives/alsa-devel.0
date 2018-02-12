From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4641: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:45:50 +0000
Message-ID: <E1elDUU-0005Oe-3V@debutante>
References: <878tch2w8u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C55E267D31
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:45:52 +0100 (CET)
In-Reply-To: <878tch2w8u.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4641: replace codec to component

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

>From 2b5c3e43cb0c5d9f6ab66baabb3dc08ee9f23e7b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:14:32 +0000
Subject: [PATCH] ASoC: ak4641: replace codec to component

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
 sound/soc/codecs/ak4641.c | 91 ++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 60142ff32d4f..05869beff26e 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -70,9 +70,9 @@ static const struct reg_default ak4641_reg_defaults[] = {
 
 static const int deemph_settings[] = {44100, 0, 48000, 32000};
 
-static int ak4641_set_deemph(struct snd_soc_codec *codec)
+static int ak4641_set_deemph(struct snd_soc_component *component)
 {
-	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
+	struct ak4641_priv *ak4641 = snd_soc_component_get_drvdata(component);
 	int i, best = 0;
 
 	for (i = 0 ; i < ARRAY_SIZE(deemph_settings); i++) {
@@ -86,16 +86,16 @@ static int ak4641_set_deemph(struct snd_soc_codec *codec)
 			best = i;
 	}
 
-	dev_dbg(codec->dev, "Set deemphasis %d\n", best);
+	dev_dbg(component->dev, "Set deemphasis %d\n", best);
 
-	return snd_soc_update_bits(codec, AK4641_DAC, 0x3, best);
+	return snd_soc_component_update_bits(component, AK4641_DAC, 0x3, best);
 }
 
 static int ak4641_put_deemph(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct ak4641_priv *ak4641 = snd_soc_component_get_drvdata(component);
 	int deemph = ucontrol->value.integer.value[0];
 
 	if (deemph > 1)
@@ -103,14 +103,14 @@ static int ak4641_put_deemph(struct snd_kcontrol *kcontrol,
 
 	ak4641->deemph = deemph;
 
-	return ak4641_set_deemph(codec);
+	return ak4641_set_deemph(component);
 }
 
 static int ak4641_get_deemph(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct ak4641_priv *ak4641 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = ak4641->deemph;
 	return 0;
@@ -307,8 +307,8 @@ static const struct snd_soc_dapm_route ak4641_audio_map[] = {
 static int ak4641_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct ak4641_priv *ak4641 = snd_soc_component_get_drvdata(component);
 
 	ak4641->sysclk = freq;
 	return 0;
@@ -318,8 +318,8 @@ static int ak4641_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4641_priv *ak4641 = snd_soc_component_get_drvdata(component);
 	int rate = params_rate(params), fs = 256;
 	u8 mode2;
 
@@ -340,16 +340,16 @@ static int ak4641_i2s_hw_params(struct snd_pcm_substream *substream,
 		mode2 = (0x0 << 5);
 		break;
 	default:
-		dev_err(codec->dev, "Error: unsupported fs=%d\n", fs);
+		dev_err(component->dev, "Error: unsupported fs=%d\n", fs);
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, AK4641_MODE2, (0x3 << 5), mode2);
+	snd_soc_component_update_bits(component, AK4641_MODE2, (0x3 << 5), mode2);
 
 	/* Update de-emphasis filter for the new rate */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ak4641->playback_fs = rate;
-		ak4641_set_deemph(codec);
+		ak4641_set_deemph(component);
 	}
 
 	return 0;
@@ -358,7 +358,7 @@ static int ak4641_i2s_hw_params(struct snd_pcm_substream *substream,
 static int ak4641_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
 				  unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u8 btif;
 	int ret;
 
@@ -380,7 +380,7 @@ static int ak4641_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	ret = snd_soc_update_bits(codec, AK4641_BTIF, (0x3 << 5), btif);
+	ret = snd_soc_component_update_bits(component, AK4641_BTIF, (0x3 << 5), btif);
 	if (ret < 0)
 		return ret;
 
@@ -390,7 +390,7 @@ static int ak4641_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int ak4641_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u8 mode1 = 0;
 
 	/* interface format */
@@ -405,34 +405,34 @@ static int ak4641_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	return snd_soc_write(codec, AK4641_MODE1, mode1);
+	return snd_soc_component_write(component, AK4641_MODE1, mode1);
 }
 
 static int ak4641_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
-	return snd_soc_update_bits(codec, AK4641_DAC, 0x20, mute ? 0x20 : 0);
+	return snd_soc_component_update_bits(component, AK4641_DAC, 0x20, mute ? 0x20 : 0);
 }
 
-static int ak4641_set_bias_level(struct snd_soc_codec *codec,
+static int ak4641_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
-	struct ak4641_platform_data *pdata = codec->dev->platform_data;
+	struct ak4641_priv *ak4641 = snd_soc_component_get_drvdata(component);
+	struct ak4641_platform_data *pdata = component->dev->platform_data;
 	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* unmute */
-		snd_soc_update_bits(codec, AK4641_DAC, 0x20, 0);
+		snd_soc_component_update_bits(component, AK4641_DAC, 0x20, 0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* mute */
-		snd_soc_update_bits(codec, AK4641_DAC, 0x20, 0x20);
+		snd_soc_component_update_bits(component, AK4641_DAC, 0x20, 0x20);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			if (pdata && gpio_is_valid(pdata->gpio_power))
 				gpio_set_value(pdata->gpio_power, 1);
 			mdelay(1);
@@ -442,16 +442,16 @@ static int ak4641_set_bias_level(struct snd_soc_codec *codec,
 
 			ret = regcache_sync(ak4641->regmap);
 			if (ret) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to sync cache: %d\n", ret);
 				return ret;
 			}
 		}
-		snd_soc_update_bits(codec, AK4641_PM1, 0x80, 0x80);
-		snd_soc_update_bits(codec, AK4641_PM2, 0x80, 0);
+		snd_soc_component_update_bits(component, AK4641_PM1, 0x80, 0x80);
+		snd_soc_component_update_bits(component, AK4641_PM2, 0x80, 0);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, AK4641_PM1, 0x80, 0);
+		snd_soc_component_update_bits(component, AK4641_PM1, 0x80, 0);
 		if (pdata && gpio_is_valid(pdata->gpio_npdn))
 			gpio_set_value(pdata->gpio_npdn, 0);
 		if (pdata && gpio_is_valid(pdata->gpio_power))
@@ -524,17 +524,19 @@ static struct snd_soc_dai_driver ak4641_dai[] = {
 },
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
-	.component_driver = {
-		.controls		= ak4641_snd_controls,
-		.num_controls		= ARRAY_SIZE(ak4641_snd_controls),
-		.dapm_widgets		= ak4641_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ak4641_dapm_widgets),
-		.dapm_routes		= ak4641_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(ak4641_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_ak4641 = {
+	.controls		= ak4641_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4641_snd_controls),
+	.dapm_widgets		= ak4641_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4641_dapm_widgets),
+	.dapm_routes		= ak4641_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(ak4641_audio_map),
 	.set_bias_level		= ak4641_set_bias_level,
-	.suspend_bias_off	= true,
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ak4641_regmap = {
@@ -583,7 +585,8 @@ static int ak4641_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, ak4641);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_ak4641,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				&soc_component_dev_ak4641,
 				ak4641_dai, ARRAY_SIZE(ak4641_dai));
 	if (ret != 0)
 		goto err_gpio2;
@@ -608,8 +611,6 @@ static int ak4641_i2c_remove(struct i2c_client *i2c)
 {
 	struct ak4641_platform_data *pdata = i2c->dev.platform_data;
 
-	snd_soc_unregister_codec(&i2c->dev);
-
 	if (pdata) {
 		if (gpio_is_valid(pdata->gpio_power)) {
 			gpio_set_value(pdata->gpio_power, 0);
-- 
2.16.1
