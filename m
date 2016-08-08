From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove codec duplicated callback function" to the asoc tree
Date: Mon, 08 Aug 2016 12:06:35 +0100
Message-ID: <E1bWiOB-0004G9-1b@debutante>
References: <87fuqm8xur.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuqm8xur.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove codec duplicated callback function

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

>From 8073aefa60823acf205a1e6a5ea118297179d766 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 09:36:49 +0000
Subject: [PATCH] ASoC: remove codec duplicated callback function

codec driver and component driver has duplicated callback functions,
and codec side functions are just copied to component side when
register timing. This was quick-hack, but no longer needed.
This patch removes codec side duplicated callback function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  8 --------
 sound/soc/soc-core.c | 13 -------------
 2 files changed, 21 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6144882cc96a..5eb2b38c3437 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -898,14 +898,6 @@ struct snd_soc_codec_driver {
 	int (*resume)(struct snd_soc_codec *);
 	struct snd_soc_component_driver component_driver;
 
-	/* Default control and setup, added after probe() is run */
-	const struct snd_kcontrol_new *controls;
-	int num_controls;
-	const struct snd_soc_dapm_widget *dapm_widgets;
-	int num_dapm_widgets;
-	const struct snd_soc_dapm_route *dapm_routes;
-	int num_dapm_routes;
-
 	/* codec wide operations */
 	int (*set_sysclk)(struct snd_soc_codec *codec,
 			  int clk_id, int source, unsigned int freq, int dir);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16369cad4803..edba975d893e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3333,19 +3333,6 @@ int snd_soc_register_codec(struct device *dev,
 	if (ret)
 		goto err_free;
 
-	if (codec_drv->controls) {
-		codec->component.controls = codec_drv->controls;
-		codec->component.num_controls = codec_drv->num_controls;
-	}
-	if (codec_drv->dapm_widgets) {
-		codec->component.dapm_widgets = codec_drv->dapm_widgets;
-		codec->component.num_dapm_widgets = codec_drv->num_dapm_widgets;
-	}
-	if (codec_drv->dapm_routes) {
-		codec->component.dapm_routes = codec_drv->dapm_routes;
-		codec->component.num_dapm_routes = codec_drv->num_dapm_routes;
-	}
-
 	if (codec_drv->probe)
 		codec->component.probe = snd_soc_codec_drv_probe;
 	if (codec_drv->remove)
-- 
2.8.1
