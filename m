From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC V2: Clean up Freescale MPC8610 HPCD
	drivers
Date: Fri, 16 May 2008 09:59:53 -0500
Message-ID: <1210949993-11819-1-git-send-email-timur@freescale.com>
Content-Type: multipart/mixed; boundary="===============3597474557533425691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 13E5C103824
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 17:00:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

--===============3597474557533425691==

This patch cleans up the drivers for the Freescale MPC8610 HPCD reference
board so that they compile and load.  Functionality has not been tested, so
the drivers themselves probably don't work, but at least the kernel boots.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

A few other patches are needed for before this driver can even pretend to
work:

Add CS4270 i2c data to fsl_soc.c
CS4270 node is misplaced in the MPC8610 device tree
Add null pointer check to of_find_property

These patches are waiting to be applied to the PowerPC repository.

 sound/soc/Makefile           |    2 +-
 sound/soc/codecs/cs4270.c    |   59 ++-
 sound/soc/fsl/fsl_dma.c      |  296 ++++++-------
 sound/soc/fsl/fsl_dma.h      |   20 +-
 sound/soc/fsl/fsl_ssi.c      |  682 ++++++++++++++++++++---------
 sound/soc/fsl/fsl_ssi.h      |   64 ++-
 sound/soc/fsl/mpc8610_hpcd.c |  995 +++++++++++++++---------------------------
 7 files changed, 1066 insertions(+), 1052 deletions(-)
 rewrite sound/soc/fsl/mpc8610_hpcd.c (60%)

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 478664c..22393cd 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ fsl/ imx/ au1x/ davinci/ omap/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ fsl/ imx/ au1x/ davinci/ omap/ fsl/
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index b47e1d8..13b9d56 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -465,6 +465,29 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
 };
 
+static int cs4270_codec_init(struct snd_soc_codec *codec,
+	struct snd_soc_card *soc_card)
+{
+	int ret;
+	unsigned int i;
+
+	/* Add the non-DAPM controls */
+
+	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
+		struct snd_kcontrol *kctrl;
+
+		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
+
+		ret = snd_ctl_add(soc_card->card, kctrl);
+		if (ret < 0) {
+			dev_err(soc_card->card->dev, "could not add control\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Initialize the I2C interface of the CS4270
  *
@@ -474,11 +497,11 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
  * Note: snd_soc_new_pcms() must be called before this function can be called,
  * because of snd_ctl_add().
  */
-static int cs4270_i2c_probe(struct i2c_client *client)
+static int cs4270_i2c_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
 {
 	struct cs4270_private *cs4270;
 	struct snd_soc_codec *codec = NULL;
-	int i;
 	int ret = 0;
 	int registered = 0;	/* 1 == the codec has been registered */
 
@@ -499,7 +522,9 @@ static int cs4270_i2c_probe(struct i2c_client *client)
 
 	/*
 	 * Normally, we'd call snd_soc_new_codec, but that function
-	 * allocates a snd_soc_codec struct, and we don't want that.
+	 * allocates a snd_soc_codec struct, and we don't want that.  So we have
+	 * to initialize all the fields ourselves.  This might break in the
+	 * future.
 	 */
 	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
 	if (!cs4270) {
@@ -516,7 +541,7 @@ static int cs4270_i2c_probe(struct i2c_client *client)
 		goto error;
 	}
 
-	strcpy(cs4270->name, "CS4270");
+	strcpy(cs4270->name, "cirrus,cs4270");
 
 	cs4270->playback.stream_name = "Playback";
 	cs4270->playback.channels_min = 1;
@@ -541,6 +566,7 @@ static int cs4270_i2c_probe(struct i2c_client *client)
 	codec->name = cs4270->name;
 
 	codec->control_data = client;
+	codec->init = cs4270_codec_init;
 
 	ret = snd_soc_register_codec(codec, &client->dev);
 	if (ret < 0) {
@@ -549,6 +575,7 @@ static int cs4270_i2c_probe(struct i2c_client *client)
 	}
 	registered = 1;
 
+	cs4270->dai_new.name = cs4270->name;
 	cs4270->dai_new.playback = &cs4270->playback;
 	cs4270->dai_new.capture = &cs4270->capture;
 	cs4270->dai_new.ops = &cs4270->dai_ops;
@@ -560,18 +587,6 @@ static int cs4270_i2c_probe(struct i2c_client *client)
 		goto error;
 	}
 
-	/* Add the non-DAPM controls */
-
-	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
-		struct snd_kcontrol *kctrl;
-
-		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
-
-		ret = snd_ctl_add(codec->soc_card->card, kctrl);
-		if (ret < 0)
-			goto error;
-	}
-
 	i2c_set_clientdata(client, codec);
 
 	return 0;
@@ -604,12 +619,18 @@ static int cs4270_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id cs4270_id[] = {
+	{"cs4270", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4270_id);
+
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
 		.name = "cs4270",
 		.owner = THIS_MODULE,
 	},
-	.id = I2C_DRIVERID_CS4270,
+	.id_table = cs4270_id,
 	.probe = cs4270_i2c_probe,
 	.remove = cs4270_i2c_remove,
 };
@@ -623,7 +644,7 @@ static int __init cs4270_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Cirrus Logic CS4270 ALSA SoC codec driver\n");
+	printk(KERN_INFO "Cirrus Logic CS4270 ASoC codec driver\n");
 
 	/* i2c_add_driver() will call cs4270_i2c_probe() */
 	ret = i2c_add_driver(&cs4270_i2c_driver);
@@ -648,5 +669,5 @@ module_init(cs4270_init);
 module_exit(cs4270_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Cirrus Logic CS4270 ALSA SoC Codec Driver");
+MODULE_DESCRIPTION("Cirrus Logic CS4270 ASoC codec driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 2511eee..94ed933 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -11,6 +11,15 @@
  * This driver implements ASoC support for the Elo DMA controller, which is
  * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
  * the PCM driver is what handles the DMA buffer.
+ *
+ * The DMA driver is not really a stand-alone driver as much as it's a library
+ * for the SSI driver.  This is because the DMA channels cannot really stand
+ * alone.  A particular SSI device needs to know which two DMA channels to use
+ * for playback and capture.  If the DMA driver were a regular OF driver, it
+ * would get probed for each DMA channel, and then it would have to figure out
+ * which SSI to use for those channels.  That's just too complicated.  So we
+ * load like a normal platform driver and wait for the SSI driver to give us the
+ * information we need via cpu_dai->dma_data.
  */
 
 #include <linux/module.h>
@@ -19,8 +28,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -52,34 +62,13 @@
 #define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
 			  SNDRV_PCM_RATE_CONTINUOUS)
 
-/* DMA global data.  This structure is used by fsl_dma_open() to determine
- * which DMA channels to assign to a substream.  Unfortunately, ASoC V1 does
- * not allow the soc_card driver to provide this information to the PCM
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
-	dma_addr_t ssi_stx_phys;
-	dma_addr_t ssi_srx_phys;
-	struct ccsr_dma_channel __iomem *dma_channel[2];
-	unsigned int irq[2];
-	unsigned int assigned[2];
-} dma_global_data;
-
 /*
  * The number of DMA links to use.  Two is the bare minimum, but if you
  * have really small links you might need more.
  */
 #define NUM_DMA_LINKS   2
 
-/** fsl_dma_private: p-substream DMA data
+/** fsl_dma_private: per-substream DMA data
  *
  * Each substream has a 1-to-1 association with a DMA channel.
  *
@@ -104,12 +93,8 @@ static struct {
  */
 struct fsl_dma_private {
 	struct fsl_dma_link_descriptor link[NUM_DMA_LINKS];
-	unsigned int controller_id;
-	unsigned int channel_id;
-	struct ccsr_dma_channel __iomem *dma_channel;
-	unsigned int irq;
+	struct fsl_dma_info *dma_info;
 	struct snd_pcm_substream *substream;
-	dma_addr_t ssi_sxx_phys;
 	dma_addr_t ld_buf_phys;
 	unsigned int current_link;
 	dma_addr_t dma_buf_phys;
@@ -143,7 +128,7 @@ static const struct snd_pcm_hardware fsl_dma_hardware = {
 	.rate_min       	= 5512,
 	.rate_max       	= 192000,
 	.period_bytes_min       = 512,  	/* A reasonable limit */
-	.period_bytes_max       = (u32) -1,
+	.period_bytes_max       = (uint32_t) -1,
 	.periods_min    	= NUM_DMA_LINKS,
 	.periods_max    	= (unsigned int) -1,
 	.buffer_bytes_max       = 128 * 1024,   /* A reasonable limit */
@@ -205,9 +190,10 @@ static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
 static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 {
 	struct fsl_dma_private *dma_private = dev_id;
-	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+	struct ccsr_dma_channel __iomem *dma_channel =
+		dma_private->dma_info->channel;
 	irqreturn_t ret = IRQ_NONE;
-	u32 sr, sr2 = 0;
+	uint32_t sr, sr2 = 0;
 
 	/* We got an interrupt, so read the status register to see what we
 	   were interrupted for.
@@ -216,9 +202,9 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 
 	if (sr & CCSR_DMA_SR_TE) {
 		dev_err(dma_private->substream->pcm->card->dev,
-			"DMA transmit error (controller=%u channel=%u irq=%u\n",
-			dma_private->controller_id,
-			dma_private->channel_id, irq);
+			"DMA%u transmit error (channel=%u irq=%u)\n",
+			dma_private->dma_info->controller_id,
+			dma_private->dma_info->channel_id, irq);
 		fsl_dma_abort_stream(dma_private->substream);
 		sr2 |= CCSR_DMA_SR_TE;
 		ret = IRQ_HANDLED;
@@ -230,8 +216,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 	if (sr & CCSR_DMA_SR_PE) {
 		dev_err(dma_private->substream->pcm->card->dev,
 			"DMA%u programming error (channel=%u irq=%u)\n",
-			dma_private->controller_id,
-			dma_private->channel_id, irq);
+			dma_private->dma_info->controller_id,
+			dma_private->dma_info->channel_id, irq);
 		fsl_dma_abort_stream(dma_private->substream);
 		sr2 |= CCSR_DMA_SR_PE;
 		ret = IRQ_HANDLED;
@@ -281,9 +267,12 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
  * This function is called when the codec driver calls snd_soc_new_pcms(),
  * once for each .dai_link in the soc_card driver's snd_soc_card
  * structure.
+ *
+ * The DMA controller does support 36-bit addresses for the DMA buffers, but
+ * supporting that is clunky so we restrict ourselves to 32-bit addresses.
  */
-static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
-	struct snd_pcm *pcm)
+static int fsl_dma_new(struct snd_soc_platform *platform,
+	struct snd_card *card, int playback, int capture, struct snd_pcm *pcm)
 {
 	static u64 fsl_dma_dmamask = DMA_BIT_MASK(32);
 	int ret;
@@ -294,28 +283,40 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = fsl_dma_dmamask;
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
-		fsl_dma_hardware.buffer_bytes_max,
-		&pcm->streams[0].substream->dma_buffer);
-	if (ret) {
-		dev_err(card->dev,
-			"Can't allocate playback DMA buffer (size=%u)\n",
-			fsl_dma_hardware.buffer_bytes_max);
-		return -ENOMEM;
+	if (playback) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
+			fsl_dma_hardware.buffer_bytes_max,
+			&pcm->streams[0].substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev,
+				"cannot allocate playback buffer (size=%u)\n",
+				fsl_dma_hardware.buffer_bytes_max);
+			goto error;
+		}
 	}
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
-		fsl_dma_hardware.buffer_bytes_max,
-		&pcm->streams[1].substream->dma_buffer);
-	if (ret) {
-		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
-		dev_err(card->dev,
-			"Can't allocate capture DMA buffer (size=%u)\n",
-			fsl_dma_hardware.buffer_bytes_max);
-		return -ENOMEM;
+	if (capture) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
+			fsl_dma_hardware.buffer_bytes_max,
+			&pcm->streams[1].substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev,
+				"cannot allocate capture buffer (size=%u)\n",
+				fsl_dma_hardware.buffer_bytes_max);
+			goto error;
+		}
 	}
 
 	return 0;
+
+error:
+	if (pcm->streams[0].substream->dma_buffer.area)
+		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
+
+	if (pcm->streams[1].substream->dma_buffer.area)
+		snd_dma_free_pages(&pcm->streams[1].substream->dma_buffer);
+
+	return ret;
 }
 
 /**
@@ -326,6 +327,10 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
 static int fsl_dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *pcm_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = pcm_runtime->cpu_dai;
+	struct fsl_dma_info *dma_info = cpu_dai->dma_data;
+
 	struct fsl_dma_private *dma_private;
 	dma_addr_t ld_buf_phys;
 	unsigned int channel;
@@ -345,12 +350,6 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 
 	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
 
-	if (dma_global_data.assigned[channel]) {
-		dev_err(substream->pcm->card->dev,
-			"DMA channel already assigned\n");
-		return -EBUSY;
-	}
-
 	dma_private = dma_alloc_coherent(substream->pcm->dev,
 		sizeof(struct fsl_dma_private), &ld_buf_phys, GFP_KERNEL);
 	if (!dma_private) {
@@ -358,34 +357,24 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 			"can't allocate DMA private data\n");
 		return -ENOMEM;
 	}
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_private->ssi_sxx_phys = dma_global_data.ssi_stx_phys;
+		dma_private->dma_info = &dma_info[0];
 	else
-		dma_private->ssi_sxx_phys = dma_global_data.ssi_srx_phys;
-
-	dma_private->dma_channel = dma_global_data.dma_channel[channel];
-	dma_private->irq = dma_global_data.irq[channel];
-	dma_private->substream = substream;
-	dma_private->ld_buf_phys = ld_buf_phys;
-	dma_private->dma_buf_phys = substream->dma_buffer.addr;
-
-	/* We only support one DMA controller for now */
-	dma_private->controller_id = 0;
-	dma_private->channel_id = channel;
+		dma_private->dma_info = &dma_info[1];
 
-	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "DMA", dma_private);
+	ret = request_irq(dma_private->dma_info->irq,
+		fsl_dma_isr, 0, "DMA", dma_private);
 	if (ret) {
 		dev_err(substream->pcm->card->dev,
 			"can't register ISR for IRQ %u (ret=%i)\n",
-			dma_private->irq, ret);
+			dma_private->dma_info->irq, ret);
 		dma_free_coherent(substream->pcm->dev,
 			sizeof(struct fsl_dma_private),
 			dma_private, dma_private->ld_buf_phys);
 		return ret;
 	}
 
-	dma_global_data.assigned[channel] = 1;
-
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
 	runtime->private_data = dma_private;
@@ -463,11 +452,12 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+	struct ccsr_dma_channel __iomem *dma_channel =
+		dma_private->dma_info->channel;
 
 	dma_addr_t temp_addr;   /* Pointer to next period */
 	u64 temp_link;  	/* Pointer to next link descriptor */
-	u32 mr; 		/* Temporary variable for MR register */
+	uint32_t mr; 		/* Temporary variable for MR register */
 
 	unsigned int i;
 
@@ -599,13 +589,14 @@ static int fsl_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
-	u32 mr;
+	struct ccsr_dma_channel __iomem *dma_channel =
+		dma_private->dma_info->channel;
+	uint32_t mr;
 	unsigned int i;
 	dma_addr_t ssi_sxx_phys;	/* Bus address of SSI STX register */
 	unsigned int frame_size;	/* Number of bytes per frame */
 
-	ssi_sxx_phys = dma_private->ssi_sxx_phys;
+	ssi_sxx_phys = dma_private->dma_info->ssi_sxx_phys;
 
 	mr = in_be32(&dma_channel->mr) & ~(CCSR_DMA_MR_BWC_MASK |
 		  CCSR_DMA_MR_SAHTS_MASK | CCSR_DMA_MR_DAHTS_MASK);
@@ -676,7 +667,8 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+	struct ccsr_dma_channel __iomem *dma_channel =
+		dma_private->dma_info->channel;
 	dma_addr_t position;
 	snd_pcm_uframes_t frames;
 
@@ -713,7 +705,7 @@ static int fsl_dma_hw_free(struct snd_pcm_substream *substream)
 	if (dma_private) {
 		struct ccsr_dma_channel __iomem *dma_channel;
 
-		dma_channel = dma_private->dma_channel;
+		dma_channel = dma_private->dma_info->channel;
 
 		/* Stop the DMA */
 		out_be32(&dma_channel->mr, CCSR_DMA_MR_CA);
@@ -742,11 +734,10 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	int dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
 
 	if (dma_private) {
-		if (dma_private->irq)
-			free_irq(dma_private->irq, dma_private);
+		if (dma_private->dma_info->irq)
+			free_irq(dma_private->dma_info->irq, dma_private);
 
 		if (dma_private->ld_buf_phys) {
 			dma_unmap_single(substream->pcm->dev,
@@ -761,8 +752,6 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 		substream->runtime->private_data = NULL;
 	}
 
-	dma_global_data.assigned[dir] = 0;
-
 	return 0;
 }
 
@@ -794,95 +783,92 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.pointer	= fsl_dma_pointer,
 };
 
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
-{
-	static int initialized;
-
-	/* We only support one DMA controller for now */
-	if (initialized)
-		return 0;
-
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
-}
-EXPORT_SYMBOL_GPL(fsl_dma_configure);
+const char fsl_platform_id[] = "fsl_pcm";
+EXPORT_SYMBOL_GPL(fsl_platform_id);
 
+static struct snd_soc_platform_new fsl_dma_platform = {
+	.name		= fsl_platform_id,
+	.pcm_ops	= &fsl_dma_ops,
+	.pcm_new	= fsl_dma_new,
+	.pcm_free	= fsl_dma_free_dma_buffers,
+};
 
 /*
- * TODO: We may want to query the device tree here for our DMA and SSI
- * properties. It may also beneficial to merge in the SSI driver.
  */ 
-static int fsl_pcm_probe(struct device *dev)
+static int fsl_dma_probe(struct platform_device *pdev)
 {
-	struct snd_soc_platform *platform = to_snd_soc_platform(dev);
+	struct snd_soc_platform *platform;
 	int ret;
 	
-	platform->pcm_ops = &fsl_dma_ops;
-	platform->pcm_new = fsl_pcm_new,
-	platform->pcm_free = fsl_dma_free_dma_buffers,
-/* TODO: DAI can be config here after dev tree parse */
-	ret = snd_soc_platform_add_dai(platform, imx_ssi, ARRAY_SIZE(imx_ssi));
-	if (ret < 0)
-		return ret;
-*/	
-	ret = snd_soc_register_platform(platform);
+	platform = snd_soc_new_platform(&fsl_dma_platform);
+	if (!platform) {
+		dev_err(&pdev->dev, "unable to allocate platform\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, platform);
+
+	ret = snd_soc_register_platform(platform, &pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not register platform\n");
+		snd_soc_free_platform(platform);
+	}
+
 	return ret;
 }
 
-static int fsl_pcm_remove(struct device *dev)
+static int fsl_dma_remove(struct platform_device *pdev)
 {
-	struct snd_soc_platform *platform = to_snd_soc_platform(dev);
+	struct snd_soc_platform *platform = platform_get_drvdata(pdev);
+
+	if (platform)
+		snd_soc_free_platform(platform);
 	
-	snd_soc_unregister_platform(platform);
 	return 0;
 }
 
-const char fsl_platform_id[] = "fsl_pcm";
-EXPORT_SYMBOL_GPL(fsl_platform_id);
-
-static struct device_driver fsl_pcm_driver = {
-	.name 		= fsl_platform_id,
-	.owner		= THIS_MODULE,
-	.bus 		= &asoc_bus_type,
-	.probe		= fsl_pcm_probe,
-	.remove		= __devexit_p(fsl_pcm_remove),
-//	.suspend	= fsl_pcm_suspend,
-//	.resume		= fsl_pcm_resume,
+static struct platform_driver fsl_dma_driver = {
+	.driver = {
+		.name		= fsl_platform_id,
+		.owner		= THIS_MODULE,
+	},
+	.probe		= fsl_dma_probe,
+	.remove		= __devexit_p(fsl_dma_remove),
 };
 
-static __init int fsl_pcm_init(void)
+static struct platform_device *pdev;
+
+static __init int fsl_dma_init(void)
 {
-	return driver_register(&fsl_pcm_driver);
+	int ret;
+
+	printk(KERN_INFO "Freescale Elo DMA ASoC PCM driver\n");
+
+	ret = platform_driver_register(&fsl_dma_driver);
+	if (ret < 0) {
+		pr_err("fsl-dma: could not register platform\n");
+		return ret;
+	}
+
+	pdev = platform_device_register_simple(fsl_platform_id, 0, NULL, 0);
+	if (!pdev) {
+		pr_err("fsl-dma: could not register platform\n");
+		return ret;
+	}
+
+	return 0;
 }
 
-static __exit void fsl_pcm_exit(void)
+static __exit void fsl_dma_exit(void)
 {
-	driver_unregister(&fsl_pcm_driver);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&fsl_dma_driver);
 }
 
-module_init(fsl_pcm_init);
-module_exit(fsl_pcm_exit);
+module_init(fsl_dma_init);
+module_exit(fsl_dma_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM module");
+MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM driver");
 MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 05febed..ed4592f 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -126,20 +126,18 @@ struct fsl_dma_link_descriptor {
 	u8 res[4];      /* Reserved */
 } __attribute__ ((aligned(32), packed));
 
-/* DMA information needed to create a snd_soc_cpu_dai object
+/* Per-stream DMA information that the SSI driver passes to the DMA driver
  *
- * ssi_stx_phys: bus address of SSI STX register to use
- * ssi_srx_phys: bus address of SSI SRX register to use
- * dma[0]: points to the DMA channel to use for playback
- * dma[1]: points to the DMA channel to use for capture
- * dma_irq[0]: IRQ of the DMA channel to use for playback
- * dma_irq[1]: IRQ of the DMA channel to use for capture
+ * ssi_sxx_phys: bus address of SSI STX or SRX register to use
+ * channel: points to the DMA channel device to use
+ * irq: IRQ of the DMA channel
  */
 struct fsl_dma_info {
-	dma_addr_t ssi_stx_phys;
-	dma_addr_t ssi_srx_phys;
-	struct ccsr_dma_channel __iomem *dma_channel[2];
-	unsigned int dma_irq[2];
+	dma_addr_t ssi_sxx_phys;
+	struct ccsr_dma_channel __iomem *channel;
+	unsigned int irq;
+	unsigned int controller_id;
+	unsigned int channel_id;
 };
 
 extern const char fsl_platform_id[];
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9f194bc..75576b2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -14,8 +14,9 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -24,6 +25,7 @@
 
 #include <asm/immap_86xx.h>
 
+#include "fsl_dma.h"
 #include "fsl_ssi.h"
 
 /**
@@ -62,56 +64,6 @@
 #endif
 
 /**
- * fsl_ssi_private: per-SSI private data
- *
- * @name: short name for this device ("SSI0", "SSI1", etc)
- * @ssi: pointer to the SSI's registers
- * @ssi_phys: physical address of the SSI registers
- * @irq: IRQ of this SSI
- * @dev: struct device pointer
- * @playback: the number of playback streams opened
- * @capture: the number of capture streams opened
- * @cpu_dai: the CPU DAI for this device
- * @dev_attr: the sysfs device attribute structure
- * @stats: SSI statistics
- */
-struct fsl_ssi_private {
-	char name[8];
-	struct ccsr_ssi __iomem *ssi;
-	dma_addr_t ssi_phys;
-	unsigned int irq;
-	struct device *dev;
-	unsigned int playback;
-	unsigned int capture;
-	struct snd_soc_cpu_dai cpu_dai;
-	struct device_attribute dev_attr;
-
-	struct {
-		unsigned int rfrc;
-		unsigned int tfrc;
-		unsigned int cmdau;
-		unsigned int cmddu;
-		unsigned int rxt;
-		unsigned int rdr1;
-		unsigned int rdr0;
-		unsigned int tde1;
-		unsigned int tde0;
-		unsigned int roe1;
-		unsigned int roe0;
-		unsigned int tue1;
-		unsigned int tue0;
-		unsigned int tfs;
-		unsigned int rfs;
-		unsigned int tls;
-		unsigned int rls;
-		unsigned int rff1;
-		unsigned int rff0;
-		unsigned int tfe1;
-		unsigned int tfe0;
-	} stats;
-};
-
-/**
  * fsl_ssi_isr: SSI interrupt handler
  *
  * Although it's possible to use the interrupt handler to send and receive
@@ -121,12 +73,12 @@ struct fsl_ssi_private {
  * This interrupt handler is used only to gather statistics.
  *
  * @irq: IRQ of the SSI device
- * @dev_id: pointer to the ssi_private structure for this SSI device
+ * @dev_id: pointer to the ssi_info structure for this SSI device
  */
 static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 {
-	struct fsl_ssi_private *ssi_private = dev_id;
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct fsl_ssi_info *ssi_info = dev_id;
+	struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
 	irqreturn_t ret = IRQ_NONE;
 	__be32 sisr;
 	__be32 sisr2 = 0;
@@ -138,113 +90,113 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	sisr = in_be32(&ssi->sisr) & in_be32(&ssi->sier);
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
-		ssi_private->stats.rfrc++;
+		ssi_info->stats.rfrc++;
 		sisr2 |= CCSR_SSI_SISR_RFRC;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TFRC) {
-		ssi_private->stats.tfrc++;
+		ssi_info->stats.tfrc++;
 		sisr2 |= CCSR_SSI_SISR_TFRC;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_CMDAU) {
-		ssi_private->stats.cmdau++;
+		ssi_info->stats.cmdau++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_CMDDU) {
-		ssi_private->stats.cmddu++;
+		ssi_info->stats.cmddu++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RXT) {
-		ssi_private->stats.rxt++;
+		ssi_info->stats.rxt++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RDR1) {
-		ssi_private->stats.rdr1++;
+		ssi_info->stats.rdr1++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RDR0) {
-		ssi_private->stats.rdr0++;
+		ssi_info->stats.rdr0++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TDE1) {
-		ssi_private->stats.tde1++;
+		ssi_info->stats.tde1++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TDE0) {
-		ssi_private->stats.tde0++;
+		ssi_info->stats.tde0++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_ROE1) {
-		ssi_private->stats.roe1++;
+		ssi_info->stats.roe1++;
 		sisr2 |= CCSR_SSI_SISR_ROE1;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_ROE0) {
-		ssi_private->stats.roe0++;
+		ssi_info->stats.roe0++;
 		sisr2 |= CCSR_SSI_SISR_ROE0;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TUE1) {
-		ssi_private->stats.tue1++;
+		ssi_info->stats.tue1++;
 		sisr2 |= CCSR_SSI_SISR_TUE1;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TUE0) {
-		ssi_private->stats.tue0++;
+		ssi_info->stats.tue0++;
 		sisr2 |= CCSR_SSI_SISR_TUE0;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TFS) {
-		ssi_private->stats.tfs++;
+		ssi_info->stats.tfs++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RFS) {
-		ssi_private->stats.rfs++;
+		ssi_info->stats.rfs++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TLS) {
-		ssi_private->stats.tls++;
+		ssi_info->stats.tls++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RLS) {
-		ssi_private->stats.rls++;
+		ssi_info->stats.rls++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RFF1) {
-		ssi_private->stats.rff1++;
+		ssi_info->stats.rff1++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_RFF0) {
-		ssi_private->stats.rff0++;
+		ssi_info->stats.rff0++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TFE1) {
-		ssi_private->stats.tfe1++;
+		ssi_info->stats.tfe1++;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TFE0) {
-		ssi_private->stats.tfe0++;
+		ssi_info->stats.tfe0++;
 		ret = IRQ_HANDLED;
 	}
 
@@ -263,24 +215,24 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
  * If this is the first stream open, then grab the IRQ and program most of
  * the SSI registers.
  */
-static int fsl_ssi_startup(struct snd_pcm_substream *substream)
+static int fsl_ssi_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 
 	/*
 	 * If this is the first stream opened, then request the IRQ
 	 * and initialize the SSI registers.
 	 */
-	if (!ssi_private->playback && !ssi_private->capture) {
-		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	if (!ssi_info->playback && !ssi_info->capture) {
+		struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
 		int ret;
 
-		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
-				  ssi_private->name, ssi_private);
+		ret = request_irq(ssi_info->irq, fsl_ssi_isr, 0,
+				  ssi_info->name, ssi_info);
 		if (ret < 0) {
 			dev_err(substream->pcm->card->dev,
-				"could not claim irq %u\n", ssi_private->irq);
+				"could not claim irq %u\n", ssi_info->irq);
 			return ret;
 		}
 
@@ -344,10 +296,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream)
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ssi_private->playback++;
+		ssi_info->playback++;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ssi_private->capture++;
+		ssi_info->capture++;
+
+	cpu_dai->dma_data = ssi_info->dma_info;
 
 	return 0;
 }
@@ -365,17 +319,19 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream)
  * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
  * clock master.
  */
-static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
+static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *cpu_dai)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
-
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	u32 wl;
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+	struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
+	uint32_t wl;
 
 	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
 
+	/* FIXME: We should read and write the registers manually so as to
+	   minimize the amount of time the SSI is disabled. */
+
 	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -397,11 +353,12 @@ static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
  * The DMA channel is in external master start and pause mode, which
  * means the SSI completely controls the flow of data.
  */
-static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
+static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
+	struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+	struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -417,7 +374,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
 			 * to put data into its FIFO.  Without it, ALSA starts
 			 * to complain about overruns.
 			 */
-			msleep(1);
+			mdelay(1);
 		}
 		break;
 
@@ -442,27 +399,28 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
  *
  * Shutdown the SSI if there are no other substreams open.
  */
-static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
+static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ssi_private->playback--;
+		ssi_info->playback--;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ssi_private->capture--;
+		ssi_info->capture--;
 
 	/*
 	 * If this is the last active substream, disable the SSI and release
 	 * the IRQ.
 	 */
-	if (!ssi_private->playback && !ssi_private->capture) {
-		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	if (!ssi_info->playback && !ssi_info->capture) {
+		struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
 
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 
-		free_irq(ssi_private->irq, ssi_private);
+		free_irq(ssi_info->irq, ssi_info);
 	}
 }
 
@@ -480,8 +438,8 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
  * @freq: the frequency of the given clock ID, currently ignored
  * @dir: SND_SOC_CLOCK_IN (clock slave) or SND_SOC_CLOCK_OUT (clock master)
  */
-static int fsl_ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
-			      int clk_id, unsigned int freq, int dir)
+static int fsl_ssi_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+	unsigned int freq, int dir)
 {
 
 	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
@@ -498,7 +456,7 @@ static int fsl_ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
  *
  * @format: one of SND_SOC_DAIFMT_xxx
  */
-static int fsl_ssi_set_fmt(struct snd_soc_cpu_dai *cpu_dai, unsigned int format)
+static int fsl_ssi_set_fmt(struct snd_soc_dai *dai, unsigned int format)
 {
 	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
 }
@@ -511,142 +469,448 @@ static int fsl_ssi_set_fmt(struct snd_soc_cpu_dai *cpu_dai, unsigned int format)
 static ssize_t fsl_sysfs_ssi_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct fsl_ssi_private *ssi_private =
-	container_of(attr, struct fsl_ssi_private, dev_attr);
+	struct fsl_ssi_info *ssi_info =
+	container_of(attr, struct fsl_ssi_info, dev_attr);
 	ssize_t length;
 
-	length = sprintf(buf, "rfrc=%u", ssi_private->stats.rfrc);
-	length += sprintf(buf + length, "\ttfrc=%u", ssi_private->stats.tfrc);
-	length += sprintf(buf + length, "\tcmdau=%u", ssi_private->stats.cmdau);
-	length += sprintf(buf + length, "\tcmddu=%u", ssi_private->stats.cmddu);
-	length += sprintf(buf + length, "\trxt=%u", ssi_private->stats.rxt);
-	length += sprintf(buf + length, "\trdr1=%u", ssi_private->stats.rdr1);
-	length += sprintf(buf + length, "\trdr0=%u", ssi_private->stats.rdr0);
-	length += sprintf(buf + length, "\ttde1=%u", ssi_private->stats.tde1);
-	length += sprintf(buf + length, "\ttde0=%u", ssi_private->stats.tde0);
-	length += sprintf(buf + length, "\troe1=%u", ssi_private->stats.roe1);
-	length += sprintf(buf + length, "\troe0=%u", ssi_private->stats.roe0);
-	length += sprintf(buf + length, "\ttue1=%u", ssi_private->stats.tue1);
-	length += sprintf(buf + length, "\ttue0=%u", ssi_private->stats.tue0);
-	length += sprintf(buf + length, "\ttfs=%u", ssi_private->stats.tfs);
-	length += sprintf(buf + length, "\trfs=%u", ssi_private->stats.rfs);
-	length += sprintf(buf + length, "\ttls=%u", ssi_private->stats.tls);
-	length += sprintf(buf + length, "\trls=%u", ssi_private->stats.rls);
-	length += sprintf(buf + length, "\trff1=%u", ssi_private->stats.rff1);
-	length += sprintf(buf + length, "\trff0=%u", ssi_private->stats.rff0);
-	length += sprintf(buf + length, "\ttfe1=%u", ssi_private->stats.tfe1);
-	length += sprintf(buf + length, "\ttfe0=%u\n", ssi_private->stats.tfe0);
+	length = sprintf(buf, "rfrc=%u", ssi_info->stats.rfrc);
+	length += sprintf(buf + length, "\ttfrc=%u", ssi_info->stats.tfrc);
+	length += sprintf(buf + length, "\tcmdau=%u", ssi_info->stats.cmdau);
+	length += sprintf(buf + length, "\tcmddu=%u", ssi_info->stats.cmddu);
+	length += sprintf(buf + length, "\trxt=%u", ssi_info->stats.rxt);
+	length += sprintf(buf + length, "\trdr1=%u", ssi_info->stats.rdr1);
+	length += sprintf(buf + length, "\trdr0=%u", ssi_info->stats.rdr0);
+	length += sprintf(buf + length, "\ttde1=%u", ssi_info->stats.tde1);
+	length += sprintf(buf + length, "\ttde0=%u", ssi_info->stats.tde0);
+	length += sprintf(buf + length, "\troe1=%u", ssi_info->stats.roe1);
+	length += sprintf(buf + length, "\troe0=%u", ssi_info->stats.roe0);
+	length += sprintf(buf + length, "\ttue1=%u", ssi_info->stats.tue1);
+	length += sprintf(buf + length, "\ttue0=%u", ssi_info->stats.tue0);
+	length += sprintf(buf + length, "\ttfs=%u", ssi_info->stats.tfs);
+	length += sprintf(buf + length, "\trfs=%u", ssi_info->stats.rfs);
+	length += sprintf(buf + length, "\ttls=%u", ssi_info->stats.tls);
+	length += sprintf(buf + length, "\trls=%u", ssi_info->stats.rls);
+	length += sprintf(buf + length, "\trff1=%u", ssi_info->stats.rff1);
+	length += sprintf(buf + length, "\trff0=%u", ssi_info->stats.rff0);
+	length += sprintf(buf + length, "\ttfe1=%u", ssi_info->stats.tfe1);
+	length += sprintf(buf + length, "\ttfe0=%u\n", ssi_info->stats.tfe0);
 
 	return length;
 }
 
+static struct snd_soc_dai_caps playback = {
+	/* The SSI does not support monaural audio. */
+	.channels_min	= 2,
+	.channels_max	= 2,
+	.rates		= FSLSSI_I2S_RATES,
+	.formats	= FSLSSI_I2S_FORMATS,
+};
+
+static struct snd_soc_dai_caps capture = {
+	.channels_min	= 2,
+	.channels_max	= 2,
+	.rates		= FSLSSI_I2S_RATES,
+	.formats	= FSLSSI_I2S_FORMATS,
+};
+
+static struct snd_soc_dai_ops ops = {
+	.startup	= fsl_ssi_startup,
+	.prepare	= fsl_ssi_prepare,
+	.shutdown	= fsl_ssi_shutdown,
+	.trigger	= fsl_ssi_trigger,
+
+	.set_sysclk	= fsl_ssi_set_sysclk,
+	.set_fmt	= fsl_ssi_set_fmt,
+};
+
+static struct device_node *find_dma_node(unsigned int controller,
+	unsigned int channel)
+{
+	struct device_node *np = NULL;
+	struct device_node *np2 = NULL;
+	const uint32_t *iprop;
+
+	for_each_compatible_node(np, NULL, "fsl,eloplus-dma") {
+		iprop = of_get_property(np, "cell-index", NULL);
+		if (!iprop) {
+			pr_err("fsl-ssi: cell-index property not found\n");
+			return NULL;
+		}
+		if (*iprop == controller)
+			break;
+	}
+
+	if (!np) {
+		pr_err("fsl-ssi: cannot find node for DMA controller %u\n",
+			controller);
+		return NULL;
+	}
+
+	for_each_child_of_node(np, np2) {
+		if (!of_device_is_compatible(np2, "fsl,eloplus-dma-channel"))
+			continue;
+
+		iprop = of_get_property(np2, "cell-index", NULL);
+		if (!iprop) {
+			pr_err("fsl-ssi: cell-index property not found\n");
+			return NULL;
+		}
+		if (*iprop == channel)
+			break;
+	}
+
+	if (!np2) {
+		pr_err("fsl-ssi: cannot find node for DMA channel %u\n",
+			channel);
+		return NULL;
+	}
+
+	of_node_put(np);
+
+	return np2;
+}
+
 /**
- * fsl_ssi_create_dai: create a snd_soc_cpu_dai structure
- *
- * This function is called by the soc_card driver to create a snd_soc_cpu_dai
- * structure.  The function creates an ssi_private object, which contains
- * the snd_soc_cpu_dai.  It also creates the sysfs statistics device.
+ * Initialize a dma_info structure from a pointer to a DMA node
  */
-struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
+static int get_dma_info(struct device_node *np, struct fsl_dma_info *dma_info)
+{
+	const uint32_t *iprop;
+
+	if (!np)
+		return 0;
+
+	iprop = of_get_property(of_get_parent(np), "cell-index", NULL);
+	if (!iprop)
+		return 0;
+
+	dma_info->controller_id = *iprop;
+
+	iprop = of_get_property(np, "cell-index", NULL);
+	if (!iprop)
+		return 0;
+
+	dma_info->channel_id = *iprop;
+
+	dma_info->channel = of_iomap(np, 0);
+	dma_info->irq = irq_of_parse_and_map(np, 0);
+
+	return 1;
+}
 
+static int fsl_ssi_probe(struct of_device *ofdev,
+	const struct of_device_id *match)
 {
-	struct snd_soc_cpu_dai *fsl_ssi_dai;
-	struct fsl_ssi_private *ssi_private;
-	int ret = 0;
-	struct device_attribute *dev_attr;
-
-	ssi_private = kzalloc(sizeof(struct fsl_ssi_private), GFP_KERNEL);
-	if (!ssi_private) {
-		dev_err(ssi_info->dev, "could not allocate DAI object\n");
-		return NULL;
+	struct device_node *np = ofdev->node;
+	struct device_node *codec_np = NULL;
+	struct device_node *dma_np[2] = {NULL, NULL};
+	const phandle *codec_ph;
+	const phandle *dma_ph;
+	const char *sprop;
+	const uint32_t *iprop;
+	struct resource res;
+
+	struct fsl_ssi_info *ssi_info;
+	int ret = -ENODEV;
+
+	struct snd_soc_dai_new dai_template;
+
+	ssi_info = kzalloc(sizeof(struct fsl_ssi_info), GFP_KERNEL);
+	if (!ssi_info) {
+		dev_err(&ofdev->dev, "cannot allocate ssi_info\n");
+		return -ENOMEM;
+	}
+
+	ssi_info->dev = &ofdev->dev;
+
+	/*
+	 * We are only interested in SSIs with a codec phandle in them, so let's
+	 * make sure this SSI has one.
+	 */
+	codec_ph = of_get_property(np, "codec-handle", NULL);
+	if (!codec_ph) {
+		dev_dbg(&ofdev->dev, "no codec handle for this SSI\n");
+		goto error;
+	}
+
+	codec_np = of_find_node_by_phandle(*codec_ph);
+	if (!codec_np) {
+		dev_err(&ofdev->dev, "codec handle does not exist\n");
+		goto error;
+	}
+
+	/* The MPC8610 HPCD only knows about the CS4270 codec, so reject
+	 * anything else.
+	 * FIXME: This should be unnecessary
+	 */
+	if (!of_device_is_compatible(codec_np, "cirrus,cs4270")) {
+		dev_dbg(&ofdev->dev, "unknown codec %s\n",
+			(char *) of_get_property(codec_np, "compatible", NULL));
+		goto error;
+	}
+
+	/* Get the device ID */
+	iprop = of_get_property(np, "cell-index", NULL);
+	if (!iprop) {
+		dev_err(&ofdev->dev, "cell-index property not found\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	ssi_info->id = *iprop;
+
+	strcpy(ssi_info->name, "fsl,mpc8610-ssi");
+
+	/* Get the serial format and clock direction. */
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (!sprop) {
+		dev_err(&ofdev->dev, "fsl,mode property not found\n");
+		ret = -EINVAL;
+		goto error;
 	}
-	memcpy(&ssi_private->cpu_dai, &fsl_ssi_dai_template,
-	       sizeof(struct snd_soc_cpu_dai));
 
-	fsl_ssi_dai = &ssi_private->cpu_dai;
-	dev_attr = &ssi_private->dev_attr;
+	if (strcasecmp(sprop, "i2s-slave") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_I2S;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
-	sprintf(ssi_private->name, "ssi%u", (u8) ssi_info->id);
-	ssi_private->ssi = ssi_info->ssi;
-	ssi_private->ssi_phys = ssi_info->ssi_phys;
-	ssi_private->irq = ssi_info->irq;
-	ssi_private->dev = ssi_info->dev;
+		/*
+		 * In i2s-slave mode, the codec has its own clock source, so we
+		 * need to get the frequency from the device tree and pass it to
+		 * the codec driver.
+		 */
+		iprop = of_get_property(codec_np, "clock-frequency", NULL);
+		if (!iprop || !*iprop) {
+			dev_err(&ofdev->dev, "codec bus-frequency property "
+				"is missing or invalid\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		ssi_info->clk_frequency = *iprop;
+	} else if (strcasecmp(sprop, "i2s-master") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_I2S;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_IN;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "lj-slave") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "lj-master") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_IN;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "rj-master") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "rj-master") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_IN;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_AC97;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "ac97-master") == 0) {
+		ssi_info->dai_format = SND_SOC_DAIFMT_AC97;
+		ssi_info->codec_clk_direction = SND_SOC_CLOCK_IN;
+		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else {
+		dev_err(&ofdev->dev,
+			"unrecognized fsl,mode property \"%s\"\n", sprop);
+		ret = -EINVAL;
+		goto error;
+	}
 
-	ssi_private->dev->driver_data = fsl_ssi_dai;
+	if (!ssi_info->clk_frequency) {
+		dev_err(&ofdev->dev, "unknown clock frequency\n");
+		ret = -EINVAL;
+		goto error;
+	}
 
-	/* Initialize the the device_attribute structure */
-	dev_attr->attr.name = "ssi-stats";
-	dev_attr->attr.mode = S_IRUGO;
-	dev_attr->show = fsl_sysfs_ssi_show;
+	/* Read the SSI hardware information from the device tree */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(&ofdev->dev, "could not obtain SSI address\n");
+		goto error;
+	}
+	if (!res.start) {
+		dev_err(&ofdev->dev, "invalid SSI address\n");
+		goto error;
+	}
+	ssi_info->ssi_phys = res.start;
+
+	ssi_info->ssi = ioremap(ssi_info->ssi_phys, sizeof(struct ccsr_ssi));
+	if (!ssi_info->ssi) {
+		dev_err(&ofdev->dev, "could not map SSI address %x\n",
+			ssi_info->ssi_phys);
+		ret = -EINVAL;
+		goto error;
+	}
 
-	ret = device_create_file(ssi_private->dev, dev_attr);
+	/* Get the IRQ of the SSI */
+	ssi_info->irq = irq_of_parse_and_map(np, 0);
+	if (!ssi_info->irq) {
+		dev_err(&ofdev->dev, "could not get SSI IRQ\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ssi_info->dma_info[0].ssi_sxx_phys = ssi_info->ssi_phys +
+		offsetof(struct ccsr_ssi, stx0);
+	ssi_info->dma_info[1].ssi_sxx_phys = ssi_info->ssi_phys +
+		offsetof(struct ccsr_ssi, srx0);
+
+	/*
+	 * Get the DMA information.  If it's an older device tree (i.e. without
+	 * an "fsl,playback-dma" property), then we assume that SSI1 uses DMA1
+	 * Channels 0 and 1, and SSI2 uses DMA2 Channels 0 and 1.
+	 */
+	dma_ph = of_get_property(np, "fsl,playback-dma", NULL);
+	if (!dma_ph) {
+		dev_warn(&ofdev->dev, "please update your device tree\n");
+		dma_np[0] = find_dma_node(ssi_info->id, 0);
+		dma_np[1] = find_dma_node(ssi_info->id, 1);
+	} else {
+		dma_np[0] = of_find_node_by_phandle(*dma_ph);
+		dma_ph = of_get_property(np, "fsl,capture-dma", NULL);
+		if (dma_ph)
+			dma_np[1] = of_find_node_by_phandle(*dma_ph);
+	}
+
+	if (!get_dma_info(dma_np[0], &ssi_info->dma_info[0])) {
+		dev_err(&ofdev->dev, "could not obtain playback DMA info\n");
+		goto error;
+	}
+
+	if (!get_dma_info(dma_np[1], &ssi_info->dma_info[1])) {
+		dev_err(&ofdev->dev, "could not obtain capture DMA info\n");
+		goto error;
+	}
+
+	memset(&dai_template, 0, sizeof(dai_template));
+	dai_template.name = ssi_info->name;
+	dai_template.id = ssi_info->id;
+	dai_template.playback = &playback;
+	dai_template.capture = &capture;
+	dai_template.ops = &ops;
+
+	ssi_info->dai =
+		snd_soc_register_platform_dai(&dai_template, &ofdev->dev);
+	if (!ssi_info->dai) {
+		dev_err(&ofdev->dev, "could not register platform DAI\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ssi_info->dai->private_data = ssi_info;
+
+	ssi_info->dev_attr.attr.name = ssi_info->name;
+	ssi_info->dev_attr.attr.mode = S_IRUGO;
+	ssi_info->dev_attr.show = fsl_sysfs_ssi_show;
+
+	ret = device_create_file(&ofdev->dev, &ssi_info->dev_attr);
 	if (ret) {
-		dev_err(ssi_info->dev, "could not create sysfs %s file\n",
-			ssi_private->dev_attr.attr.name);
-		kfree(fsl_ssi_dai);
-		return NULL;
+		dev_err(&ofdev->dev, "could not create sysfs %s file\n",
+			ssi_info->dev_attr.attr.name);
+		goto error;
 	}
 
-	fsl_ssi_dai->private_data = ssi_private;
-	fsl_ssi_dai->name = ssi_private->name;
-	fsl_ssi_dai->id = ssi_info->id;
+	dev_set_drvdata(&ofdev->dev, ssi_info);
+
+
+
+	return 0;
+
+error:
+
+	if (ssi_info->dai)
+		snd_soc_unregister_platform_dai(ssi_info->dai);
+
+	if (ssi_info->irq)
+		irq_dispose_mapping(ssi_info->irq);
+
+	if (ssi_info->ssi)
+		iounmap(ssi_info->ssi);
 
-	return fsl_ssi_dai;
+	kfree(ssi_info);
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(fsl_ssi_create_dai);
 
 /**
- * fsl_ssi_destroy_dai: destroy the snd_soc_cpu_dai object
+ * fsl_ssi_remove: remove the OF device
  *
- * This function undoes the operations of fsl_ssi_create_dai()
+ * This function is called when the OF device is removed.
  */
-void fsl_ssi_destroy_dai(struct snd_soc_cpu_dai *fsl_ssi_dai)
+static int fsl_ssi_remove(struct of_device *ofdev)
 {
-	struct fsl_ssi_private *ssi_private =
-	container_of(fsl_ssi_dai, struct fsl_ssi_private, cpu_dai);
+	struct fsl_ssi_info *ssi_info = dev_get_drvdata(&ofdev->dev);
+
+	if (ssi_info->dai)
+		snd_soc_unregister_platform_dai(ssi_info->dai);
+
+	if (ssi_info->irq)
+		irq_dispose_mapping(ssi_info->irq);
+
+	if (ssi_info->ssi)
+		iounmap(ssi_info->ssi);
 
-	device_remove_file(ssi_private->dev, &ssi_private->dev_attr);
+	kfree(ssi_info);
 
-	kfree(ssi_private);
+	dev_set_drvdata(&ofdev->dev, NULL);
+
+	return 0;
 }
 
-/*
- * TODO: we probably want to remove this dai template and dynamically 
- * create our DAI in platform probe() based on device tree parse data.
+static struct of_device_id fsl_ssi_match[] = {
+	{
+		.compatible = "fsl,mpc8610-ssi",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_match);
+
+static struct of_platform_driver fsl_ssi_of_driver = {
+	.owner  	= THIS_MODULE,
+	.name   	= "fsl_ssi",
+	.match_table    = fsl_ssi_match,
+	.probe  	= fsl_ssi_probe,
+	.remove 	= fsl_ssi_remove,
+};
+
+/**
+ * fsl_ssi_init: fabric driver initialization.
+ *
+ * This function is called when this module is loaded.
  */
-struct snd_soc_dai fsl_ssi_template = {
+static int __init fsl_ssi_init(void)
 {
-	.name	= "SSI0-0",
-	.id	= IMX_DAI_SSI0,
-	.new 	= fsl_ssi_create_dai,
-	.free	= fsl_ssi_destroy_dai,
-	
-	.playback = {
-		/* The SSI does not support monaural audio. */
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= FSLSSI_I2S_RATES,
-		.formats	= FSLSSI_I2S_FORMATS,
-	},
-	.capture = {
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= FSLSSI_I2S_RATES,
-		.formats	= FSLSSI_I2S_FORMATS,
-	},
+	int ret;
 	
-	/* alsa ops */
-	.startup	= fsl_ssi_startup,
-	.prepare	= fsl_ssi_prepare,
-	.shutdown	= fsl_ssi_shutdown,
-	.trigger	= fsl_ssi_trigger,
+	printk(KERN_INFO "Freescale SSI ASoC driver\n");
 	
-	/* dai ops */
-	.set_sysclk	= fsl_ssi_set_sysclk,
-	.set_fmt	= fsl_ssi_set_fmt,
-},
-EXPORT_SYMBOL_GPL(fsl_ssi_template);
+	ret = of_register_platform_driver(&fsl_ssi_of_driver);
+
+	if (ret)
+		printk(KERN_ERR
+			"fsl-ssi: failed to register SSI driver\n");
+
+	return ret;
+}
+
+/**
+ * fsl_ssi_exit: fabric driver exit
+ *
+ * This function is called when this driver is unloaded.
+ */
+static void __exit fsl_ssi_exit(void)
+{
+	of_unregister_platform_driver(&fsl_ssi_of_driver);
+}
+
+module_init(fsl_ssi_init);
+module_exit(fsl_ssi_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
+MODULE_DESCRIPTION("Freescale SSI ASoC driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 0aaafa4..05fd84d 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -196,29 +196,63 @@ struct ccsr_ssi {
 #define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
 #define CCSR_SSI_SOR_SYNRST 		0x00000001
 
-/* Instantiation data for an SSI interface
+/**
+ * fsl_ssi_info: per-SSI private data
  *
- * This structure contains all the information that the the SSI driver needs
- * to instantiate an SSI interface with ALSA.  The soc_card driver should
- * create this structure, fill it in, call fsl_ssi_create_dai(), and then
- * delete the structure.
- *
- * id: which SSI this is (0, 1, etc. )
- * ssi: pointer to the SSI's registers
- * ssi_phys: physical address of the SSI registers
- * irq: IRQ of this SSI
- * dev: struct device, used to create the sysfs statistics file
-*/
+ * @name: short name for this device ("SSI0", "SSI1", etc)
+ * @ssi: pointer to the SSI's registers
+ * @ssi_phys: physical address of the SSI registers
+ * @irq: IRQ of this SSI
+ * @dev: struct device pointer
+ * @playback: the number of playback streams opened
+ * @capture: the number of capture streams opened
+ * @cpu_dai: the CPU DAI for this device
+ * @dev_attr: the sysfs device attribute structure
+ * @stats: SSI statistics
+ */
 struct fsl_ssi_info {
+	char name[16];
 	unsigned int id;
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	struct device *dev;
-};
+	unsigned int playback;
+	unsigned int capture;
+	struct snd_soc_dai *dai;
+	struct device_attribute dev_attr;
 
-struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info);
-void fsl_ssi_destroy_dai(struct snd_soc_cpu_dai *fsl_ssi_dai);
+	unsigned int dai_format;
+	unsigned int codec_clk_direction;
+	unsigned int cpu_clk_direction;
+	unsigned long clk_frequency;
+
+	struct fsl_dma_info dma_info[2];
+
+	struct {
+		unsigned int rfrc;
+		unsigned int tfrc;
+		unsigned int cmdau;
+		unsigned int cmddu;
+		unsigned int rxt;
+		unsigned int rdr1;
+		unsigned int rdr0;
+		unsigned int tde1;
+		unsigned int tde0;
+		unsigned int roe1;
+		unsigned int roe0;
+		unsigned int tue1;
+		unsigned int tue0;
+		unsigned int tfs;
+		unsigned int rfs;
+		unsigned int tls;
+		unsigned int rls;
+		unsigned int rff1;
+		unsigned int rff0;
+		unsigned int tfe1;
+		unsigned int tfe0;
+	} stats;
+};
 
 #endif
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
dissimilarity index 60%
index e154e3f..a857e57 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,642 +1,353 @@
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
-	struct snd_soc_device sound_devdata;
-	struct snd_soc_dai_link dai;
-	struct snd_soc_card soc_card;
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
- * mpc8610_hpcd_audio_init: initalize the board
- *
- * This function is called when platform_device_add() is called.  It is used
- * to initialize the board-specific hardware.
- *
- * Here we program the DMACR and PMUXCR registers.
- */
-static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
-{
-	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
-
-	/* Program the signal routing between the SSI and the DMA */
-	guts_set_dmacr(soc_card_data->guts, soc_card_data->dma_id + 1,
-		soc_card_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
-	guts_set_dmacr(soc_card_data->guts, soc_card_data->dma_id + 1,
-		soc_card_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
-
-	guts_set_pmuxcr_dma(soc_card_data->guts, soc_card_data->dma_id,
-		soc_card_data->dma_channel_id[0], 0);
-	guts_set_pmuxcr_dma(soc_card_data->guts, soc_card_data->dma_id,
-		soc_card_data->dma_channel_id[1], 0);
-
-	guts_set_pmuxcr_dma(soc_card_data->guts, 1, 0, 0);
-	guts_set_pmuxcr_dma(soc_card_data->guts, 1, 3, 0);
-	guts_set_pmuxcr_dma(soc_card_data->guts, 0, 3, 0);
-
-	switch (soc_card_data->ssi_id) {
-	case 0:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
-		break;
-	case 1:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
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
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct mpc8610_hpcd_data *soc_card_data =
-		rtd->socdev->dev->platform_data;
-	int ret = 0;
-
-	/* Tell the CPU driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(cpu_dai, soc_card_data->dai_format);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver audio format\n");
-		return ret;
-	}
-
-	/* Tell the codec driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(codec_dai, soc_card_data->dai_format);
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
-	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, soc_card_data->clk_frequency,
-		soc_card_data->cpu_clk_direction);
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
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, soc_card_data->clk_frequency,
-		soc_card_data->codec_clk_direction);
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
- * mpc8610_hpcd_audio_exit: Remove the sound device
- *
- * This function is called to remove the sound device for one SSI.  We
- * de-program the DMACR and PMUXCR register.
- */
-int mpc8610_hpcd_audio_exit(struct snd_soc_card *soc_card)
-{
-	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
-
-	/* Restore the signal routing */
-
-	guts_set_dmacr(soc_card_data->guts, soc_card_data->dma_id + 1,
-		soc_card_data->dma_channel_id[0], 0);
-	guts_set_dmacr(soc_card_data->guts, soc_card_data->dma_id + 1,
-		soc_card_data->dma_channel_id[1], 0);
-
-	switch (soc_card_data->ssi_id) {
-	case 0:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
-		break;
-	case 1:
-		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
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
-	struct snd_soc_card *soc_card;
-	struct device_node *np = ofdev->node;
-	struct device_node *codec_np = NULL;
-	struct device_node *guts_np = NULL;
-	struct device_node *dma_np = NULL;
-	struct device_node *dma_channel_np = NULL;
-	const phandle *codec_ph;
-	const char *sprop;
-	const u32 *iprop;
-	struct resource res;
-	struct mpc8610_hpcd_data *soc_card_data;
-
-/* TODO: ssi_info and dma_info could now be created in the platform driver 
- * during it's probe. A lot of this code could be moved to platform probe() */	
-
-	struct fsl_ssi_info ssi_info;
-	struct fsl_dma_info dma_info;
-	int ret = -ENODEV;
-
-	soc_card_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
-	if (!soc_card_data)
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
-	soc_card_data->ssi_id = *iprop;
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
-		soc_card_data->dai_format = SND_SOC_DAIFMT_I2S;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
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
-		soc_card_data->clk_frequency = *iprop;
-	} else if (strcasecmp(sprop, "i2s-master") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_I2S;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "lj-slave") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "lj-master") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "rj-master") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "rj-master") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_AC97;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "ac97-master") == 0) {
-		soc_card_data->dai_format = SND_SOC_DAIFMT_AC97;
-		soc_card_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		soc_card_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else {
-		dev_err(&ofdev->dev,
-			"unrecognized fsl,mode property \"%s\"\n", sprop);
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (!soc_card_data->clk_frequency) {
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
-	soc_card_data->ssi = ioremap(ssi_info.ssi_phys, sizeof(struct ccsr_ssi));
-	if (!soc_card_data->ssi) {
-		dev_err(&ofdev->dev, "could not map SSI address %x\n",
-			ssi_info.ssi_phys);
-		ret = -EINVAL;
-		goto error;
-	}
-	ssi_info.ssi = soc_card_data->ssi;
-
-
-	/* Get the IRQ of the SSI */
-	soc_card_data->ssi_irq = irq_of_parse_and_map(np, 0);
-	if (!soc_card_data->ssi_irq) {
-		dev_err(&ofdev->dev, "could not get SSI IRQ\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	ssi_info.irq = soc_card_data->ssi_irq;
-
-
-	/* Map the global utilities registers. */
-	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
-	if (!guts_np) {
-		dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	soc_card_data->guts = of_iomap(guts_np, 0);
-	of_node_put(guts_np);
-	if (!soc_card_data->guts) {
-		dev_err(&ofdev->dev, "could not map GUTS\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	/* Find the DMA channels to use.  For now, we always use the first DMA
-	   controller. */
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
-	soc_card_data->dma_id = *iprop;
-
-	/*
-	 * Find the DMA channels to use.  For now, we always use DMA channel 0
-	 * for playback, and DMA channel 1 for capture.
-	 */
-	while ((dma_channel_np = of_get_next_child(dma_np, dma_channel_np))) {
-		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
-		/* Is it DMA channel 0? */
-		if (iprop && (*iprop == 0)) {
-			/* dma_channel[0] and dma_irq[0] are for playback */
-			dma_info.dma_channel[0] = of_iomap(dma_channel_np, 0);
-			dma_info.dma_irq[0] =
-				irq_of_parse_and_map(dma_channel_np, 0);
-			soc_card_data->dma_channel_id[0] = *iprop;
-			continue;
-		}
-		if (iprop && (*iprop == 1)) {
-			/* dma_channel[1] and dma_irq[1] are for capture */
-			dma_info.dma_channel[1] = of_iomap(dma_channel_np, 0);
-			dma_info.dma_irq[1] =
-				irq_of_parse_and_map(dma_channel_np, 0);
-			soc_card_data->dma_channel_id[1] = *iprop;
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
-
-#if 0 /* V1 TODO: remove */
-	/*
-	 * Initialize our DAI data structure.  We should probably get this
-	 * information from the device tree.
-	 */
-	soc_card_data->dai.name = "CS4270";
-	soc_card_data->dai.stream_name = "CS4270";
-
-	soc_card_data->dai.cpu_dai = fsl_ssi_create_dai(&ssi_info);
-	soc_card_data->dai.codec_dai = &cs4270_dai; /* The codec_dai we want */
-	soc_card_data->dai.ops = &mpc8610_hpcd_ops;
-
-	mpc8610_hpcd_soc_card.dai_link = &soc_card_data->dai;
-
-	/* Allocate a new audio platform device structure */
-	sound_device = platform_device_alloc("soc-audio", -1);
-	if (!sound_device) {
-		dev_err(&ofdev->dev, "platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	soc_card_data->sound_devdata.soc_card = &mpc8610_hpcd_soc_card;
-	soc_card_data->sound_devdata.codec_dev = &soc_codec_device_cs4270;
-	soc_card_data->sound_devdata.platform = &fsl_soc_platform;
-
-	sound_device->dev.platform_data = soc_card_data;
-
-
-	/* Set the platform device and ASoC device to point to each other */
-	platform_set_drvdata(sound_device, &soc_card_data->sound_devdata);
-
-	soc_card_data->sound_devdata.dev = &sound_device->dev;
-
-
-	/* Tell ASoC to probe us.  This will call mpc8610_hpcd_soc_card.probe(),
-	   if it exists. */
-	ret = platform_device_add(sound_device);
-
-	if (ret) {
-		dev_err(&ofdev->dev, "platform device add failed\n");
-		goto error;
-	}
-#else /* V2 */
-	soc_card = snd_soc_card_create("MPC8610", &ofdev->dev, 
-		SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (soc_card == NULL)
-		return -ENOMEM;
-
-	soc_card->longname = "CS4270";
-	soc_card->init = mpc8610_hpcd_audio_init;
-	soc_card->exit = mpc8610_hpcd_audio_exit;
-	soc_card->private_data = soc_card_data;
-
-	/* TODO: the number, ID and config of codecs, platforms,
-	 * pcm's could be found in dev tree */
-	ret = snd_soc_codec_create(soc_card, cs4270_codec_id);
-	if (ret < 0)
-		goto err;
-
-	ret = snd_soc_platform_create(soc_card, fsl_platform_id);
-	if (ret < 0)
-		goto err;
-
-	ret = snd_soc_pcm_create(soc_card, "HiFi", &mpc8610_hpcd_ops, 
-		CS4270_HIFI_DAI, FSL_DAI_SSI0, 1, 1);
-	if (ret < 0)
-		goto err;
-		
-	/* every has been added at this point */
-	dev_set_drvdata(&ofdev->dev, soc_card);
-	ret = snd_soc_card_register(soc_card);
-	if (ret < 0)
-		goto err;
-
-#endif
-
-	dev_set_drvdata(&ofdev->dev, sound_device);
-
-	return 0;
-
-error:
-
-	of_node_put(codec_np);
-	of_node_put(guts_np);
-	of_node_put(dma_np);
-	of_node_put(dma_channel_np);
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
-	if (soc_card_data->guts)
-		iounmap(soc_card_data->guts);
-
-	kfree(soc_card_data);
-
-	snd_soc_card_free(soc_card);
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
-	struct snd_soc_card *soc_card = dev_get_drvdata(&ofdev->dev);
-	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
-
-/* TODO: some of this will move to platform remove() */
-
-	if (soc_card_data->dai.cpu_dai)
-		fsl_ssi_destroy_dai(soc_card_data->dai.cpu_dai);
-
-	if (soc_card_data->ssi)
-		iounmap(soc_card_data->ssi);
-
-	if (soc_card_data->dma[0])
-		iounmap(soc_card_data->dma[0]);
-
-	if (soc_card_data->dma[1])
-		iounmap(soc_card_data->dma[1]);
-
-	if (soc_card_data->dma_irq[0])
-		irq_dispose_mapping(soc_card_data->dma_irq[0]);
-
-	if (soc_card_data->dma_irq[1])
-		irq_dispose_mapping(soc_card_data->dma_irq[1]);
-
-	if (soc_card_data->guts)
-		iounmap(soc_card_data->guts);
-
-	kfree(soc_card_data);
-
-	snd_soc_card_free(soc_card);
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
+ * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
+ * under the terms of the GNU General Public License version 2.  This
+ * program is licensed "as is" without any warranty of any kind, whether
+ * express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
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
+	struct snd_soc_card soc_card;
+	unsigned int dai_format;
+	unsigned int codec_clk_direction;
+	unsigned int cpu_clk_direction;
+	unsigned int clk_frequency;
+	struct ccsr_guts __iomem *guts;
+};
+
+/**
+ * mpc8610_hpcd_audio_init: initalize the board
+ *
+ * This function is called when platform_device_add() is called.  It is used
+ * to initialize the board-specific hardware.
+ *
+ * Here we program the DMACR and PMUXCR registers.
+ */
+static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
+{
+	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
+	struct snd_soc_dai *cpu_dai =
+		snd_soc_card_get_dai(soc_card, "fsl,mpc8610-ssi");
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+
+	/* Program the signal routing between the SSI and the DMA */
+	guts_set_dmacr(soc_card_data->guts,
+		ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id, CCSR_GUTS_DMACR_DEV_SSI);
+	guts_set_dmacr(soc_card_data->guts,
+		ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id, CCSR_GUTS_DMACR_DEV_SSI);
+
+	guts_set_pmuxcr_dma(soc_card_data->guts,
+		ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id, 0);
+	guts_set_pmuxcr_dma(soc_card_data->guts,
+		ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id, 0);
+
+	/* FIXME: Magic numbers? */
+	guts_set_pmuxcr_dma(soc_card_data->guts, 1, 0, 0);
+	guts_set_pmuxcr_dma(soc_card_data->guts, 1, 3, 0);
+	guts_set_pmuxcr_dma(soc_card_data->guts, 0, 3, 0);
+
+	switch (ssi_info->id) {
+	case 0:
+		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
+		break;
+	case 1:
+		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
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
+	struct mpc8610_hpcd_data *soc_card_data = rtd->soc_card->private_data;
+	int ret = 0;
+
+	/* Tell the CPU driver what the serial protocol is. */
+	ret = snd_soc_dai_set_fmt(cpu_dai, soc_card_data->dai_format);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set CPU driver audio format\n");
+		return ret;
+	}
+
+	/* Tell the codec driver what the serial protocol is. */
+	ret = snd_soc_dai_set_fmt(codec_dai, soc_card_data->dai_format);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set codec driver audio format\n");
+		return ret;
+	}
+
+	/*
+	 * Tell the CPU driver what the clock frequency is, and whether it's a
+	 * slave or master.
+	 */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, soc_card_data->clk_frequency,
+		soc_card_data->cpu_clk_direction);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set CPU driver clock parameters\n");
+		return ret;
+	}
+
+	/*
+	 * Tell the codec driver what the MCLK frequency is, and whether it's
+	 * a slave or master.
+	 */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, soc_card_data->clk_frequency,
+		soc_card_data->codec_clk_direction);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set codec driver clock params\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_audio_exit: Remove the sound device
+ *
+ * This function is called to remove the sound device for one SSI.  We
+ * de-program the DMACR and PMUXCR register.
+ */
+void mpc8610_hpcd_audio_exit(struct snd_soc_card *soc_card)
+{
+	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
+	struct snd_soc_dai *cpu_dai =
+		snd_soc_card_get_dai(soc_card, "fsl,mpc8610-ssi");
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+
+	/* Restore the signal routing */
+
+	guts_set_dmacr(soc_card_data->guts,
+		ssi_info->dma_info[0].controller_id,
+		ssi_info->dma_info[0].channel_id, 0);
+	guts_set_dmacr(soc_card_data->guts,
+		ssi_info->dma_info[1].controller_id,
+		ssi_info->dma_info[1].channel_id, 0);
+
+	switch (ssi_info->id) {
+	case 0:
+		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+		break;
+	case 1:
+		clrsetbits_be32(&soc_card_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+		break;
+	}
+}
+
+/**
+ * mpc8610_hpcd_ops: ASoC fabric driver operations
+ */
+static struct snd_soc_ops mpc8610_hpcd_ops = {
+	.startup = mpc8610_hpcd_startup,
+};
+
+static struct snd_soc_pcm_config mpc8610_pcm_config = {
+	.name		= "MPC8610 HPCD",
+	.codec		= "cirrus,cs4270",
+	.codec_dai	= "cirrus,cs4270",
+	.platform	= "fsl_pcm",
+	.cpu_dai	= "fsl,mpc8610-ssi",
+	.ops		= &mpc8610_hpcd_ops,
+	.playback	= 1,
+	.capture	= 1,
+};
+
+/**
+ * mpc8610_hpcd_probe: OF probe function for the fabric driver
+ *
+ * This function gets called when an SSI node is found in the device tree.
+ *
+ * Although this is a fabric driver, the SSI node is the "master" node with
+ * respect to audio hardware connections.  Therefore, we create a new ASoC
+ * device for each new SSI node that has a codec attached.
+ */
+static int mpc8610_hpcd_probe(struct of_device *ofdev,
+	const struct of_device_id *match)
+{
+	struct snd_soc_card *soc_card = NULL;
+	struct device_node *guts_np = NULL;
+	struct mpc8610_hpcd_data *soc_card_data;
+	int ret = -ENODEV;
+
+	soc_card_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
+	if (!soc_card_data) {
+		dev_err(&ofdev->dev, "could not allocate card structure\n");
+		return -ENOMEM;
+	}
+
+	/* Map the global utilities registers. */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (!guts_np) {
+		dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	soc_card_data->guts = of_iomap(guts_np, 0);
+	of_node_put(guts_np);
+	if (!soc_card_data->guts) {
+		dev_err(&ofdev->dev, "could not map GUTS\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	soc_card = snd_soc_card_create("MPC8610", &ofdev->dev,
+		SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (!soc_card) {
+		dev_err(&ofdev->dev, "could not create card\n");
+		goto error;
+	}
+
+	soc_card->longname = "MPC8610HPCD";
+	soc_card->init = mpc8610_hpcd_audio_init;
+	soc_card->exit = mpc8610_hpcd_audio_exit;
+	soc_card->private_data = soc_card_data;
+	soc_card->dev = &ofdev->dev;
+
+	ret = snd_soc_card_create_pcms(soc_card, &mpc8610_pcm_config, 1);
+	if (ret) {
+		dev_err(&ofdev->dev, "could not create PCMs\n");
+		goto error;
+	}
+
+	/* every has been added at this point */
+	dev_set_drvdata(&ofdev->dev, soc_card);
+	ret = snd_soc_card_register(soc_card);
+	if (ret) {
+		dev_err(&ofdev->dev, "could not register card\n");
+		goto error;
+	}
+
+	return 0;
+
+error:
+	if (soc_card_data->guts)
+		iounmap(soc_card_data->guts);
+
+	kfree(soc_card_data);
+
+	if (soc_card)
+		snd_soc_card_free(soc_card);
+
+	return ret;
+}
+
+/**
+ * mpc8610_hpcd_remove: remove the OF device
+ *
+ * This function is called when the OF device is removed.
+ */
+static int mpc8610_hpcd_remove(struct of_device *ofdev)
+{
+	struct snd_soc_card *soc_card = dev_get_drvdata(&ofdev->dev);
+	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
+
+	if (soc_card_data->guts)
+		iounmap(soc_card_data->guts);
+
+	kfree(soc_card_data);
+
+	snd_soc_card_free(soc_card);
+
+	dev_set_drvdata(&ofdev->dev, NULL);
+
+	return 0;
+}
+
+static struct of_device_id mpc8610_hpcd_match[] = {
+	{
+		.compatible = "fsl,mpc8610-ssi",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
+
+static struct of_platform_driver mpc8610_hpcd_of_driver = {
+	.owner  	= THIS_MODULE,
+	.name   	= "mpc8610_hpcd",
+	.match_table    = mpc8610_hpcd_match,
+	.probe  	= mpc8610_hpcd_probe,
+	.remove 	= mpc8610_hpcd_remove,
+};
+
+/**
+ * mpc8610_hpcd_init: fabric driver initialization.
+ *
+ * This function is called when this module is loaded.
+ */
+static int __init mpc8610_hpcd_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
+
+	ret = of_register_platform_driver(&mpc8610_hpcd_of_driver);
+
+	if (ret)
+		printk(KERN_ERR
+			"mpc8610-hpcd: failed to register platform driver\n");
+
+	return ret;
+}
+
+/**
+ * mpc8610_hpcd_exit: fabric driver exit
+ *
+ * This function is called when this driver is unloaded.
+ */
+static void __exit mpc8610_hpcd_exit(void)
+{
+	of_unregister_platform_driver(&mpc8610_hpcd_of_driver);
+}
+
+module_init(mpc8610_hpcd_init);
+module_exit(mpc8610_hpcd_exit);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
+MODULE_LICENSE("GPL");
-- 
1.5.5


--===============3597474557533425691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3597474557533425691==--
