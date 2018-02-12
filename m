From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pistachio: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:35:02 +0000
Message-ID: <E1elDK2-0003l6-4D@debutante>
References: <87inbluvjx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 833FA2679D9
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:35:04 +0100 (CET)
In-Reply-To: <87inbluvjx.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pistachio: replace codec to component

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

>From 8dc906d3ae088668ab9c0f4e0fa2314a8cd8fcaa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:42:01 +0000
Subject: [PATCH] ASoC: pistachio: replace codec to component

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
 sound/soc/img/pistachio-internal-dac.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/img/pistachio-internal-dac.c b/sound/soc/img/pistachio-internal-dac.c
index 53e11c6d4e22..915b894f99ce 100644
--- a/sound/soc/img/pistachio-internal-dac.c
+++ b/sound/soc/img/pistachio-internal-dac.c
@@ -122,26 +122,26 @@ static struct snd_soc_dai_driver pistachio_internal_dac_dais[] = {
 	},
 };
 
-static int pistachio_internal_dac_codec_probe(struct snd_soc_codec *codec)
+static int pistachio_internal_dac_codec_probe(struct snd_soc_component *component)
 {
-	struct pistachio_internal_dac *dac = snd_soc_codec_get_drvdata(codec);
+	struct pistachio_internal_dac *dac = snd_soc_component_get_drvdata(component);
 
-	snd_soc_codec_init_regmap(codec, dac->regmap);
+	snd_soc_component_init_regmap(component, dac->regmap);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver pistachio_internal_dac_driver = {
-	.probe = pistachio_internal_dac_codec_probe,
-	.idle_bias_off = true,
-	.component_driver = {
-		.controls		= pistachio_internal_dac_snd_controls,
-		.num_controls		= ARRAY_SIZE(pistachio_internal_dac_snd_controls),
-		.dapm_widgets		= pistachio_internal_dac_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(pistachio_internal_dac_widgets),
-		.dapm_routes		= pistachio_internal_dac_routes,
-		.num_dapm_routes	= ARRAY_SIZE(pistachio_internal_dac_routes),
-	},
+static const struct snd_soc_component_driver pistachio_internal_dac_driver = {
+	.probe			= pistachio_internal_dac_codec_probe,
+	.controls		= pistachio_internal_dac_snd_controls,
+	.num_controls		= ARRAY_SIZE(pistachio_internal_dac_snd_controls),
+	.dapm_widgets		= pistachio_internal_dac_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pistachio_internal_dac_widgets),
+	.dapm_routes		= pistachio_internal_dac_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pistachio_internal_dac_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int pistachio_internal_dac_probe(struct platform_device *pdev)
@@ -202,11 +202,12 @@ static int pistachio_internal_dac_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_idle(dev);
 
-	ret = snd_soc_register_codec(dev, &pistachio_internal_dac_driver,
+	ret = devm_snd_soc_register_component(dev,
+			&pistachio_internal_dac_driver,
 			pistachio_internal_dac_dais,
 			ARRAY_SIZE(pistachio_internal_dac_dais));
 	if (ret) {
-		dev_err(dev, "failed to register codec: %d\n", ret);
+		dev_err(dev, "failed to register component: %d\n", ret);
 		goto err_pwr;
 	}
 
@@ -225,7 +226,6 @@ static int pistachio_internal_dac_remove(struct platform_device *pdev)
 {
 	struct pistachio_internal_dac *dac = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pistachio_internal_dac_pwr_off(dac);
 	regulator_disable(dac->supply);
-- 
2.16.1
