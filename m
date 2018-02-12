From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4554: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:45:46 +0000
Message-ID: <E1elDUQ-0005Np-VJ@debutante>
References: <877es12w8d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 114F0267D0F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:45:49 +0100 (CET)
In-Reply-To: <877es12w8d.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4554: replace codec to component

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

>From 5aea27d59f764e346cb93923b0af6a94567cb95b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:14:50 +0000
Subject: [PATCH] ASoC: ak4554: replace codec to component

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
 sound/soc/codecs/ak4554.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ak4554.c b/sound/soc/codecs/ak4554.c
index 0bb4fe5c122a..b7ee13406d93 100644
--- a/sound/soc/codecs/ak4554.c
+++ b/sound/soc/codecs/ak4554.c
@@ -64,28 +64,24 @@ static struct snd_soc_dai_driver ak4554_dai = {
 	.symmetric_rates = 1,
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_ak4554 = {
-	.component_driver = {
-		.dapm_widgets		= ak4554_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ak4554_dapm_widgets),
-		.dapm_routes		= ak4554_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(ak4554_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_ak4554 = {
+	.dapm_widgets		= ak4554_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4554_dapm_widgets),
+	.dapm_routes		= ak4554_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ak4554_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int ak4554_soc_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev,
-				      &soc_codec_dev_ak4554,
+	return devm_snd_soc_register_component(&pdev->dev,
+				      &soc_component_dev_ak4554,
 				      &ak4554_dai, 1);
 }
 
-static int ak4554_soc_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 static const struct of_device_id ak4554_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4554" },
 	{},
@@ -98,7 +94,6 @@ static struct platform_driver ak4554_driver = {
 		.of_match_table = ak4554_of_match,
 	},
 	.probe	= ak4554_soc_probe,
-	.remove	= ak4554_soc_remove,
 };
 module_platform_driver(ak4554_driver);
 
-- 
2.16.1
