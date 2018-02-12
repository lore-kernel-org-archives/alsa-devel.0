From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lm49453: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:34:50 +0000
Message-ID: <E1elDJq-0003k5-HM@debutante>
References: <87h8r5uvjd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A086A267839
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:34:52 +0100 (CET)
In-Reply-To: <87h8r5uvjd.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: lm49453: replace codec to component

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

>From f5d5240e087556991b6f33eca6124f3b8f9da703 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:42:27 +0000
Subject: [PATCH] ASoC: lm49453: replace codec to component

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
 sound/soc/codecs/lm49453.c | 65 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 41e09d1287b8..59a646cc03d4 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1110,7 +1110,7 @@ static int lm49453_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 clk_div = 0;
 
 	/* Setting DAC clock dividers based on substream sample rate. */
@@ -1134,15 +1134,15 @@ static int lm49453_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, LM49453_P0_ADC_CLK_DIV_REG, clk_div);
-	snd_soc_write(codec, LM49453_P0_DAC_HP_CLK_DIV_REG, clk_div);
+	snd_soc_component_write(component, LM49453_P0_ADC_CLK_DIV_REG, clk_div);
+	snd_soc_component_write(component, LM49453_P0_DAC_HP_CLK_DIV_REG, clk_div);
 
 	return 0;
 }
 
 static int lm49453_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
 	u16 aif_val;
 	int mode = 0;
@@ -1185,11 +1185,11 @@ static int lm49453_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, LM49453_P0_AUDIO_PORT1_BASIC_REG,
+	snd_soc_component_update_bits(component, LM49453_P0_AUDIO_PORT1_BASIC_REG,
 			    LM49453_AUDIO_PORT1_BASIC_FMT_MASK|BIT(0)|BIT(5),
 			    (aif_val | mode | clk_phase));
 
-	snd_soc_write(codec, LM49453_P0_AUDIO_PORT1_RX_MSB_REG, clk_shift);
+	snd_soc_component_write(component, LM49453_P0_AUDIO_PORT1_RX_MSB_REG, clk_shift);
 
 	return 0;
 }
@@ -1197,7 +1197,7 @@ static int lm49453_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 				  unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 pll_clk = 0;
 
 	switch (freq) {
@@ -1216,50 +1216,50 @@ static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, BIT(4), pll_clk);
+	snd_soc_component_update_bits(component, LM49453_P0_PMC_SETUP_REG, BIT(4), pll_clk);
 
 	return 0;
 }
 
 static int lm49453_hp_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(1)|BIT(0),
+	snd_soc_component_update_bits(dai->component, LM49453_P0_DAC_DSP_REG, BIT(1)|BIT(0),
 			    (mute ? (BIT(1)|BIT(0)) : 0));
 	return 0;
 }
 
 static int lm49453_lo_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(3)|BIT(2),
+	snd_soc_component_update_bits(dai->component, LM49453_P0_DAC_DSP_REG, BIT(3)|BIT(2),
 			    (mute ? (BIT(3)|BIT(2)) : 0));
 	return 0;
 }
 
 static int lm49453_ls_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(5)|BIT(4),
+	snd_soc_component_update_bits(dai->component, LM49453_P0_DAC_DSP_REG, BIT(5)|BIT(4),
 			    (mute ? (BIT(5)|BIT(4)) : 0));
 	return 0;
 }
 
 static int lm49453_ep_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(4),
+	snd_soc_component_update_bits(dai->component, LM49453_P0_DAC_DSP_REG, BIT(4),
 			    (mute ? BIT(4) : 0));
 	return 0;
 }
 
 static int lm49453_ha_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(7)|BIT(6),
+	snd_soc_component_update_bits(dai->component, LM49453_P0_DAC_DSP_REG, BIT(7)|BIT(6),
 			    (mute ? (BIT(7)|BIT(6)) : 0));
 	return 0;
 }
 
-static int lm49453_set_bias_level(struct snd_soc_codec *codec,
+static int lm49453_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
-	struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+	struct lm49453_priv *lm49453 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1267,15 +1267,15 @@ static int lm49453_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			regcache_sync(lm49453->regmap);
 
-		snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
+		snd_soc_component_update_bits(component, LM49453_P0_PMC_SETUP_REG,
 				    LM49453_PMC_SETUP_CHIP_EN, LM49453_CHIP_EN);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
+		snd_soc_component_update_bits(component, LM49453_P0_PMC_SETUP_REG,
 				    LM49453_PMC_SETUP_CHIP_EN, 0);
 		break;
 	}
@@ -1389,17 +1389,17 @@ static struct snd_soc_dai_driver lm49453_dai[] = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_lm49453 = {
-	.set_bias_level = lm49453_set_bias_level,
-	.component_driver = {
-		.controls		= lm49453_snd_controls,
-		.num_controls		= ARRAY_SIZE(lm49453_snd_controls),
-		.dapm_widgets		= lm49453_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(lm49453_dapm_widgets),
-		.dapm_routes		= lm49453_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(lm49453_audio_map),
-	},
-	.idle_bias_off = true,
+static const struct snd_soc_component_driver soc_component_dev_lm49453 = {
+	.set_bias_level		= lm49453_set_bias_level,
+	.controls		= lm49453_snd_controls,
+	.num_controls		= ARRAY_SIZE(lm49453_snd_controls),
+	.dapm_widgets		= lm49453_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(lm49453_dapm_widgets),
+	.dapm_routes		= lm49453_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(lm49453_audio_map),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config lm49453_regmap_config = {
@@ -1434,18 +1434,17 @@ static int lm49453_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-				      &soc_codec_dev_lm49453,
+	ret =  devm_snd_soc_register_component(&i2c->dev,
+				      &soc_component_dev_lm49453,
 				      lm49453_dai, ARRAY_SIZE(lm49453_dai));
 	if (ret < 0)
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 
 	return ret;
 }
 
 static int lm49453_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
