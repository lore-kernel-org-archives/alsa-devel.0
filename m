From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sta350: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:08 +0000
Message-ID: <E1elDN2-0004DX-Fw@debutante>
References: <87r2q9wap7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C31A4267925
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:10 +0100 (CET)
In-Reply-To: <87r2q9wap7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sta350: replace codec to component

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

>From 1f6440c596fef81acfb1c2d7e64254449ab2e428 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:29:31 +0000
Subject: [PATCH] ASoC: sta350: replace codec to component

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
 sound/soc/codecs/sta350.c | 117 +++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 9644c20f44e3..0b870319b106 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -309,8 +309,8 @@ static int sta350_coefficient_info(struct snd_kcontrol *kcontrol,
 static int sta350_coefficient_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
 	unsigned int cfud, val;
@@ -351,8 +351,8 @@ static int sta350_coefficient_get(struct snd_kcontrol *kcontrol,
 static int sta350_coefficient_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
 	unsigned int cfud;
@@ -386,9 +386,9 @@ static int sta350_coefficient_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int sta350_sync_coef_shadow(struct snd_soc_codec *codec)
+static int sta350_sync_coef_shadow(struct snd_soc_component *component)
 {
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	unsigned int cfud;
 	int i;
 
@@ -414,16 +414,16 @@ static int sta350_sync_coef_shadow(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int sta350_cache_sync(struct snd_soc_codec *codec)
+static int sta350_cache_sync(struct snd_soc_component *component)
 {
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	unsigned int mute;
 	int rc;
 
 	/* mute during register sync */
 	regmap_read(sta350->regmap, STA350_CFUD, &mute);
 	regmap_write(sta350->regmap, STA350_MMUTE, mute | STA350_MMUTE_MMUTE);
-	sta350_sync_coef_shadow(codec);
+	sta350_sync_coef_shadow(component);
 	rc = regcache_sync(sta350->regmap);
 	regmap_write(sta350->regmap, STA350_MMUTE, mute);
 	return rc;
@@ -613,10 +613,10 @@ static int mcs_ratio_table[3][6] = {
 static int sta350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "mclk=%u\n", freq);
+	dev_dbg(component->dev, "mclk=%u\n", freq);
 	sta350->mclk = freq;
 
 	return 0;
@@ -633,8 +633,8 @@ static int sta350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int sta350_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	unsigned int confb = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -682,22 +682,22 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	int i, mcs = -EINVAL, ir = -EINVAL;
 	unsigned int confa, confb;
 	unsigned int rate, ratio;
 	int ret;
 
 	if (!sta350->mclk) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"sta350->mclk is unset. Unable to determine ratio\n");
 		return -EIO;
 	}
 
 	rate = params_rate(params);
 	ratio = sta350->mclk / rate;
-	dev_dbg(codec->dev, "rate: %u, ratio: %u\n", rate, ratio);
+	dev_dbg(component->dev, "rate: %u, ratio: %u\n", rate, ratio);
 
 	for (i = 0; i < ARRAY_SIZE(interpolation_ratios); i++) {
 		if (interpolation_ratios[i].fs == rate) {
@@ -707,7 +707,7 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (ir < 0) {
-		dev_err(codec->dev, "Unsupported samplerate: %u\n", rate);
+		dev_err(component->dev, "Unsupported samplerate: %u\n", rate);
 		return -EINVAL;
 	}
 
@@ -719,7 +719,7 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (mcs < 0) {
-		dev_err(codec->dev, "Unresolvable ratio: %u\n", ratio);
+		dev_err(component->dev, "Unresolvable ratio: %u\n", ratio);
 		return -EINVAL;
 	}
 
@@ -729,10 +729,10 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_width(params)) {
 	case 24:
-		dev_dbg(codec->dev, "24bit\n");
+		dev_dbg(component->dev, "24bit\n");
 		/* fall through */
 	case 32:
-		dev_dbg(codec->dev, "24bit or 32bit\n");
+		dev_dbg(component->dev, "24bit or 32bit\n");
 		switch (sta350->format) {
 		case SND_SOC_DAIFMT_I2S:
 			confb |= 0x0;
@@ -747,7 +747,7 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 
 		break;
 	case 20:
-		dev_dbg(codec->dev, "20bit\n");
+		dev_dbg(component->dev, "20bit\n");
 		switch (sta350->format) {
 		case SND_SOC_DAIFMT_I2S:
 			confb |= 0x4;
@@ -762,7 +762,7 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 
 		break;
 	case 18:
-		dev_dbg(codec->dev, "18bit\n");
+		dev_dbg(component->dev, "18bit\n");
 		switch (sta350->format) {
 		case SND_SOC_DAIFMT_I2S:
 			confb |= 0x8;
@@ -777,7 +777,7 @@ static int sta350_hw_params(struct snd_pcm_substream *substream,
 
 		break;
 	case 16:
-		dev_dbg(codec->dev, "16bit\n");
+		dev_dbg(component->dev, "16bit\n");
 		switch (sta350->format) {
 		case SND_SOC_DAIFMT_I2S:
 			confb |= 0x0;
@@ -827,20 +827,20 @@ static int sta350_startup_sequence(struct sta350_priv *sta350)
 
 /**
  * sta350_set_bias_level - DAPM callback
- * @codec: the codec device
+ * @component: the component device
  * @level: DAPM power level
  *
- * This is called by ALSA to put the codec into low power mode
- * or to wake it up.  If the codec is powered off completely
+ * This is called by ALSA to put the component into low power mode
+ * or to wake it up.  If the component is powered off completely
  * all registers must be restored after power on.
  */
-static int sta350_set_bias_level(struct snd_soc_codec *codec,
+static int sta350_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	dev_dbg(codec->dev, "level = %d\n", level);
+	dev_dbg(component->dev, "level = %d\n", level);
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -853,18 +853,18 @@ static int sta350_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(
 				ARRAY_SIZE(sta350->supplies),
 				sta350->supplies);
 			if (ret < 0) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to enable supplies: %d\n",
 					ret);
 				return ret;
 			}
 			sta350_startup_sequence(sta350);
-			sta350_cache_sync(codec);
+			sta350_cache_sync(component);
 		}
 
 		/* Power down */
@@ -911,22 +911,22 @@ static struct snd_soc_dai_driver sta350_dai = {
 	.ops = &sta350_dai_ops,
 };
 
-static int sta350_probe(struct snd_soc_codec *codec)
+static int sta350_probe(struct snd_soc_component *component)
 {
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 	struct sta350_platform_data *pdata = sta350->pdata;
 	int i, ret = 0, thermal = 0;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta350->supplies),
 				    sta350->supplies);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		dev_err(component->dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
 	ret = sta350_startup_sequence(sta350);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to startup device\n");
+		dev_err(component->dev, "Failed to startup device\n");
 		return ret;
 	}
 
@@ -1036,35 +1036,35 @@ static int sta350_probe(struct snd_soc_codec *codec)
 	sta350->coef_shadow[60] = 0x400000;
 	sta350->coef_shadow[61] = 0x400000;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);
 
 	return 0;
 }
 
-static int sta350_remove(struct snd_soc_codec *codec)
+static void sta350_remove(struct snd_soc_component *component)
 {
-	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct sta350_priv *sta350 = snd_soc_component_get_drvdata(component);
 
 	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);
-
-	return 0;
 }
 
-static const struct snd_soc_codec_driver sta350_codec = {
-	.probe =		sta350_probe,
-	.remove =		sta350_remove,
-	.set_bias_level =	sta350_set_bias_level,
-	.suspend_bias_off =	true,
-	.component_driver = {
-		.controls =		sta350_snd_controls,
-		.num_controls =		ARRAY_SIZE(sta350_snd_controls),
-		.dapm_widgets =		sta350_dapm_widgets,
-		.num_dapm_widgets =	ARRAY_SIZE(sta350_dapm_widgets),
-		.dapm_routes =		sta350_dapm_routes,
-		.num_dapm_routes =	ARRAY_SIZE(sta350_dapm_routes),
-	},
+static const struct snd_soc_component_driver sta350_component = {
+	.probe			= sta350_probe,
+	.remove			= sta350_remove,
+	.set_bias_level		= sta350_set_bias_level,
+	.controls		= sta350_snd_controls,
+	.num_controls		= ARRAY_SIZE(sta350_snd_controls),
+	.dapm_widgets		= sta350_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sta350_dapm_widgets),
+	.dapm_routes		= sta350_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sta350_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config sta350_regmap = {
@@ -1244,16 +1244,15 @@ static int sta350_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, sta350);
 
-	ret = snd_soc_register_codec(dev, &sta350_codec, &sta350_dai, 1);
+	ret = devm_snd_soc_register_component(dev, &sta350_component, &sta350_dai, 1);
 	if (ret < 0)
-		dev_err(dev, "Failed to register codec (%d)\n", ret);
+		dev_err(dev, "Failed to register component (%d)\n", ret);
 
 	return ret;
 }
 
 static int sta350_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
