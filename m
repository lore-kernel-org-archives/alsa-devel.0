From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:41:04 +0000
Message-ID: <E1elDPs-0004mD-2E@debutante>
References: <87h8r5z4rr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C032679A5
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:06 +0100 (CET)
In-Reply-To: <87h8r5z4rr.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: max98357a: replace codec to component

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

>From 4b51e9f1c386dbd7bd7bc5a342a6ac90a6c54904 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:09:20 +0000
Subject: [PATCH] ASoC: max98357a: replace codec to component

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
 sound/soc/codecs/max98357a.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 426ed2dae6ca..d469576b5a7b 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -59,27 +59,29 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 	{"Speaker", NULL, "HiFi Playback"},
 };
 
-static int max98357a_codec_probe(struct snd_soc_codec *codec)
+static int max98357a_component_probe(struct snd_soc_component *component)
 {
 	struct gpio_desc *sdmode;
 
-	sdmode = devm_gpiod_get_optional(codec->dev, "sdmode", GPIOD_OUT_LOW);
+	sdmode = devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_LOW);
 	if (IS_ERR(sdmode))
 		return PTR_ERR(sdmode);
 
-	snd_soc_codec_set_drvdata(codec, sdmode);
+	snd_soc_component_set_drvdata(component, sdmode);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver max98357a_codec_driver = {
-	.probe			= max98357a_codec_probe,
-	.component_driver = {
-		.dapm_widgets		= max98357a_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
-		.dapm_routes		= max98357a_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(max98357a_dapm_routes),
-	},
+static const struct snd_soc_component_driver max98357a_component_driver = {
+	.probe			= max98357a_component_probe,
+	.dapm_widgets		= max98357a_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
+	.dapm_routes		= max98357a_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(max98357a_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct snd_soc_dai_ops max98357a_dai_ops = {
@@ -107,14 +109,13 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &max98357a_codec_driver,
+	return devm_snd_soc_register_component(&pdev->dev,
+			&max98357a_component_driver,
 			&max98357a_dai_driver, 1);
 }
 
 static int max98357a_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.16.1
