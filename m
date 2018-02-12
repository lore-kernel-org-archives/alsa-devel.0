From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:36:13 +0000
Message-ID: <E1elDLB-0003r8-PP@debutante>
References: <87o9lduvmh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1F30267A4D
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:36:15 +0100 (CET)
In-Reply-To: <87o9lduvmh.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: dmic: replace codec to component

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

>From 6d6c3946d877adf1e73c6292f947bbb687452ed5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:40:29 +0000
Subject: [PATCH] ASoC: dmic: replace codec to component

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
 sound/soc/codecs/dmic.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index cf83c423394d..32a8f71d51f1 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -71,16 +71,16 @@ static struct snd_soc_dai_driver dmic_dai = {
 	.ops    = &dmic_dai_ops,
 };
 
-static int dmic_codec_probe(struct snd_soc_codec *codec)
+static int dmic_component_probe(struct snd_soc_component *component)
 {
 	struct gpio_desc *dmic_en;
 
-	dmic_en = devm_gpiod_get_optional(codec->dev,
+	dmic_en = devm_gpiod_get_optional(component->dev,
 					"dmicen", GPIOD_OUT_LOW);
 	if (IS_ERR(dmic_en))
 		return PTR_ERR(dmic_en);
 
-	snd_soc_codec_set_drvdata(codec, dmic_en);
+	snd_soc_component_set_drvdata(component, dmic_en);
 
 	return 0;
 }
@@ -95,14 +95,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"DMIC AIF", NULL, "DMic"},
 };
 
-static const struct snd_soc_codec_driver soc_dmic = {
-	.probe = dmic_codec_probe,
-	.component_driver = {
-		.dapm_widgets		= dmic_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(dmic_dapm_widgets),
-		.dapm_routes		= intercon,
-		.num_dapm_routes	= ARRAY_SIZE(intercon),
-	},
+static const struct snd_soc_component_driver soc_dmic = {
+	.probe			= dmic_component_probe,
+	.dapm_widgets		= dmic_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(dmic_dapm_widgets),
+	.dapm_routes		= intercon,
+	.num_dapm_routes	= ARRAY_SIZE(intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int dmic_dev_probe(struct platform_device *pdev)
@@ -129,16 +131,10 @@ static int dmic_dev_probe(struct platform_device *pdev)
 		}
 	}
 
-	return snd_soc_register_codec(&pdev->dev,
+	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_dmic, dai_drv, 1);
 }
 
-static int dmic_dev_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 MODULE_ALIAS("platform:dmic-codec");
 
 static const struct of_device_id dmic_dev_match[] = {
@@ -152,7 +148,6 @@ static struct platform_driver dmic_driver = {
 		.of_match_table = dmic_dev_match,
 	},
 	.probe = dmic_dev_probe,
-	.remove = dmic_dev_remove,
 };
 
 module_platform_driver(dmic_driver);
-- 
2.16.1
