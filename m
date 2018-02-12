From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8782: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:49:28 +0000
Message-ID: <E1elDY0-00067j-EB@debutante>
References: <87po5t4bc1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1F29267B06
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:49:30 +0100 (CET)
In-Reply-To: <87po5t4bc1.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8782: replace codec to component

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

>From d6ae5c166ab77245ba5d8c7f57518ce00945d05f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:03:17 +0000
Subject: [PATCH] ASoC: wm8782: replace codec to component

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
 sound/soc/codecs/wm8782.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index bcda21018505..7949703f3d04 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -50,25 +50,21 @@ static struct snd_soc_dai_driver wm8782_dai = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8782 = {
-	.component_driver = {
-		.dapm_widgets		= wm8782_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8782_dapm_widgets),
-		.dapm_routes		= wm8782_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8782_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8782 = {
+	.dapm_widgets		= wm8782_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8782_dapm_widgets),
+	.dapm_routes		= wm8782_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8782_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm8782_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_wm8782, &wm8782_dai, 1);
-}
-
-static int wm8782_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
 
 static struct platform_driver wm8782_codec_driver = {
@@ -76,7 +72,6 @@ static struct platform_driver wm8782_codec_driver = {
 		.name = "wm8782",
 	},
 	.probe = wm8782_probe,
-	.remove = wm8782_remove,
 };
 
 module_platform_driver(wm8782_codec_driver);
-- 
2.16.1
