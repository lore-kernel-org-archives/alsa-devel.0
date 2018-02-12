From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:44:31 +0000
Message-ID: <E1elDTD-00059m-ST@debutante>
References: <87inbl1fu3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D0426738D
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:44:34 +0100 (CET)
In-Reply-To: <87inbl1fu3.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: cs35l32: replace codec to component

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

>From fa643703a8776cb8987843ea81c765fdf2419383 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:54:19 +0000
Subject: [PATCH] ASoC: cs35l32: replace codec to component

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
 sound/soc/codecs/cs35l32.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index bc3a72e4c4ed..4297058b6938 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -43,7 +43,7 @@ static const char *const cs35l32_supply_names[CS35L32_NUM_SUPPLIES] = {
 
 struct  cs35l32_private {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[CS35L32_NUM_SUPPLIES];
 	struct cs35l32_platform_data pdata;
 	struct gpio_desc *reset_gpio;
@@ -154,16 +154,16 @@ static const struct snd_soc_dapm_route cs35l32_audio_map[] = {
 
 static int cs35l32_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		snd_soc_update_bits(codec, CS35L32_ADSP_CTL,
+		snd_soc_component_update_bits(component, CS35L32_ADSP_CTL,
 				    CS35L32_ADSP_MASTER_MASK,
 				CS35L32_ADSP_MASTER_MASK);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		snd_soc_update_bits(codec, CS35L32_ADSP_CTL,
+		snd_soc_component_update_bits(component, CS35L32_ADSP_CTL,
 				    CS35L32_ADSP_MASTER_MASK, 0);
 		break;
 	default:
@@ -175,9 +175,9 @@ static int cs35l32_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 
 static int cs35l32_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
-	return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
+	return snd_soc_component_update_bits(component, CS35L32_PWRCTL2,
 					CS35L32_SDOUT_3ST, tristate << 3);
 }
 
@@ -202,7 +202,7 @@ static struct snd_soc_dai_driver cs35l32_dai[] = {
 	}
 };
 
-static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
+static int cs35l32_component_set_sysclk(struct snd_soc_component *component,
 			      int clk_id, int source, unsigned int freq, int dir)
 {
 	unsigned int val;
@@ -224,21 +224,22 @@ static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	return snd_soc_update_bits(codec, CS35L32_CLK_CTL,
+	return snd_soc_component_update_bits(component, CS35L32_CLK_CTL,
 			CS35L32_MCLK_DIV2_MASK | CS35L32_MCLK_RATIO_MASK, val);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_cs35l32 = {
-	.set_sysclk = cs35l32_codec_set_sysclk,
-
-	.component_driver = {
-		.controls		= cs35l32_snd_controls,
-		.num_controls		= ARRAY_SIZE(cs35l32_snd_controls),
-		.dapm_widgets		= cs35l32_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(cs35l32_dapm_widgets),
-		.dapm_routes		= cs35l32_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(cs35l32_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_cs35l32 = {
+	.set_sysclk		= cs35l32_component_set_sysclk,
+	.controls		= cs35l32_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs35l32_snd_controls),
+	.dapm_widgets		= cs35l32_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs35l32_dapm_widgets),
+	.dapm_routes		= cs35l32_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(cs35l32_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 /* Current and threshold powerup sequence Pg37 in datasheet */
@@ -483,8 +484,8 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	/* Clear MCLK Error Bit since we don't have the clock yet */
 	ret = regmap_read(cs35l32->regmap, CS35L32_INT_STATUS_1, &reg);
 
-	ret =  snd_soc_register_codec(&i2c_client->dev,
-			&soc_codec_dev_cs35l32, cs35l32_dai,
+	ret = devm_snd_soc_register_component(&i2c_client->dev,
+			&soc_component_dev_cs35l32, cs35l32_dai,
 			ARRAY_SIZE(cs35l32_dai));
 	if (ret < 0)
 		goto err_disable;
@@ -501,8 +502,6 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs35l32_private *cs35l32 = i2c_get_clientdata(i2c_client);
 
-	snd_soc_unregister_codec(&i2c_client->dev);
-
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
-- 
2.16.1
