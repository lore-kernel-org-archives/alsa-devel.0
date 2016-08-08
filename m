From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec duplicated callback function goes to component on mc13783" to the asoc tree
Date: Mon, 08 Aug 2016 12:01:32 +0100
Message-ID: <E1bWiJI-0002o1-0n@debutante>
References: <87popj39qp.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87popj39qp.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec duplicated callback function goes to component on mc13783

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f9294a24ae392a59f283b37c821c8f21c2ce1ade Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:20:05 +0000
Subject: [PATCH] ASoC: codec duplicated callback function goes to component on
 mc13783

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch moves these functions from codec driver to component driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mc13783.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 3e770cbe7f0f..90562703dcfd 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -737,12 +737,14 @@ static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.probe		= mc13783_probe,
 	.remove		= mc13783_remove,
 	.get_regmap	= mc13783_get_regmap,
-	.controls	= mc13783_control_list,
-	.num_controls	= ARRAY_SIZE(mc13783_control_list),
-	.dapm_widgets	= mc13783_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mc13783_dapm_widgets),
-	.dapm_routes	= mc13783_routes,
-	.num_dapm_routes = ARRAY_SIZE(mc13783_routes),
+	.component_driver = {
+		.controls		= mc13783_control_list,
+		.num_controls		= ARRAY_SIZE(mc13783_control_list),
+		.dapm_widgets		= mc13783_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(mc13783_dapm_widgets),
+		.dapm_routes		= mc13783_routes,
+		.num_dapm_routes	= ARRAY_SIZE(mc13783_routes),
+	},
 };
 
 static int __init mc13783_codec_probe(struct platform_device *pdev)
-- 
2.8.1
