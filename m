From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/3] ASoC: imx: remove superfluous code in imx-ssi.c
Date: Fri, 25 Mar 2011 16:51:46 +0100
Message-ID: <1301068306-11997-4-git-send-email-w.sang@pengutronix.de>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@freescale.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Checking if IMX_SSI_DMA is set and then set it again is useless.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/imx/imx-ssi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index bc92ec6..c331d65 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -667,12 +667,6 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	if (res)
 		ssi->dma_params_rx.dma = res->start;
 
-	if ((cpu_is_mx27() || cpu_is_mx21()) &&
-			!(ssi->flags & IMX_SSI_USE_AC97) &&
-			(ssi->flags & IMX_SSI_DMA)) {
-		ssi->flags |= IMX_SSI_DMA;
-	}
-
 	platform_set_drvdata(pdev, ssi);
 
 	ret = snd_soc_register_dai(&pdev->dev, dai);
-- 
1.7.2.5
