From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: isabelle: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:36:20 +0000
Message-ID: <E1elDLI-0003sl-2U@debutante>
References: <87r2q9uvo5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 379B22678BB
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:36:22 +0100 (CET)
In-Reply-To: <87r2q9uvo5.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: isabelle: replace codec to component

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

>From f572634c90586fb5426d514e7c584b0b6b5028c0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:39:30 +0000
Subject: [PATCH] ASoC: isabelle: replace codec to component

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
 sound/soc/codecs/isabelle.c | 57 ++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 5ca99280ae00..166420376e67 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -867,7 +867,7 @@ static const struct snd_soc_dapm_route isabelle_intercon[] = {
 
 static int isabelle_hs_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, ISABELLE_DAC1_SOFTRAMP_REG,
+	snd_soc_component_update_bits(dai->component, ISABELLE_DAC1_SOFTRAMP_REG,
 			BIT(4), (mute ? BIT(4) : 0));
 
 	return 0;
@@ -875,7 +875,7 @@ static int isabelle_hs_mute(struct snd_soc_dai *dai, int mute)
 
 static int isabelle_hf_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, ISABELLE_DAC2_SOFTRAMP_REG,
+	snd_soc_component_update_bits(dai->component, ISABELLE_DAC2_SOFTRAMP_REG,
 			BIT(4), (mute ? BIT(4) : 0));
 
 	return 0;
@@ -883,13 +883,13 @@ static int isabelle_hf_mute(struct snd_soc_dai *dai, int mute)
 
 static int isabelle_line_mute(struct snd_soc_dai *dai, int mute)
 {
-	snd_soc_update_bits(dai->codec, ISABELLE_DAC3_SOFTRAMP_REG,
+	snd_soc_component_update_bits(dai->component, ISABELLE_DAC3_SOFTRAMP_REG,
 			BIT(4), (mute ? BIT(4) : 0));
 
 	return 0;
 }
 
-static int isabelle_set_bias_level(struct snd_soc_codec *codec,
+static int isabelle_set_bias_level(struct snd_soc_component *component,
 				enum snd_soc_bias_level level)
 {
 	switch (level) {
@@ -899,12 +899,12 @@ static int isabelle_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_update_bits(codec, ISABELLE_PWR_EN_REG,
+		snd_soc_component_update_bits(component, ISABELLE_PWR_EN_REG,
 				ISABELLE_CHIP_EN, BIT(0));
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, ISABELLE_PWR_EN_REG,
+		snd_soc_component_update_bits(component, ISABELLE_PWR_EN_REG,
 				ISABELLE_CHIP_EN, 0);
 		break;
 	}
@@ -916,7 +916,7 @@ static int isabelle_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params,
 			      struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 aif = 0;
 	unsigned int fs_val = 0;
 
@@ -952,7 +952,7 @@ static int isabelle_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ISABELLE_FS_RATE_CFG_REG,
+	snd_soc_component_update_bits(component, ISABELLE_FS_RATE_CFG_REG,
 			ISABELLE_FS_RATE_MASK, fs_val);
 
 	/* bit size */
@@ -967,7 +967,7 @@ static int isabelle_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ISABELLE_INTF_CFG_REG,
+	snd_soc_component_update_bits(component, ISABELLE_INTF_CFG_REG,
 			ISABELLE_AIF_LENGTH_MASK, aif);
 
 	return 0;
@@ -975,7 +975,7 @@ static int isabelle_hw_params(struct snd_pcm_substream *substream,
 
 static int isabelle_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	unsigned int aif_val = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1003,7 +1003,7 @@ static int isabelle_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ISABELLE_INTF_CFG_REG,
+	snd_soc_component_update_bits(component, ISABELLE_INTF_CFG_REG,
 			(ISABELLE_AIF_MS | ISABELLE_AIF_FMT_MASK), aif_val);
 
 	return 0;
@@ -1087,17 +1087,17 @@ static struct snd_soc_dai_driver isabelle_dai[] = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_isabelle = {
-	.set_bias_level = isabelle_set_bias_level,
-	.component_driver = {
-		.controls		= isabelle_snd_controls,
-		.num_controls		= ARRAY_SIZE(isabelle_snd_controls),
-		.dapm_widgets		= isabelle_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(isabelle_dapm_widgets),
-		.dapm_routes		= isabelle_intercon,
-		.num_dapm_routes	= ARRAY_SIZE(isabelle_intercon),
-	},
-	.idle_bias_off = true,
+static const struct snd_soc_component_driver soc_component_dev_isabelle = {
+	.set_bias_level		= isabelle_set_bias_level,
+	.controls		= isabelle_snd_controls,
+	.num_controls		= ARRAY_SIZE(isabelle_snd_controls),
+	.dapm_widgets		= isabelle_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(isabelle_dapm_widgets),
+	.dapm_routes		= isabelle_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(isabelle_intercon),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config isabelle_regmap_config = {
@@ -1125,23 +1125,17 @@ static int isabelle_i2c_probe(struct i2c_client *i2c,
 	}
 	i2c_set_clientdata(i2c, isabelle_regmap);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-				&soc_codec_dev_isabelle, isabelle_dai,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				&soc_component_dev_isabelle, isabelle_dai,
 				ARRAY_SIZE(isabelle_dai));
 	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 		return ret;
 	}
 
 	return ret;
 }
 
-static int isabelle_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id isabelle_i2c_id[] = {
 	{ "isabelle", 0 },
 	{ }
@@ -1153,7 +1147,6 @@ static struct i2c_driver isabelle_i2c_driver = {
 		.name = "isabelle",
 	},
 	.probe = isabelle_i2c_probe,
-	.remove = isabelle_i2c_remove,
 	.id_table = isabelle_i2c_id,
 };
 
-- 
2.16.1
