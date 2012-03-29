From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
Date: Thu, 29 Mar 2012 10:53:41 +0800
Message-ID: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E4FA324469
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 04:54:03 +0200 (CEST)
Received: by iakh37 with SMTP id h37so2477582iak.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2012 19:54:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

For power saving, most IMX platform initilization code turns off
modules' clock, and expects driver turn on clock as needed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4f76b5d..4ed2afd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -119,6 +120,7 @@ struct fsl_ssi_private {
 
 	bool new_binding;
 	bool ssi_on_imx;
+	struct clk *clk;
 	struct platform_device *imx_pcm_pdev;
 	struct imx_pcm_dma_params dma_params_tx;
 	struct imx_pcm_dma_params dma_params_rx;
@@ -722,6 +724,15 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
+
+		ssi_private->clk = clk_get(&pdev->dev, NULL);
+		if (IS_ERR(ssi_private->clk)) {
+			ret = PTR_ERR(ssi_private->clk);
+			dev_err(&pdev->dev, "could not get clock: %d\n", ret);
+			goto error_irq;
+		}
+		clk_prepare_enable(ssi_private->clk);
+
 		/*
 		 * We have burstsize be "fifo_depth - 2" to match the SSI
 		 * watermark setting in fsl_ssi_startup().
@@ -742,7 +753,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 					"fsl,ssi-dma-events", dma_events, 2);
 		if (ret) {
 			dev_err(&pdev->dev, "could not get dma events\n");
-			goto error_irq;
+			goto error_clk;
 		}
 		ssi_private->dma_params_tx.dma = dma_events[0];
 		ssi_private->dma_params_rx.dma = dma_events[1];
@@ -830,6 +841,12 @@ error_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
 	device_remove_file(&pdev->dev, dev_attr);
 
+error_clk:
+	if (ssi_private->ssi_on_imx) {
+		clk_disable_unprepare(ssi_private->clk);
+		clk_put(ssi_private->clk);
+	}
+
 error_irq:
 	free_irq(ssi_private->irq, ssi_private);
 
@@ -851,8 +868,11 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 	if (!ssi_private->new_binding)
 		platform_device_unregister(ssi_private->pdev);
-	if (ssi_private->ssi_on_imx)
+	if (ssi_private->ssi_on_imx) {
 		platform_device_unregister(ssi_private->imx_pcm_pdev);
+		clk_disable_unprepare(ssi_private->clk);
+		clk_put(ssi_private->clk);
+	}
 	snd_soc_unregister_dai(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 
-- 
1.7.5.4
