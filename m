From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm4567: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:18 +0000
Message-ID: <E1elDNC-0004Fz-G4@debutante>
References: <87vaflwark.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7DC267A80
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:20 +0100 (CET)
In-Reply-To: <87vaflwark.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ssm4567: replace codec to component

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

>From b63aecbdbcf393e13c71497edb6c8b772f11c773 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:28:10 +0000
Subject: [PATCH] ASoC: ssm4567: replace codec to component

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
 sound/soc/codecs/ssm4567.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 4afeddef7728..90119ea00498 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -199,8 +199,8 @@ static const struct snd_soc_dapm_route ssm4567_routes[] = {
 static int ssm4567_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ssm4567 *ssm4567 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ssm4567 *ssm4567 = snd_soc_component_get_drvdata(component);
 	unsigned int rate = params_rate(params);
 	unsigned int dacfs;
 
@@ -223,7 +223,7 @@ static int ssm4567_hw_params(struct snd_pcm_substream *substream,
 
 static int ssm4567_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct ssm4567 *ssm4567 = snd_soc_codec_get_drvdata(dai->codec);
+	struct ssm4567 *ssm4567 = snd_soc_component_get_drvdata(dai->component);
 	unsigned int val;
 
 	val = mute ? SSM4567_DAC_MUTE : 0;
@@ -366,10 +366,10 @@ static int ssm4567_set_power(struct ssm4567 *ssm4567, bool enable)
 	return ret;
 }
 
-static int ssm4567_set_bias_level(struct snd_soc_codec *codec,
+static int ssm4567_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct ssm4567 *ssm4567 = snd_soc_codec_get_drvdata(codec);
+	struct ssm4567 *ssm4567 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	switch (level) {
@@ -378,7 +378,7 @@ static int ssm4567_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			ret = ssm4567_set_power(ssm4567, true);
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -417,18 +417,17 @@ static struct snd_soc_dai_driver ssm4567_dai = {
 	.ops = &ssm4567_dai_ops,
 };
 
-static const struct snd_soc_codec_driver ssm4567_codec_driver = {
-	.set_bias_level = ssm4567_set_bias_level,
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.controls		= ssm4567_snd_controls,
-		.num_controls		= ARRAY_SIZE(ssm4567_snd_controls),
-		.dapm_widgets		= ssm4567_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ssm4567_dapm_widgets),
-		.dapm_routes		= ssm4567_routes,
-		.num_dapm_routes	= ARRAY_SIZE(ssm4567_routes),
-	},
+static const struct snd_soc_component_driver ssm4567_component_driver = {
+	.set_bias_level		= ssm4567_set_bias_level,
+	.controls		= ssm4567_snd_controls,
+	.num_controls		= ARRAY_SIZE(ssm4567_snd_controls),
+	.dapm_widgets		= ssm4567_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ssm4567_dapm_widgets),
+	.dapm_routes		= ssm4567_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ssm4567_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ssm4567_regmap_config = {
@@ -469,16 +468,10 @@ static int ssm4567_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	return snd_soc_register_codec(&i2c->dev, &ssm4567_codec_driver,
+	return devm_snd_soc_register_component(&i2c->dev, &ssm4567_component_driver,
 			&ssm4567_dai, 1);
 }
 
-static int ssm4567_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id ssm4567_i2c_ids[] = {
 	{ "ssm4567", 0 },
 	{ }
@@ -510,7 +503,6 @@ static struct i2c_driver ssm4567_driver = {
 		.acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
 	},
 	.probe = ssm4567_i2c_probe,
-	.remove = ssm4567_i2c_remove,
 	.id_table = ssm4567_i2c_ids,
 };
 module_i2c_driver(ssm4567_driver);
-- 
2.16.1
