From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stac9766: replace codec to component"
	to the asoc tree
Date: Tue, 13 Feb 2018 12:15:03 +0000
Message-ID: <E1elZUF-0005R0-Gp@debutante>
References: <87vafluvq5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 147A12678B4
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:15:06 +0100 (CET)
In-Reply-To: <87vafluvq5.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: stac9766: replace codec to component

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

>From b5b410de5550b0417f8648ccbf267192d8fc2272 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:38:18 +0000
Subject: [PATCH] ASoC: stac9766: replace codec to component

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
 sound/soc/codecs/stac9766.c | 77 +++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index c66363a2cac7..f62101a629e0 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -168,58 +168,58 @@ static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
 static int ac97_analog_prepare(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned short reg;
 
 	/* enable variable rate audio, disable SPDIF output */
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x5, 0x1);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x5, 0x1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return snd_soc_write(codec, reg, runtime->rate);
+	return snd_soc_component_write(component, reg, runtime->rate);
 }
 
 static int ac97_digital_prepare(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned short reg;
 
-	snd_soc_write(codec, AC97_SPDIF, 0x2002);
+	snd_soc_component_write(component, AC97_SPDIF, 0x2002);
 
 	/* Enable VRA and SPDIF out */
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x5, 0x5);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x5, 0x5);
 
 	reg = AC97_PCM_FRONT_DAC_RATE;
 
-	return snd_soc_write(codec, reg, runtime->rate);
+	return snd_soc_component_write(component, reg, runtime->rate);
 }
 
-static int stac9766_set_bias_level(struct snd_soc_codec *codec,
+static int stac9766_set_bias_level(struct snd_soc_component *component,
 				   enum snd_soc_bias_level level)
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON: /* full On */
 	case SND_SOC_BIAS_PREPARE: /* partial On */
 	case SND_SOC_BIAS_STANDBY: /* Off, with power */
-		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_component_write(component, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF: /* Off, without power */
 		/* disable everything including AC link */
-		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_component_write(component, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
 }
 
-static int stac9766_codec_resume(struct snd_soc_codec *codec)
+static int stac9766_component_resume(struct snd_soc_component *component)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct snd_ac97 *ac97 = snd_soc_component_get_drvdata(component);
 
 	return snd_ac97_reset(ac97, true, STAC9766_VENDOR_ID,
 		STAC9766_VENDOR_ID_MASK);
@@ -272,13 +272,13 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 }
 };
 
-static int stac9766_codec_probe(struct snd_soc_codec *codec)
+static int stac9766_component_probe(struct snd_soc_component *component)
 {
 	struct snd_ac97 *ac97;
 	struct regmap *regmap;
 	int ret;
 
-	ac97 = snd_soc_new_ac97_codec(codec, STAC9766_VENDOR_ID,
+	ac97 = snd_soc_new_ac97_component(component, STAC9766_VENDOR_ID,
 			STAC9766_VENDOR_ID_MASK);
 	if (IS_ERR(ac97))
 		return PTR_ERR(ac97);
@@ -289,46 +289,42 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 		goto err_free_ac97;
 	}
 
-	snd_soc_codec_init_regmap(codec, regmap);
-	snd_soc_codec_set_drvdata(codec, ac97);
+	snd_soc_component_init_regmap(component, regmap);
+	snd_soc_component_set_drvdata(component, ac97);
 
 	return 0;
 err_free_ac97:
-	snd_soc_free_ac97_codec(ac97);
+	snd_soc_free_ac97_component(ac97);
 	return ret;
 }
 
-static int stac9766_codec_remove(struct snd_soc_codec *codec)
+static void stac9766_component_remove(struct snd_soc_component *component)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct snd_ac97 *ac97 = snd_soc_component_get_drvdata(component);
 
-	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(ac97);
-	return 0;
+	snd_soc_component_exit_regmap(component);
+	snd_soc_free_ac97_component(ac97);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
-	.component_driver = {
-		.controls		= stac9766_snd_ac97_controls,
-		.num_controls		= ARRAY_SIZE(stac9766_snd_ac97_controls),
-	},
-	.set_bias_level = stac9766_set_bias_level,
-	.suspend_bias_off = true,
-	.probe = stac9766_codec_probe,
-	.remove = stac9766_codec_remove,
-	.resume = stac9766_codec_resume,
+static const struct snd_soc_component_driver soc_component_dev_stac9766 = {
+	.controls		= stac9766_snd_ac97_controls,
+	.num_controls		= ARRAY_SIZE(stac9766_snd_ac97_controls),
+	.set_bias_level		= stac9766_set_bias_level,
+	.probe			= stac9766_component_probe,
+	.remove			= stac9766_component_remove,
+	.resume			= stac9766_component_resume,
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+
 };
 
 static int stac9766_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_stac9766, stac9766_dai, ARRAY_SIZE(stac9766_dai));
-}
-
-static int stac9766_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_stac9766, stac9766_dai, ARRAY_SIZE(stac9766_dai));
 }
 
 static struct platform_driver stac9766_codec_driver = {
@@ -337,7 +333,6 @@ static struct platform_driver stac9766_codec_driver = {
 	},
 
 	.probe = stac9766_probe,
-	.remove = stac9766_remove,
 };
 
 module_platform_driver(stac9766_codec_driver);
-- 
2.16.1
