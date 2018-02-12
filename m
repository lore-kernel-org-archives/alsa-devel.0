From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4642: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:08 +0000
Message-ID: <E1elDUm-0005Sn-90@debutante>
References: <87fu6p2wb6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D0F72675E7
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:10 +0100 (CET)
In-Reply-To: <87fu6p2wb6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4642: replace codec to component

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

>From 43c5d0f05ec55aa71680744ffcaa1aa6fd8a9bab Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:13:07 +0000
Subject: [PATCH] ASoC: ak4642: replace codec to component

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
 sound/soc/codecs/ak4642.c | 105 ++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 29530c567bd9..9c35e91d412d 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -178,19 +178,19 @@ static const struct snd_kcontrol_new ak4642_lout_mixer_controls[] = {
 static int ak4642_lout_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMD:
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Power save mode ON */
-		snd_soc_update_bits(codec, SG_SL2, LOPS, LOPS);
+		snd_soc_component_update_bits(component, SG_SL2, LOPS, LOPS);
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 	case SND_SOC_DAPM_POST_PMD:
 		/* Power save mode OFF */
 		msleep(300);
-		snd_soc_update_bits(codec, SG_SL2, LOPS, 0);
+		snd_soc_component_update_bits(component, SG_SL2, LOPS, 0);
 		break;
 	}
 
@@ -282,7 +282,7 @@ static int ak4642_dai_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
 	if (is_play) {
 		/*
@@ -295,8 +295,8 @@ static int ak4642_dai_startup(struct snd_pcm_substream *substream,
 		 * This operation came from example code of
 		 * "ASAHI KASEI AK4642" (japanese) manual p97.
 		 */
-		snd_soc_write(codec, L_IVC, 0x91); /* volume */
-		snd_soc_write(codec, R_IVC, 0x91); /* volume */
+		snd_soc_component_write(component, L_IVC, 0x91); /* volume */
+		snd_soc_component_write(component, R_IVC, 0x91); /* volume */
 	} else {
 		/*
 		 * start stereo input
@@ -311,11 +311,11 @@ static int ak4642_dai_startup(struct snd_pcm_substream *substream,
 		 * This operation came from example code of
 		 * "ASAHI KASEI AK4642" (japanese) manual p94.
 		 */
-		snd_soc_update_bits(codec, SG_SL1, PMMP | MGAIN0, PMMP | MGAIN0);
-		snd_soc_write(codec, TIMER, ZTM(0x3) | WTM(0x3));
-		snd_soc_write(codec, ALC_CTL1, ALC | LMTH0);
-		snd_soc_update_bits(codec, PW_MGMT1, PMADL, PMADL);
-		snd_soc_update_bits(codec, PW_MGMT3, PMADR, PMADR);
+		snd_soc_component_update_bits(component, SG_SL1, PMMP | MGAIN0, PMMP | MGAIN0);
+		snd_soc_component_write(component, TIMER, ZTM(0x3) | WTM(0x3));
+		snd_soc_component_write(component, ALC_CTL1, ALC | LMTH0);
+		snd_soc_component_update_bits(component, PW_MGMT1, PMADL, PMADL);
+		snd_soc_component_update_bits(component, PW_MGMT3, PMADR, PMADR);
 	}
 
 	return 0;
@@ -325,22 +325,22 @@ static void ak4642_dai_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
 	if (is_play) {
 	} else {
 		/* stop stereo input */
-		snd_soc_update_bits(codec, PW_MGMT1, PMADL, 0);
-		snd_soc_update_bits(codec, PW_MGMT3, PMADR, 0);
-		snd_soc_update_bits(codec, ALC_CTL1, ALC, 0);
+		snd_soc_component_update_bits(component, PW_MGMT1, PMADL, 0);
+		snd_soc_component_update_bits(component, PW_MGMT3, PMADR, 0);
+		snd_soc_component_update_bits(component, ALC_CTL1, ALC, 0);
 	}
 }
 
 static int ak4642_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 	int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct ak4642_priv *priv = snd_soc_component_get_drvdata(component);
 	u8 pll;
 	int extended_freq = 0;
 
@@ -382,14 +382,14 @@ static int ak4642_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 	if (extended_freq && !priv->drvdata->extended_frequencies)
 		return -EINVAL;
 
-	snd_soc_update_bits(codec, MD_CTL1, PLL_MASK, pll);
+	snd_soc_component_update_bits(component, MD_CTL1, PLL_MASK, pll);
 
 	return 0;
 }
 
 static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 data;
 	u8 bcko;
 
@@ -407,8 +407,8 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, PW_MGMT2, MS | MCKO | PMPLL, data);
-	snd_soc_update_bits(codec, MD_CTL1, BCKO_MASK, bcko);
+	snd_soc_component_update_bits(component, PW_MGMT2, MS | MCKO | PMPLL, data);
+	snd_soc_component_update_bits(component, MD_CTL1, BCKO_MASK, bcko);
 
 	/* format type */
 	data = 0;
@@ -425,12 +425,12 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, MD_CTL1, DIF_MASK, data);
+	snd_soc_component_update_bits(component, MD_CTL1, DIF_MASK, data);
 
 	return 0;
 }
 
-static int ak4642_set_mcko(struct snd_soc_codec *codec,
+static int ak4642_set_mcko(struct snd_soc_component *component,
 			   u32 frequency)
 {
 	static const u32 fs_list[] = {
@@ -458,7 +458,7 @@ static int ak4642_set_mcko(struct snd_soc_codec *codec,
 	for (ps = 0; ps < ARRAY_SIZE(ps_list); ps++) {
 		for (fs = 0; fs < ARRAY_SIZE(fs_list); fs++) {
 			if (frequency == ps_list[ps] * fs_list[fs]) {
-				snd_soc_write(codec, MD_CTL2,
+				snd_soc_component_write(component, MD_CTL2,
 					      PSs(ps) | FSs(fs));
 				return 0;
 			}
@@ -472,25 +472,25 @@ static int ak4642_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4642_priv *priv = snd_soc_component_get_drvdata(component);
 	u32 rate = clk_get_rate(priv->mcko);
 
 	if (!rate)
 		rate = params_rate(params) * 256;
 
-	return ak4642_set_mcko(codec, rate);
+	return ak4642_set_mcko(component, rate);
 }
 
-static int ak4642_set_bias_level(struct snd_soc_codec *codec,
+static int ak4642_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
 	switch (level) {
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, PW_MGMT1, 0x00);
+		snd_soc_component_write(component, PW_MGMT1, 0x00);
 		break;
 	default:
-		snd_soc_update_bits(codec, PW_MGMT1, PMVCM, PMVCM);
+		snd_soc_component_update_bits(component, PW_MGMT1, PMVCM, PMVCM);
 		break;
 	}
 
@@ -523,46 +523,48 @@ static struct snd_soc_dai_driver ak4642_dai = {
 	.symmetric_rates = 1,
 };
 
-static int ak4642_suspend(struct snd_soc_codec *codec)
+static int ak4642_suspend(struct snd_soc_component *component)
 {
-	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+	struct regmap *regmap = dev_get_regmap(component->dev, NULL);
 
 	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
 	return 0;
 }
 
-static int ak4642_resume(struct snd_soc_codec *codec)
+static int ak4642_resume(struct snd_soc_component *component)
 {
-	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+	struct regmap *regmap = dev_get_regmap(component->dev, NULL);
 
 	regcache_cache_only(regmap, false);
 	regcache_sync(regmap);
 	return 0;
 }
-static int ak4642_probe(struct snd_soc_codec *codec)
+static int ak4642_probe(struct snd_soc_component *component)
 {
-	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct ak4642_priv *priv = snd_soc_component_get_drvdata(component);
 
 	if (priv->mcko)
-		ak4642_set_mcko(codec, clk_get_rate(priv->mcko));
+		ak4642_set_mcko(component, clk_get_rate(priv->mcko));
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
+static const struct snd_soc_component_driver soc_component_dev_ak4642 = {
 	.probe			= ak4642_probe,
 	.suspend		= ak4642_suspend,
 	.resume			= ak4642_resume,
 	.set_bias_level		= ak4642_set_bias_level,
-	.component_driver = {
-		.controls		= ak4642_snd_controls,
-		.num_controls		= ARRAY_SIZE(ak4642_snd_controls),
-		.dapm_widgets		= ak4642_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ak4642_dapm_widgets),
-		.dapm_routes		= ak4642_intercon,
-		.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
-	},
+	.controls		= ak4642_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4642_snd_controls),
+	.dapm_widgets		= ak4642_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4642_dapm_widgets),
+	.dapm_routes		= ak4642_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ak4642_regmap = {
@@ -675,14 +677,8 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return snd_soc_register_codec(dev,
-				      &soc_codec_dev_ak4642, &ak4642_dai, 1);
-}
-
-static int ak4642_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
+	return devm_snd_soc_register_component(dev,
+				&soc_component_dev_ak4642, &ak4642_dai, 1);
 }
 
 static const struct of_device_id ak4642_of_match[] = {
@@ -707,7 +703,6 @@ static struct i2c_driver ak4642_i2c_driver = {
 		.of_match_table = ak4642_of_match,
 	},
 	.probe		= ak4642_i2c_probe,
-	.remove		= ak4642_i2c_remove,
 	.id_table	= ak4642_i2c_id,
 };
 
-- 
2.16.1
