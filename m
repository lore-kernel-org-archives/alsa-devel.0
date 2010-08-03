From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc/multi-component: fsl: fix exit and error
	paths in DMA and SSI drivers
Date: Tue, 3 Aug 2010 17:55:28 -0500
Message-ID: <1280876128-19263-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id 402D724487
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 00:55:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The error handling code in the OF probe function of the SSI driver is not
freeing all resources correctly.

Since the machine driver no longer calls the DMA driver to provide information
about the SSI, we don't need to keep a list of DMA objects any more.  In
addition, the fsl_soc_dma_remove() function is incorrectly removing *all*
DMA objects when it should only remove one.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |   23 +++++++----------------
 sound/soc/fsl/fsl_ssi.c |   29 ++++++++++++++++-------------
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 4450f9d..57774cb 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -57,7 +57,6 @@
 			  SNDRV_PCM_RATE_CONTINUOUS)
 
 struct dma_object {
-	struct list_head list;
 	struct snd_soc_platform_driver dai;
 	dma_addr_t ssi_stx_phys;
 	dma_addr_t ssi_srx_phys;
@@ -825,9 +824,6 @@ static void fsl_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-/* List of DMA nodes that we've probed */
-static LIST_HEAD(dma_list);
-
 /**
  * find_ssi_node -- returns the SSI node that points to his DMA channel node
  *
@@ -915,25 +911,20 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 
 	dma->channel = of_iomap(np, 0);
 	dma->irq = irq_of_parse_and_map(np, 0);
-	list_add(&dma->list, &dma_list);
+
+	dev_set_drvdata(&of_dev->dev, dma);
 
 	return 0;
 }
 
 static int __devexit fsl_soc_dma_remove(struct of_device *of_dev)
 {
-	struct list_head *n, *ptr;
-	struct dma_object *dma;
+	struct dma_object *dma = dev_get_drvdata(&of_dev->dev);
 
-	list_for_each_safe(ptr, n, &dma_list) {
-		dma = list_entry(ptr, struct dma_object, list);
-		list_del_init(ptr);
-
-		snd_soc_unregister_platform(&of_dev->dev);
-		iounmap(dma->channel);
-		irq_dispose_mapping(dma->irq);
-		kfree(dma);
-	}
+	snd_soc_unregister_platform(&of_dev->dev);
+	iounmap(dma->channel);
+	irq_dispose_mapping(dma->irq);
+	kfree(dma);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 51b089f..00e3e62 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -619,7 +619,7 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 {
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
-	struct device_attribute *dev_attr;
+	struct device_attribute *dev_attr = NULL;
 	struct device_node *np = of_dev->dev.of_node;
 	const char *p, *sprop;
 	struct resource res;
@@ -681,18 +681,16 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	if (ret) {
 		dev_err(&of_dev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
-		kfree(ssi_private);
-		return ret;
+		goto error;
 	}
 
 	/* Register with ASoC */
 	dev_set_drvdata(&of_dev->dev, ssi_private);
 
 	ret = snd_soc_register_dai(&of_dev->dev, &ssi_private->cpu_dai_drv);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(&of_dev->dev, "failed to register DAI: %d\n", ret);
-		kfree(ssi_private);
-		return ret;
+		goto error;
 	}
 
 	/* Trigger the machine driver's probe function.  The platform driver
@@ -713,18 +711,23 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	if (IS_ERR(ssi_private->pdev)) {
 		ret = PTR_ERR(ssi_private->pdev);
 		dev_err(&of_dev->dev, "failed to register platform: %d\n", ret);
-		kfree(ssi_private);
-		return ret;
+		goto error;
 	}
 
 	return 0;
+
+error:
+	snd_soc_unregister_dai(&of_dev->dev);
+	dev_set_drvdata(&of_dev->dev, NULL);
+	if (dev_attr)
+		device_remove_file(&of_dev->dev, dev_attr);
+	irq_dispose_mapping(ssi_private->irq);
+	iounmap(ssi_private->ssi);
+	kfree(ssi_private);
+
+	return ret;
 }
 
-/**
- * fsl_ssi_destroy_dai: destroy the snd_soc_dai object
- *
- * This function undoes the operations of fsl_ssi_probe()
- */
 static int fsl_ssi_remove(struct of_device *of_dev)
 {
 	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&of_dev->dev);
-- 
1.7.0.1
