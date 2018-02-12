From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:37:26 +0000
Message-ID: <E1elDMM-00042V-Re@debutante>
References: <878tchwah4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A6D267501
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:37:29 +0100 (CET)
In-Reply-To: <878tchwah4.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: hdmi-codec: replace codec to component

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

>From d20aa608f4244868139b0a25a8afc89c5a6bf422 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:34:21 +0000
Subject: [PATCH] ASoC: hdmi-codec: replace codec to component

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
 sound/soc/codecs/hdmi-codec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 5672e516bec3..42df579cb507 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -730,14 +730,16 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	return ret;
 }
 
-static const struct snd_soc_codec_driver hdmi_codec = {
-	.component_driver = {
-		.dapm_widgets		= hdmi_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
-		.dapm_routes		= hdmi_routes,
-		.num_dapm_routes	= ARRAY_SIZE(hdmi_routes),
-		.of_xlate_dai_id	= hdmi_of_xlate_dai_id,
-	},
+static const struct snd_soc_component_driver hdmi_driver = {
+	.dapm_widgets		= hdmi_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
+	.dapm_routes		= hdmi_routes,
+	.num_dapm_routes	= ARRAY_SIZE(hdmi_routes),
+	.of_xlate_dai_id	= hdmi_of_xlate_dai_id,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int hdmi_codec_probe(struct platform_device *pdev)
@@ -784,10 +786,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->spdif)
 		hcp->daidrv[i] = hdmi_spdif_dai;
 
-	ret = snd_soc_register_codec(dev, &hdmi_codec, hcp->daidrv,
+	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
 				     dai_count);
 	if (ret) {
-		dev_err(dev, "%s: snd_soc_register_codec() failed (%d)\n",
+		dev_err(dev, "%s: snd_soc_register_component() failed (%d)\n",
 			__func__, ret);
 		return ret;
 	}
@@ -803,7 +805,6 @@ static int hdmi_codec_remove(struct platform_device *pdev)
 
 	hcp = dev_get_drvdata(dev);
 	kfree(hcp->chmap_info);
-	snd_soc_unregister_codec(dev);
 
 	return 0;
 }
-- 
2.16.1
