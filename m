From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4671: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:01 +0000
Message-ID: <E1elDUf-0005R9-0C@debutante>
References: <87d11t2wab.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F0A52678EE
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:03 +0100 (CET)
In-Reply-To: <87d11t2wab.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4671: replace codec to component

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

>From 57188d8875894b14f6cdd21c7ee6e96ab66c1f2b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:13:39 +0000
Subject: [PATCH] ASoC: ak4671: replace codec to component

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
 sound/soc/codecs/ak4671.c | 67 ++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index dcfdff56fc5a..7133fd69c641 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -163,15 +163,15 @@ static const struct snd_kcontrol_new ak4671_snd_controls[] = {
 static int ak4671_out2_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec, AK4671_LOUT2_POWER_MANAGERMENT,
+		snd_soc_component_update_bits(component, AK4671_LOUT2_POWER_MANAGERMENT,
 				    AK4671_MUTEN, AK4671_MUTEN);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, AK4671_LOUT2_POWER_MANAGERMENT,
+		snd_soc_component_update_bits(component, AK4671_LOUT2_POWER_MANAGERMENT,
 				    AK4671_MUTEN, 0);
 		break;
 	}
@@ -427,10 +427,10 @@ static int ak4671_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 fs;
 
-	fs = snd_soc_read(codec, AK4671_PLL_MODE_SELECT0);
+	fs = snd_soc_component_read32(component, AK4671_PLL_MODE_SELECT0);
 	fs &= ~AK4671_FS;
 
 	switch (params_rate(params)) {
@@ -465,7 +465,7 @@ static int ak4671_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, AK4671_PLL_MODE_SELECT0, fs);
+	snd_soc_component_write(component, AK4671_PLL_MODE_SELECT0, fs);
 
 	return 0;
 }
@@ -473,10 +473,10 @@ static int ak4671_hw_params(struct snd_pcm_substream *substream,
 static int ak4671_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 pll;
 
-	pll = snd_soc_read(codec, AK4671_PLL_MODE_SELECT0);
+	pll = snd_soc_component_read32(component, AK4671_PLL_MODE_SELECT0);
 	pll &= ~AK4671_PLL;
 
 	switch (freq) {
@@ -511,19 +511,19 @@ static int ak4671_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, AK4671_PLL_MODE_SELECT0, pll);
+	snd_soc_component_write(component, AK4671_PLL_MODE_SELECT0, pll);
 
 	return 0;
 }
 
 static int ak4671_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 mode;
 	u8 format;
 
 	/* set master/slave audio interface */
-	mode = snd_soc_read(codec, AK4671_PLL_MODE_SELECT1);
+	mode = snd_soc_component_read32(component, AK4671_PLL_MODE_SELECT1);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -537,7 +537,7 @@ static int ak4671_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* interface format */
-	format = snd_soc_read(codec, AK4671_FORMAT_SELECT);
+	format = snd_soc_component_read32(component, AK4671_FORMAT_SELECT);
 	format &= ~AK4671_DIF;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -557,24 +557,24 @@ static int ak4671_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set mode and format */
-	snd_soc_write(codec, AK4671_PLL_MODE_SELECT1, mode);
-	snd_soc_write(codec, AK4671_FORMAT_SELECT, format);
+	snd_soc_component_write(component, AK4671_PLL_MODE_SELECT1, mode);
+	snd_soc_component_write(component, AK4671_FORMAT_SELECT, format);
 
 	return 0;
 }
 
-static int ak4671_set_bias_level(struct snd_soc_codec *codec,
+static int ak4671_set_bias_level(struct snd_soc_component *component,
 		enum snd_soc_bias_level level)
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_update_bits(codec, AK4671_AD_DA_POWER_MANAGEMENT,
+		snd_soc_component_update_bits(component, AK4671_AD_DA_POWER_MANAGEMENT,
 				    AK4671_PMVCM, AK4671_PMVCM);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, AK4671_AD_DA_POWER_MANAGEMENT, 0x00);
+		snd_soc_component_write(component, AK4671_AD_DA_POWER_MANAGEMENT, 0x00);
 		break;
 	}
 	return 0;
@@ -610,16 +610,18 @@ static struct snd_soc_dai_driver ak4671_dai = {
 	.ops = &ak4671_dai_ops,
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
-	.set_bias_level = ak4671_set_bias_level,
-	.component_driver = {
-		.controls		= ak4671_snd_controls,
-		.num_controls		= ARRAY_SIZE(ak4671_snd_controls),
-		.dapm_widgets		= ak4671_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ak4671_dapm_widgets),
-		.dapm_routes		= ak4671_intercon,
-		.num_dapm_routes	= ARRAY_SIZE(ak4671_intercon),
-	},
+static const struct snd_soc_component_driver soc_component_dev_ak4671 = {
+	.set_bias_level		= ak4671_set_bias_level,
+	.controls		= ak4671_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4671_snd_controls),
+	.dapm_widgets		= ak4671_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4671_dapm_widgets),
+	.dapm_routes		= ak4671_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak4671_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ak4671_regmap = {
@@ -645,17 +647,11 @@ static int ak4671_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = snd_soc_register_codec(&client->dev,
-			&soc_codec_dev_ak4671, &ak4671_dai, 1);
+	ret = devm_snd_soc_register_component(&client->dev,
+			&soc_component_dev_ak4671, &ak4671_dai, 1);
 	return ret;
 }
 
-static int ak4671_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id ak4671_i2c_id[] = {
 	{ "ak4671", 0 },
 	{ }
@@ -667,7 +663,6 @@ static struct i2c_driver ak4671_i2c_driver = {
 		.name = "ak4671-codec",
 	},
 	.probe = ak4671_i2c_probe,
-	.remove = ak4671_i2c_remove,
 	.id_table = ak4671_i2c_id,
 };
 
-- 
2.16.1
