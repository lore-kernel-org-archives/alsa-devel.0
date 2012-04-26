From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs-saif: Use devm_clk_get()
Date: Thu, 26 Apr 2012 01:33:22 -0300
Message-ID: <1335414802-4972-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ABEA104B85
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 06:33:32 +0200 (CEST)
Received: by yenl1 with SMTP id l1so723108yen.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 21:33:31 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Using devm_clk_get() can make the error handling path easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 53f4fd8..bfc1f9e 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -650,7 +650,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		saif->master_id = saif->id;
 	}
 
-	saif->clk = clk_get(&pdev->dev, NULL);
+	saif->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
 		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
@@ -663,16 +663,14 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	saif->base = devm_request_and_ioremap(&pdev->dev, iores);
 	if (!saif->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENODEV;
-		goto failed_get_resource;
+		return -ENODEV;
 	}
 
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmares) {
-		ret = -ENODEV;
 		dev_err(&pdev->dev, "failed to get dma resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return -ENODEV;
 	}
 	saif->dma_param.chan_num = dmares->start;
 
@@ -681,7 +679,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		ret = saif->irq;
 		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return saif->irq;
 	}
 
 	saif->dev = &pdev->dev;
@@ -689,15 +687,14 @@ static int mxs_saif_probe(struct platform_device *pdev)
 			       "mxs-saif", saif);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto failed_get_resource;
+		return ret;
 	}
 
 	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
 	if (saif->dma_param.chan_irq < 0) {
-		ret = saif->dma_param.chan_irq;
 		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return saif->dma_param.chan_irq;
 	}
 
 	platform_set_drvdata(pdev, saif);
@@ -705,7 +702,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &mxs_saif_dai);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
-		goto failed_get_resource;
+		return ret;
 	}
 
 	saif->soc_platform_pdev = platform_device_alloc(
@@ -728,8 +725,6 @@ failed_pdev_add:
 	platform_device_put(saif->soc_platform_pdev);
 failed_pdev_alloc:
 	snd_soc_unregister_dai(&pdev->dev);
-failed_get_resource:
-	clk_put(saif->clk);
 
 	return ret;
 }
@@ -740,7 +735,6 @@ static int __devexit mxs_saif_remove(struct platform_device *pdev)
 
 	platform_device_unregister(saif->soc_platform_pdev);
 	snd_soc_unregister_dai(&pdev->dev);
-	clk_put(saif->clk);
 
 	return 0;
 }
-- 
1.7.1
