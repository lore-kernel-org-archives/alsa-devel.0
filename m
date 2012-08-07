From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs-saif: Use devm_clk_get()
Date: Tue,  7 Aug 2012 01:29:43 -0300
Message-ID: <1344313783-29936-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 852CB265E77
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 06:00:06 +0200 (CEST)
Received: by yenr13 with SMTP id r13so3053521yen.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 21:29:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_clk_get can make the code simpler and smaller.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b303071..aa037b2 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -704,7 +704,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	saif->clk = clk_get(&pdev->dev, NULL);
+	saif->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
 		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
@@ -717,8 +717,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 	saif->base = devm_request_and_ioremap(&pdev->dev, iores);
 	if (!saif->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENODEV;
-		goto failed_get_resource;
+		return -ENODEV;
 	}
 
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -731,7 +730,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 					   &saif->dma_param.chan_num);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get dma channel\n");
-			goto failed_get_resource;
+			return ret;
 		}
 	} else {
 		saif->dma_param.chan_num = dmares->start;
@@ -742,7 +741,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 		ret = saif->irq;
 		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return ret;
 	}
 
 	saif->dev = &pdev->dev;
@@ -750,7 +749,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 			       "mxs-saif", saif);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto failed_get_resource;
+		return ret;
 	}
 
 	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
@@ -758,7 +757,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 		ret = saif->dma_param.chan_irq;
 		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, saif);
@@ -766,7 +765,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &mxs_saif_dai);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
-		goto failed_get_resource;
+		return ret;
 	}
 
 	ret = mxs_pcm_platform_register(&pdev->dev);
@@ -779,19 +778,14 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 
 failed_pdev_alloc:
 	snd_soc_unregister_dai(&pdev->dev);
-failed_get_resource:
-	clk_put(saif->clk);
 
 	return ret;
 }
 
 static int __devexit mxs_saif_remove(struct platform_device *pdev)
 {
-	struct mxs_saif *saif = platform_get_drvdata(pdev);
-
 	mxs_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
-	clk_put(saif->clk);
 
 	return 0;
 }
-- 
1.7.1
