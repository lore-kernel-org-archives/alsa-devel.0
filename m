From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC V2] Additional fixes for the Freescale
	MPC8610 drivers
Date: Thu, 22 May 2008 16:53:20 -0500
Message-ID: <1211493200-10279-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 116F924468
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 23:53:29 +0200 (CEST)
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

More miscellaneous fixes for the Freescale MPC8610 ASoC V2 drivers.

CS4270 driver: Replace printk() with dev_xxx(). Use snd_soc_add_new_controls().
Report an error if a CS4270 is not found at the given I2C address.  Additional
initialization of the 'codec' structure.

DMA driver: when an OSS application requests a sync, ASoC calls
fsl_dma_hw_params() after calling fsl_dma_prepare(). This caused the DMA
controller to be reprogrammed, which made it stop working.  So the bulk of
DMA programming was moved to fsl_dma_open().  Initialized some more fields
in dma_private, so now the ISR won't panic.

SSI driver: The SSI is now enabled only when it starts playback or capture,
to prevent premature communication with the DMA controller.  Added spinlocks
to prevent the SSI from being enabled inadvertently by another stream.

Fabric driver: Turned the driver into a platform driver.  Added calls to
snd_soc_card_config_codec() and snd_soc_card_init_codec().

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c    |   54 +++++++++--------
 sound/soc/fsl/fsl_dma.c      |  139 ++++++++++++++++++++++-------------------
 sound/soc/fsl/fsl_ssi.c      |   79 +++++++++++++++++-------
 sound/soc/fsl/fsl_ssi.h      |    1 +
 sound/soc/fsl/mpc8610_hpcd.c |  130 ++++++++++++++++++++++++---------------
 5 files changed, 240 insertions(+), 163 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 13b9d56..6bb4bc7 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -223,7 +223,7 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	rates &= ~SNDRV_PCM_RATE_KNOT;
 
 	if (!rates) {
-		printk(KERN_ERR "cs4270: could not find a valid sample rate\n");
+		dev_err(codec_dai->dev, "could not find a valid sample rate\n");
 		return -EINVAL;
 	}
 
@@ -263,7 +263,7 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		cs4270->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
 		break;
 	default:
-		printk(KERN_ERR "cs4270: invalid DAI format\n");
+		dev_err(codec_dai->dev, "invalid DAI format\n");
 		ret = -EINVAL;
 	}
 
@@ -315,7 +315,7 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 		struct i2c_client *client = codec->control_data;
 
 		if (i2c_smbus_write_byte_data(client, reg, value)) {
-			printk(KERN_ERR "cs4270: I2C write failed\n");
+			dev_err(codec->dev, "I2C write failed\n");
 			return -EIO;
 		}
 
@@ -359,7 +359,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	if (i == NUM_MCLK_RATIOS) {
 		/* We did not find a matching ratio */
-		printk(KERN_ERR "cs4270: could not find matching ratio\n");
+		dev_err(codec->dev, "could not find matching ratio\n");
 		return -EINVAL;
 	}
 
@@ -369,7 +369,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		CS4270_PWRCTL_PDN_ADC | CS4270_PWRCTL_PDN_DAC |
 		CS4270_PWRCTL_PDN);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "I2C write failed\n");
 		return ret;
 	}
 
@@ -381,7 +381,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	ret = cs4270_i2c_write(codec, CS4270_MODE, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "I2C write failed\n");
 		return ret;
 	}
 
@@ -398,13 +398,13 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		reg |= CS4270_FORMAT_DAC_LJ | CS4270_FORMAT_ADC_LJ;
 		break;
 	default:
-		printk(KERN_ERR "cs4270: unknown format\n");
+		dev_err(codec->dev, "unknown format\n");
 		return -EINVAL;
 	}
 
 	ret = cs4270_i2c_write(codec, CS4270_FORMAT, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "I2C write failed\n");
 		return ret;
 	}
 
@@ -415,7 +415,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	reg &= ~CS4270_MUTE_AUTO;
 	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "I2C write failed\n");
 		return ret;
 	}
 
@@ -423,7 +423,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	ret = cs4270_i2c_write(codec, CS4270_PWRCTL, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "I2C write failed\n");
 		return ret;
 	}
 
@@ -469,23 +469,16 @@ static int cs4270_codec_init(struct snd_soc_codec *codec,
 	struct snd_soc_card *soc_card)
 {
 	int ret;
-	unsigned int i;
 
 	/* Add the non-DAPM controls */
 
-	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
-		struct snd_kcontrol *kctrl;
-
-		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
+	ret = snd_soc_add_new_controls(soc_card, cs4270_snd_controls, codec,
+		ARRAY_SIZE(cs4270_snd_controls));
 
-		ret = snd_ctl_add(soc_card->card, kctrl);
-		if (ret < 0) {
-			dev_err(soc_card->card->dev, "could not add control\n");
-			return ret;
-		}
-	}
+	if (ret < 0)
+		dev_err(soc_card->card->dev, "could not add control\n");
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -513,9 +506,14 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 	/* The top four bits of the chip ID should be 1100. */
-	if ((ret & 0xF0) != 0xC0)
-		/* The device at this address is not a CS4270 codec */
+	if ((ret & 0xF0) != 0xC0) {
+		/* This is a new-style I2C driver, which means we're supposed
+		 * to be given the actual I2C address that the chip is on.  If
+		 * this device is not a CS4270, then that's a bug.
+		 */
+		dev_err(&client->dev, "device is not a CS4270\n");
 		return -ENODEV;
+	}
 
 	dev_info(&client->dev, "found device at address %X\n", client->addr);
 	dev_info(&client->dev, "hardware revision %X\n", ret & 0xF);
@@ -567,10 +565,13 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 
 	codec->control_data = client;
 	codec->init = cs4270_codec_init;
+	codec->reg_cache = cs4270->reg_cache;
+	codec->codec_read = cs4270_read_reg_cache;
+	codec->codec_write = cs4270_i2c_write;
 
 	ret = snd_soc_register_codec(codec, &client->dev);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to register card\n");
+		dev_err(&client->dev, "failed to register card\n");
 		goto error;
 	}
 	registered = 1;
@@ -583,6 +584,7 @@ static int cs4270_i2c_probe(struct i2c_client *client,
 	cs4270->dai =
 		snd_soc_register_codec_dai(&cs4270->dai_new, &client->dev);
 	if (!cs4270->dai) {
+		dev_err(&client->dev, "failed to register DAI\n");
 		ret = -EINVAL;
 		goto error;
 	}
@@ -650,7 +652,7 @@ static int __init cs4270_init(void)
 	ret = i2c_add_driver(&cs4270_i2c_driver);
 
 	if (ret)
-		printk(KERN_ERR "cs4270: failed to register I2C driver\n");
+		pr_err("cs4270: failed to register I2C driver\n");
 
 	return ret;
 }
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 4b48f8a..5a266fc 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -232,10 +232,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 
 	if (sr & CCSR_DMA_SR_EOSI) {
-		struct snd_pcm_substream *substream = dma_private->substream;
-
 		/* Tell ALSA we completed a period. */
-		snd_pcm_period_elapsed(substream);
+		snd_pcm_period_elapsed(dma_private->substream);
 
 		/*
 		 * Update our link descriptors to point to the next period. We
@@ -332,9 +330,13 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	struct fsl_dma_info *dma_info = cpu_dai->dma_data;
 
 	struct fsl_dma_private *dma_private;
+	struct ccsr_dma_channel __iomem *dma_channel;
 	dma_addr_t ld_buf_phys;
+	u64 temp_link;  	/* Pointer to next link descriptor */
+	u32 mr;
 	unsigned int channel;
 	int ret = 0;
+	unsigned int i;
 
 	/*
 	 * Reject any DMA buffer whose size is not a multiple of the period
@@ -363,6 +365,10 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	else
 		dma_private->dma_info = &dma_info[1];
 
+	dma_private->substream = substream;
+	dma_private->ld_buf_phys = ld_buf_phys;
+	dma_private->dma_buf_phys = substream->dma_buffer.addr;
+
 	ret = request_irq(dma_private->dma_info->irq,
 		fsl_dma_isr, 0, "DMA", dma_private);
 	if (ret) {
@@ -379,6 +385,66 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
 	runtime->private_data = dma_private;
 
+	/* Program the fixed DMA controller parameters */
+
+	dma_channel = dma_private->dma_info->channel;
+
+	temp_link = dma_private->ld_buf_phys +
+		sizeof(struct fsl_dma_link_descriptor);
+
+	for (i = 0; i < NUM_DMA_LINKS; i++) {
+		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
+
+		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+		link->next = cpu_to_be64(temp_link);
+
+		temp_link += sizeof(struct fsl_dma_link_descriptor);
+	}
+	/* The last link descriptor points to the first */
+	dma_private->link[i - 1].next = cpu_to_be64(dma_private->ld_buf_phys);
+
+	/* Tell the DMA controller where the first link descriptor is */
+	out_be32(&dma_channel->clndar,
+		CCSR_DMA_CLNDAR_ADDR(dma_private->ld_buf_phys));
+	out_be32(&dma_channel->eclndar,
+		CCSR_DMA_ECLNDAR_ADDR(dma_private->ld_buf_phys));
+
+	/* The manual says the BCR must be clear before enabling EMP */
+	out_be32(&dma_channel->bcr, 0);
+
+	/*
+	 * Program the mode register for interrupts, external master control,
+	 * and source/destination hold.  Also clear the Channel Abort bit.
+	 */
+	mr = in_be32(&dma_channel->mr) &
+		~(CCSR_DMA_MR_CA | CCSR_DMA_MR_DAHE | CCSR_DMA_MR_SAHE);
+
+	/*
+	 * We want External Master Start and External Master Pause enabled,
+	 * because the SSI is controlling the DMA controller.  We want the DMA
+	 * controller to be set up in advance, and then we signal only the SSI
+	 * to start transfering.
+	 *
+	 * We want End-Of-Segment Interrupts enabled, because this will generate
+	 * an interrupt at the end of each segment (each link descriptor
+	 * represents one segment).  Each DMA segment is the same thing as an
+	 * ALSA period, so this is how we get an interrupt at the end of every
+	 * period.
+	 *
+	 * We want Error Interrupt enabled, so that we can get an error if
+	 * the DMA controller is mis-programmed somehow.
+	 */
+	mr |= CCSR_DMA_MR_EOSIE | CCSR_DMA_MR_EIE | CCSR_DMA_MR_EMP_EN |
+		CCSR_DMA_MR_EMS_EN;
+
+	/* For playback, we want the destination address to be held.  For
+	   capture, set the source address to be held. */
+	mr |= (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		CCSR_DMA_MR_DAHE : CCSR_DMA_MR_SAHE;
+
+	out_be32(&dma_channel->mr, mr);
+
 	return 0;
 }
 
@@ -452,12 +518,8 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	struct ccsr_dma_channel __iomem *dma_channel =
-		dma_private->dma_info->channel;
 
 	dma_addr_t temp_addr;   /* Pointer to next period */
-	u64 temp_link;  	/* Pointer to next link descriptor */
-	uint32_t mr; 		/* Temporary variable for MR register */
 
 	unsigned int i;
 
@@ -475,8 +537,6 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 		dma_private->dma_buf_next = dma_private->dma_buf_phys;
 
 	/*
-	 * Initialize each link descriptor.
-	 *
 	 * The actual address in STX0 (destination for playback, source for
 	 * capture) is based on the sample size, but we don't know the sample
 	 * size in this function, so we'll have to adjust that later.  See
@@ -492,16 +552,11 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 	 * buffer itself.
 	 */
 	temp_addr = substream->dma_buffer.addr;
-	temp_link = dma_private->ld_buf_phys +
-		sizeof(struct fsl_dma_link_descriptor);
 
 	for (i = 0; i < NUM_DMA_LINKS; i++) {
 		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
 
 		link->count = cpu_to_be32(period_size);
-		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
-		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
-		link->next = cpu_to_be64(temp_link);
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			link->source_addr = cpu_to_be32(temp_addr);
@@ -509,51 +564,7 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 			link->dest_addr = cpu_to_be32(temp_addr);
 
 		temp_addr += period_size;
-		temp_link += sizeof(struct fsl_dma_link_descriptor);
 	}
-	/* The last link descriptor points to the first */
-	dma_private->link[i - 1].next = cpu_to_be64(dma_private->ld_buf_phys);
-
-	/* Tell the DMA controller where the first link descriptor is */
-	out_be32(&dma_channel->clndar,
-		CCSR_DMA_CLNDAR_ADDR(dma_private->ld_buf_phys));
-	out_be32(&dma_channel->eclndar,
-		CCSR_DMA_ECLNDAR_ADDR(dma_private->ld_buf_phys));
-
-	/* The manual says the BCR must be clear before enabling EMP */
-	out_be32(&dma_channel->bcr, 0);
-
-	/*
-	 * Program the mode register for interrupts, external master control,
-	 * and source/destination hold.  Also clear the Channel Abort bit.
-	 */
-	mr = in_be32(&dma_channel->mr) &
-		~(CCSR_DMA_MR_CA | CCSR_DMA_MR_DAHE | CCSR_DMA_MR_SAHE);
-
-	/*
-	 * We want External Master Start and External Master Pause enabled,
-	 * because the SSI is controlling the DMA controller.  We want the DMA
-	 * controller to be set up in advance, and then we signal only the SSI
-	 * to start transfering.
-	 *
-	 * We want End-Of-Segment Interrupts enabled, because this will generate
-	 * an interrupt at the end of each segment (each link descriptor
-	 * represents one segment).  Each DMA segment is the same thing as an
-	 * ALSA period, so this is how we get an interrupt at the end of every
-	 * period.
-	 *
-	 * We want Error Interrupt enabled, so that we can get an error if
-	 * the DMA controller is mis-programmed somehow.
-	 */
-	mr |= CCSR_DMA_MR_EOSIE | CCSR_DMA_MR_EIE | CCSR_DMA_MR_EMP_EN |
-		CCSR_DMA_MR_EMS_EN;
-
-	/* For playback, we want the destination address to be held.  For
-	   capture, set the source address to be held. */
-	mr |= (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-		CCSR_DMA_MR_DAHE : CCSR_DMA_MR_SAHE;
-
-	out_be32(&dma_channel->mr, mr);
 
 	return 0;
 }
@@ -793,8 +804,6 @@ static struct snd_soc_platform_new fsl_dma_platform = {
 	.pcm_free	= fsl_dma_free_dma_buffers,
 };
 
-/*
- */ 
 static int fsl_dma_probe(struct platform_device *pdev)
 {
 	struct snd_soc_platform *platform;
@@ -806,15 +815,16 @@ static int fsl_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, platform);
-
 	ret = snd_soc_register_platform(platform, &pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register platform\n");
 		snd_soc_free_platform(platform);
+		return ret;
 	}
 
-	return ret;
+	platform_set_drvdata(pdev, platform);
+
+	return 0;
 }
 
 static int fsl_dma_remove(struct platform_device *pdev)
@@ -852,7 +862,8 @@ static __init int fsl_dma_init(void)
 
 	pdev = platform_device_register_simple(fsl_platform_id, 0, NULL, 0);
 	if (!pdev) {
-		pr_err("fsl-dma: could not register platform\n");
+		pr_err("fsl-dma: could not register device\n");
+		platform_driver_unregister(&fsl_dma_driver);
 		return ret;
 	}
 
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9263fd5..0d531e9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -245,11 +245,13 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 
 		/*
 		 * Program the SSI into I2S Slave Non-Network Synchronous mode.
-		 * Also enable the transmit and receive FIFO.
+		 * Also enable the transmit and receive FIFO.  Make sure TE and
+		 * RE are disabled.
 		 *
 		 * FIXME: Little-endian samples require a different shift dir
 		 */
-		clrsetbits_be32(&ssi->scr, CCSR_SSI_SCR_I2S_MODE_MASK,
+		clrsetbits_be32(&ssi->scr, CCSR_SSI_SCR_I2S_MODE_MASK |
+			CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
 			CCSR_SSI_SCR_TFR_CLK_DIS |
 			CCSR_SSI_SCR_I2S_MODE_SLAVE | CCSR_SSI_SCR_SYN);
 
@@ -284,6 +286,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		out_be32(&ssi->sfcsr,
 			 CCSR_SSI_SFCSR_TFWM0(6) | CCSR_SSI_SFCSR_RFWM0(2));
 
+		spin_unlock(&ssi_info->lock);
+
 		/*
 		 * We keep the SSI disabled because if we enable it, then the
 		 * DMA controller will start.  It's not supposed to start until
@@ -296,10 +300,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ssi_info->playback++;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ssi_info->capture++;
+		ssi_info->playback = 1;
+	else
+		ssi_info->capture = 1;
 
 	cpu_dai->dma_data = ssi_info->dma_info;
 
@@ -326,20 +329,33 @@ static int fsl_ssi_prepare(struct snd_pcm_substream *substream,
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 	struct ccsr_ssi __iomem *ssi = ssi_info->ssi;
 	uint32_t wl;
+	u32 scr;
+	u32 sxccr;
 
 	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
 
-	/* FIXME: We should read and write the registers manually so as to
-	   minimize the amount of time the SSI is disabled. */
+	spin_lock(&ssi_info->lock);
 
-	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+	scr = in_be32(&ssi->scr);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-	else
-		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+	/* If the SSI is currently enabled, then we want to keep it disabled for
+	 * as short as time as possible, so we pre-calculate all the values for
+	 * the appropriate registers, and then program them rapidly.
+	 */
 
-	setbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sxccr = (in_be32(&ssi->stccr) & ~CCSR_SSI_SxCCR_WL_MASK) | wl;
+		out_be32(&ssi->scr, scr & ~CCSR_SSI_SCR_SSIEN);
+		out_be32(&ssi->stccr, sxccr);
+		out_be32(&ssi->scr, scr);
+	} else {
+		sxccr = (in_be32(&ssi->srccr) & ~CCSR_SSI_SxCCR_WL_MASK) | wl;
+		out_be32(&ssi->scr, scr & ~CCSR_SSI_SCR_SSIEN);
+		out_be32(&ssi->srccr, sxccr);
+		out_be32(&ssi->scr, scr);
+	}
+
+	spin_unlock(&ssi_info->lock);
 
 	return 0;
 }
@@ -364,10 +380,14 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			setbits32(&ssi->scr, CCSR_SSI_SCR_TE);
-		} else {
-			setbits32(&ssi->scr, CCSR_SSI_SCR_RE);
+		spin_lock(&ssi_info->lock);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			setbits32(&ssi->scr,
+				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
+		else {
+			setbits32(&ssi->scr,
+				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
 
 			/*
 			 * I think we need this delay to allow time for the SSI
@@ -376,6 +396,8 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			 */
 			mdelay(1);
 		}
+
+		spin_unlock(&ssi_info->lock);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -406,10 +428,9 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ssi_info->playback--;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ssi_info->capture--;
+		ssi_info->playback = 0;
+	else
+		ssi_info->capture = 0;
 
 	/*
 	 * If this is the last active substream, disable the SSI and release
@@ -427,7 +448,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 /**
  * fsl_ssi_set_sysclk: set the clock frequency and direction
  *
- * This function is called by the soc_card driver to tell us what the clock
+ * This function is called by the fabric driver to tell us what the clock
  * frequency and direction are.
  *
  * Currently, we only support operating as a clock slave (SND_SOC_CLOCK_IN),
@@ -523,6 +544,16 @@ static struct snd_soc_dai_ops ops = {
 	.set_fmt	= fsl_ssi_set_fmt,
 };
 
+/**
+ * find_dma_node: find the DMA node to use in a legacy device tree
+ *
+ * This function returns a device node matching a given DMA channel on a
+ * given DMA controller.
+ *
+ * The original device tree for the MPC8610 HPCD did not include phandles
+ * from the SSI nodes to the DMA nodes.  To support these device trees, we
+ * declare that SSIx will use DMA channels 0 and 1 of DMA controller DMAx.
+ */
 static struct device_node *find_dma_node(unsigned int controller,
 	unsigned int channel)
 {
@@ -698,7 +729,7 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 		ssi_info->dai_format = SND_SOC_DAIFMT_LEFT_J;
 		ssi_info->codec_clk_direction = SND_SOC_CLOCK_IN;
 		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "rj-master") == 0) {
+	} else if (strcasecmp(sprop, "rj-slave") == 0) {
 		ssi_info->dai_format = SND_SOC_DAIFMT_RIGHT_J;
 		ssi_info->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		ssi_info->cpu_clk_direction = SND_SOC_CLOCK_IN;
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 05fd84d..9a22b04 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -219,6 +219,7 @@ struct fsl_ssi_info {
 	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
+	spinlock_t lock;
 	struct snd_soc_dai *dai;
 	struct device_attribute dev_attr;
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index a857e57..10c7fd7 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -52,7 +52,24 @@ static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
 	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
 	struct snd_soc_dai *cpu_dai =
 		snd_soc_card_get_dai(soc_card, "fsl,mpc8610-ssi");
+	struct snd_soc_codec *codec =
+		snd_soc_card_get_codec(soc_card, "cirrus,cs4270");
 	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
+	int ret;
+
+	/* This is stupid. snd_soc_card_config_codec() initializes the
+	 * codec->control_data structure, which is supposed to be a pointer to
+	 * the i2c_client structure.  But I already assigned that variable in
+	 * the codec driver.  After all, the codec driver is the one that
+	 * supposed to get probed by the I2C bus.  So in order to avoid
+	 * overwriting codec->control_data, I pass it as the 4th parameter.
+	 */
+	snd_soc_card_config_codec(codec, NULL, NULL, codec->control_data);
+	ret = snd_soc_card_init_codec(codec, soc_card);
+	if (ret < 0) {
+		dev_err(soc_card->dev, "could not initialize codec\n");
+		return ret;
+	}
 
 	/* Program the signal routing between the SSI and the DMA */
 	guts_set_dmacr(soc_card_data->guts,
@@ -94,17 +111,37 @@ static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
  * This function takes board-specific information, like clock frequencies
  * and serial data formats, and passes that information to the codec and
  * transport drivers.
+ *
+ * The clock information is stored in the ssi_info data structure because
+ * it's gathered by the SSI driver from the device tree.  This isn't really
+ * the best way to handle it.  In fact, this problem is a core dillema with
+ * ASoC V2: whether the fabric driver should hand the information to the
+ * platform/codec drivers, or whether these drivers should get the
+ * information themselves.  With device trees, the necessary data may be
+ * scattered in various device nodes, so it might be impossible to obtain
+ * that information in a generic manner.
+ *
+ * What makes this problem even more thorny is that some of these drivers
+ * are OF drivers and the rest aren't.  The CS4270 can't be an OF driver,
+ * yet the information it needs is in an OF device node.  So perhaps the
+ * best approach is to have generic codec OF->platform code in the fabric
+ * driver (normally this code is in fsl_soc.c).
+ *
+ * Even more frustrating is the fact that the CS4270 driver is an I2C
+ * driver, so it's probed via the I2C bus.  We need to update the powerpc
+ * platform to initialize client->dev->archdata.of_node to point to the
+ * device node.  Then the CS4270 driver can get its own clock rate.
  */
 static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct mpc8610_hpcd_data *soc_card_data = rtd->soc_card->private_data;
+	struct fsl_ssi_info *ssi_info = cpu_dai->private_data;
 	int ret = 0;
 
 	/* Tell the CPU driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(cpu_dai, soc_card_data->dai_format);
+	ret = snd_soc_dai_set_fmt(cpu_dai, ssi_info->dai_format);
 	if (ret < 0) {
 		dev_err(substream->pcm->card->dev,
 			"could not set CPU driver audio format\n");
@@ -112,7 +149,7 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	}
 
 	/* Tell the codec driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(codec_dai, soc_card_data->dai_format);
+	ret = snd_soc_dai_set_fmt(codec_dai, ssi_info->dai_format);
 	if (ret < 0) {
 		dev_err(substream->pcm->card->dev,
 			"could not set codec driver audio format\n");
@@ -123,8 +160,8 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	 * Tell the CPU driver what the clock frequency is, and whether it's a
 	 * slave or master.
 	 */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, soc_card_data->clk_frequency,
-		soc_card_data->cpu_clk_direction);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, ssi_info->clk_frequency,
+		ssi_info->cpu_clk_direction);
 	if (ret < 0) {
 		dev_err(substream->pcm->card->dev,
 			"could not set CPU driver clock parameters\n");
@@ -135,8 +172,8 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	 * Tell the codec driver what the MCLK frequency is, and whether it's
 	 * a slave or master.
 	 */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, soc_card_data->clk_frequency,
-		soc_card_data->codec_clk_direction);
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, ssi_info->clk_frequency,
+		ssi_info->codec_clk_direction);
 	if (ret < 0) {
 		dev_err(substream->pcm->card->dev,
 			"could not set codec driver clock params\n");
@@ -207,39 +244,38 @@ static struct snd_soc_pcm_config mpc8610_pcm_config = {
  * respect to audio hardware connections.  Therefore, we create a new ASoC
  * device for each new SSI node that has a codec attached.
  */
-static int mpc8610_hpcd_probe(struct of_device *ofdev,
-	const struct of_device_id *match)
+static int mpc8610_hpcd_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *soc_card = NULL;
-	struct device_node *guts_np = NULL;
 	struct mpc8610_hpcd_data *soc_card_data;
+	struct device_node *guts_np = NULL;
 	int ret = -ENODEV;
 
 	soc_card_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
 	if (!soc_card_data) {
-		dev_err(&ofdev->dev, "could not allocate card structure\n");
+		dev_err(&pdev->dev, "could not allocate card structure\n");
 		return -ENOMEM;
 	}
 
 	/* Map the global utilities registers. */
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
 	if (!guts_np) {
-		dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
+		dev_err(&pdev->dev, "could not obtain address of GUTS\n");
 		ret = -EINVAL;
 		goto error;
 	}
 	soc_card_data->guts = of_iomap(guts_np, 0);
 	of_node_put(guts_np);
 	if (!soc_card_data->guts) {
-		dev_err(&ofdev->dev, "could not map GUTS\n");
+		dev_err(&pdev->dev, "could not map GUTS\n");
 		ret = -EINVAL;
 		goto error;
 	}
 
-	soc_card = snd_soc_card_create("MPC8610", &ofdev->dev,
+	soc_card = snd_soc_card_create("MPC8610", &pdev->dev,
 		SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (!soc_card) {
-		dev_err(&ofdev->dev, "could not create card\n");
+		dev_err(&pdev->dev, "could not create card\n");
 		goto error;
 	}
 
@@ -247,19 +283,19 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 	soc_card->init = mpc8610_hpcd_audio_init;
 	soc_card->exit = mpc8610_hpcd_audio_exit;
 	soc_card->private_data = soc_card_data;
-	soc_card->dev = &ofdev->dev;
+	soc_card->dev = &pdev->dev;
 
 	ret = snd_soc_card_create_pcms(soc_card, &mpc8610_pcm_config, 1);
 	if (ret) {
-		dev_err(&ofdev->dev, "could not create PCMs\n");
+		dev_err(&pdev->dev, "could not create PCMs\n");
 		goto error;
 	}
 
-	/* every has been added at this point */
-	dev_set_drvdata(&ofdev->dev, soc_card);
+	platform_set_drvdata(pdev, soc_card);
+
 	ret = snd_soc_card_register(soc_card);
 	if (ret) {
-		dev_err(&ofdev->dev, "could not register card\n");
+		dev_err(&pdev->dev, "could not register card\n");
 		goto error;
 	}
 
@@ -277,14 +313,9 @@ error:
 	return ret;
 }
 
-/**
- * mpc8610_hpcd_remove: remove the OF device
- *
- * This function is called when the OF device is removed.
- */
-static int mpc8610_hpcd_remove(struct of_device *ofdev)
+static int mpc8610_hpcd_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *soc_card = dev_get_drvdata(&ofdev->dev);
+	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
 	struct mpc8610_hpcd_data *soc_card_data = soc_card->private_data;
 
 	if (soc_card_data->guts)
@@ -294,27 +325,20 @@ static int mpc8610_hpcd_remove(struct of_device *ofdev)
 
 	snd_soc_card_free(soc_card);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
-
 	return 0;
 }
 
-static struct of_device_id mpc8610_hpcd_match[] = {
-	{
-		.compatible = "fsl,mpc8610-ssi",
+static struct platform_driver mpc8610_hpcd_driver = {
+	.driver = {
+		.name   	= "mpc8610_hpcd",
+		.owner		= THIS_MODULE,
 	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
-
-static struct of_platform_driver mpc8610_hpcd_of_driver = {
-	.owner  	= THIS_MODULE,
-	.name   	= "mpc8610_hpcd",
-	.match_table    = mpc8610_hpcd_match,
 	.probe  	= mpc8610_hpcd_probe,
-	.remove 	= mpc8610_hpcd_remove,
+	.remove 	= __devexit_p(mpc8610_hpcd_remove),
 };
 
+static struct platform_device *pdev;
+
 /**
  * mpc8610_hpcd_init: fabric driver initialization.
  *
@@ -324,15 +348,22 @@ static int __init mpc8610_hpcd_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
+	printk(KERN_INFO "Freescale MPC8610 HPCD ASoC fabric driver\n");
 
-	ret = of_register_platform_driver(&mpc8610_hpcd_of_driver);
+	ret = platform_driver_register(&mpc8610_hpcd_driver);
+	if (ret < 0) {
+		pr_err("mpc8610-hpcd: could not register platform\n");
+		return ret;
+	}
 
-	if (ret)
-		printk(KERN_ERR
-			"mpc8610-hpcd: failed to register platform driver\n");
+	pdev = platform_device_register_simple("mpc8610_hpcd", 0, NULL, 0);
+	if (!pdev) {
+		pr_err("mpc8610-hpcd: could not register device\n");
+		platform_driver_unregister(&mpc8610_hpcd_driver);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -342,12 +373,13 @@ static int __init mpc8610_hpcd_init(void)
  */
 static void __exit mpc8610_hpcd_exit(void)
 {
-	of_unregister_platform_driver(&mpc8610_hpcd_of_driver);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&mpc8610_hpcd_driver);
 }
 
 module_init(mpc8610_hpcd_init);
 module_exit(mpc8610_hpcd_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
+MODULE_DESCRIPTION("Freescale MPC8610 HPCD ASoC fabric driver");
 MODULE_LICENSE("GPL");
-- 
1.5.5
