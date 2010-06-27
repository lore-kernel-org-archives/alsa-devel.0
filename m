From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 09/15] ASoC: multi-component - Freescale PPC
	Platform
Date: Sun, 27 Jun 2010 12:52:08 +0100
Message-ID: <1277639534-5104-10-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FAF11038AD
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:45 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so919297wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:45 -0700 (PDT)
In-Reply-To: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Freescale PPC platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o fsl_ssi_create_dai() and fsl_ssi_destroy_dai() no longer required.
 o Added mpc5200_hpcd_of_driver of_driver.
 o Multi-component support for fsl_ssi, fsl_pcm and mpc8610 by Timur Tabi

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/fsl/efika-audio-fabric.c  |   23 +-
 sound/soc/fsl/fsl_dma.c             |  293 ++++++++++-------
 sound/soc/fsl/fsl_dma.h             |   21 +-
 sound/soc/fsl/fsl_ssi.c             |  246 ++++++++------
 sound/soc/fsl/fsl_ssi.h             |   26 --
 sound/soc/fsl/mpc5200_dma.c         |   64 +++-
 sound/soc/fsl/mpc5200_dma.h         |    5 +-
 sound/soc/fsl/mpc5200_psc_ac97.c    |   31 +--
 sound/soc/fsl/mpc5200_psc_ac97.h    |    2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c     |   17 +-
 sound/soc/fsl/mpc8610_hpcd.c        |  609 ++++++++++++++++-------------------
 sound/soc/fsl/pcm030-audio-fabric.c |   25 +-
 12 files changed, 679 insertions(+), 683 deletions(-)

diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index 1a5b8e0..11289f8 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -32,21 +32,28 @@
 
 #define DRV_NAME "efika-audio-fabric"
 
-static struct snd_soc_device device;
 static struct snd_soc_card card;
 
 static struct snd_soc_dai_link efika_fabric_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 Analog",
-	.codec_dai = &stac9766_dai[STAC9766_DAI_AC97_ANALOG],
-	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_NORMAL],
+	.codec_dai_drv = &stac9766_dai[STAC9766_DAI_AC97_ANALOG],
+	.codec_dai_id = STAC9766_DAI_AC97_ANALOG,
+	.cpu_dai_drv = &psc_ac97_dai[MPC5200_AC97_NORMAL],
+	.cpu_dai_id = MPC5200_AC97_NORMAL,
+	.platform_drv = &mpc5200_audio_dma_platform,
+	.codec_drv = &soc_codec_dev_stac9766,
 },
 {
 	.name = "AC97",
 	.stream_name = "AC97 IEC958",
-	.codec_dai = &stac9766_dai[STAC9766_DAI_AC97_DIGITAL],
-	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_SPDIF],
+	.codec_dai_drv = &stac9766_dai[STAC9766_DAI_AC97_DIGITAL],
+	.codec_dai_id = STAC9766_DAI_AC97_DIGITAL,
+	.cpu_dai_drv = &psc_ac97_dai[MPC5200_AC97_SPDIF],
+	.cpu_dai_id = MPC5200_AC97_SPDIF,
+	.platform_drv = &mpc5200_audio_dma_platform,
+	.codec_drv = &soc_codec_dev_stac9766,
 },
 };
 
@@ -58,13 +65,10 @@ static __init int efika_fabric_init(void)
 	if (!of_machine_is_compatible("bplan,efika"))
 		return -ENODEV;
 
-	card.platform = &mpc5200_audio_dma_platform;
 	card.name = "Efika";
 	card.dai_link = efika_fabric_dai;
 	card.num_links = ARRAY_SIZE(efika_fabric_dai);
 
-	device.card = &card;
-	device.codec_dev = &soc_codec_dev_stac9766;
 
 	pdev = platform_device_alloc("soc-audio", 1);
 	if (!pdev) {
@@ -72,8 +76,7 @@ static __init int efika_fabric_init(void)
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(pdev, &device);
-	device.dev = &pdev->dev;
+	platform_set_drvdata(pdev, &card);
 
 	rc = platform_device_add(pdev);
 	if (rc) {
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 410c749..54f9111 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -3,10 +3,11 @@
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  *
  * This driver implements ASoC support for the Elo DMA controller, which is
  * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
@@ -20,6 +21,8 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/gfp.h>
+#include <linux/of_platform.h>
+#include <linux/list.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -52,26 +55,16 @@
 #define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
 			  SNDRV_PCM_RATE_CONTINUOUS)
 
-/* DMA global data.  This structure is used by fsl_dma_open() to determine
- * which DMA channels to assign to a substream.  Unfortunately, ASoC V1 does
- * not allow the machine driver to provide this information to the PCM
- * driver in advance, and there's no way to differentiate between the two
- * DMA controllers.  So for now, this driver only supports one SSI device
- * using two DMA channels.  We cannot support multiple DMA devices.
- *
- * ssi_stx_phys: bus address of SSI STX register
- * ssi_srx_phys: bus address of SSI SRX register
- * dma_channel: pointer to the DMA channel's registers
- * irq: IRQ for this DMA channel
- * assigned: set to 1 if that DMA channel is assigned to a substream
- */
-static struct {
+struct dma_object {
+	struct list_head list;
+	struct snd_soc_platform_driver dai;
 	dma_addr_t ssi_stx_phys;
 	dma_addr_t ssi_srx_phys;
-	struct ccsr_dma_channel __iomem *dma_channel[2];
-	unsigned int irq[2];
-	unsigned int assigned[2];
-} dma_global_data;
+	struct ccsr_dma_channel __iomem *channel;
+	unsigned int irq;
+	bool assigned;
+	char path[1];
+};
 
 /*
  * The number of DMA links to use.  Two is the bare minimum, but if you
@@ -88,8 +81,6 @@ static struct {
  * structure.
  *
  * @link[]: array of link descriptors
- * @controller_id: which DMA controller (0, 1, ...)
- * @channel_id: which DMA channel on the controller (0, 1, 2, ...)
  * @dma_channel: pointer to the DMA channel's registers
  * @irq: IRQ for this DMA channel
  * @substream: pointer to the substream object, needed by the ISR
@@ -104,8 +95,6 @@ static struct {
  */
 struct fsl_dma_private {
 	struct fsl_dma_link_descriptor link[NUM_DMA_LINKS];
-	unsigned int controller_id;
-	unsigned int channel_id;
 	struct ccsr_dma_channel __iomem *dma_channel;
 	unsigned int irq;
 	struct snd_pcm_substream *substream;
@@ -212,6 +201,9 @@ static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
 static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 {
 	struct fsl_dma_private *dma_private = dev_id;
+	struct snd_pcm_substream *substream = dma_private->substream;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
 	irqreturn_t ret = IRQ_NONE;
 	u32 sr, sr2 = 0;
@@ -222,11 +214,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 	sr = in_be32(&dma_channel->sr);
 
 	if (sr & CCSR_DMA_SR_TE) {
-		dev_err(dma_private->substream->pcm->card->dev,
-			"DMA transmit error (controller=%u channel=%u irq=%u\n",
-			dma_private->controller_id,
-			dma_private->channel_id, irq);
-		fsl_dma_abort_stream(dma_private->substream);
+		dev_err(dev, "dma transmit error\n");
+		fsl_dma_abort_stream(substream);
 		sr2 |= CCSR_DMA_SR_TE;
 		ret = IRQ_HANDLED;
 	}
@@ -235,11 +224,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 
 	if (sr & CCSR_DMA_SR_PE) {
-		dev_err(dma_private->substream->pcm->card->dev,
-			"DMA%u programming error (channel=%u irq=%u)\n",
-			dma_private->controller_id,
-			dma_private->channel_id, irq);
-		fsl_dma_abort_stream(dma_private->substream);
+		dev_err(dev, "dma programming error\n");
+		fsl_dma_abort_stream(substream);
 		sr2 |= CCSR_DMA_SR_PE;
 		ret = IRQ_HANDLED;
 	}
@@ -253,8 +239,6 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 
 	if (sr & CCSR_DMA_SR_EOSI) {
-		struct snd_pcm_substream *substream = dma_private->substream;
-
 		/* Tell ALSA we completed a period. */
 		snd_pcm_period_elapsed(substream);
 
@@ -305,10 +289,8 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 		fsl_dma_hardware.buffer_bytes_max,
 		&pcm->streams[0].substream->dma_buffer);
 	if (ret) {
-		dev_err(card->dev,
-			"Can't allocate playback DMA buffer (size=%u)\n",
-			fsl_dma_hardware.buffer_bytes_max);
-		return -ENOMEM;
+		dev_err(card->dev, "can't allocate playback dma buffer\n");
+		return ret;
 	}
 
 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
@@ -316,10 +298,8 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 		&pcm->streams[1].substream->dma_buffer);
 	if (ret) {
 		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
-		dev_err(card->dev,
-			"Can't allocate capture DMA buffer (size=%u)\n",
-			fsl_dma_hardware.buffer_bytes_max);
-		return -ENOMEM;
+		dev_err(card->dev, "can't allocate capture dma buffer\n");
+		return ret;
 	}
 
 	return 0;
@@ -390,6 +370,10 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 static int fsl_dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
+	struct dma_object *dma =
+		container_of(rtd->platform->driver, struct dma_object, dai);
 	struct fsl_dma_private *dma_private;
 	struct ccsr_dma_channel __iomem *dma_channel;
 	dma_addr_t ld_buf_phys;
@@ -407,52 +391,44 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	ret = snd_pcm_hw_constraint_integer(runtime,
 		SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
-		dev_err(substream->pcm->card->dev, "invalid buffer size\n");
+		dev_err(dev, "invalid buffer size\n");
 		return ret;
 	}
 
 	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
 
-	if (dma_global_data.assigned[channel]) {
-		dev_err(substream->pcm->card->dev,
-			"DMA channel already assigned\n");
+	if (dma->assigned) {
+		dev_err(dev, "dma channel already assigned\n");
 		return -EBUSY;
 	}
 
-	dma_private = dma_alloc_coherent(substream->pcm->card->dev,
-		sizeof(struct fsl_dma_private), &ld_buf_phys, GFP_KERNEL);
+	dma_private = dma_alloc_coherent(dev, sizeof(struct fsl_dma_private),
+					 &ld_buf_phys, GFP_KERNEL);
 	if (!dma_private) {
-		dev_err(substream->pcm->card->dev,
-			"can't allocate DMA private data\n");
+		dev_err(dev, "can't allocate dma private data\n");
 		return -ENOMEM;
 	}
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_private->ssi_sxx_phys = dma_global_data.ssi_stx_phys;
+		dma_private->ssi_sxx_phys = dma->ssi_stx_phys;
 	else
-		dma_private->ssi_sxx_phys = dma_global_data.ssi_srx_phys;
+		dma_private->ssi_sxx_phys = dma->ssi_srx_phys;
 
-	dma_private->dma_channel = dma_global_data.dma_channel[channel];
-	dma_private->irq = dma_global_data.irq[channel];
+	dma_private->dma_channel = dma->channel;
+	dma_private->irq = dma->irq;
 	dma_private->substream = substream;
 	dma_private->ld_buf_phys = ld_buf_phys;
 	dma_private->dma_buf_phys = substream->dma_buffer.addr;
 
-	/* We only support one DMA controller for now */
-	dma_private->controller_id = 0;
-	dma_private->channel_id = channel;
-
 	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "DMA", dma_private);
 	if (ret) {
-		dev_err(substream->pcm->card->dev,
-			"can't register ISR for IRQ %u (ret=%i)\n",
+		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
 			dma_private->irq, ret);
-		dma_free_coherent(substream->pcm->card->dev,
-			sizeof(struct fsl_dma_private),
+		dma_free_coherent(dev, sizeof(struct fsl_dma_private),
 			dma_private, dma_private->ld_buf_phys);
 		return ret;
 	}
 
-	dma_global_data.assigned[channel] = 1;
+	dma->assigned = 1;
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
@@ -546,6 +522,8 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
 
 	/* Number of bits per sample */
 	unsigned int sample_size =
@@ -606,8 +584,7 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		/* We should never get here */
-		dev_err(substream->pcm->card->dev,
-			"unsupported sample size %u\n", sample_size);
+		dev_err(dev, "unsupported sample size %u\n", sample_size);
 		return -EINVAL;
 	}
 
@@ -689,6 +666,8 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
 	dma_addr_t position;
 	snd_pcm_uframes_t frames;
@@ -710,8 +689,7 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 
 	if ((position < dma_private->dma_buf_phys) ||
 	    (position > dma_private->dma_buf_end)) {
-		dev_err(substream->pcm->card->dev,
-			"dma pointer is out of range, halting stream\n");
+		dev_err(dev, "dma pointer is out of range, halting stream\n");
 		return SNDRV_PCM_POS_XRUN;
 	}
 
@@ -772,26 +750,28 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	int dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
+	struct dma_object *dma =
+		container_of(rtd->platform->driver, struct dma_object, dai);
 
 	if (dma_private) {
 		if (dma_private->irq)
 			free_irq(dma_private->irq, dma_private);
 
 		if (dma_private->ld_buf_phys) {
-			dma_unmap_single(substream->pcm->card->dev,
-				dma_private->ld_buf_phys,
-				sizeof(dma_private->link), DMA_TO_DEVICE);
+			dma_unmap_single(dev, dma_private->ld_buf_phys,
+					 sizeof(dma_private->link),
+					 DMA_TO_DEVICE);
 		}
 
 		/* Deallocate the fsl_dma_private structure */
-		dma_free_coherent(substream->pcm->card->dev,
-			sizeof(struct fsl_dma_private),
-			dma_private, dma_private->ld_buf_phys);
+		dma_free_coherent(dev, sizeof(struct fsl_dma_private),
+				  dma_private, dma_private->ld_buf_phys);
 		substream->runtime->private_data = NULL;
 	}
 
-	dma_global_data.assigned[dir] = 0;
+	dma->assigned = 0;
 
 	return 0;
 }
@@ -814,6 +794,41 @@ static void fsl_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
+/* List of DMA nodes that we've probed */
+static LIST_HEAD(dma_list);
+
+/**
+ * fsl_soc_dma_to_dai - returning the DAI struct for a given DMA node
+ *
+ * When a machine driver registers itself with ASoC, it must provide the
+ * address of the DAI structures that it wants to connect.  Most drivers simply
+ * reference global data structures in the various drivers, but we PowerPC
+ * developers are better than that.  This driver keeps a list of every DMA
+ * node that it probes, and when the machine driver wants to reference a
+ * DMA DAI, this function provides that service.
+ *
+ * Hopefully one day, ASoC will just want the name of the DMA device, not
+ * some obscure pointer, and this function will go away.
+ */
+struct snd_soc_platform_driver *fsl_soc_dma_to_dai(const char *path,
+	dma_addr_t ssi_stx_phys, dma_addr_t ssi_srx_phys)
+{
+	struct list_head *ptr;
+	struct dma_object *dma;
+
+	list_for_each(ptr, &dma_list) {
+		dma = list_entry(ptr, struct dma_object, list);
+		if (strcmp(path, dma->path) == 0) {
+			dma->ssi_stx_phys = ssi_stx_phys;
+			dma->ssi_srx_phys = ssi_srx_phys;
+			return &dma->dai;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(fsl_soc_dma_to_dai);
+
 static struct snd_pcm_ops fsl_dma_ops = {
 	.open   	= fsl_dma_open,
 	.close  	= fsl_dma_close,
@@ -823,59 +838,93 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.pointer	= fsl_dma_pointer,
 };
 
-struct snd_soc_platform fsl_soc_platform = {
-	.name   	= "fsl-dma",
-	.pcm_ops	= &fsl_dma_ops,
-	.pcm_new	= fsl_dma_new,
-	.pcm_free       = fsl_dma_free_dma_buffers,
-};
-EXPORT_SYMBOL_GPL(fsl_soc_platform);
+static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
+				       const struct of_device_id *match)
+ {
+	struct dma_object *dma;
+	struct device_node *np = of_dev->dev.of_node;
+	int ret;
 
-/**
- * fsl_dma_configure: store the DMA parameters from the fabric driver.
- *
- * This function is called by the ASoC fabric driver to give us the DMA and
- * SSI channel information.
- *
- * Unfortunately, ASoC V1 does make it possible to determine the DMA/SSI
- * data when a substream is created, so for now we need to store this data
- * into a global variable.  This means that we can only support one DMA
- * controller, and hence only one SSI.
- */
-int fsl_dma_configure(struct fsl_dma_info *dma_info)
+	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
+	if (!dma) {
+		dev_err(&of_dev->dev, "could not allocate dma object\n");
+		return -ENOMEM;
+	}
+
+	strcpy(dma->path, np->full_name);
+	dma->dai.name = dma->path;
+	dma->dai.ops = &fsl_dma_ops;
+	dma->dai.pcm_new = fsl_dma_new;
+	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
+
+	ret = snd_soc_register_platform(&of_dev->dev, 0, &dma->dai);
+	if (ret) {
+		dev_err(&of_dev->dev, "could not register platform\n");
+		kfree(dma);
+		return ret;
+	}
+
+	dma->channel = of_iomap(np, 0);
+	dma->irq = irq_of_parse_and_map(np, 0);
+	list_add(&dma->list, &dma_list);
+
+	return 0;
+}
+
+static int __devexit fsl_soc_dma_remove(struct of_device *of_dev)
 {
-	static int initialized;
+	struct list_head *n, *ptr;
+	struct dma_object *dma;
 
-	/* We only support one DMA controller for now */
-	if (initialized)
-		return 0;
+	list_for_each_safe(ptr, n, &dma_list) {
+		dma = list_entry(ptr, struct dma_object, list);
+		list_del_init(ptr);
 
-	dma_global_data.ssi_stx_phys = dma_info->ssi_stx_phys;
-	dma_global_data.ssi_srx_phys = dma_info->ssi_srx_phys;
-	dma_global_data.dma_channel[0] = dma_info->dma_channel[0];
-	dma_global_data.dma_channel[1] = dma_info->dma_channel[1];
-	dma_global_data.irq[0] = dma_info->dma_irq[0];
-	dma_global_data.irq[1] = dma_info->dma_irq[1];
-	dma_global_data.assigned[0] = 0;
-	dma_global_data.assigned[1] = 0;
-
-	initialized = 1;
-	return 1;
+		snd_soc_unregister_platform(&of_dev->dev, 0);
+		iounmap(dma->channel);
+		irq_dispose_mapping(dma->irq);
+		kfree(dma);
+	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_dma_configure);
 
-static int __init fsl_soc_platform_init(void)
+static const struct of_device_id fsl_soc_dma_ids[] = {
+	{ .compatible = "fsl,ssi-dma-channel", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_soc_dma_ids);
+
+static struct of_platform_driver fsl_soc_dma_driver = {
+	.driver = {
+		.name = "fsl-soc-dma-dai",
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_soc_dma_ids,
+	},
+	.probe = fsl_soc_dma_probe,
+	.remove = __devexit_p(fsl_soc_dma_remove),
+};
+
+static int __init fsl_soc_dma_init(void)
 {
-	return snd_soc_register_platform(&fsl_soc_platform);
+	pr_info("Freescale Elo DMA ASoC PCM Driver\n");
+
+	return of_register_platform_driver(&fsl_soc_dma_driver);
 }
-module_init(fsl_soc_platform_init);
 
-static void __exit fsl_soc_platform_exit(void)
+static void __exit fsl_soc_dma_exit(void)
 {
-	snd_soc_unregister_platform(&fsl_soc_platform);
+	of_unregister_platform_driver(&fsl_soc_dma_driver);
 }
-module_exit(fsl_soc_platform_exit);
+
+/* We want the DMA driver to be initialized before the SSI driver, so that
+ * when the SSI driver calls fsl_soc_dma_dai_from_node(), the DMA driver
+ * will already have been probed.  The easiest way to do that is to make the
+ * __init function called via arch_initcall().
+ */
+arch_initcall(fsl_soc_dma_init);
+module_exit(fsl_soc_dma_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM module");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 385d4a4..88c686d 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -126,24 +126,9 @@ struct fsl_dma_link_descriptor {
 	u8 res[4];      /* Reserved */
 } __attribute__ ((aligned(32), packed));
 
-/* DMA information needed to create a snd_soc_dai object
- *
- * ssi_stx_phys: bus address of SSI STX register to use
- * ssi_srx_phys: bus address of SSI SRX register to use
- * dma[0]: points to the DMA channel to use for playback
- * dma[1]: points to the DMA channel to use for capture
- * dma_irq[0]: IRQ of the DMA channel to use for playback
- * dma_irq[1]: IRQ of the DMA channel to use for capture
- */
-struct fsl_dma_info {
-	dma_addr_t ssi_stx_phys;
-	dma_addr_t ssi_srx_phys;
-	struct ccsr_dma_channel __iomem *dma_channel[2];
-	unsigned int dma_irq[2];
-};
-
-extern struct snd_soc_platform fsl_soc_platform;
+extern struct snd_soc_platform_driver fsl_soc_platform;
 
-int fsl_dma_configure(struct fsl_dma_info *dma_info);
+struct snd_soc_platform_driver *fsl_soc_dma_to_dai(const char *path,
+	dma_addr_t ssi_stx_phys, dma_addr_t ssi_srx_phys);
 
 #endif
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 762c1b8..31e8e5c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -3,10 +3,11 @@
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  */
 
 #include <linux/init.h>
@@ -15,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of_platform.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -71,33 +73,31 @@
 /**
  * fsl_ssi_private: per-SSI private data
  *
- * @name: short name for this device ("SSI0", "SSI1", etc)
  * @ssi: pointer to the SSI's registers
  * @ssi_phys: physical address of the SSI registers
  * @irq: IRQ of this SSI
  * @first_stream: pointer to the stream that was opened first
  * @second_stream: pointer to second stream
- * @dev: struct device pointer
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
  * @asynchronous: 0=synchronous mode, 1=asynchronous mode
  * @cpu_dai: the CPU DAI for this device
  * @dev_attr: the sysfs device attribute structure
  * @stats: SSI statistics
+ * @name: name for this device
  */
 struct fsl_ssi_private {
-	char name[8];
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	struct snd_pcm_substream *first_stream;
 	struct snd_pcm_substream *second_stream;
-	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
 	int asynchronous;
-	struct snd_soc_dai cpu_dai;
+	struct snd_soc_dai_driver cpu_dai_drv;
 	struct device_attribute dev_attr;
+	struct platform_device *pdev;
 
 	struct {
 		unsigned int rfrc;
@@ -122,6 +122,8 @@ struct fsl_ssi_private {
 		unsigned int tfe1;
 		unsigned int tfe0;
 	} stats;
+
+	char name[1];
 };
 
 /**
@@ -280,7 +282,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
 	/*
 	 * If this is the first stream opened, then request the IRQ
@@ -290,8 +292,10 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 		int ret;
 
+		/* The 'name' should not have any slashes in it. */
 		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
-				  ssi_private->name, ssi_private);
+				  strrchr(ssi_private->name, '/') + 1,
+				  ssi_private);
 		if (ret < 0) {
 			dev_err(substream->pcm->card->dev,
 				"could not claim irq %u\n", ssi_private->irq);
@@ -422,7 +426,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
 {
-	struct fsl_ssi_private *ssi_private = cpu_dai->private_data;
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 
 	if (substream == ssi_private->first_stream) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -458,7 +462,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 	switch (cmd) {
@@ -497,7 +501,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		ssi_private->playback--;
@@ -523,56 +527,15 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	}
 }
 
-/**
- * fsl_ssi_set_sysclk: set the clock frequency and direction
- *
- * This function is called by the machine driver to tell us what the clock
- * frequency and direction are.
- *
- * Currently, we only support operating as a clock slave (SND_SOC_CLOCK_IN),
- * and we don't care about the frequency.  Return an error if the direction
- * is not SND_SOC_CLOCK_IN.
- *
- * @clk_id: reserved, should be zero
- * @freq: the frequency of the given clock ID, currently ignored
- * @dir: SND_SOC_CLOCK_IN (clock slave) or SND_SOC_CLOCK_OUT (clock master)
- */
-static int fsl_ssi_set_sysclk(struct snd_soc_dai *cpu_dai,
-			      int clk_id, unsigned int freq, int dir)
-{
-
-	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
-}
-
-/**
- * fsl_ssi_set_fmt: set the serial format.
- *
- * This function is called by the machine driver to tell us what serial
- * format to use.
- *
- * Currently, we only support I2S mode.  Return an error if the format is
- * not SND_SOC_DAIFMT_I2S.
- *
- * @format: one of SND_SOC_DAIFMT_xxx
- */
-static int fsl_ssi_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
-{
-	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
-}
-
-/**
- * fsl_ssi_dai_template: template CPU DAI for the SSI
- */
 static struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
 	.hw_params	= fsl_ssi_hw_params,
 	.shutdown	= fsl_ssi_shutdown,
 	.trigger	= fsl_ssi_trigger,
-	.set_sysclk	= fsl_ssi_set_sysclk,
-	.set_fmt	= fsl_ssi_set_fmt,
 };
 
-static struct snd_soc_dai fsl_ssi_dai_template = {
+/* Template for the CPU dai driver structure */
+static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.playback = {
 		/* The SSI does not support monaural audio. */
 		.channels_min = 2,
@@ -640,95 +603,170 @@ static ssize_t fsl_sysfs_ssi_show(struct device *dev,
 }
 
 /**
- * fsl_ssi_create_dai: create a snd_soc_dai structure
- *
- * This function is called by the machine driver to create a snd_soc_dai
- * structure.  The function creates an ssi_private object, which contains
- * the snd_soc_dai.  It also creates the sysfs statistics device.
+ * Make every character in a string lower-case
  */
-struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
+static void make_lowercase(char *s)
+{
+	char *p = s;
+	char c;
+
+	while ((c = *p)) {
+		if ((c >= 'A') && (c <= 'Z'))
+			*p = c + ('a' - 'A');
+		p++;
+	}
+}
+
+static int __devinit fsl_ssi_probe(struct of_device *of_dev,
+				   const struct of_device_id *match)
 {
-	struct snd_soc_dai *fsl_ssi_dai;
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
 	struct device_attribute *dev_attr;
+	struct device_node *np = of_dev->dev.of_node;
+	const char *sprop;
+	struct resource res;
+	char name[64];
+	struct platform_device *pdev;
+	void *platform_data;
+
+	/* We are only interested in SSIs with a codec phandle in them, so let's
+	 * make sure this SSI has one.
+	 */
+	if (!of_get_property(np, "codec-handle", NULL))
+		return -ENODEV;
+
+	/* We only support the SSI in "I2S Slave" mode */
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (!sprop || strcmp(sprop, "i2s-slave")) {
+		dev_notice(&of_dev->dev, "mode %s is unsupported\n", sprop);
+		return -ENODEV;
+	}
 
-	ssi_private = kzalloc(sizeof(struct fsl_ssi_private), GFP_KERNEL);
+	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) +
+			      strlen(np->full_name), GFP_KERNEL);
 	if (!ssi_private) {
-		dev_err(ssi_info->dev, "could not allocate DAI object\n");
-		return NULL;
+		dev_err(&of_dev->dev, "could not allocate DAI object\n");
+		return -ENOMEM;
 	}
-	memcpy(&ssi_private->cpu_dai, &fsl_ssi_dai_template,
-	       sizeof(struct snd_soc_dai));
 
-	fsl_ssi_dai = &ssi_private->cpu_dai;
-	dev_attr = &ssi_private->dev_attr;
+	/* Initialize this copy of the CPU DAI driver structure */
+	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
+	       sizeof(fsl_ssi_dai_template));
+	ssi_private->cpu_dai_drv.name = ssi_private->name;
 
-	sprintf(ssi_private->name, "ssi%u", (u8) ssi_info->id);
-	ssi_private->ssi = ssi_info->ssi;
-	ssi_private->ssi_phys = ssi_info->ssi_phys;
-	ssi_private->irq = ssi_info->irq;
-	ssi_private->dev = ssi_info->dev;
-	ssi_private->asynchronous = ssi_info->asynchronous;
+	/* The name we register with ASoC is the full node name */
+	strlcpy(ssi_private->name, np->full_name, sizeof(ssi_private->name));
 
-	dev_set_drvdata(ssi_private->dev, fsl_ssi_dai);
+	/* Get the addresses and IRQ */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(&of_dev->dev, "could not determine device resources\n");
+		kfree(ssi_private);
+		return ret;
+	}
+	ssi_private->ssi = ioremap(res.start, 1 + res.end - res.start);
+	ssi_private->ssi_phys = res.start;
+	ssi_private->irq = irq_of_parse_and_map(np, 0);
+
+	/* Are the RX and the TX clocks locked? */
+	if (of_find_property(np, "fsl,ssi-asynchronous", NULL))
+		ssi_private->asynchronous = 1;
+	else
+		ssi_private->cpu_dai_drv.symmetric_rates = 1;
 
 	/* Initialize the the device_attribute structure */
-	dev_attr->attr.name = "ssi-stats";
+	dev_attr = &ssi_private->dev_attr;
+	dev_attr->attr.name = "statistics";
 	dev_attr->attr.mode = S_IRUGO;
 	dev_attr->show = fsl_sysfs_ssi_show;
 
-	ret = device_create_file(ssi_private->dev, dev_attr);
+	ret = device_create_file(&of_dev->dev, dev_attr);
 	if (ret) {
-		dev_err(ssi_info->dev, "could not create sysfs %s file\n",
+		dev_err(&of_dev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
-		kfree(fsl_ssi_dai);
-		return NULL;
+		kfree(ssi_private);
+		return ret;
 	}
 
-	fsl_ssi_dai->private_data = ssi_private;
-	fsl_ssi_dai->name = ssi_private->name;
-	fsl_ssi_dai->id = ssi_info->id;
-	fsl_ssi_dai->dev = ssi_info->dev;
-	fsl_ssi_dai->symmetric_rates = 1;
+	/* Register with ASoC */
+	dev_set_drvdata(&of_dev->dev, ssi_private);
 
-	ret = snd_soc_register_dai(fsl_ssi_dai);
+	ret = snd_soc_register_dai(&of_dev->dev, 0, &ssi_private->cpu_dai_drv);
 	if (ret != 0) {
-		dev_err(ssi_info->dev, "failed to register DAI: %d\n", ret);
-		kfree(fsl_ssi_dai);
-		return NULL;
+		dev_err(&of_dev->dev, "failed to register DAI: %d\n", ret);
+		kfree(ssi_private);
+		return ret;
 	}
 
-	return fsl_ssi_dai;
+	/* Trigger the machine driver's probe function.  The platform driver
+	 * name of the machine driver is taken from the /model node of the
+	 * device tree.  We also pass the address of the CPU DAI driver
+	 * structure.
+	 */
+	sprop = of_get_property(of_find_node_by_path("/"), "model", NULL);
+	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
+	make_lowercase(name);
+
+	platform_data = &ssi_private->cpu_dai_drv;
+	pdev = platform_device_register_data(&of_dev->dev, name, -1,
+		&platform_data, sizeof(void *));
+
+	ssi_private->pdev = pdev;
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_ssi_create_dai);
 
 /**
  * fsl_ssi_destroy_dai: destroy the snd_soc_dai object
  *
- * This function undoes the operations of fsl_ssi_create_dai()
+ * This function undoes the operations of fsl_ssi_probe()
  */
-void fsl_ssi_destroy_dai(struct snd_soc_dai *fsl_ssi_dai)
+static int fsl_ssi_remove(struct of_device *of_dev)
 {
-	struct fsl_ssi_private *ssi_private =
-	container_of(fsl_ssi_dai, struct fsl_ssi_private, cpu_dai);
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&of_dev->dev);
 
-	device_remove_file(ssi_private->dev, &ssi_private->dev_attr);
-
-	snd_soc_unregister_dai(&ssi_private->cpu_dai);
+	platform_device_unregister(ssi_private->pdev);
+	snd_soc_unregister_dai(&of_dev->dev, 0);
+	device_remove_file(&of_dev->dev, &ssi_private->dev_attr);
 
 	kfree(ssi_private);
+	dev_set_drvdata(&of_dev->dev, NULL);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_ssi_destroy_dai);
+
+static const struct of_device_id fsl_ssi_ids[] = {
+	{ .compatible = "fsl,mpc8610-ssi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
+
+static struct of_platform_driver fsl_ssi_driver = {
+	.driver = {
+		.name = "fsl-ssi-dai",
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_ssi_ids,
+	},
+	.probe = fsl_ssi_probe,
+	.remove = fsl_ssi_remove,
+};
 
 static int __init fsl_ssi_init(void)
 {
 	printk(KERN_INFO "Freescale Synchronous Serial Interface (SSI) ASoC Driver\n");
 
-	return 0;
+	return of_register_platform_driver(&fsl_ssi_driver);
+}
+
+static void __exit fsl_ssi_exit(void)
+{
+	of_unregister_platform_driver(&fsl_ssi_driver);
 }
+
 module_init(fsl_ssi_init);
+module_exit(fsl_ssi_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index eade01f..2173000 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -196,31 +196,5 @@ struct ccsr_ssi {
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
-struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info);
-void fsl_ssi_destroy_dai(struct snd_soc_dai *fsl_ssi_dai);
-
 #endif
 
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 1d4e716..ddebde8 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -9,6 +9,8 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <sound/soc.h>
 
@@ -107,7 +109,7 @@ static int psc_dma_hw_free(struct snd_pcm_substream *substream)
 static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
@@ -212,7 +214,7 @@ static int psc_dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct psc_dma_stream *s;
 	int rc;
 
@@ -239,7 +241,7 @@ static int psc_dma_open(struct snd_pcm_substream *substream)
 static int psc_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct psc_dma_stream *s;
 
 	dev_dbg(psc_dma->dev, "psc_dma_close(substream=%p)\n", substream);
@@ -264,7 +266,7 @@ static snd_pcm_uframes_t
 psc_dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct psc_dma_stream *s;
 	dma_addr_t count;
 
@@ -302,11 +304,11 @@ static int psc_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 			   struct snd_pcm *pcm)
 {
 	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	size_t size = psc_dma_hardware.buffer_bytes_max;
 	int rc = 0;
 
-	dev_dbg(rtd->socdev->dev, "psc_dma_new(card=%p, dai=%p, pcm=%p)\n",
+	dev_dbg(rtd->platform->dev, "psc_dma_new(card=%p, dai=%p, pcm=%p)\n",
 		card, dai, pcm);
 
 	if (!card->dev->dma_mask)
@@ -328,8 +330,8 @@ static int psc_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 			goto capture_alloc_err;
 	}
 
-	if (rtd->socdev->card->codec->ac97)
-		rtd->socdev->card->codec->ac97->private_data = psc_dma;
+	if (rtd->codec->ac97)
+		rtd->codec->ac97->private_data = psc_dma;
 
 	return 0;
 
@@ -349,7 +351,7 @@ static void psc_dma_free(struct snd_pcm *pcm)
 	struct snd_pcm_substream *substream;
 	int stream;
 
-	dev_dbg(rtd->socdev->dev, "psc_dma_free(pcm=%p)\n", pcm);
+	dev_dbg(rtd->platform->dev, "psc_dma_free(pcm=%p)\n", pcm);
 
 	for (stream = 0; stream < 2; stream++) {
 		substream = pcm->streams[stream].substream;
@@ -361,15 +363,16 @@ static void psc_dma_free(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform mpc5200_audio_dma_platform = {
+struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
 	.name		= "mpc5200-psc-audio",
-	.pcm_ops	= &psc_dma_ops,
+	.ops		= &psc_dma_ops,
 	.pcm_new	= &psc_dma_new,
 	.pcm_free	= &psc_dma_free,
 };
 EXPORT_SYMBOL_GPL(mpc5200_audio_dma_platform);
 
-int mpc5200_audio_dma_create(struct of_device *op)
+static int mpc5200_hpcd_probe(struct of_device *op,
+		const struct of_device_id *match)
 {
 	phys_addr_t fifo;
 	struct psc_dma *psc_dma;
@@ -475,7 +478,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
 	dev_set_drvdata(&op->dev, psc_dma);
 
 	/* Tell the ASoC OF helpers about it */
-	return snd_soc_register_platform(&mpc5200_audio_dma_platform);
+	return snd_soc_register_platform(&op->dev, -1, &mpc5200_audio_dma_platform);
 out_irq:
 	free_irq(psc_dma->irq, psc_dma);
 	free_irq(psc_dma->capture.irq, &psc_dma->capture);
@@ -486,15 +489,14 @@ out_unmap:
 	iounmap(regs);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mpc5200_audio_dma_create);
 
-int mpc5200_audio_dma_destroy(struct of_device *op)
+static int mpc5200_hpcd_remove(struct of_device *op)
 {
 	struct psc_dma *psc_dma = dev_get_drvdata(&op->dev);
 
 	dev_dbg(&op->dev, "mpc5200_audio_dma_destroy()\n");
 
-	snd_soc_unregister_platform(&mpc5200_audio_dma_platform);
+	snd_soc_unregister_platform(&op->dev, -1);
 
 	bcom_gen_bd_rx_release(psc_dma->capture.bcom_task);
 	bcom_gen_bd_tx_release(psc_dma->playback.bcom_task);
@@ -510,7 +512,35 @@ int mpc5200_audio_dma_destroy(struct of_device *op)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mpc5200_audio_dma_destroy);
+
+static struct of_device_id mpc5200_hpcd_match[] = {
+	{
+		.compatible = "fsl,mpc5200-pcm",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpc5200_hpcd_match);
+
+static struct of_platform_driver mpc5200_hpcd_of_driver = {
+	.owner  	= THIS_MODULE,
+	.name   	= "mpc5200_hpcd",
+	.match_table    = mpc5200_hpcd_match,
+	.probe  	= mpc5200_hpcd_probe,
+	.remove 	= mpc5200_hpcd_remove,
+};
+
+static int __init mpc5200_hpcd_init(void)
+{
+	return of_register_platform_driver(&mpc5200_hpcd_of_driver);
+}
+
+static void __exit mpc5200_hpcd_exit(void)
+{
+	of_unregister_platform_driver(&mpc5200_hpcd_of_driver);
+}
+
+module_init(mpc5200_hpcd_init);
+module_exit(mpc5200_hpcd_exit);
 
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_DESCRIPTION("Freescale MPC5200 PSC in DMA mode ASoC Driver");
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index 22208b3..4b42969 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -81,9 +81,6 @@ to_psc_dma_stream(struct snd_pcm_substream *substream, struct psc_dma *psc_dma)
 	return &psc_dma->playback;
 }
 
-int mpc5200_audio_dma_create(struct of_device *op);
-int mpc5200_audio_dma_destroy(struct of_device *op);
-
-extern struct snd_soc_platform mpc5200_audio_dma_platform;
+extern struct snd_soc_platform_driver mpc5200_audio_dma_platform;
 
 #endif /* __SOUND_SOC_FSL_MPC5200_DMA_H__ */
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index e2ee220..8e754ef 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -129,7 +129,7 @@ static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *cpu_dai)
 {
-	struct psc_dma *psc_dma = cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(cpu_dai);
 	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 
 	dev_dbg(psc_dma->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
@@ -152,7 +152,7 @@ static int psc_ac97_hw_digital_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *cpu_dai)
 {
-	struct psc_dma *psc_dma = cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(cpu_dai);
 
 	dev_dbg(psc_dma->dev, "%s(substream=%p)\n", __func__, substream);
 
@@ -167,8 +167,7 @@ static int psc_ac97_hw_digital_params(struct snd_pcm_substream *substream,
 static int psc_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 							struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(dai);
 	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 
 	switch (cmd) {
@@ -193,10 +192,9 @@ static int psc_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int psc_ac97_probe(struct platform_device *pdev,
-					struct snd_soc_dai *cpu_dai)
+static int psc_ac97_probe(struct snd_soc_dai *cpu_dai)
 {
-	struct psc_dma *psc_dma = cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(cpu_dai);
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
 	/* Go */
@@ -223,7 +221,7 @@ static struct snd_soc_dai_ops psc_ac97_digital_ops = {
 	.hw_params	= psc_ac97_hw_digital_params,
 };
 
-struct snd_soc_dai psc_ac97_dai[] = {
+struct snd_soc_dai_driver psc_ac97_dai[] = {
 {
 	.name   = "AC97",
 	.ac97_control = 1,
@@ -266,18 +264,11 @@ EXPORT_SYMBOL_GPL(psc_ac97_dai);
 static int __devinit psc_ac97_of_probe(struct of_device *op,
 				      const struct of_device_id *match)
 {
-	int rc, i;
+	int rc;
 	struct snd_ac97 ac97;
 	struct mpc52xx_psc __iomem *regs;
 
-	rc = mpc5200_audio_dma_create(op);
-	if (rc != 0)
-		return rc;
-
-	for (i = 0; i < ARRAY_SIZE(psc_ac97_dai); i++)
-		psc_ac97_dai[i].dev = &op->dev;
-
-	rc = snd_soc_register_dais(psc_ac97_dai, ARRAY_SIZE(psc_ac97_dai));
+	rc = snd_soc_register_dais(&op->dev, psc_ac97_dai, ARRAY_SIZE(psc_ac97_dai));
 	if (rc != 0) {
 		dev_err(&op->dev, "Failed to register DAI\n");
 		return rc;
@@ -287,9 +278,6 @@ static int __devinit psc_ac97_of_probe(struct of_device *op,
 	regs = psc_dma->psc_regs;
 	ac97.private_data = psc_dma;
 
-	for (i = 0; i < ARRAY_SIZE(psc_ac97_dai); i++)
-		psc_ac97_dai[i].private_data = psc_dma;
-
 	psc_dma->imr = 0;
 	out_be16(&psc_dma->psc_regs->isr_imr.imr, psc_dma->imr);
 
@@ -305,7 +293,8 @@ static int __devinit psc_ac97_of_probe(struct of_device *op,
 
 static int __devexit psc_ac97_of_remove(struct of_device *op)
 {
-	return mpc5200_audio_dma_destroy(op);
+	snd_soc_unregister_dais(&op->dev, ARRAY_SIZE(psc_ac97_dai));
+	return 0;
 }
 
 /* Match table for of_platform binding */
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.h b/sound/soc/fsl/mpc5200_psc_ac97.h
index 4bc18c3..89f2dff 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.h
+++ b/sound/soc/fsl/mpc5200_psc_ac97.h
@@ -7,7 +7,7 @@
 #ifndef __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__
 #define __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__
 
-extern struct snd_soc_dai psc_ac97_dai[];
+extern struct snd_soc_dai_driver psc_ac97_dai[];
 
 #define MPC5200_AC97_NORMAL 0
 #define MPC5200_AC97_SPDIF 1
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 676841c..16eee4c 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -40,7 +40,7 @@ static int psc_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	u32 mode;
 
 	dev_dbg(psc_dma->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
@@ -88,7 +88,7 @@ static int psc_i2s_hw_params(struct snd_pcm_substream *substream,
 static int psc_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 			      int clk_id, unsigned int freq, int dir)
 {
-	struct psc_dma *psc_dma = cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(cpu_dai);
 	dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(cpu_dai=%p, dir=%i)\n",
 				cpu_dai, dir);
 	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
@@ -107,7 +107,7 @@ static int psc_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
  */
 static int psc_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
 {
-	struct psc_dma *psc_dma = cpu_dai->private_data;
+	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(cpu_dai);
 	dev_dbg(psc_dma->dev, "psc_i2s_set_fmt(cpu_dai=%p, format=%i)\n",
 				cpu_dai, format);
 	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
@@ -129,7 +129,7 @@ static struct snd_soc_dai_ops psc_i2s_dai_ops = {
 	.set_fmt	= psc_i2s_set_fmt,
 };
 
-struct snd_soc_dai psc_i2s_dai[] = {{
+struct snd_soc_dai_driver psc_i2s_dai[] = {{
 	.name   = "I2S",
 	.playback = {
 		.channels_min = 2,
@@ -159,11 +159,7 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 	struct psc_dma *psc_dma;
 	struct mpc52xx_psc __iomem *regs;
 
-	rc = mpc5200_audio_dma_create(op);
-	if (rc != 0)
-		return rc;
-
-	rc = snd_soc_register_dais(psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
+	rc = snd_soc_register_dais(&op->dev, psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
 	if (rc != 0) {
 		pr_err("Failed to register DAI\n");
 		return 0;
@@ -207,7 +203,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 
 static int __devexit psc_i2s_of_remove(struct of_device *op)
 {
-	return mpc5200_audio_dma_destroy(op);
+	snd_soc_unregister_dais(&op->dev, ARRAY_SIZE(psc_i2s_dai));
+	return 0;
 }
 
 /* Match table for of_platform binding */
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 6a2764e..81ab639 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,19 +1,18 @@
 /**
- * Freescale MPC8610HPCD ALSA SoC Fabric driver
+ * Freescale MPC8610HPCD ALSA SoC Machine driver
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  */
 
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <sound/soc.h>
 #include <asm/immap_86xx.h>
 
@@ -21,65 +20,74 @@
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
 
+/* There's only one global utilities register */
+static phys_addr_t guts_phys;
+
 /**
- * mpc8610_hpcd_data: fabric-specific ASoC device data
+ * mpc8610_hpcd_data: machine-specific ASoC device data
  *
  * This structure contains data for a single sound platform device on an
  * MPC8610 HPCD.  Some of the data is taken from the device tree.
  */
 struct mpc8610_hpcd_data {
-	struct snd_soc_device sound_devdata;
-	struct snd_soc_dai_link dai;
-	struct snd_soc_card machine;
+	struct snd_soc_dai_link dai[2];
+	struct snd_soc_card card;
 	unsigned int dai_format;
 	unsigned int codec_clk_direction;
 	unsigned int cpu_clk_direction;
 	unsigned int clk_frequency;
-	struct ccsr_guts __iomem *guts;
-	struct ccsr_ssi __iomem *ssi;
-	unsigned int ssi_id;    	/* 0 = SSI1, 1 = SSI2, etc */
-	unsigned int ssi_irq;
-	unsigned int dma_id;    	/* 0 = DMA1, 1 = DMA2, etc */
-	unsigned int dma_irq[2];
-	struct ccsr_dma_channel __iomem *dma[2];
+	unsigned int ssi_id;		/* 0 = SSI1, 1 = SSI2, etc */
+	unsigned int dma_id[0];		/* 0 = DMA1, 1 = DMA2, etc */
 	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
+	char dai_name[32];
 };
 
 /**
- * mpc8610_hpcd_machine_probe: initalize the board
+ * mpc8610_hpcd_machine_probe: initialize the board
  *
- * This function is called when platform_device_add() is called.  It is used
- * to initialize the board-specific hardware.
+ * This function is used to initialize the board-specific hardware.
  *
  * Here we program the DMACR and PMUXCR registers.
  */
 static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
 {
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
+		container_of(card, struct mpc8610_hpcd_data, card);
+	struct ccsr_guts __iomem *guts;
 
-	/* Program the signal routing between the SSI and the DMA */
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
+	if (!guts) {
+		dev_err(card->dev, "could not map global utilities\n");
+		return -ENOMEM;
+	}
 
-	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], 0);
-	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], 0);
+	/* Program the signal routing between the SSI and the DMA */
+	guts_set_dmacr(guts, machine_data->dma_id[0],
+		       machine_data->dma_channel_id[0],
+		       CCSR_GUTS_DMACR_DEV_SSI);
+	guts_set_dmacr(guts, machine_data->dma_id[1],
+		       machine_data->dma_channel_id[1],
+		       CCSR_GUTS_DMACR_DEV_SSI);
+
+	guts_set_pmuxcr_dma(guts, machine_data->dma_id[0],
+			    machine_data->dma_channel_id[0], 0);
+	guts_set_pmuxcr_dma(guts, machine_data->dma_id[1],
+			    machine_data->dma_channel_id[1], 0);
 
 	switch (machine_data->ssi_id) {
 	case 0:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
+		clrsetbits_be32(&guts->pmuxcr,
 			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
 		break;
 	case 1:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
+		clrsetbits_be32(&guts->pmuxcr,
 			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
 		break;
 	}
 
+	iounmap(guts);
+
 	return 0;
 }
 
@@ -93,38 +101,15 @@ static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
 static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct mpc8610_hpcd_data *machine_data =
-		rtd->socdev->dev->platform_data;
+		container_of(rtd->card, struct mpc8610_hpcd_data, card);
+	struct device *dev = rtd->card->dev;
 	int ret = 0;
 
-	/* Tell the CPU driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver audio format\n");
-		return ret;
-	}
-
 	/* Tell the codec driver what the serial protocol is. */
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
+	ret = snd_soc_dai_set_fmt(rtd->codec_dai, machine_data->dai_format);
 	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver clock parameters\n");
+		dev_err(dev, "could not set codec driver audio format\n");
 		return ret;
 	}
 
@@ -132,12 +117,11 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	 * Tell the codec driver what the MCLK frequency is, and whether it's
 	 * a slave or master.
 	 */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-					machine_data->clk_frequency,
-					machine_data->codec_clk_direction);
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, 0,
+				     machine_data->clk_frequency,
+				     machine_data->codec_clk_direction);
 	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set codec driver clock params\n");
+		dev_err(dev, "could not set codec driver clock params\n");
 		return ret;
 	}
 
@@ -150,116 +134,211 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
  * This function is called to remove the sound device for one SSI.  We
  * de-program the DMACR and PMUXCR register.
  */
-int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
+static int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
 {
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
+		container_of(card, struct mpc8610_hpcd_data, card);
+	struct ccsr_guts __iomem *guts;
+
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
+	if (!guts) {
+		dev_err(card->dev, "could not map global utilities\n");
+		return -ENOMEM;
+	}
 
 	/* Restore the signal routing */
 
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], 0);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], 0);
+	guts_set_dmacr(guts, machine_data->dma_id[0],
+		       machine_data->dma_channel_id[0], 0);
+	guts_set_dmacr(guts, machine_data->dma_id[1],
+		       machine_data->dma_channel_id[1], 0);
 
 	switch (machine_data->ssi_id) {
 	case 0:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
+		clrsetbits_be32(&guts->pmuxcr,
 			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
 		break;
 	case 1:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
+		clrsetbits_be32(&guts->pmuxcr,
 			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_LA);
 		break;
 	}
 
+	iounmap(guts);
+
 	return 0;
 }
 
 /**
- * mpc8610_hpcd_ops: ASoC fabric driver operations
+ * mpc8610_hpcd_ops: ASoC machine driver operations
  */
 static struct snd_soc_ops mpc8610_hpcd_ops = {
 	.startup = mpc8610_hpcd_startup,
 };
 
 /**
- * mpc8610_hpcd_probe: OF probe function for the fabric driver
+ * get_node_by_phandle_name - get a node by its phandle name
  *
- * This function gets called when an SSI node is found in the device tree.
+ * This function takes a node, the name of a property in that node, and a
+ * compatible string.  Assuming the property is a phandle to another node,
+ * it returns that node, (optionally) if that node is compatible.
  *
- * Although this is a fabric driver, the SSI node is the "master" node with
- * respect to audio hardware connections.  Therefore, we create a new ASoC
- * device for each new SSI node that has a codec attached.
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
+ * get_parent_cell_index -- return the cell-index of the parent of a node
  *
- * FIXME: Currently, we only support one DMA controller, so if there are
- * multiple SSI nodes with codecs, only the first will be supported.
+ * Return the value of the cell-index property of the parent of the given
+ * node.  This is used for DMA channel nodes that need to know the DMA ID
+ * of the controller they are on.
+ */
+static int get_parent_cell_index(struct device_node *np)
+{
+	struct device_node *parent = of_get_parent(np);
+	const u32 *iprop;
+
+	if (!parent)
+		return -1;
+
+	iprop = of_get_property(parent, "cell-index", NULL);
+	of_node_put(parent);
+
+	if (!iprop)
+		return -1;
+
+	return *iprop;
+}
+
+static int get_dma_channel(struct device_node *ssi_np,
+			   const char *compatible,
+			   dma_addr_t ssi_stx_phys,
+			   dma_addr_t ssi_srx_phys,
+			   struct snd_soc_dai_link *dai,
+			   unsigned int *dma_channel_id,
+			   unsigned int *dma_id)
+{
+	struct device_node *dma_channel_np;
+	const u32 *iprop;
+
+	dma_channel_np = get_node_by_phandle_name(ssi_np, compatible,
+						  "fsl,ssi-dma-channel");
+	if (!dma_channel_np)
+		return -EINVAL;
+
+	dai->platform_drv = fsl_soc_dma_to_dai(dma_channel_np->full_name,
+					       ssi_stx_phys, ssi_srx_phys);
+
+	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
+	if (!iprop) {
+		of_node_put(dma_channel_np);
+		return -EINVAL;
+	}
+
+	*dma_channel_id = *iprop;
+	*dma_id = get_parent_cell_index(dma_channel_np);
+	of_node_put(dma_channel_np);
+
+	return 0;
+}
+/**
+ * mpc8610_hpcd_probe: platform probe function for the machine driver
  *
- * FIXME: Even if we did support multiple DMA controllers, we have no
- * mechanism for assigning DMA controllers and channels to the individual
- * SSI devices.  We also probably aren't compatible with the generic Elo DMA
- * device driver.
+ * Although this is a machine driver, the SSI node is the "master" node with
+ * respect to audio hardware connections.  Therefore, we create a new ASoC
+ * device for each new SSI node that has a codec attached.
  */
-static int mpc8610_hpcd_probe(struct of_device *ofdev,
-	const struct of_device_id *match)
+static int mpc8610_hpcd_probe(struct platform_device *pdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
+	struct snd_soc_dai_driver **platform_data = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *cpu_dai_drv = *platform_data;
+	struct device *dev = pdev->dev.parent;
+	struct of_device *of_dev = container_of(dev, struct of_device, dev);
+	struct device_node *np = of_dev->dev.of_node;
 	struct device_node *codec_np = NULL;
-	struct device_node *guts_np = NULL;
 	struct device_node *dma_np = NULL;
 	struct device_node *dma_channel_np = NULL;
-	const phandle *codec_ph;
-	const char *sprop;
-	const u32 *iprop;
-	struct resource res;
 	struct platform_device *sound_device = NULL;
 	struct mpc8610_hpcd_data *machine_data;
-	struct fsl_ssi_info ssi_info;
-	struct fsl_dma_info dma_info;
+	int id;
+	dma_addr_t ssi_stx_phys;
+	dma_addr_t ssi_srx_phys;
 	int ret = -ENODEV;
-	unsigned int playback_dma_channel;
-	unsigned int capture_dma_channel;
+	const char *sprop;
+	const u32 *iprop;
+	struct resource res;
+
+	/* We are only interested in SSIs with a codec phandle in them,
+	 * so let's make sure this SSI has one. The MPC8610 HPCD only
+	 * knows about the CS4270 codec, so reject anything else.
+	 */
+	codec_np = get_node_by_phandle_name(np, "codec-handle",
+					    "cirrus,cs4270");
+	if (!codec_np) {
+		dev_err(dev, "invalid codec node\n");
+		return -EINVAL;
+	}
 
 	machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
 	if (!machine_data)
 		return -ENOMEM;
 
-	memset(&ssi_info, 0, sizeof(ssi_info));
-	memset(&dma_info, 0, sizeof(dma_info));
+	machine_data->dai[0].cpu_dai_id = 0;
+	machine_data->dai[0].codec_dai_id = 0;
+	machine_data->dai[0].platform_id = 0;
 
-	ssi_info.dev = &ofdev->dev;
+	machine_data->dai[0].name = machine_data->dai_name;
 
-	/*
-	 * We are only interested in SSIs with a codec phandle in them, so let's
-	 * make sure this SSI has one.
-	 */
-	codec_ph = of_get_property(np, "codec-handle", NULL);
-	if (!codec_ph)
-		goto error;
+	machine_data->dai[0].cpu_dai_drv = cpu_dai_drv;
+	machine_data->dai[0].codec_dai_drv = &cs4270_dai;
+	machine_data->dai[0].codec_drv = &soc_codec_device_cs4270;
+	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
 
-	codec_np = of_find_node_by_phandle(*codec_ph);
-	if (!codec_np)
-		goto error;
+	/* Store the codec name, it will be used as the codec DAI name */
+	of_modalias_node(codec_np, machine_data->dai_name,
+			 sizeof(machine_data->dai_name));
 
-	/* The MPC8610 HPCD only knows about the CS4270 codec, so reject
-	   anything else. */
-	if (!of_device_is_compatible(codec_np, "cirrus,cs4270"))
-		goto error;
+	memcpy(&machine_data->dai[1], &machine_data->dai[0],
+	       sizeof(struct snd_soc_dai_link));
 
 	/* Get the device ID */
 	iprop = of_get_property(np, "cell-index", NULL);
 	if (!iprop) {
-		dev_err(&ofdev->dev, "cell-index property not found\n");
+		dev_err(&pdev->dev, "cell-index property not found\n");
 		ret = -EINVAL;
 		goto error;
 	}
 	machine_data->ssi_id = *iprop;
-	ssi_info.id = *iprop;
+	id = *iprop;
 
 	/* Get the serial format and clock direction. */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop) {
-		dev_err(&ofdev->dev, "fsl,mode property not found\n");
+		dev_err(&pdev->dev, "fsl,mode property not found\n");
 		ret = -EINVAL;
 		goto error;
 	}
@@ -269,15 +348,14 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
-		/*
-		 * In i2s-slave mode, the codec has its own clock source, so we
+		/* In i2s-slave mode, the codec has its own clock source, so we
 		 * need to get the frequency from the device tree and pass it to
 		 * the codec driver.
 		 */
 		iprop = of_get_property(codec_np, "clock-frequency", NULL);
 		if (!iprop || !*iprop) {
-			dev_err(&ofdev->dev, "codec bus-frequency property "
-				"is missing or invalid\n");
+			dev_err(&pdev->dev, "codec bus-frequency "
+				"property is missing or invalid\n");
 			ret = -EINVAL;
 			goto error;
 		}
@@ -311,317 +389,170 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else {
-		dev_err(&ofdev->dev,
-			"unrecognized fsl,mode property \"%s\"\n", sprop);
+		dev_err(&pdev->dev,
+			"unrecognized fsl,mode property '%s'\n", sprop);
 		ret = -EINVAL;
 		goto error;
 	}
 
 	if (!machine_data->clk_frequency) {
-		dev_err(&ofdev->dev, "unknown clock frequency\n");
+		dev_err(&pdev->dev, "unknown clock frequency\n");
 		ret = -EINVAL;
 		goto error;
 	}
 
 	/* Read the SSI information from the device tree */
 	ret = of_address_to_resource(np, 0, &res);
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
+	if (ret || !res.start) {
+		dev_err(&pdev->dev, "could not obtain SSI address\n");
 		goto error;
 	}
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
+	ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
+	ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
+
+	/* Find the playback DMA channel to use. */
+	ret = get_dma_channel(np, "fsl,playback-dma", ssi_stx_phys,
+			      ssi_srx_phys, &machine_data->dai[0],
+			      &machine_data->dma_channel_id[0],
+			      &machine_data->dma_id[0]);
+	if (ret) {
+		dev_err(&pdev->dev, "missing/invalid playback DMA phandle\n");
 		goto error;
 	}
-	machine_data->dma_id = *iprop;
 
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
+	/* Find the capture DMA channel to use. */
+	ret = get_dma_channel(np, "fsl,capture-dma", ssi_stx_phys,
+			      ssi_srx_phys, &machine_data->dai[1],
+			      &machine_data->dma_channel_id[1],
+			      &machine_data->dma_id[1]);
+	if (ret) {
+		dev_err(&pdev->dev, "missing/invalid capture DMA phandle\n");
 		goto error;
 	}
 
-	dma_info.ssi_stx_phys = ssi_info.ssi_phys +
-		offsetof(struct ccsr_ssi, stx0);
-	dma_info.ssi_srx_phys = ssi_info.ssi_phys +
-		offsetof(struct ccsr_ssi, srx0);
-
-	/* We have the DMA information, so tell the DMA driver what it is */
-	if (!fsl_dma_configure(&dma_info)) {
-		dev_err(&ofdev->dev, "could not instantiate DMA device\n");
-		ret = -EBUSY;
+	/* Initialize our DAI data structure.  */
+	iprop = of_get_property(codec_np, "reg", NULL);
+	if (!iprop) {
+		dev_err(&pdev->dev, "codec node is missing 'reg' property\n");
 		goto error;
 	}
+	machine_data->dai[0].codec_id = *iprop;
+	machine_data->dai[1].codec_id = *iprop;
 
-	/*
-	 * Initialize our DAI data structure.  We should probably get this
-	 * information from the device tree.
-	 */
-	machine_data->dai.name = "CS4270";
-	machine_data->dai.stream_name = "CS4270";
-
-	machine_data->dai.cpu_dai = fsl_ssi_create_dai(&ssi_info);
-	machine_data->dai.codec_dai = &cs4270_dai; /* The codec_dai we want */
-	machine_data->dai.ops = &mpc8610_hpcd_ops;
+	machine_data->dai[0].stream_name = "playback";
+	machine_data->dai[1].stream_name = "capture";
 
-	machine_data->machine.probe = mpc8610_hpcd_machine_probe;
-	machine_data->machine.remove = mpc8610_hpcd_machine_remove;
-	machine_data->machine.name = "MPC8610 HPCD";
-	machine_data->machine.num_links = 1;
-	machine_data->machine.dai_link = &machine_data->dai;
+	machine_data->card.probe = mpc8610_hpcd_machine_probe;
+	machine_data->card.remove = mpc8610_hpcd_machine_remove;
+	machine_data->card.name = "MPC8610 HPCD";
+	machine_data->card.num_links = 2;
+	machine_data->card.dai_link = machine_data->dai;
 
 	/* Allocate a new audio platform device structure */
 	sound_device = platform_device_alloc("soc-audio", -1);
 	if (!sound_device) {
-		dev_err(&ofdev->dev, "platform device allocation failed\n");
+		dev_err(&pdev->dev, "platform device alloc failed\n");
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	machine_data->sound_devdata.card = &machine_data->machine;
-	machine_data->sound_devdata.codec_dev = &soc_codec_device_cs4270;
-	machine_data->machine.platform = &fsl_soc_platform;
-
-	sound_device->dev.platform_data = machine_data;
-
-
-	/* Set the platform device and ASoC device to point to each other */
-	platform_set_drvdata(sound_device, &machine_data->sound_devdata);
-
-	machine_data->sound_devdata.dev = &sound_device->dev;
+	/* Associate the card data with the sound device */
+	platform_set_drvdata(sound_device, &machine_data->card);
 
-
-	/* Tell ASoC to probe us.  This will call mpc8610_hpcd_machine.probe(),
-	   if it exists. */
+	/* Register with ASoC */
 	ret = platform_device_add(sound_device);
-
 	if (ret) {
-		dev_err(&ofdev->dev, "platform device add failed\n");
+		dev_err(&pdev->dev, "platform device add failed\n");
 		goto error;
 	}
 
-	dev_set_drvdata(&ofdev->dev, sound_device);
+	of_node_put(codec_np);
 
 	return 0;
 
 error:
 	of_node_put(codec_np);
-	of_node_put(guts_np);
 	of_node_put(dma_np);
 	of_node_put(dma_channel_np);
 
 	if (sound_device)
 		platform_device_unregister(sound_device);
 
-	if (machine_data->dai.cpu_dai)
-		fsl_ssi_destroy_dai(machine_data->dai.cpu_dai);
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
 	kfree(machine_data);
 
 	return ret;
 }
 
 /**
- * mpc8610_hpcd_remove: remove the OF device
+ * mpc8610_hpcd_remove: remove the platform device
  *
- * This function is called when the OF device is removed.
+ * This function is called when the platform device is removed.
  */
-static int mpc8610_hpcd_remove(struct of_device *ofdev)
+static int __devexit mpc8610_hpcd_remove(struct platform_device *pdev)
 {
-	struct platform_device *sound_device = dev_get_drvdata(&ofdev->dev);
+	struct platform_device *sound_device = dev_get_drvdata(&pdev->dev);
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
+		container_of(card, struct mpc8610_hpcd_data, card);
 
 	platform_device_unregister(sound_device);
 
-	if (machine_data->dai.cpu_dai)
-		fsl_ssi_destroy_dai(machine_data->dai.cpu_dai);
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
 	kfree(machine_data);
 	sound_device->dev.platform_data = NULL;
 
-	dev_set_drvdata(&ofdev->dev, NULL);
+	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
 
-static struct of_device_id mpc8610_hpcd_match[] = {
-	{
-		.compatible = "fsl,mpc8610-ssi",
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
-
-static struct of_platform_driver mpc8610_hpcd_of_driver = {
+static struct platform_driver mpc8610_hpcd_driver = {
+	.probe = mpc8610_hpcd_probe,
+	.remove = __devexit_p(mpc8610_hpcd_remove),
 	.driver = {
-		.name = "mpc8610_hpcd",
+		/* The name must match the 'model' property in the device tree,
+		 * in lowercase letters.
+		 */
+		.name = "snd-soc-mpc8610hpcd",
 		.owner = THIS_MODULE,
-		.of_match_table = mpc8610_hpcd_match,
 	},
-	.probe  	= mpc8610_hpcd_probe,
-	.remove 	= mpc8610_hpcd_remove,
 };
 
 /**
- * mpc8610_hpcd_init: fabric driver initialization.
+ * mpc8610_hpcd_init: machine driver initialization.
  *
  * This function is called when this module is loaded.
  */
 static int __init mpc8610_hpcd_init(void)
 {
-	int ret;
-
-	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
+	struct device_node *guts_np;
+	struct resource res;
 
-	ret = of_register_platform_driver(&mpc8610_hpcd_of_driver);
+	pr_info("Freescale MPC8610 HPCD ALSA SoC machine driver\n");
 
-	if (ret)
-		printk(KERN_ERR
-			"mpc8610-hpcd: failed to register platform driver\n");
+	/* Get the physical address of the global utilities registers */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (of_address_to_resource(guts_np, 0, &res)) {
+		pr_err("mpc8610-hpcd: missing/invalid global utilities node\n");
+		return -EINVAL;
+	}
+	guts_phys = res.start;
 
-	return ret;
+	return platform_driver_register(&mpc8610_hpcd_driver);
 }
 
 /**
- * mpc8610_hpcd_exit: fabric driver exit
+ * mpc8610_hpcd_exit: machine driver exit
  *
  * This function is called when this driver is unloaded.
  */
 static void __exit mpc8610_hpcd_exit(void)
 {
-	of_unregister_platform_driver(&mpc8610_hpcd_of_driver);
+	platform_driver_unregister(&mpc8610_hpcd_driver);
 }
 
 module_init(mpc8610_hpcd_init);
 module_exit(mpc8610_hpcd_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC machine driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 6644cba..1309996 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -32,21 +32,28 @@
 
 #define DRV_NAME "pcm030-audio-fabric"
 
-static struct snd_soc_device device;
 static struct snd_soc_card card;
 
 static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 Analog",
-	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
-	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_NORMAL],
+	.codec_dai_drv = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+	.codec_dai_id = WM9712_DAI_AC97_HIFI,
+	.cpu_dai_drv = &psc_ac97_dai[MPC5200_AC97_NORMAL],
+	.cpu_dai_id = MPC5200_AC97_NORMAL,
+	.platform_drv = &mpc5200_audio_dma_platform,
+	.codec_drv = &soc_codec_dev_wm9712,
 },
 {
 	.name = "AC97",
 	.stream_name = "AC97 IEC958",
-	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
-	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_SPDIF],
+	.codec_dai_drv = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	.codec_dai_id = WM9712_DAI_AC97_AUX,
+	.cpu_dai_drv = &psc_ac97_dai[MPC5200_AC97_SPDIF],
+	.cpu_dai_id = MPC5200_AC97_SPDIF,
+	.platform_drv = &mpc5200_audio_dma_platform,
+	.codec_drv = &soc_codec_dev_wm9712,
 },
 };
 
@@ -58,22 +65,18 @@ static __init int pcm030_fabric_init(void)
 	if (!of_machine_is_compatible("phytec,pcm030"))
 		return -ENODEV;
 
-	card.platform = &mpc5200_audio_dma_platform;
+
 	card.name = "pcm030";
 	card.dai_link = pcm030_fabric_dai;
 	card.num_links = ARRAY_SIZE(pcm030_fabric_dai);
 
-	device.card = &card;
-	device.codec_dev = &soc_codec_dev_wm9712;
-
 	pdev = platform_device_alloc("soc-audio", 1);
 	if (!pdev) {
 		pr_err("pcm030_fabric_init: platform_device_alloc() failed\n");
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(pdev, &device);
-	device.dev = &pdev->dev;
+	platform_set_drvdata(pdev, &card);
 
 	rc = platform_device_add(pdev);
 	if (rc) {
-- 
1.7.0.4
