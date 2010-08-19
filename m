From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc/multi-component: mpc8610: replace
	of_device with platform_device
Date: Thu, 19 Aug 2010 15:26:58 -0500
Message-ID: <1282249618-27137-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D05624382
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 22:27:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

'struct of_device' no longer exists, and its functionality has been merged
into platform_device.  Update the MPC8610 HPCD audio drivers (fsl_ssi, fsl_dma,
and mpc8610_hpcd) accordingly.

Also add a #include for slab.h, which is now needed for kmalloc and kfree.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c      |   23 ++++++++++++-----------
 sound/soc/fsl/fsl_ssi.c      |   42 +++++++++++++++++++++---------------------
 sound/soc/fsl/mpc8610_hpcd.c |   10 ++++++----
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index dfe1cb9..cb78698 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -23,6 +23,7 @@
 #include <linux/gfp.h>
 #include <linux/of_platform.h>
 #include <linux/list.h>
+#include <linux/slab.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -887,11 +888,11 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.pointer	= fsl_dma_pointer,
 };
 
-static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
+static int __devinit fsl_soc_dma_probe(struct platform_device *pdev,
 				       const struct of_device_id *match)
  {
 	struct dma_object *dma;
-	struct device_node *np = of_dev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ssi_np;
 	struct resource res;
 	const uint32_t *iprop;
@@ -900,13 +901,13 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 	/* Find the SSI node that points to us. */
 	ssi_np = find_ssi_node(np);
 	if (!ssi_np) {
-		dev_err(&of_dev->dev, "cannot find parent SSI node\n");
+		dev_err(&pdev->dev, "cannot find parent SSI node\n");
 		return -ENODEV;
 	}
 
 	ret = of_address_to_resource(ssi_np, 0, &res);
 	if (ret) {
-		dev_err(&of_dev->dev, "could not determine resources for %s\n",
+		dev_err(&pdev->dev, "could not determine resources for %s\n",
 			ssi_np->full_name);
 		of_node_put(ssi_np);
 		return ret;
@@ -914,7 +915,7 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 
 	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
 	if (!dma) {
-		dev_err(&of_dev->dev, "could not allocate dma object\n");
+		dev_err(&pdev->dev, "could not allocate dma object\n");
 		of_node_put(ssi_np);
 		return -ENOMEM;
 	}
@@ -937,9 +938,9 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 
 	of_node_put(ssi_np);
 
-	ret = snd_soc_register_platform(&of_dev->dev, &dma->dai);
+	ret = snd_soc_register_platform(&pdev->dev, &dma->dai);
 	if (ret) {
-		dev_err(&of_dev->dev, "could not register platform\n");
+		dev_err(&pdev->dev, "could not register platform\n");
 		kfree(dma);
 		return ret;
 	}
@@ -947,16 +948,16 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 	dma->channel = of_iomap(np, 0);
 	dma->irq = irq_of_parse_and_map(np, 0);
 
-	dev_set_drvdata(&of_dev->dev, dma);
+	dev_set_drvdata(&pdev->dev, dma);
 
 	return 0;
 }
 
-static int __devexit fsl_soc_dma_remove(struct of_device *of_dev)
+static int __devexit fsl_soc_dma_remove(struct platform_device *pdev)
 {
-	struct dma_object *dma = dev_get_drvdata(&of_dev->dev);
+	struct dma_object *dma = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_platform(&of_dev->dev);
+	snd_soc_unregister_platform(&pdev->dev);
 	iounmap(dma->channel);
 	irq_dispose_mapping(dma->irq);
 	kfree(dma);
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d1c855a..4cc167a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -624,13 +624,13 @@ static void make_lowercase(char *s)
 	}
 }
 
-static int __devinit fsl_ssi_probe(struct of_device *of_dev,
+static int __devinit fsl_ssi_probe(struct platform_device *pdev,
 				   const struct of_device_id *match)
 {
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
 	struct device_attribute *dev_attr = NULL;
-	struct device_node *np = of_dev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	const char *p, *sprop;
 	const uint32_t *iprop;
 	struct resource res;
@@ -645,14 +645,14 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 
 	/* Check for a codec-handle property. */
 	if (!of_get_property(np, "codec-handle", NULL)) {
-		dev_err(&of_dev->dev, "missing codec-handle property\n");
+		dev_err(&pdev->dev, "missing codec-handle property\n");
 		return -ENODEV;
 	}
 
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop || strcmp(sprop, "i2s-slave")) {
-		dev_notice(&of_dev->dev, "mode %s is unsupported\n", sprop);
+		dev_notice(&pdev->dev, "mode %s is unsupported\n", sprop);
 		return -ENODEV;
 	}
 
@@ -661,7 +661,7 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) + strlen(p),
 			      GFP_KERNEL);
 	if (!ssi_private) {
-		dev_err(&of_dev->dev, "could not allocate DAI object\n");
+		dev_err(&pdev->dev, "could not allocate DAI object\n");
 		return -ENOMEM;
 	}
 
@@ -675,7 +675,7 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
-		dev_err(&of_dev->dev, "could not determine device resources\n");
+		dev_err(&pdev->dev, "could not determine device resources\n");
 		kfree(ssi_private);
 		return ret;
 	}
@@ -703,19 +703,19 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	dev_attr->attr.mode = S_IRUGO;
 	dev_attr->show = fsl_sysfs_ssi_show;
 
-	ret = device_create_file(&of_dev->dev, dev_attr);
+	ret = device_create_file(&pdev->dev, dev_attr);
 	if (ret) {
-		dev_err(&of_dev->dev, "could not create sysfs %s file\n",
+		dev_err(&pdev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
 		goto error;
 	}
 
 	/* Register with ASoC */
-	dev_set_drvdata(&of_dev->dev, ssi_private);
+	dev_set_drvdata(&pdev->dev, ssi_private);
 
-	ret = snd_soc_register_dai(&of_dev->dev, &ssi_private->cpu_dai_drv);
+	ret = snd_soc_register_dai(&pdev->dev, &ssi_private->cpu_dai_drv);
 	if (ret) {
-		dev_err(&of_dev->dev, "failed to register DAI: %d\n", ret);
+		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
 		goto error;
 	}
 
@@ -733,20 +733,20 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	make_lowercase(name);
 
 	ssi_private->pdev =
-		platform_device_register_data(&of_dev->dev, name, 0, NULL, 0);
+		platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
 	if (IS_ERR(ssi_private->pdev)) {
 		ret = PTR_ERR(ssi_private->pdev);
-		dev_err(&of_dev->dev, "failed to register platform: %d\n", ret);
+		dev_err(&pdev->dev, "failed to register platform: %d\n", ret);
 		goto error;
 	}
 
 	return 0;
 
 error:
-	snd_soc_unregister_dai(&of_dev->dev);
-	dev_set_drvdata(&of_dev->dev, NULL);
+	snd_soc_unregister_dai(&pdev->dev);
+	dev_set_drvdata(&pdev->dev, NULL);
 	if (dev_attr)
-		device_remove_file(&of_dev->dev, dev_attr);
+		device_remove_file(&pdev->dev, dev_attr);
 	irq_dispose_mapping(ssi_private->irq);
 	iounmap(ssi_private->ssi);
 	kfree(ssi_private);
@@ -754,16 +754,16 @@ error:
 	return ret;
 }
 
-static int fsl_ssi_remove(struct of_device *of_dev)
+static int fsl_ssi_remove(struct platform_device *pdev)
 {
-	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&of_dev->dev);
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
 
 	platform_device_unregister(ssi_private->pdev);
-	snd_soc_unregister_dai(&of_dev->dev);
-	device_remove_file(&of_dev->dev, &ssi_private->dev_attr);
+	snd_soc_unregister_dai(&pdev->dev);
+	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 
 	kfree(ssi_private);
-	dev_set_drvdata(&of_dev->dev, NULL);
+	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 38339c1..0d7dcf1 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
+#include <linux/slab.h>
 #include <sound/soc.h>
 #include <asm/fsl_guts.h>
 
@@ -323,9 +324,10 @@ static int get_dma_channel(struct device_node *ssi_np,
 static int mpc8610_hpcd_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
-	/* of_dev is the OF device for the SSI node that probed us */
-	struct of_device *of_dev = container_of(dev, struct of_device, dev);
-	struct device_node *np = of_dev->dev.of_node;
+	/* ssi_pdev is the platform device for the SSI node that probed us */
+	struct platform_device *ssi_pdev =
+		container_of(dev, struct platform_device, dev);
+	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct platform_device *sound_device = NULL;
 	struct mpc8610_hpcd_data *machine_data;
@@ -348,7 +350,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	if (!machine_data)
 		return -ENOMEM;
 
-	machine_data->dai[0].cpu_dai_name = dev_name(&of_dev->dev);
+	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
 	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
 
 	/* Determine the codec name, it will be used as the codec DAI name */
-- 
1.7.0.1
