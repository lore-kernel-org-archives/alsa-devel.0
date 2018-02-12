From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:44:47 +0000
Message-ID: <E1elDTT-0005Bf-29@debutante>
References: <87lggh1fwe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 378B82678B3
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:44:49 +0100 (CET)
In-Reply-To: <87lggh1fwe.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: cs4349: replace codec to component

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

>From 0ec65b677c255204d8a26efea400fd7a37771476 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:53:32 +0000
Subject: [PATCH] ASoC: cs4349: replace codec to component

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
 sound/soc/codecs/cs4349.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 0a749c79ef57..bee0e343723f 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -74,8 +74,8 @@ static bool cs4349_writeable_register(struct device *dev, unsigned int reg)
 static int cs4349_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct cs4349_private *cs4349 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct cs4349_private *cs4349 = snd_soc_component_get_drvdata(component);
 	unsigned int fmt;
 
 	fmt = format & SND_SOC_DAIFMT_FORMAT_MASK;
@@ -97,8 +97,8 @@ static int cs4349_pcm_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cs4349_private *cs4349 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cs4349_private *cs4349 = snd_soc_component_get_drvdata(component);
 	int fmt, ret;
 
 	cs4349->rate = params_rate(params);
@@ -126,7 +126,7 @@ static int cs4349_pcm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	ret = snd_soc_update_bits(codec, CS4349_MODE, DIF_MASK,
+	ret = snd_soc_component_update_bits(component, CS4349_MODE, DIF_MASK,
 				  MODE_FORMAT(fmt));
 	if (ret < 0)
 		return ret;
@@ -136,14 +136,14 @@ static int cs4349_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int cs4349_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int reg;
 
 	reg = 0;
 	if (mute)
 		reg = MUTE_AB_MASK;
 
-	return snd_soc_update_bits(codec, CS4349_MUTE, MUTE_AB_MASK, reg);
+	return snd_soc_component_update_bits(component, CS4349_MUTE, MUTE_AB_MASK, reg);
 }
 
 static DECLARE_TLV_DB_SCALE(dig_tlv, -12750, 50, 0);
@@ -255,15 +255,17 @@ static struct snd_soc_dai_driver cs4349_dai = {
 	.symmetric_rates = 1,
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_cs4349 = {
-	.component_driver = {
-		.controls		= cs4349_snd_controls,
-		.num_controls		= ARRAY_SIZE(cs4349_snd_controls),
-		.dapm_widgets		= cs4349_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(cs4349_dapm_widgets),
-		.dapm_routes		= cs4349_routes,
-		.num_dapm_routes	= ARRAY_SIZE(cs4349_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_cs4349 = {
+	.controls		= cs4349_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs4349_snd_controls),
+	.dapm_widgets		= cs4349_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs4349_dapm_widgets),
+	.dapm_routes		= cs4349_routes,
+	.num_dapm_routes	= ARRAY_SIZE(cs4349_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config cs4349_regmap = {
@@ -305,7 +307,8 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, cs4349);
 
-	return snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4349,
+	return devm_snd_soc_register_component(&client->dev,
+		&soc_component_dev_cs4349,
 		&cs4349_dai, 1);
 }
 
@@ -313,8 +316,6 @@ static int cs4349_i2c_remove(struct i2c_client *client)
 {
 	struct cs4349_private *cs4349 = i2c_get_clientdata(client);
 
-	snd_soc_unregister_codec(&client->dev);
-
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
 
-- 
2.16.1
