From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98925: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:41:17 +0000
Message-ID: <E1elDQ5-0004nx-CF@debutante>
References: <87k1w1z4t5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C314E26748A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:19 +0100 (CET)
In-Reply-To: <87k1w1z4t5.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: max98925: replace codec to component

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

>From cf9cb34eeba71acc80f9019aac46b2ffd13081b3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:08:29 +0000
Subject: [PATCH] ASoC: max98925: replace codec to component

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
 sound/soc/codecs/max98925.c | 72 +++++++++++++++++++++------------------------
 sound/soc/codecs/max98925.h |  2 +-
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 921f95fc396d..29877730a2b0 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -99,8 +99,8 @@ static const struct snd_kcontrol_new max98925_dai_sel_mux =
 static int max98925_dac_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98925_priv *max98925 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -256,7 +256,7 @@ static const struct {
 	},
 };
 
-static inline int max98925_rate_value(struct snd_soc_codec *codec,
+static inline int max98925_rate_value(struct snd_soc_component *component,
 		int rate, int clock, int *value, int *n, int *m)
 {
 	int ret = -EINVAL;
@@ -297,11 +297,11 @@ static void max98925_set_sense_data(struct max98925_priv *max98925)
 static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
 				 unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98925_priv *max98925 = snd_soc_component_get_drvdata(component);
 	unsigned int invert = 0;
 
-	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
+	dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* set DAI to slave mode */
@@ -322,7 +322,7 @@ static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_CBS_CFM:
 	case SND_SOC_DAIFMT_CBM_CFS:
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(component->dev, "DAI clock mode unsupported");
 		return -EINVAL;
 	}
 
@@ -339,7 +339,7 @@ static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		invert = M98925_DAI_BCI_MASK | M98925_DAI_WCI_MASK;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported");
+		dev_err(component->dev, "DAI invert mode unsupported");
 		return -EINVAL;
 	}
 
@@ -352,7 +352,7 @@ static int max98925_set_clock(struct max98925_priv *max98925,
 		struct snd_pcm_hw_params *params)
 {
 	unsigned int dai_sr = 0, clock, mdll, n, m;
-	struct snd_soc_codec *codec = max98925->codec;
+	struct snd_soc_component *component = max98925->component;
 	int rate = params_rate(params);
 	/* BCLK/LRCLK ratio calculation */
 	int blr_clk_ratio = params_channels(params) * max98925->ch_size;
@@ -395,12 +395,12 @@ static int max98925_set_clock(struct max98925_priv *max98925,
 		mdll  = M98925_MDLL_MULT_MCLKx8;
 		break;
 	default:
-		dev_info(max98925->codec->dev, "unsupported sysclk %d\n",
+		dev_info(max98925->component->dev, "unsupported sysclk %d\n",
 					max98925->sysclk);
 		return -EINVAL;
 	}
 
-	if (max98925_rate_value(codec, rate, clock, &dai_sr, &n, &m))
+	if (max98925_rate_value(component, rate, clock, &dai_sr, &n, &m))
 		return -EINVAL;
 
 	/* set DAI_SR to correct LRCLK frequency */
@@ -427,8 +427,8 @@ static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98925_priv *max98925 = snd_soc_component_get_drvdata(component);
 
 	switch (params_width(params)) {
 	case 16:
@@ -454,7 +454,7 @@ static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
 				__func__, params_format(params));
 		return -EINVAL;
 	}
-	dev_dbg(codec->dev, "%s: format supported %d",
+	dev_dbg(component->dev, "%s: format supported %d",
 				__func__, params_format(params));
 	return max98925_set_clock(max98925, params);
 }
@@ -462,8 +462,8 @@ static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
 static int max98925_dai_set_sysclk(struct snd_soc_dai *dai,
 				   int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98925_priv *max98925 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case 0:
@@ -516,11 +516,11 @@ static struct snd_soc_dai_driver max98925_dai[] = {
 	}
 };
 
-static int max98925_probe(struct snd_soc_codec *codec)
+static int max98925_probe(struct snd_soc_component *component)
 {
-	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct max98925_priv *max98925 = snd_soc_component_get_drvdata(component);
 
-	max98925->codec = codec;
+	max98925->component = component;
 	regmap_write(max98925->regmap, MAX98925_GLOBAL_ENABLE, 0x00);
 	/* It's not the default but we need to set DAI_DLY */
 	regmap_write(max98925->regmap,
@@ -538,16 +538,18 @@ static int max98925_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_max98925 = {
-	.probe            = max98925_probe,
-	.component_driver = {
-		.controls		= max98925_snd_controls,
-		.num_controls		= ARRAY_SIZE(max98925_snd_controls),
-		.dapm_routes		= max98925_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(max98925_audio_map),
-		.dapm_widgets		= max98925_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max98925_dapm_widgets),
-	},
+static const struct snd_soc_component_driver soc_component_dev_max98925 = {
+	.probe			= max98925_probe,
+	.controls		= max98925_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98925_snd_controls),
+	.dapm_routes		= max98925_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98925_audio_map),
+	.dapm_widgets		= max98925_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98925_dapm_widgets),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config max98925_regmap = {
@@ -612,20 +614,15 @@ static int max98925_i2c_probe(struct i2c_client *i2c,
 
 	dev_info(&i2c->dev, "device version 0x%02X\n", reg);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98925,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_max98925,
 			max98925_dai, ARRAY_SIZE(max98925_dai));
 	if (ret < 0)
 		dev_err(&i2c->dev,
-				"Failed to register codec: %d\n", ret);
+				"Failed to register component: %d\n", ret);
 	return ret;
 }
 
-static int max98925_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max98925_i2c_id[] = {
 	{ "max98925", 0 },
 	{ }
@@ -645,7 +642,6 @@ static struct i2c_driver max98925_i2c_driver = {
 		.pm = NULL,
 	},
 	.probe  = max98925_i2c_probe,
-	.remove = max98925_i2c_remove,
 	.id_table = max98925_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98925.h b/sound/soc/codecs/max98925.h
index 3783248f2780..96f97085328d 100644
--- a/sound/soc/codecs/max98925.h
+++ b/sound/soc/codecs/max98925.h
@@ -821,7 +821,7 @@
 
 struct max98925_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct max98925_pdata *pdata;
 	unsigned int sysclk;
 	unsigned int v_slot;
-- 
2.16.1
