From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 1/9] ASoC: fsl-ssi: Fix probe error handling
Date: Fri, 20 Dec 2013 14:11:28 +0100
Message-ID: <1387545096-2334-2-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E1346265639
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 14:12:24 +0100 (CET)
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the error handling in the fsl-ssi probe function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b2ebaf8..878a3b2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -141,6 +141,7 @@ struct fsl_ssi_private {
 	bool imx_ac97;
 	bool use_dma;
 	bool baudclk_locked;
+	bool irq_stats;
 	u8 i2s_mode;
 	spinlock_t baudclk_lock;
 	struct clk *baudclk;
@@ -1223,6 +1224,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
 					ssi_private);
+		ssi_private->irq_stats = true;
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
 					ssi_private->irq);
@@ -1273,11 +1275,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 			ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
 			if (ret)
-				goto error_dev;
+				goto error_pcm;
 		} else {
 			ret = imx_pcm_dma_init(pdev);
 			if (ret)
-				goto error_dev;
+				goto error_pcm;
 		}
 	}
 
@@ -1319,6 +1321,10 @@ done:
 	return 0;
 
 error_dai:
+	if (ssi_private->ssi_on_imx && !ssi_private->use_dma)
+		imx_pcm_fiq_exit(pdev);
+
+error_pcm:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
@@ -1332,7 +1338,8 @@ error_clk:
 	}
 
 error_irqmap:
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->irq_stats)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return ret;
 }
@@ -1350,7 +1357,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 			clk_disable_unprepare(ssi_private->baudclk);
 		clk_disable_unprepare(ssi_private->clk);
 	}
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->irq_stats)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
 }
-- 
1.8.5.1
