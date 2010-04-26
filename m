From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2/2] powerpc/alsa: update MPC8610 HPCD audio
	drivers to support multiple components
Date: Mon, 26 Apr 2010 15:49:58 -0500
Message-ID: <1272314998-23715-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2375424714
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 22:50:18 +0200 (CEST)
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

Update the Freescale MPC8610 HPCD audio drivers to support the new multiple-
component architecture in ASoC.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c      |   42 +--
 sound/soc/fsl/fsl_dma.h      |    1 +
 sound/soc/fsl/fsl_ssi.c      |   88 ++--
 sound/soc/fsl/fsl_ssi.h      |   23 -
 sound/soc/fsl/mpc8610_hpcd.c | 1188 ++++++++++++++++++++----------------------
 5 files changed, 637 insertions(+), 705 deletions(-)
 rewrite sound/soc/fsl/mpc8610_hpcd.c (64%)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 857e9f7..326b852 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -15,7 +15,6 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -844,6 +843,7 @@ EXPORT_SYMBOL_GPL(fsl_soc_platform);
 int fsl_dma_configure(struct fsl_dma_info *dma_info)
 {
 	static int initialized;
+	int ret;
 
 	/* We only support one DMA controller for now */
 	if (initialized)
@@ -859,42 +859,16 @@ int fsl_dma_configure(struct fsl_dma_info *dma_info)
 	dma_global_data.assigned[1] = 0;
 
 	initialized = 1;
-	return 1;
-}
-EXPORT_SYMBOL_GPL(fsl_dma_configure);
-
-static int __devinit fsl_soc_platform_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev, -1, &fsl_soc_platform);
-}
-
-static int __devexit fsl_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev, -1);
-	return 0;
-}
 
-static struct platform_driver fsl_pcm_driver = {
-	.driver = {
-			.name = "fsl-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = fsl_soc_platform_probe,
-	.remove = __devexit_p(fsl_soc_platform_remove),
-};
-
-static int __init snd_fsl_pcm_init(void)
-{
-	return platform_driver_register(&fsl_pcm_driver);
-}
-module_init(snd_fsl_pcm_init);
+	ret = snd_soc_register_platform(dma_info->dev, -1, &fsl_soc_platform);
+	if (ret) {
+		dev_err(dma_info->dev, "could not register platform");
+		return 0;
+	}
 
-static void __exit snd_fsl_pcm_exit(void)
-{
-	platform_driver_unregister(&fsl_pcm_driver);
+	return 1;
 }
-module_exit(snd_fsl_pcm_exit);
+EXPORT_SYMBOL(fsl_dma_configure);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM module");
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 253bd3c..62bb617 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -140,6 +140,7 @@ struct fsl_dma_info {
 	dma_addr_t ssi_srx_phys;
 	struct ccsr_dma_channel __iomem *dma_channel[2];
 	unsigned int dma_irq[2];
+	struct device *dev;
 };
 
 extern struct snd_soc_platform_driver fsl_soc_platform;
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 780e243..99cc662 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/of_platform.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -86,12 +87,12 @@
  */
 struct fsl_ssi_private {
 	char name[8];
+	int id;
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	struct snd_pcm_substream *first_stream;
 	struct snd_pcm_substream *second_stream;
-	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
 	int asynchronous;
@@ -639,92 +640,115 @@ static ssize_t fsl_sysfs_ssi_show(struct device *dev,
 	return length;
 }
 
-static int fsl_ssi_probe(struct platform_device *pdev)
+static int __devinit fsl_ssi_probe(struct of_device *of_dev,
+				   const struct of_device_id *match)
 {
-	struct fsl_ssi_info *ssi_info = dev_get_platdata(&pdev->dev);
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
 	struct device_attribute *dev_attr;
+	struct device_node *np = of_dev->node;
+	const u32 *prop;
+	int id;
+	struct resource res;
+
+	/* We are only interested in SSIs with a codec phandle in them, so let's
+	 * make sure this SSI has one.
+	 */
+	if (!of_get_property(np, "codec-handle", NULL))
+		return -ENODEV;
 
 	ssi_private = kzalloc(sizeof(struct fsl_ssi_private), GFP_KERNEL);
 	if (!ssi_private) {
-		dev_err(ssi_info->dev, "could not allocate DAI object\n");
+		dev_err(&of_dev->dev, "could not allocate DAI object\n");
 		return -ENOMEM;
 	}
 
 	dev_attr = &ssi_private->dev_attr;
 
-	sprintf(ssi_private->name, "ssi%u", (u8) ssi_info->id);
-	ssi_private->ssi = ssi_info->ssi;
-	ssi_private->ssi_phys = ssi_info->ssi_phys;
-	ssi_private->irq = ssi_info->irq;
-	ssi_private->dev = ssi_info->dev;
-	ssi_private->asynchronous = ssi_info->asynchronous;
+	prop = of_get_property(np, "cell-index", NULL);
+	if (!prop) {
+		dev_err(&of_dev->dev, "node is missing cell-index property\n");
+		return -ENODEV;
+	}
+	id = *prop;
+
+	strcpy(ssi_private->name, "ssi");
+	ssi_private->id = id;
+	ssi_private->ssi = of_iomap(np, 0);
+	of_address_to_resource(np, 0, &res);
+	ssi_private->ssi_phys = res.start;
+	ssi_private->irq = irq_of_parse_and_map(np, 0);
+
+	if (of_find_property(np, "fsl,ssi-asynchronous", NULL))
+		ssi_private->asynchronous = 1;
+	else
+		fsl_ssi_dai.symmetric_rates = 1;
 
 	/* Initialize the the device_attribute structure */
 	dev_attr->attr.name = "ssi-stats";
 	dev_attr->attr.mode = S_IRUGO;
 	dev_attr->show = fsl_sysfs_ssi_show;
 
-	ret = device_create_file(ssi_private->dev, dev_attr);
+	ret = device_create_file(&of_dev->dev, dev_attr);
 	if (ret) {
-		dev_err(ssi_info->dev, "could not create sysfs %s file\n",
+		dev_err(&of_dev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
 		kfree(ssi_private);
 		return ret;
 	}
 
-	dev_set_drvdata(ssi_private->dev, ssi_private);
+	dev_set_drvdata(&of_dev->dev, ssi_private);
 	fsl_ssi_dai.name = ssi_private->name;
-	fsl_ssi_dai.symmetric_rates = 1;
 
-	ret = snd_soc_register_dai(ssi_private->dev, ssi_info->id, &fsl_ssi_dai);
+	ret = snd_soc_register_dai(&of_dev->dev, id, &fsl_ssi_dai);
 	if (ret != 0) {
-		dev_err(ssi_info->dev, "failed to register DAI: %d\n", ret);
+		dev_err(&of_dev->dev, "failed to register DAI: %d\n", ret);
 		kfree(ssi_private);
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
  * fsl_ssi_destroy_dai: destroy the snd_soc_dai object
  *
- * This function undoes the operations of fsl_ssi_create_dai()
+ * This function undoes the operations of fsl_ssi_probe()
  */
-static int  fsl_ssi_remove(struct platform_device *pdev)
+static int fsl_ssi_remove(struct of_device *of_dev)
 {
-	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
-	struct fsl_ssi_info *ssi_info = dev_get_platdata(&pdev->dev);
-
-	device_remove_file(ssi_private->dev, &ssi_private->dev_attr);
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&of_dev->dev);
 
-	snd_soc_unregister_dai(&pdev->dev, ssi_info->id);
+	snd_soc_unregister_dai(&of_dev->dev, ssi_private->id);
+	device_remove_file(&of_dev->dev, &ssi_private->dev_attr);
 
 	kfree(ssi_private);
 	return 0;
 }
 
-static struct platform_driver fsl_ssi_driver = {
+static const struct of_device_id fsl_ssi_ids[] = {
+	{ .compatible = "fsl,mpc8610-ssi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
+
+static struct of_platform_driver fsl_ssi_driver = {
+	.name = "fsl-ssi-dai",
+	.match_table = fsl_ssi_ids,
 	.probe = fsl_ssi_probe,
-	.remove = __devexit_p(fsl_ssi_remove),
-	.driver = {
-		.name = "fsl-ssi-dai",
-		.owner = THIS_MODULE,
-	},
+	.remove = fsl_ssi_remove,
 };
 
 static int __init fsl_ssi_init(void)
 {
 	printk(KERN_INFO "Freescale Synchronous Serial Interface (SSI) ASoC Driver\n");
 
-	return platform_driver_register(&fsl_ssi_driver);
+	return of_register_platform_driver(&fsl_ssi_driver);
 }
 
 static void __exit fsl_ssi_exit(void)
 {
-	platform_driver_unregister(&fsl_ssi_driver);
+	of_unregister_platform_driver(&fsl_ssi_driver);
 }
 
 module_init(fsl_ssi_init);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 965fd86..7cb229b 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -196,29 +196,6 @@ struct ccsr_ssi {
 #define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
 #define CCSR_SSI_SOR_SYNRST 		0x00000001
 
-/* Instantiation data for an SSI interface
- *
- * This structure contains all the information that the the SSI driver needs
- * to instantiate an SSI interface with ALSA.  The machine driver should
- * create this structure, fill it in, call fsl_ssi_create_dai(), and then
- * delete the structure.
- *
- * id: which SSI this is (0, 1, etc. )
- * ssi: pointer to the SSI's registers
- * ssi_phys: physical address of the SSI registers
- * irq: IRQ of this SSI
- * dev: struct device, used to create the sysfs statistics file
- * asynchronous: 0=synchronous mode, 1=asynchronous mode
-*/
-struct fsl_ssi_info {
-	unsigned int id;
-	struct ccsr_ssi __iomem *ssi;
-	dma_addr_t ssi_phys;
-	unsigned int irq;
-	struct device *dev;
-	int asynchronous;
-};
-
 extern struct snd_soc_dai_driver fsl_ssi_dai;
 
 #endif
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
dissimilarity index 64%
index ad8d763..5276cbe 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,616 +1,572 @@
-/**
- * Freescale MPC8610HPCD ALSA SoC Fabric driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
- */
-
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <sound/soc.h>
-#include <asm/immap_86xx.h>
-
-#include "../codecs/cs4270.h"
-#include "fsl_dma.h"
-#include "fsl_ssi.h"
-
-/**
- * mpc8610_hpcd_data: fabric-specific ASoC device data
- *
- * This structure contains data for a single sound platform device on an
- * MPC8610 HPCD.  Some of the data is taken from the device tree.
- */
-struct mpc8610_hpcd_data {
-	struct snd_soc_dai_link dai;
-	struct snd_soc_card machine;
-	unsigned int dai_format;
-	unsigned int codec_clk_direction;
-	unsigned int cpu_clk_direction;
-	unsigned int clk_frequency;
-	struct ccsr_guts __iomem *guts;
-	struct ccsr_ssi __iomem *ssi;
-	unsigned int ssi_id;    	/* 0 = SSI1, 1 = SSI2, etc */
-	unsigned int ssi_irq;
-	unsigned int dma_id;    	/* 0 = DMA1, 1 = DMA2, etc */
-	unsigned int dma_irq[2];
-	struct ccsr_dma_channel __iomem *dma[2];
-	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
-};
-
-/**
- * mpc8610_hpcd_machine_probe: initalize the board
- *
- * This function is called when platform_device_add() is called.  It is used
- * to initialize the board-specific hardware.
- *
- * Here we program the DMACR and PMUXCR registers.
- */
-static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
-{
-	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
-
-	/* Program the signal routing between the SSI and the DMA */
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
-
-	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], 0);
-	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], 0);
-
-	switch (machine_data->ssi_id) {
-	case 0:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
-		break;
-	case 1:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
-		break;
-	}
-
-	return 0;
-}
-
-/**
- * mpc8610_hpcd_startup: program the board with various hardware parameters
- *
- * This function takes board-specific information, like clock frequencies
- * and serial data formats, and passes that information to the codec and
- * transport drivers.
- */
-static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct mpc8610_hpcd_data *machine_data =
-		rtd->card->dev->platform_data;
-	int ret = 0;
-
-	/* Tell the CPU driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver audio format\n");
-		return ret;
-	}
-
-	/* Tell the codec driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(codec_dai, machine_data->dai_format);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set codec driver audio format\n");
-		return ret;
-	}
-
-	/*
-	 * Tell the CPU driver what the clock frequency is, and whether it's a
-	 * slave or master.
-	 */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, 0,
-					machine_data->clk_frequency,
-					machine_data->cpu_clk_direction);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver clock parameters\n");
-		return ret;
-	}
-
-	/*
-	 * Tell the codec driver what the MCLK frequency is, and whether it's
-	 * a slave or master.
-	 */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-					machine_data->clk_frequency,
-					machine_data->codec_clk_direction);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set codec driver clock params\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-/**
- * mpc8610_hpcd_machine_remove: Remove the sound device
- *
- * This function is called to remove the sound device for one SSI.  We
- * de-program the DMACR and PMUXCR register.
- */
-int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
-{
-	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
-
-	/* Restore the signal routing */
-
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], 0);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], 0);
-
-	switch (machine_data->ssi_id) {
-	case 0:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
-		break;
-	case 1:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_LA);
-		break;
-	}
-
-	return 0;
-}
-
-/**
- * mpc8610_hpcd_ops: ASoC fabric driver operations
- */
-static struct snd_soc_ops mpc8610_hpcd_ops = {
-	.startup = mpc8610_hpcd_startup,
-};
-
-/**
- * mpc8610_hpcd_probe: OF probe function for the fabric driver
- *
- * This function gets called when an SSI node is found in the device tree.
- *
- * Although this is a fabric driver, the SSI node is the "master" node with
- * respect to audio hardware connections.  Therefore, we create a new ASoC
- * device for each new SSI node that has a codec attached.
- *
- * FIXME: Currently, we only support one DMA controller, so if there are
- * multiple SSI nodes with codecs, only the first will be supported.
- *
- * FIXME: Even if we did support multiple DMA controllers, we have no
- * mechanism for assigning DMA controllers and channels to the individual
- * SSI devices.  We also probably aren't compatible with the generic Elo DMA
- * device driver.
- */
-static int mpc8610_hpcd_probe(struct of_device *ofdev,
-	const struct of_device_id *match)
-{
-	struct device_node *np = ofdev->node;
-	struct device_node *codec_np = NULL;
-	struct device_node *guts_np = NULL;
-	struct device_node *dma_np = NULL;
-	struct device_node *dma_channel_np = NULL;
-	const phandle *codec_ph;
-	const char *sprop;
-	const u32 *iprop;
-	struct resource res;
-	struct platform_device *sound_device = NULL;
-	struct mpc8610_hpcd_data *machine_data;
-	struct fsl_ssi_info ssi_info;
-	struct fsl_dma_info dma_info;
-	int ret = -ENODEV;
-	unsigned int playback_dma_channel;
-	unsigned int capture_dma_channel;
-
-	machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
-	if (!machine_data)
-		return -ENOMEM;
-
-	memset(&ssi_info, 0, sizeof(ssi_info));
-	memset(&dma_info, 0, sizeof(dma_info));
-
-	ssi_info.dev = &ofdev->dev;
-
-	/*
-	 * We are only interested in SSIs with a codec phandle in them, so let's
-	 * make sure this SSI has one.
-	 */
-	codec_ph = of_get_property(np, "codec-handle", NULL);
-	if (!codec_ph)
-		goto error;
-
-	codec_np = of_find_node_by_phandle(*codec_ph);
-	if (!codec_np)
-		goto error;
-
-	/* The MPC8610 HPCD only knows about the CS4270 codec, so reject
-	   anything else. */
-	if (!of_device_is_compatible(codec_np, "cirrus,cs4270"))
-		goto error;
-
-	/* Get the device ID */
-	iprop = of_get_property(np, "cell-index", NULL);
-	if (!iprop) {
-		dev_err(&ofdev->dev, "cell-index property not found\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->ssi_id = *iprop;
-	ssi_info.id = *iprop;
-
-	/* Get the serial format and clock direction. */
-	sprop = of_get_property(np, "fsl,mode", NULL);
-	if (!sprop) {
-		dev_err(&ofdev->dev, "fsl,mode property not found\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (strcasecmp(sprop, "i2s-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-
-		/*
-		 * In i2s-slave mode, the codec has its own clock source, so we
-		 * need to get the frequency from the device tree and pass it to
-		 * the codec driver.
-		 */
-		iprop = of_get_property(codec_np, "clock-frequency", NULL);
-		if (!iprop || !*iprop) {
-			dev_err(&ofdev->dev, "codec bus-frequency property "
-				"is missing or invalid\n");
-			ret = -EINVAL;
-			goto error;
-		}
-		machine_data->clk_frequency = *iprop;
-	} else if (strcasecmp(sprop, "i2s-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "lj-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "lj-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "rj-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "rj-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "ac97-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else {
-		dev_err(&ofdev->dev,
-			"unrecognized fsl,mode property \"%s\"\n", sprop);
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (!machine_data->clk_frequency) {
-		dev_err(&ofdev->dev, "unknown clock frequency\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	/* Read the SSI information from the device tree */
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(&ofdev->dev, "could not obtain SSI address\n");
-		goto error;
-	}
-	if (!res.start) {
-		dev_err(&ofdev->dev, "invalid SSI address\n");
-		goto error;
-	}
-	ssi_info.ssi_phys = res.start;
-
-	machine_data->ssi = ioremap(ssi_info.ssi_phys, sizeof(struct ccsr_ssi));
-	if (!machine_data->ssi) {
-		dev_err(&ofdev->dev, "could not map SSI address %x\n",
-			ssi_info.ssi_phys);
-		ret = -EINVAL;
-		goto error;
-	}
-	ssi_info.ssi = machine_data->ssi;
-
-
-	/* Get the IRQ of the SSI */
-	machine_data->ssi_irq = irq_of_parse_and_map(np, 0);
-	if (!machine_data->ssi_irq) {
-		dev_err(&ofdev->dev, "could not get SSI IRQ\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	ssi_info.irq = machine_data->ssi_irq;
-
-	/* Do we want to use asynchronous mode? */
-	ssi_info.asynchronous =
-		of_find_property(np, "fsl,ssi-asynchronous", NULL) ? 1 : 0;
-	if (ssi_info.asynchronous)
-		dev_info(&ofdev->dev, "using asynchronous mode\n");
-
-	/* Map the global utilities registers. */
-	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
-	if (!guts_np) {
-		dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->guts = of_iomap(guts_np, 0);
-	of_node_put(guts_np);
-	if (!machine_data->guts) {
-		dev_err(&ofdev->dev, "could not map GUTS\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	/* Find the DMA channels to use.  Both SSIs need to use the same DMA
-	 * controller, so let's use DMA#1.
-	 */
-	for_each_compatible_node(dma_np, NULL, "fsl,mpc8610-dma") {
-		iprop = of_get_property(dma_np, "cell-index", NULL);
-		if (iprop && (*iprop == 0)) {
-			of_node_put(dma_np);
-			break;
-		}
-	}
-	if (!dma_np) {
-		dev_err(&ofdev->dev, "could not find DMA node\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->dma_id = *iprop;
-
-	/* SSI1 needs to use DMA Channels 0 and 1, and SSI2 needs to use DMA
-	 * channels 2 and 3.  This is just how the MPC8610 is wired
-	 * internally.
-	 */
-	playback_dma_channel = (machine_data->ssi_id == 0) ? 0 : 2;
-	capture_dma_channel = (machine_data->ssi_id == 0) ? 1 : 3;
-
-	/*
-	 * Find the DMA channels to use.
-	 */
-	while ((dma_channel_np = of_get_next_child(dma_np, dma_channel_np))) {
-		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
-		if (iprop && (*iprop == playback_dma_channel)) {
-			/* dma_channel[0] and dma_irq[0] are for playback */
-			dma_info.dma_channel[0] = of_iomap(dma_channel_np, 0);
-			dma_info.dma_irq[0] =
-				irq_of_parse_and_map(dma_channel_np, 0);
-			machine_data->dma_channel_id[0] = *iprop;
-			continue;
-		}
-		if (iprop && (*iprop == capture_dma_channel)) {
-			/* dma_channel[1] and dma_irq[1] are for capture */
-			dma_info.dma_channel[1] = of_iomap(dma_channel_np, 0);
-			dma_info.dma_irq[1] =
-				irq_of_parse_and_map(dma_channel_np, 0);
-			machine_data->dma_channel_id[1] = *iprop;
-			continue;
-		}
-	}
-	if (!dma_info.dma_channel[0] || !dma_info.dma_channel[1] ||
-	    !dma_info.dma_irq[0] || !dma_info.dma_irq[1]) {
-		dev_err(&ofdev->dev, "could not find DMA channels\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	dma_info.ssi_stx_phys = ssi_info.ssi_phys +
-		offsetof(struct ccsr_ssi, stx0);
-	dma_info.ssi_srx_phys = ssi_info.ssi_phys +
-		offsetof(struct ccsr_ssi, srx0);
-
-	/* We have the DMA information, so tell the DMA driver what it is */
-	if (!fsl_dma_configure(&dma_info)) {
-		dev_err(&ofdev->dev, "could not instantiate DMA device\n");
-		ret = -EBUSY;
-		goto error;
-	}
-
-	/*
-	 * Initialize our DAI data structure.  We should probably get this
-	 * information from the device tree.
-	 */
-	machine_data->dai.name = "CS4270";
-	machine_data->dai.stream_name = "CS4270";
-
-	iprop = of_get_property(codec_np, "reg", NULL);
-	if (!iprop) {
-		dev_err(&ofdev->dev, "codec node is missing 'reg' property\n");
-		goto error;
-	}
-	machine_data->dai.codec_id = *iprop;
-
-	machine_data->dai.cpu_dai_drv = &fsl_ssi_dai;
-	machine_data->dai.codec_dai_drv = &cs4270_dai; /* The codec_dai we want */
-	machine_data->dai.codec_drv = &soc_codec_device_cs4270;
-	machine_data->dai.ops = &mpc8610_hpcd_ops;
-	machine_data->dai.platform_drv = &fsl_soc_platform;
-
-	machine_data->machine.probe = mpc8610_hpcd_machine_probe;
-	machine_data->machine.remove = mpc8610_hpcd_machine_remove;
-	machine_data->machine.name = "MPC8610 HPCD";
-	machine_data->machine.num_links = 1;
-	machine_data->machine.dai_link = &machine_data->dai;
-
-	/* Allocate a new audio platform device structure */
-	sound_device = platform_device_alloc("soc-audio", -1);
-	if (!sound_device) {
-		dev_err(&ofdev->dev, "platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	/* Set the platform device and ASoC device to point to each other */
-	platform_set_drvdata(sound_device, &machine_data->machine);
-
-	/* Tell ASoC to probe us.  This will call mpc8610_hpcd_machine.probe(),
-	   if it exists. */
-	ret = platform_device_add(sound_device);
-
-	if (ret) {
-		dev_err(&ofdev->dev, "platform device add failed\n");
-		goto error;
-	}
-
-	dev_set_drvdata(&ofdev->dev, sound_device);
-
-	return 0;
-
-error:
-	of_node_put(codec_np);
-	of_node_put(guts_np);
-	of_node_put(dma_np);
-	of_node_put(dma_channel_np);
-
-	if (sound_device)
-		platform_device_unregister(sound_device);
-
-	if (ssi_info.ssi)
-		iounmap(ssi_info.ssi);
-
-	if (ssi_info.irq)
-		irq_dispose_mapping(ssi_info.irq);
-
-	if (dma_info.dma_channel[0])
-		iounmap(dma_info.dma_channel[0]);
-
-	if (dma_info.dma_channel[1])
-		iounmap(dma_info.dma_channel[1]);
-
-	if (dma_info.dma_irq[0])
-		irq_dispose_mapping(dma_info.dma_irq[0]);
-
-	if (dma_info.dma_irq[1])
-		irq_dispose_mapping(dma_info.dma_irq[1]);
-
-	if (machine_data->guts)
-		iounmap(machine_data->guts);
-
-	kfree(machine_data);
-
-	return ret;
-}
-
-/**
- * mpc8610_hpcd_remove: remove the OF device
- *
- * This function is called when the OF device is removed.
- */
-static int mpc8610_hpcd_remove(struct of_device *ofdev)
-{
-	struct platform_device *sound_device = dev_get_drvdata(&ofdev->dev);
-	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
-
-	platform_device_unregister(sound_device);
-
-	if (machine_data->ssi)
-		iounmap(machine_data->ssi);
-
-	if (machine_data->dma[0])
-		iounmap(machine_data->dma[0]);
-
-	if (machine_data->dma[1])
-		iounmap(machine_data->dma[1]);
-
-	if (machine_data->dma_irq[0])
-		irq_dispose_mapping(machine_data->dma_irq[0]);
-
-	if (machine_data->dma_irq[1])
-		irq_dispose_mapping(machine_data->dma_irq[1]);
-
-	if (machine_data->guts)
-		iounmap(machine_data->guts);
-
-	kfree(machine_data);
-	sound_device->dev.platform_data = NULL;
-
-	dev_set_drvdata(&ofdev->dev, NULL);
-
-	return 0;
-}
-
-static struct of_device_id mpc8610_hpcd_match[] = {
-	{
-		.compatible = "fsl,mpc8610-ssi",
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
-
-static struct of_platform_driver mpc8610_hpcd_of_driver = {
-	.owner  	= THIS_MODULE,
-	.name   	= "mpc8610_hpcd",
-	.match_table    = mpc8610_hpcd_match,
-	.probe  	= mpc8610_hpcd_probe,
-	.remove 	= mpc8610_hpcd_remove,
-};
-
-/**
- * mpc8610_hpcd_init: fabric driver initialization.
- *
- * This function is called when this module is loaded.
- */
-static int __init mpc8610_hpcd_init(void)
-{
-	int ret;
-
-	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
-
-	ret = of_register_platform_driver(&mpc8610_hpcd_of_driver);
-
-	if (ret)
-		printk(KERN_ERR
-			"mpc8610-hpcd: failed to register platform driver\n");
-
-	return ret;
-}
-
-/**
- * mpc8610_hpcd_exit: fabric driver exit
- *
- * This function is called when this driver is unloaded.
- */
-static void __exit mpc8610_hpcd_exit(void)
-{
-	of_unregister_platform_driver(&mpc8610_hpcd_of_driver);
-}
-
-module_init(mpc8610_hpcd_init);
-module_exit(mpc8610_hpcd_exit);
-
-MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
-MODULE_LICENSE("GPL");
+/**
+ * Freescale MPC8610HPCD ALSA SoC Fabric driver
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <asm/immap_86xx.h>
+
+#include "../codecs/cs4270.h"
+#include "fsl_dma.h"
+#include "fsl_ssi.h"
+
+/**
+ * mpc8610_hpcd_data: fabric-specific ASoC device data
+ *
+ * This structure contains data for a single sound platform device on an
+ * MPC8610 HPCD.  Some of the data is taken from the device tree.
+ */
+struct mpc8610_hpcd_data {
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+	unsigned int dai_format;
+	unsigned int codec_clk_direction;
+	unsigned int cpu_clk_direction;
+	unsigned int clk_frequency;
+	struct ccsr_guts __iomem *guts;
+	unsigned int ssi_id;		/* 0 = SSI1, 1 = SSI2, etc */
+	unsigned int dma_id;		/* 0 = DMA1, 1 = DMA2, etc */
+	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
+	char dai_name[32];
+};
+
+/**
+ * mpc8610_hpcd_machine_probe: initialize the board
+ *
+ * This function is used to initialize the board-specific hardware.
+ *
+ * Here we program the DMACR and PMUXCR registers.
+ */
+static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
+{
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(card, struct mpc8610_hpcd_data, card);
+
+	/* Program the signal routing between the SSI and the DMA */
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
+
+	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[0], 0);
+	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[1], 0);
+
+	switch (machine_data->ssi_id) {
+	case 0:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
+		break;
+	case 1:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_startup: program the board with various hardware parameters
+ *
+ * This function takes board-specific information, like clock frequencies
+ * and serial data formats, and passes that information to the codec and
+ * transport drivers.
+ */
+static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(rtd->card, struct mpc8610_hpcd_data, card);
+	struct device *dev = rtd->card->dev;
+	int ret = 0;
+
+	/* Tell the CPU driver what the serial protocol is. */
+	ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
+	if (ret < 0) {
+		dev_err(dev, "could not set CPU driver audio format\n");
+		return ret;
+	}
+
+	/* Tell the codec driver what the serial protocol is. */
+	ret = snd_soc_dai_set_fmt(codec_dai, machine_data->dai_format);
+	if (ret < 0) {
+		dev_err(dev, "could not set codec driver audio format\n");
+		return ret;
+	}
+
+	/*
+	 * Tell the CPU driver what the clock frequency is, and whether it's a
+	 * slave or master.
+	 */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, machine_data->clk_frequency,
+				     machine_data->cpu_clk_direction);
+	if (ret < 0) {
+		dev_err(dev, "could not set CPU driver clock parameters\n");
+		return ret;
+	}
+
+	/*
+	 * Tell the codec driver what the MCLK frequency is, and whether it's
+	 * a slave or master.
+	 */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, machine_data->clk_frequency,
+				     machine_data->codec_clk_direction);
+	if (ret < 0) {
+		dev_err(dev, "could not set codec driver clock params\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_machine_remove: Remove the sound device
+ *
+ * This function is called to remove the sound device for one SSI.  We
+ * de-program the DMACR and PMUXCR register.
+ */
+static int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
+{
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(card, struct mpc8610_hpcd_data, card);
+
+	/* Restore the signal routing */
+
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[0], 0);
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[1], 0);
+
+	switch (machine_data->ssi_id) {
+	case 0:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+		break;
+	case 1:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_LA);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_ops: ASoC fabric driver operations
+ */
+static struct snd_soc_ops mpc8610_hpcd_ops = {
+	.startup = mpc8610_hpcd_startup,
+};
+
+/**
+ * get_node_by_phandle_name - get a node by its phandle name
+ *
+ * This function takes a node, the name of a property in that node, and a
+ * compatible string.  Assuming the property is a phandle to another node,
+ * it returns that node, (optionally) if that node is compatible.
+ *
+ * If the property is not a phandle, or the node it points to is not compatible
+ * with the specific string, then NULL is returned.
+ */
+static struct device_node *get_node_by_phandle_name(struct device_node *np,
+					       const char *name,
+					       const char *compatible)
+{
+	const phandle *ph;
+	int len;
+
+	ph = of_get_property(np, name, &len);
+	if (!ph || (len != sizeof(phandle)))
+		return NULL;
+
+	np = of_find_node_by_phandle(*ph);
+	if (!np)
+		return NULL;
+
+	if (compatible && !of_device_is_compatible(np, compatible)) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+
+/**
+ * mpc8610_hpcd_probe: platform probe function for the fabric driver
+ *
+ * Although this is a fabric driver, the SSI node is the "master" node with
+ * respect to audio hardware connections.  Therefore, we create a new ASoC
+ * device for each new SSI node that has a codec attached.
+ *
+ * FIXME: Currently, we only support one DMA controller, so if there are
+ * multiple SSI nodes with codecs, only the first will be supported.  We have no
+ * mechanism for assigning DMA controllers and channels to the individual
+ * SSI devices.
+ */
+static int mpc8610_hpcd_probe(struct platform_device *pdev)
+{
+	struct device_node *np = NULL;
+	struct device_node *codec_np = NULL;
+	struct device_node *dma_np = NULL;
+	struct device_node *dma_channel_np = NULL;
+	struct device_node *guts_np;
+	struct platform_device *sound_device;
+	struct mpc8610_hpcd_data *machine_data;
+	int id;
+	struct fsl_dma_info dma_info;
+	int ret = -ENODEV;
+
+	/* Map the global utilities registers. */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (!guts_np) {
+		dev_err(&pdev->dev, "missing global utilities node\n");
+		return -EINVAL;
+	}
+
+	while ((np = of_find_compatible_node(np, NULL, "fsl,mpc8610-ssi"))) {
+		const char *sprop;
+		const u32 *iprop;
+		struct resource res;
+
+		sound_device = NULL;
+
+		machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data),
+				       GFP_KERNEL);
+		if (!machine_data)
+			return -ENOMEM;
+
+		memset(&dma_info, 0, sizeof(dma_info));
+
+		/* We are only interested in SSIs with a codec phandle in them,
+		 * so let's make sure this SSI has one. The MPC8610 HPCD only
+		 * knows about the CS4270 codec, so reject anything else.
+		 */
+		codec_np = get_node_by_phandle_name(np, "codec-handle",
+						    "cirrus,cs4270");
+		if (!codec_np)
+			continue;
+
+		/* Get the device ID */
+		iprop = of_get_property(np, "cell-index", NULL);
+		if (!iprop) {
+			dev_err(&pdev->dev, "cell-index property not found\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		machine_data->ssi_id = *iprop;
+		id = *iprop;
+
+		/* Get the serial format and clock direction. */
+		sprop = of_get_property(np, "fsl,mode", NULL);
+		if (!sprop) {
+			dev_err(&pdev->dev, "fsl,mode property not found\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		if (strcasecmp(sprop, "i2s-slave") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+
+			/* In i2s-slave mode, the codec has its own clock
+			 * source, so we need to get the frequency from the
+			 * device tree and pass it to the codec driver.
+			 */
+			iprop = of_get_property(codec_np, "clock-frequency",
+						NULL);
+			if (!iprop || !*iprop) {
+				dev_err(&pdev->dev, "codec bus-frequency "
+					"property is missing or invalid\n");
+				ret = -EINVAL;
+				goto error;
+			}
+			machine_data->clk_frequency = *iprop;
+		} else if (strcasecmp(sprop, "i2s-master") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+		} else if (strcasecmp(sprop, "lj-slave") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+		} else if (strcasecmp(sprop, "lj-master") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+		} else if (strcasecmp(sprop, "rj-slave") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+		} else if (strcasecmp(sprop, "rj-master") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+		} else if (strcasecmp(sprop, "ac97-slave") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+		} else if (strcasecmp(sprop, "ac97-master") == 0) {
+			machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+			machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+			machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+		} else {
+			dev_err(&pdev->dev,
+				"unrecognized fsl,mode property '%s'\n", sprop);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		if (!machine_data->clk_frequency) {
+			dev_err(&pdev->dev, "unknown clock frequency\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		/* Read the SSI information from the device tree */
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret || !res.start) {
+			dev_err(&pdev->dev, "could not obtain SSI address\n");
+			goto error;
+		}
+		dma_info.ssi_stx_phys = res.start +
+			offsetof(struct ccsr_ssi, stx0);
+		dma_info.ssi_srx_phys = res.start +
+			offsetof(struct ccsr_ssi, srx0);
+
+		/* Find the playback DMA channelto use. */
+		dma_channel_np =
+			get_node_by_phandle_name(np, "fsl,playback-dma",
+						 "fsl,ssi-dma-channel");
+		if (!dma_channel_np) {
+			dev_err(&pdev->dev, "missing or invalid phandle\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		dma_info.dma_channel[0] = of_iomap(dma_channel_np, 0);
+
+		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
+		if (!iprop) {
+			dev_err(&pdev->dev, "missing cell-index property\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		machine_data->dma_channel_id[0] = *iprop;
+		of_node_put(dma_channel_np);
+
+		/* Find the capture DMA channelto use. */
+		dma_channel_np =
+			get_node_by_phandle_name(np, "fsl,capture-dma",
+						 "fsl,ssi-dma-channel");
+		if (!dma_channel_np) {
+			dev_err(&pdev->dev, "missing or invalid phandle\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		dma_info.dma_channel[1] = of_iomap(dma_channel_np, 0);
+
+		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
+		if (!iprop) {
+			dev_err(&pdev->dev, "missing cell-index property\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		machine_data->dma_channel_id[1] = *iprop;
+
+		/* Find the cell-index of the parent DMA node.  We assume
+		 * that both DMA channels are part of the same DMA
+		 * controller, but that doesn't necessarily have to be true.
+		 */
+		dma_np = of_get_parent(dma_channel_np);
+		of_node_put(dma_channel_np);
+		dma_channel_np = NULL;
+		if (!dma_np) {
+			dev_err(&pdev->dev, "missing parent DMA node\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		iprop = of_get_property(dma_np, "cell-index", NULL);
+		if (!iprop) {
+			dev_err(&pdev->dev, "missing cell-index property\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		machine_data->dma_id = *iprop;
+		of_node_put(dma_np);
+		dma_np = NULL;
+
+		/* Map the global utilities registers */
+		machine_data->guts = of_iomap(guts_np, 0);
+		if (!machine_data->guts) {
+			dev_err(&pdev->dev,
+				"could not map global utilities node\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		dma_info.dev = &pdev->dev;
+
+		/* We have the DMA information, so tell the DMA driver */
+		if (!fsl_dma_configure(&dma_info)) {
+			dev_err(&pdev->dev,
+				"could not instantiate DMA device\n");
+			ret = -EBUSY;
+			goto error;
+		}
+
+		/* Initialize our DAI data structure.  */
+		iprop = of_get_property(codec_np, "reg", NULL);
+		if (!iprop) {
+			dev_err(&pdev->dev,
+				"codec node is missing 'reg' property\n");
+			goto error;
+		}
+
+		machine_data->dai.codec_id = *iprop;
+		machine_data->dai.cpu_dai_id = id;
+		machine_data->dai.codec_dai_id = 0;
+		machine_data->dai.platform_id = 0;
+
+		/* Store the codec name as the DAI name */
+		of_modalias_node(codec_np, machine_data->dai_name,
+				 sizeof(machine_data->dai_name));
+		of_node_put(codec_np);
+		codec_np = NULL;
+		machine_data->dai.name = machine_data->dai_name;
+		machine_data->dai.stream_name = machine_data->dai_name;
+
+		machine_data->dai.cpu_dai_drv = &fsl_ssi_dai;
+		machine_data->dai.codec_dai_drv = &cs4270_dai;
+		machine_data->dai.codec_drv = &soc_codec_device_cs4270;
+		machine_data->dai.ops = &mpc8610_hpcd_ops;
+		machine_data->dai.platform_drv = &fsl_soc_platform;
+
+		machine_data->card.probe = mpc8610_hpcd_machine_probe;
+		machine_data->card.remove = mpc8610_hpcd_machine_remove;
+		machine_data->card.name = "MPC8610 HPCD";
+		machine_data->card.num_links = 1;
+		machine_data->card.dai_link = &machine_data->dai;
+
+		/* Allocate a new audio platform device structure */
+		sound_device = platform_device_alloc("soc-audio", -1);
+		if (!sound_device) {
+			dev_err(&pdev->dev, "platform device alloc failed\n");
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		/* Associate the card data with the sound device */
+		platform_set_drvdata(sound_device, &machine_data->card);
+
+		/* Register with ASoC */
+		ret = platform_device_add(sound_device);
+		if (ret) {
+			dev_err(&pdev->dev, "platform device add failed\n");
+			goto error;
+		}
+	}
+
+	of_node_put(guts_np);
+	return 0;
+
+error:
+	of_node_put(codec_np);
+	of_node_put(dma_np);
+	of_node_put(guts_np);
+	of_node_put(dma_channel_np);
+
+	if (sound_device)
+		platform_device_unregister(sound_device);
+
+	if (dma_info.dma_channel[0])
+		iounmap(dma_info.dma_channel[0]);
+
+	if (dma_info.dma_channel[1])
+		iounmap(dma_info.dma_channel[1]);
+
+	if (machine_data->guts)
+		iounmap(machine_data->guts);
+
+	kfree(machine_data);
+
+	return ret;
+}
+
+/**
+ * mpc8610_hpcd_remove: remove the OF device
+ *
+ * This function is called when the OF device is removed.
+ */
+static int mpc8610_hpcd_remove(struct platform_device *pdev)
+{
+	struct platform_device *sound_device = dev_get_drvdata(&pdev->dev);
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(card, struct mpc8610_hpcd_data, card);
+
+	platform_device_unregister(sound_device);
+
+	if (machine_data->guts)
+		iounmap(machine_data->guts);
+
+	kfree(machine_data);
+	sound_device->dev.platform_data = NULL;
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver mpc8610_hpcd_driver = {
+	.probe = mpc8610_hpcd_probe,
+	.remove = __devexit_p(mpc8610_hpcd_remove),
+	.driver = {
+		.name = "snd-soc-mpc8610-hpcd",
+		.owner = THIS_MODULE,
+	},
+};
+
+/**
+ * mpc8610_hpcd_init: fabric driver initialization.
+ *
+ * This function is called when this module is loaded.
+ */
+static int __init mpc8610_hpcd_init(void)
+{
+	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
+
+	return platform_driver_register(&mpc8610_hpcd_driver);
+}
+
+/**
+ * mpc8610_hpcd_exit: fabric driver exit
+ *
+ * This function is called when this driver is unloaded.
+ */
+static void __exit mpc8610_hpcd_exit(void)
+{
+	platform_driver_unregister(&mpc8610_hpcd_driver);
+}
+
+module_init(mpc8610_hpcd_init);
+module_exit(mpc8610_hpcd_exit);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
+MODULE_LICENSE("GPL");
-- 
1.6.5
