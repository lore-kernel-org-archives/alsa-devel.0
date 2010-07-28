From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc multi-component: mpc8610 hpcd updates
Date: Wed, 28 Jul 2010 16:13:03 -0500
Message-ID: <1280351583-26768-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id BA91B103835
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 23:13:22 +0200 (CEST)
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

Additional updates to the multi-component branch.  Liam, please squash these
in.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c      |   68 +++++++++++++++--------
 sound/soc/fsl/fsl_dma.h      |    3 -
 sound/soc/fsl/fsl_ssi.c      |   37 +++++++-----
 sound/soc/fsl/mpc8610_hpcd.c |  125 ++++++++++++++++++++++++++---------------
 4 files changed, 144 insertions(+), 89 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 7f87297..d09e194 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -32,6 +32,7 @@
 #include <asm/io.h>
 
 #include "fsl_dma.h"
+#include "fsl_ssi.h"	/* For the offset of stx0 and srx0 */
 
 /*
  * The formats that the DMA controller supports, which is anything
@@ -798,36 +799,35 @@ static void fsl_dma_free_dma_buffers(struct snd_pcm *pcm)
 static LIST_HEAD(dma_list);
 
 /**
- * fsl_soc_dma_to_dai - returning the DAI struct for a given DMA node
- *
- * When a machine driver registers itself with ASoC, it must provide the
- * address of the DAI structures that it wants to connect.  Most drivers simply
- * reference global data structures in the various drivers, but we PowerPC
- * developers are better than that.  This driver keeps a list of every DMA
- * node that it probes, and when the machine driver wants to reference a
- * DMA DAI, this function provides that service.
- *
- * Hopefully one day, ASoC will just want the name of the DMA device, not
- * some obscure pointer, and this function will go away.
+ * find_ssi_node -- returns the SSI node that points to his DMA channel node
+ *
+ * Although this DMA driver attempts to operate independently of the other
+ * devices, it still needs to determine some information about the SSI device
+ * that it's working with.  Unfortunately, the device tree does not contain
+ * a pointer from the DMA channel node to the SSI node -- the pointer goes the
+ * other way.  So we need to scan the device tree for SSI nodes until we find
+ * the one that points to the given DMA channel node.  It's ugly, but at least
+ * it's contained in this one function.
  */
-struct snd_soc_platform_driver *fsl_soc_dma_to_dai(const char *path,
-	dma_addr_t ssi_stx_phys, dma_addr_t ssi_srx_phys)
+static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
 {
-	struct list_head *ptr;
-	struct dma_object *dma;
+	struct device_node *ssi_np, *np;
 
-	list_for_each(ptr, &dma_list) {
-		dma = list_entry(ptr, struct dma_object, list);
-		if (strcmp(path, dma->path) == 0) {
-			dma->ssi_stx_phys = ssi_stx_phys;
-			dma->ssi_srx_phys = ssi_srx_phys;
-			return &dma->dai;
-		}
+	for_each_compatible_node(ssi_np, NULL, "fsl,mpc8610-ssi") {
+		/* Check each DMA phandle to see if it points to us.  We
+		 * assume that device_node pointers are a valid comparison.
+		 */
+		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
+		if (np == dma_channel_np)
+			return ssi_np;
+
+		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
+		if (np == dma_channel_np)
+			return ssi_np;
 	}
 
 	return NULL;
 }
-EXPORT_SYMBOL(fsl_soc_dma_to_dai);
 
 static struct snd_pcm_ops fsl_dma_ops = {
 	.open   	= fsl_dma_open,
@@ -843,8 +843,24 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
  {
 	struct dma_object *dma;
 	struct device_node *np = of_dev->dev.of_node;
+	struct device_node *ssi_np;
+	struct resource res;
 	int ret;
 
+	/* Find the SSI node that points to us. */
+	ssi_np = find_ssi_node(np);
+	if (!ssi_np) {
+		dev_err(&of_dev->dev, "cannot find parent SSI node\n");
+		return -ENODEV;
+	}
+
+	ret = of_address_to_resource(ssi_np, 0, &res);
+	of_node_put(ssi_np);
+	if (ret) {
+		dev_err(&of_dev->dev, "could not determine device resources\n");
+		return ret;
+	}
+
 	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
 	if (!dma) {
 		dev_err(&of_dev->dev, "could not allocate dma object\n");
@@ -856,6 +872,10 @@ static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
 	dma->dai.pcm_new = fsl_dma_new;
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
 
+	/* Store the SSI-specific information that we need */
+	dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
+	dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
+
 	ret = snd_soc_register_platform(&of_dev->dev, &dma->dai);
 	if (ret) {
 		dev_err(&of_dev->dev, "could not register platform\n");
@@ -921,7 +941,7 @@ static void __exit fsl_soc_dma_exit(void)
  * will already have been probed.  The easiest way to do that is to make the
  * __init function called via arch_initcall().
  */
-arch_initcall(fsl_soc_dma_init);
+module_init(fsl_soc_dma_init);
 module_exit(fsl_soc_dma_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index e152bc6..78fee97 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -126,7 +126,4 @@ struct fsl_dma_link_descriptor {
 	u8 res[4];      /* Reserved */
 } __attribute__ ((aligned(32), packed));
 
-struct snd_soc_platform_driver *fsl_soc_dma_to_dai(const char *path,
-	dma_addr_t ssi_stx_phys, dma_addr_t ssi_srx_phys);
-
 #endif
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2388484..51b089f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -292,8 +292,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 
 		/* The 'name' should not have any slashes in it. */
 		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
-				  strrchr(ssi_private->name, '/') + 1,
-				  ssi_private);
+				  ssi_private->name, ssi_private);
 		if (ret < 0) {
 			dev_err(substream->pcm->card->dev,
 				"could not claim irq %u\n", ssi_private->irq);
@@ -622,11 +621,9 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	int ret = 0;
 	struct device_attribute *dev_attr;
 	struct device_node *np = of_dev->dev.of_node;
-	const char *sprop;
+	const char *p, *sprop;
 	struct resource res;
 	char name[64];
-	struct platform_device *pdev;
-	void *platform_data;
 
 	/* We are only interested in SSIs with a codec phandle in them, so let's
 	 * make sure this SSI has one.
@@ -641,21 +638,22 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 		return -ENODEV;
 	}
 
-	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) +
-			      strlen(np->full_name), GFP_KERNEL);
+	/* The DAI name is the last part of the full name of the node. */
+	p = strrchr(np->full_name, '/') + 1;
+	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) + strlen(p),
+			      GFP_KERNEL);
 	if (!ssi_private) {
 		dev_err(&of_dev->dev, "could not allocate DAI object\n");
 		return -ENOMEM;
 	}
 
+	strcpy(ssi_private->name, p);
+
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
 	       sizeof(fsl_ssi_dai_template));
 	ssi_private->cpu_dai_drv.name = ssi_private->name;
 
-	/* The name we register with ASoC is the full node name */
-	strlcpy(ssi_private->name, np->full_name, sizeof(ssi_private->name));
-
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
@@ -698,19 +696,26 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	}
 
 	/* Trigger the machine driver's probe function.  The platform driver
-	 * name of the machine driver is taken from the /model node of the
+	 * name of the machine driver is taken from the /model property of the
 	 * device tree.  We also pass the address of the CPU DAI driver
 	 * structure.
 	 */
 	sprop = of_get_property(of_find_node_by_path("/"), "model", NULL);
+	/* Sometimes the model name has a "fsl," prefix, so we strip that. */
+	p = strrchr(sprop, ',');
+	if (p)
+		sprop = p + 1;
 	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
 	make_lowercase(name);
 
-	platform_data = &ssi_private->cpu_dai_drv;
-	pdev = platform_device_register_data(&of_dev->dev, name,
-		0, &platform_data, sizeof(void *));
-
-	ssi_private->pdev = pdev;
+	ssi_private->pdev =
+		platform_device_register_data(&of_dev->dev, name, 0, NULL, 0);
+	if (IS_ERR(ssi_private->pdev)) {
+		ret = PTR_ERR(ssi_private->pdev);
+		dev_err(&of_dev->dev, "failed to register platform: %d\n", ret);
+		kfree(ssi_private);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index e87cd1e..38339c1 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -22,6 +22,8 @@
 /* There's only one global utilities register */
 static phys_addr_t guts_phys;
 
+#define DAI_NAME_SIZE	32
+
 /**
  * mpc8610_hpcd_data: machine-specific ASoC device data
  *
@@ -38,7 +40,9 @@ struct mpc8610_hpcd_data {
 	unsigned int ssi_id;		/* 0 = SSI1, 1 = SSI2, etc */
 	unsigned int dma_id[2];		/* 0 = DMA1, 1 = DMA2, etc */
 	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
-	char dai_name[32];
+	char codec_dai_name[DAI_NAME_SIZE];
+	char codec_name[DAI_NAME_SIZE];
+	char platform_name[2][DAI_NAME_SIZE]; /* One for each DMA channel */
 };
 
 /**
@@ -233,25 +237,68 @@ static int get_parent_cell_index(struct device_node *np)
 	return *iprop;
 }
 
+/**
+ * codec_node_dev_name - determine the dev_name for a codec node
+ *
+ * This function determines the dev_name for an I2C node.  This is the name
+ * that would be returned by dev_name() if this device_node were part of a
+ * 'struct device'  It's ugly and hackish, but it works.
+ *
+ * The dev_name for such devices include the bus number and I2C address. For
+ * example, "cs4270-codec.0-004f".
+ */
+static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
+{
+	const u32 *iprop;
+	int bus, addr;
+	char temp[DAI_NAME_SIZE];
+
+	of_modalias_node(np, temp, DAI_NAME_SIZE);
+
+	iprop = of_get_property(np, "reg", NULL);
+	if (!iprop)
+		return -EINVAL;
+
+	addr = *iprop;
+
+	bus = get_parent_cell_index(np);
+	if (bus < 0)
+		return bus;
+
+	snprintf(buf, len, "%s-codec.%u-%04x", temp, bus, addr);
+
+	return 0;
+}
+
 static int get_dma_channel(struct device_node *ssi_np,
 			   const char *compatible,
-			   dma_addr_t ssi_stx_phys,
-			   dma_addr_t ssi_srx_phys,
 			   struct snd_soc_dai_link *dai,
 			   unsigned int *dma_channel_id,
 			   unsigned int *dma_id)
 {
+	struct resource res;
 	struct device_node *dma_channel_np;
 	const u32 *iprop;
+	int ret;
 
 	dma_channel_np = get_node_by_phandle_name(ssi_np, compatible,
 						  "fsl,ssi-dma-channel");
 	if (!dma_channel_np)
 		return -EINVAL;
 
-	// FIXME: change this to get the OF device name
-	dai->platform_name = fsl_soc_dma_to_dai(dma_channel_np->full_name,
-					       ssi_stx_phys, ssi_srx_phys);
+	/* Determine the dev_name for the device_node.  This code mimics the
+	 * behavior of of_device_make_bus_id(). We need this because ASoC uses
+	 * the dev_name() of the device to match the platform (DMA) device with
+	 * the CPU (SSI) device.  It's all ugly and hackish, but it works (for
+	 * now).
+	 *
+	 * dai->platform name should already point to an allocated buffer.
+	 */
+	ret = of_address_to_resource(dma_channel_np, 0, &res);
+	if (ret)
+		return ret;
+	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
+		 (unsigned long long) res.start, dma_channel_np->name);
 
 	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
 	if (!iprop) {
@@ -265,6 +312,7 @@ static int get_dma_channel(struct device_node *ssi_np,
 
 	return 0;
 }
+
 /**
  * mpc8610_hpcd_probe: platform probe function for the machine driver
  *
@@ -274,22 +322,16 @@ static int get_dma_channel(struct device_node *ssi_np,
  */
 static int mpc8610_hpcd_probe(struct platform_device *pdev)
 {
-	struct snd_soc_dai_driver **platform_data = pdev->dev.platform_data;
 	struct device *dev = pdev->dev.parent;
+	/* of_dev is the OF device for the SSI node that probed us */
 	struct of_device *of_dev = container_of(dev, struct of_device, dev);
 	struct device_node *np = of_dev->dev.of_node;
 	struct device_node *codec_np = NULL;
-	struct device_node *dma_np = NULL;
-	struct device_node *dma_channel_np = NULL;
 	struct platform_device *sound_device = NULL;
 	struct mpc8610_hpcd_data *machine_data;
-	int id;
-	dma_addr_t ssi_stx_phys;
-	dma_addr_t ssi_srx_phys;
 	int ret = -ENODEV;
 	const char *sprop;
 	const u32 *iprop;
-	struct resource res;
 
 	/* We are only interested in SSIs with a codec phandle in them,
 	 * so let's make sure this SSI has one. The MPC8610 HPCD only
@@ -306,20 +348,27 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	if (!machine_data)
 		return -ENOMEM;
 
-	machine_data->dai[0].name = machine_data->dai_name;
+	machine_data->dai[0].cpu_dai_name = dev_name(&of_dev->dev);
+	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
 
-	/* FIXME: Timur, do we need to append .0 or .1 suffix here ? */
-	machine_data->dai[0].cpu_dai_name = "fsl-ssi-dai";
-	machine_data->dai[0].platform_name = "fsl-pcm-audio";
+	/* Determine the codec name, it will be used as the codec DAI name */
+	ret = codec_node_dev_name(codec_np, machine_data->codec_name,
+				  DAI_NAME_SIZE);
+	if (ret) {
+		dev_err(&pdev->dev, "invalid codec node %s\n",
+			codec_np->full_name);
+		ret = -EINVAL;
+		goto error;
+	}
+	machine_data->dai[0].codec_name = machine_data->codec_name;
 
+	/* The DAI name from the codec (snd_soc_dai_driver.name) */
 	machine_data->dai[0].codec_dai_name = "cs4270-hifi";
-	machine_data->dai[0].codec_name = "cs4270-codec";
-	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
-
-	/* Store the codec name, it will be used as the codec DAI name */
-	of_modalias_node(codec_np, machine_data->dai_name,
-			 sizeof(machine_data->dai_name));
 
+	/* We register two DAIs per SSI, one for playback and the other for
+	 * capture.  Currently, we only support codecs that have one DAI for
+	 * both playback and capture.
+	 */
 	memcpy(&machine_data->dai[1], &machine_data->dai[0],
 	       sizeof(struct snd_soc_dai_link));
 
@@ -331,7 +380,6 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		goto error;
 	}
 	machine_data->ssi_id = *iprop;
-	id = *iprop;
 
 	/* Get the serial format and clock direction. */
 	sprop = of_get_property(np, "fsl,mode", NULL);
@@ -399,18 +447,9 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/* Read the SSI information from the device tree */
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret || !res.start) {
-		dev_err(&pdev->dev, "could not obtain SSI address\n");
-		goto error;
-	}
-	ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
-	ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
-
 	/* Find the playback DMA channel to use. */
-	ret = get_dma_channel(np, "fsl,playback-dma", ssi_stx_phys,
-			      ssi_srx_phys, &machine_data->dai[0],
+	machine_data->dai[0].platform_name = machine_data->platform_name[0];
+	ret = get_dma_channel(np, "fsl,playback-dma", &machine_data->dai[0],
 			      &machine_data->dma_channel_id[0],
 			      &machine_data->dma_id[0]);
 	if (ret) {
@@ -419,8 +458,8 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	}
 
 	/* Find the capture DMA channel to use. */
-	ret = get_dma_channel(np, "fsl,capture-dma", ssi_stx_phys,
-			      ssi_srx_phys, &machine_data->dai[1],
+	machine_data->dai[1].platform_name = machine_data->platform_name[1];
+	ret = get_dma_channel(np, "fsl,capture-dma", &machine_data->dai[1],
 			      &machine_data->dma_channel_id[1],
 			      &machine_data->dma_id[1]);
 	if (ret) {
@@ -429,18 +468,14 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize our DAI data structure.  */
-	iprop = of_get_property(codec_np, "reg", NULL);
-	if (!iprop) {
-		dev_err(&pdev->dev, "codec node is missing 'reg' property\n");
-		goto error;
-	}
-
 	machine_data->dai[0].stream_name = "playback";
 	machine_data->dai[1].stream_name = "capture";
+	machine_data->dai[0].name = machine_data->dai[0].stream_name;
+	machine_data->dai[1].name = machine_data->dai[1].stream_name;
 
 	machine_data->card.probe = mpc8610_hpcd_machine_probe;
 	machine_data->card.remove = mpc8610_hpcd_machine_remove;
-	machine_data->card.name = "MPC8610 HPCD";
+	machine_data->card.name = pdev->name; /* The platform driver name */
 	machine_data->card.num_links = 2;
 	machine_data->card.dai_link = machine_data->dai;
 
@@ -468,8 +503,6 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 
 error:
 	of_node_put(codec_np);
-	of_node_put(dma_np);
-	of_node_put(dma_channel_np);
 
 	if (sound_device)
 		platform_device_unregister(sound_device);
-- 
1.7.0.1
