From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm: cygnus: replace platform to component" to the asoc tree
Date: Mon, 12 Feb 2018 12:31:52 +0000
Message-ID: <E1elDGy-0003NC-CX@debutante>
References: <87mv7t5eyn.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87mv7t5eyn.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm: cygnus: replace platform to component

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

>From 540b925af4c0456adf220dea991d91bf05ad77c0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:42:37 +0000
Subject: [PATCH] ASoC: bcm: cygnus: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-pcm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index d616e096462e..123ecf5479d7 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -820,7 +820,7 @@ static int cygnus_dma_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_platform_driver cygnus_soc_platform = {
+static struct snd_soc_component_driver cygnus_soc_platform = {
 	.ops		= &cygnus_pcm_ops,
 	.pcm_new	= cygnus_dma_new,
 	.pcm_free	= cygnus_dma_free_dma_buffers,
@@ -840,7 +840,8 @@ int cygnus_soc_platform_register(struct device *dev,
 		return rc;
 	}
 
-	rc = snd_soc_register_platform(dev, &cygnus_soc_platform);
+	rc = devm_snd_soc_register_component(dev, &cygnus_soc_platform,
+					     NULL, 0);
 	if (rc) {
 		dev_err(dev, "%s failed\n", __func__);
 		return rc;
@@ -851,8 +852,6 @@ int cygnus_soc_platform_register(struct device *dev,
 
 int cygnus_soc_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(dev);
-
 	return 0;
 }
 
-- 
2.16.1
