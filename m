From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/3] sound/soc/fsl: remove leftover release_mem_region
Date: Wed, 22 May 2013 15:21:26 +0200
Message-ID: <1369228886-3527-3-git-send-email-wsa@the-dreams.de>
References: <1369228886-3527-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369228886-3527-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When converting this driver to devm_ioremap_resource, the removal of this now
unneeded function has been forgotten.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/soc/fsl/imx-ssi.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index c6fa03e..404314d 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -627,7 +627,6 @@ failed_pdev_fiq_add:
 failed_pdev_fiq_alloc:
 	snd_soc_unregister_component(&pdev->dev);
 failed_register:
-	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(ssi->clk);
 failed_clk:
 
@@ -636,7 +635,6 @@ failed_clk:
 
 static int imx_ssi_remove(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 
 	platform_device_unregister(ssi->soc_platform_pdev);
@@ -647,7 +645,6 @@ static int imx_ssi_remove(struct platform_device *pdev)
 	if (ssi->flags & IMX_SSI_USE_AC97)
 		ac97_ssi = NULL;
 
-	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(ssi->clk);
 
 	return 0;
-- 
1.7.10.4
