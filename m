From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2518: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:12 +0000
Message-ID: <E1elDN6-0004EM-9B@debutante>
References: <87shapwapu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AC599267A77
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:14 +0100 (CET)
In-Reply-To: <87shapwapu.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ssm2518: replace codec to component

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

>From 17875fe49216b701fa08f0288ea19e608e3bb787 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:29:08 +0000
Subject: [PATCH] ASoC: ssm2518: replace codec to component

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
 sound/soc/codecs/ssm2518.c | 57 ++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 15486fd16269..4a1d42a33030 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -336,8 +336,8 @@ static int ssm2518_lookup_mcs(struct ssm2518 *ssm2518,
 static int ssm2518_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(component);
 	unsigned int rate = params_rate(params);
 	unsigned int ctrl1, ctrl1_mask;
 	int mcs;
@@ -391,7 +391,7 @@ static int ssm2518_hw_params(struct snd_pcm_substream *substream,
 
 static int ssm2518_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(dai->codec);
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(dai->component);
 	unsigned int val;
 
 	if (mute)
@@ -405,7 +405,7 @@ static int ssm2518_mute(struct snd_soc_dai *dai, int mute)
 
 static int ssm2518_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(dai->codec);
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(dai->component);
 	unsigned int ctrl1 = 0, ctrl2 = 0;
 	bool invert_fclk;
 	int ret;
@@ -498,10 +498,10 @@ static int ssm2518_set_power(struct ssm2518 *ssm2518, bool enable)
 	return ret;
 }
 
-static int ssm2518_set_bias_level(struct snd_soc_codec *codec,
+static int ssm2518_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(codec);
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	switch (level) {
@@ -510,7 +510,7 @@ static int ssm2518_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			ret = ssm2518_set_power(ssm2518, true);
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -524,7 +524,7 @@ static int ssm2518_set_bias_level(struct snd_soc_codec *codec,
 static int ssm2518_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	unsigned int rx_mask, int slots, int width)
 {
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(dai->codec);
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(dai->component);
 	unsigned int ctrl1, ctrl2;
 	int left_slot, right_slot;
 	int ret;
@@ -609,7 +609,7 @@ static int ssm2518_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 static int ssm2518_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(dai->codec);
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(dai->component);
 
 	if (ssm2518->constraints)
 		snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -641,10 +641,10 @@ static struct snd_soc_dai_driver ssm2518_dai = {
 	.ops = &ssm2518_dai_ops,
 };
 
-static int ssm2518_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+static int ssm2518_set_sysclk(struct snd_soc_component *component, int clk_id,
 	int source, unsigned int freq, int dir)
 {
-	struct ssm2518 *ssm2518 = snd_soc_codec_get_drvdata(codec);
+	struct ssm2518 *ssm2518 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	if (clk_id != SSM2518_SYSCLK)
@@ -710,19 +710,18 @@ static int ssm2518_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			SSM2518_POWER1_NO_BCLK, val);
 }
 
-static const struct snd_soc_codec_driver ssm2518_codec_driver = {
-	.set_bias_level = ssm2518_set_bias_level,
-	.set_sysclk = ssm2518_set_sysclk,
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.controls		= ssm2518_snd_controls,
-		.num_controls		= ARRAY_SIZE(ssm2518_snd_controls),
-		.dapm_widgets		= ssm2518_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ssm2518_dapm_widgets),
-		.dapm_routes		= ssm2518_routes,
-		.num_dapm_routes	= ARRAY_SIZE(ssm2518_routes),
-	},
+static const struct snd_soc_component_driver ssm2518_component_driver = {
+	.set_bias_level		= ssm2518_set_bias_level,
+	.set_sysclk		= ssm2518_set_sysclk,
+	.controls		= ssm2518_snd_controls,
+	.num_controls		= ARRAY_SIZE(ssm2518_snd_controls),
+	.dapm_widgets		= ssm2518_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ssm2518_dapm_widgets),
+	.dapm_routes		= ssm2518_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ssm2518_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ssm2518_regmap_config = {
@@ -792,16 +791,11 @@ static int ssm2518_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	return snd_soc_register_codec(&i2c->dev, &ssm2518_codec_driver,
+	return devm_snd_soc_register_component(&i2c->dev,
+			&ssm2518_component_driver,
 			&ssm2518_dai, 1);
 }
 
-static int ssm2518_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id ssm2518_dt_ids[] = {
 	{ .compatible = "adi,ssm2518", },
@@ -822,7 +816,6 @@ static struct i2c_driver ssm2518_driver = {
 		.of_match_table = of_match_ptr(ssm2518_dt_ids),
 	},
 	.probe = ssm2518_i2c_probe,
-	.remove = ssm2518_i2c_remove,
 	.id_table = ssm2518_i2c_ids,
 };
 module_i2c_driver(ssm2518_driver);
-- 
2.16.1
