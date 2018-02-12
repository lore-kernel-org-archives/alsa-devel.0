From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: spdif_transmitter: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:39:03 +0000
Message-ID: <E1elDNv-0004QO-UA@debutante>
References: <87fu6pxpmc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2005D267AF9
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:06 +0100 (CET)
In-Reply-To: <87fu6pxpmc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: spdif_transmitter: replace codec to component

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

>From 3860978c5bf48720d1bab68ffa49e153fb9c01e8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:21:55 +0000
Subject: [PATCH] ASoC: spdif_transmitter: replace codec to component

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
 sound/soc/codecs/spdif_transmitter.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index 037aa1d45559..b4f7fc4acb39 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -38,13 +38,15 @@ static const struct snd_soc_dapm_route dit_routes[] = {
 	{ "spdif-out", NULL, "Playback" },
 };
 
-static struct snd_soc_codec_driver soc_codec_spdif_dit = {
-	.component_driver = {
-		.dapm_widgets		= dit_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(dit_widgets),
-		.dapm_routes		= dit_routes,
-		.num_dapm_routes	= ARRAY_SIZE(dit_routes),
-	},
+static struct snd_soc_component_driver soc_codec_spdif_dit = {
+	.dapm_widgets		= dit_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(dit_widgets),
+	.dapm_routes		= dit_routes,
+	.num_dapm_routes	= ARRAY_SIZE(dit_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static struct snd_soc_dai_driver dit_stub_dai = {
@@ -60,16 +62,11 @@ static struct snd_soc_dai_driver dit_stub_dai = {
 
 static int spdif_dit_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_spdif_dit,
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_codec_spdif_dit,
 			&dit_stub_dai, 1);
 }
 
-static int spdif_dit_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id spdif_dit_dt_ids[] = {
 	{ .compatible = "linux,spdif-dit", },
@@ -80,7 +77,6 @@ MODULE_DEVICE_TABLE(of, spdif_dit_dt_ids);
 
 static struct platform_driver spdif_dit_driver = {
 	.probe		= spdif_dit_probe,
-	.remove		= spdif_dit_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.of_match_table = of_match_ptr(spdif_dit_dt_ids),
-- 
2.16.1
