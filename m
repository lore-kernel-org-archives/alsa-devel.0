From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] sound/soc/fsl: remove leftover
	release_mem_region
Date: Sun, 13 Oct 2013 19:38:20 +0200
Message-ID: <1381685916-7401-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D2C02610A9
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2013 19:39:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

When converting this driver to devm_ioremap_resource, the removal of this now
unneeded function has been forgotten.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/soc/fsl/imx-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index f58bcd8..b2cc743 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -615,7 +615,6 @@ failed_pcm_dma:
 failed_pcm_fiq:
 	snd_soc_unregister_component(&pdev->dev);
 failed_register:
-	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(ssi->clk);
 failed_clk:
 	snd_soc_set_ac97_ops(NULL);
@@ -636,7 +635,6 @@ static int imx_ssi_remove(struct platform_device *pdev)
 	if (ssi->flags & IMX_SSI_USE_AC97)
 		ac97_ssi = NULL;
 
-	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(ssi->clk);
 	snd_soc_set_ac97_ops(NULL);
 
-- 
1.8.4.rc3
