From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl: fsl_ssi: Use devm_ functions
Date: Wed, 17 Jul 2013 02:00:38 -0300
Message-ID: <1374037239-16984-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f174.google.com (mail-gh0-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 7054A2652AD
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 07:00:49 +0200 (CEST)
Received: by mail-gh0-f174.google.com with SMTP id r17so463402ghr.5
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 22:00:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_ functions can make the code cleaner and smaller.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2f2d837..ab8d462 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -680,7 +680,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	/* The DAI name is the last part of the full name of the node. */
 	p = strrchr(np->full_name, '/') + 1;
-	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) + strlen(p),
+	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private) + strlen(p),
 			      GFP_KERNEL);
 	if (!ssi_private) {
 		dev_err(&pdev->dev, "could not allocate DAI object\n");
@@ -698,26 +698,24 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
 		dev_err(&pdev->dev, "could not determine device resources\n");
-		goto error_kmalloc;
+		return ret;
 	}
 	ssi_private->ssi = of_iomap(np, 0);
 	if (!ssi_private->ssi) {
 		dev_err(&pdev->dev, "could not map device resources\n");
-		ret = -ENOMEM;
-		goto error_kmalloc;
+		return -ENOMEM;
 	}
 	ssi_private->ssi_phys = res.start;
 
 	ssi_private->irq = irq_of_parse_and_map(np, 0);
 	if (ssi_private->irq == NO_IRQ) {
 		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
-		ret = -ENXIO;
-		goto error_iomap;
+		return -ENXIO;
 	}
 
 	/* The 'name' should not have any slashes in it. */
-	ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0, ssi_private->name,
-			  ssi_private);
+	ret = devm_request_irq(&pdev->dev, ssi_private->irq, fsl_ssi_isr, 0,
+			       ssi_private->name, ssi_private);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not claim irq %u\n", ssi_private->irq);
 		goto error_irqmap;
@@ -739,11 +737,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
-		ssi_private->clk = clk_get(&pdev->dev, NULL);
+		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(ssi_private->clk)) {
 			ret = PTR_ERR(ssi_private->clk);
 			dev_err(&pdev->dev, "could not get clock: %d\n", ret);
-			goto error_irq;
+			goto error_irqmap;
 		}
 		clk_prepare_enable(ssi_private->clk);
 
@@ -794,7 +792,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
-		goto error_irq;
+		goto error_clk;
 	}
 
 	/* Register with ASoC */
@@ -857,23 +855,12 @@ error_dev:
 	device_remove_file(&pdev->dev, dev_attr);
 
 error_clk:
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
-		clk_put(ssi_private->clk);
-	}
-
-error_irq:
-	free_irq(ssi_private->irq, ssi_private);
 
 error_irqmap:
 	irq_dispose_mapping(ssi_private->irq);
 
-error_iomap:
-	iounmap(ssi_private->ssi);
-
-error_kmalloc:
-	kfree(ssi_private);
-
 	return ret;
 }
 
@@ -886,15 +873,10 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->ssi_on_imx) {
 		imx_pcm_dma_exit(pdev);
 		clk_disable_unprepare(ssi_private->clk);
-		clk_put(ssi_private->clk);
 	}
 	snd_soc_unregister_component(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
-
-	free_irq(ssi_private->irq, ssi_private);
 	irq_dispose_mapping(ssi_private->irq);
-
-	kfree(ssi_private);
 	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
-- 
1.8.1.2
