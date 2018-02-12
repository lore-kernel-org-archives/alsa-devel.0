From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: si476x: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:34:13 +0000
Message-ID: <E1elDJF-0003fn-PP@debutante>
References: <87a7wxuvej.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF41267683
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:34:15 +0100 (CET)
In-Reply-To: <87a7wxuvej.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: si476x: replace codec to component

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

>From 8fcfe24c2345678000fab25bbd214025becf1154 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:45:14 +0000
Subject: [PATCH] ASoC: si476x: replace codec to component

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
 sound/soc/codecs/si476x.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 7b91ee267b4e..b779c2855c01 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -140,14 +140,14 @@ static int si476x_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	si476x_core_lock(core);
 
-	err = snd_soc_update_bits(codec_dai->codec, SI476X_DIGITAL_IO_OUTPUT_FORMAT,
+	err = snd_soc_component_update_bits(codec_dai->component, SI476X_DIGITAL_IO_OUTPUT_FORMAT,
 				  SI476X_DIGITAL_IO_OUTPUT_FORMAT_MASK,
 				  format);
 
 	si476x_core_unlock(core);
 
 	if (err < 0) {
-		dev_err(codec_dai->codec->dev, "Failed to set output format\n");
+		dev_err(codec_dai->component->dev, "Failed to set output format\n");
 		return err;
 	}
 
@@ -163,7 +163,7 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
 
 	rate = params_rate(params);
 	if (rate < 32000 || rate > 48000) {
-		dev_err(dai->codec->dev, "Rate: %d is not supported\n", rate);
+		dev_err(dai->component->dev, "Rate: %d is not supported\n", rate);
 		return -EINVAL;
 	}
 
@@ -186,19 +186,19 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
 
 	si476x_core_lock(core);
 
-	err = snd_soc_write(dai->codec, SI476X_DIGITAL_IO_OUTPUT_SAMPLE_RATE,
+	err = snd_soc_component_write(dai->component, SI476X_DIGITAL_IO_OUTPUT_SAMPLE_RATE,
 			    rate);
 	if (err < 0) {
-		dev_err(dai->codec->dev, "Failed to set sample rate\n");
+		dev_err(dai->component->dev, "Failed to set sample rate\n");
 		goto out;
 	}
 
-	err = snd_soc_update_bits(dai->codec, SI476X_DIGITAL_IO_OUTPUT_FORMAT,
+	err = snd_soc_component_update_bits(dai->component, SI476X_DIGITAL_IO_OUTPUT_FORMAT,
 				  SI476X_DIGITAL_IO_OUTPUT_WIDTH_MASK,
 				  (width << SI476X_DIGITAL_IO_SLOT_SIZE_SHIFT) |
 				  (width << SI476X_DIGITAL_IO_SAMPLE_SIZE_SHIFT));
 	if (err < 0) {
-		dev_err(dai->codec->dev, "Failed to set output width\n");
+		dev_err(dai->component->dev, "Failed to set output width\n");
 		goto out;
 	}
 
@@ -239,28 +239,25 @@ static int si476x_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_si476x = {
-	.component_driver = {
-		.probe			= si476x_probe,
-		.dapm_widgets		= si476x_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(si476x_dapm_widgets),
-		.dapm_routes		= si476x_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(si476x_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_si476x = {
+	.probe			= si476x_probe,
+	.dapm_widgets		= si476x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(si476x_dapm_widgets),
+	.dapm_routes		= si476x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(si476x_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int si476x_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_si476x,
+	return devm_snd_soc_register_component(&pdev->dev,
+				      &soc_component_dev_si476x,
 				      &si476x_dai, 1);
 }
 
-static int si476x_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 MODULE_ALIAS("platform:si476x-codec");
 
 static struct platform_driver si476x_platform_driver = {
@@ -268,7 +265,6 @@ static struct platform_driver si476x_platform_driver = {
 		.name	= "si476x-codec",
 	},
 	.probe		= si476x_platform_probe,
-	.remove		= si476x_platform_remove,
 };
 module_platform_driver(si476x_platform_driver);
 
-- 
2.16.1
