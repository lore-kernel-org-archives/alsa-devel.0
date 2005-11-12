From: "mchehab@brturbo.com.br"@redhat.com
Subject: [PATCH 3/1] V4L (975) Applied saa7134-alsa fixes
Date: Sat, 12 Nov 2005 10:37:08 -0200
Message-ID: <1131799398.6504.4.camel@localhost>
Reply-To: Linux and Kernel Video <video4linux-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "linux-kernel@vger.kernel.org"@redhat.com
Cc: akpm@osdl.org, video4linux-list@redhat.com, Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- Merged parts of a patch from Takashi Iwai for an older version 
  of the module. 
  This patch was adapted and tested by Ricardo Cerqueira.

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

diff -upNr oldtree/drivers/media/video/saa7134/saa7134-alsa.c linux/drivers/media/video/saa7134/saa7134-alsa.c
--- oldtree/drivers/media/video/saa7134/saa7134-alsa.c	2005-11-11 22:17:19.000000000 -0200
+++ linux/drivers/media/video/saa7134/saa7134-alsa.c	2005-11-11 22:17:21.000000000 -0200
@@ -30,6 +30,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <linux/interrupt.h>
 
@@ -172,8 +173,9 @@ void saa7134_irq_alsa_done(struct saa713
 	if (dev->dmasound.read_count >= dev->dmasound.blksize * (dev->dmasound.blocks-2)) {
 		dprintk("irq: overrun [full=%d/%d] - Blocks in %d\n",dev->dmasound.read_count,
 			dev->dmasound.bufsize, dev->dmasound.blocks);
+		spin_unlock(&dev->slock);
 		snd_pcm_stop(dev->dmasound.substream,SNDRV_PCM_STATE_XRUN);
-		goto done;
+		return;
 	}
 
 	/* next block addr */
@@ -256,7 +258,7 @@ static int snd_card_saa7134_capture_trig
 	struct saa7134_dev *dev=pcm->dev;
 	int err = 0;
 
-	spin_lock_irq(&dev->slock);
+	spin_lock(&dev->slock);
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
 		/* start dma */
 		saa7134_dma_start(dev);
@@ -266,45 +268,12 @@ static int snd_card_saa7134_capture_trig
 	} else {
 		err = -EINVAL;
 	}
-	spin_unlock_irq(&dev->slock);
+	spin_unlock(&dev->slock);
 
 	return err;
 }
 
 /*
- * DMA buffer config
- *
- *   Sets the values that will later be used as the size of the buffer,
- *  size of the fragments, and total number of fragments.
- *   Must be called during the preparation stage, before memory is
- *  allocated
- *
- *   - Copied verbatim from saa7134-oss.
- *
- */
-
-static int dsp_buffer_conf(struct saa7134_dev *dev, int blksize, int blocks)
-{
-	if (blksize < 0x100)
-		blksize = 0x100;
-	if (blksize > 0x10000)
-		blksize = 0x10000;
-
-	if (blocks < 2)
-		blocks = 2;
-	if ((blksize * blocks) > 1024*1024)
-		blocks = 1024*1024 / blksize;
-
-	dev->dmasound.blocks  = blocks;
-	dev->dmasound.blksize = blksize;
-	dev->dmasound.bufsize = blksize * blocks;
-
-	dprintk("buffer config: %d blocks / %d bytes, %d kB total\n",
-		blocks,blksize,blksize * blocks / 1024);
-	return 0;
-}
-
-/*
  * DMA buffer initialization
  *
  *   Uses V4L functions to initialize the DMA. Shouldn't be necessary in
@@ -330,6 +299,28 @@ static int dsp_buffer_init(struct saa713
 }
 
 /*
+ * DMA buffer release
+ *
+ *   Called after closing the device, during snd_card_saa7134_capture_close
+ *
+ */
+
+static int dsp_buffer_free(struct saa7134_dev *dev)
+{
+	if (!dev->dmasound.blksize)
+		BUG();
+
+	videobuf_dma_free(&dev->dmasound.dma);
+
+	dev->dmasound.blocks  = 0;
+	dev->dmasound.blksize = 0;
+	dev->dmasound.bufsize = 0;
+
+       return 0;
+}
+
+
+/*
  * ALSA PCM preparation
  *
  *   - One of the ALSA capture callbacks.
@@ -344,74 +335,30 @@ static int dsp_buffer_init(struct saa713
 static int snd_card_saa7134_capture_prepare(snd_pcm_substream_t * substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	int err, bswap, sign;
+	int bswap, sign;
 	u32 fmt, control;
 	snd_card_saa7134_t *saa7134 = snd_pcm_substream_chip(substream);
 	struct saa7134_dev *dev;
 	snd_card_saa7134_pcm_t *pcm = runtime->private_data;
-	unsigned long size;
-	unsigned count;
-
-	size = snd_pcm_lib_buffer_bytes(substream);
-	count = snd_pcm_lib_period_bytes(substream);
 
 	pcm->dev->dmasound.substream = substream;
 
-	dev=saa7134->dev;
-
-	dsp_buffer_conf(dev,count,(size/count));
-
-	err = dsp_buffer_init(dev);
-	if (0 != err)
-		return err;
-
-	/* prepare buffer */
-	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->dmasound.dma)))
-		return err;
-	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->dmasound.pt)))
-		goto fail1;
-	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->dmasound.pt,
-					      dev->dmasound.dma.sglist,
-					      dev->dmasound.dma.sglen,
-					      0)))
-		goto fail2;
-
+	dev = saa7134->dev;
 
-
-	switch (runtime->format) {
-	  case SNDRV_PCM_FORMAT_U8:
-	  case SNDRV_PCM_FORMAT_S8:
+	if (snd_pcm_format_width(runtime->format) == 8)
 		fmt = 0x00;
-		break;
-	  case SNDRV_PCM_FORMAT_U16_LE:
-	  case SNDRV_PCM_FORMAT_U16_BE:
-	  case SNDRV_PCM_FORMAT_S16_LE:
-	  case SNDRV_PCM_FORMAT_S16_BE:
+	else
 		fmt = 0x01;
-		break;
-	  default:
-		err = -EINVAL;
-		return 1;
-	}
 
-	switch (runtime->format) {
-	  case SNDRV_PCM_FORMAT_S8:
-	  case SNDRV_PCM_FORMAT_S16_LE:
-	  case SNDRV_PCM_FORMAT_S16_BE:
+	if (snd_pcm_format_signed(runtime->format))
 		sign = 1;
-		break;
-	  default:
+	else
 		sign = 0;
-		break;
-	}
 
-	switch (runtime->format) {
-	  case SNDRV_PCM_FORMAT_U16_BE:
-	  case SNDRV_PCM_FORMAT_S16_BE:
-		bswap = 1; break;
-	  default:
-		bswap = 0; break;
-	}
+	if (snd_pcm_format_big_endian(runtime->format))
+		bswap = 1;
+	else
+		bswap = 0;
 
 	switch (dev->pci->device) {
 	  case PCI_DEVICE_ID_PHILIPS_SAA7134:
@@ -452,12 +399,6 @@ static int snd_card_saa7134_capture_prep
 	if (bswap)
 		control |= SAA7134_RS_CONTROL_BSWAP;
 
-	/* I should be able to use runtime->dma_addr in the control
-	   byte, but it doesn't work. So I allocate the DMA using the
-	   V4L functions, and force ALSA to use that as the DMA area */
-
-	runtime->dma_area = dev->dmasound.dma.vmalloc;
-
 	saa_writel(SAA7134_RS_BA1(6),0);
 	saa_writel(SAA7134_RS_BA2(6),dev->dmasound.blksize);
 	saa_writel(SAA7134_RS_PITCH(6),0);
@@ -466,12 +407,6 @@ static int snd_card_saa7134_capture_prep
 	dev->dmasound.rate = runtime->rate;
 
 	return 0;
- fail2:
-	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
- fail1:
-	videobuf_dma_pci_unmap(dev->pci,&dev->dmasound.dma);
-	return err;
-
 
 }
 
@@ -543,15 +478,76 @@ static void snd_card_saa7134_runtime_fre
  *   - One of the ALSA capture callbacks.
  *
  *   Called on initialization, right before the PCM preparation
- *   Usually used in ALSA to allocate the DMA, but since we don't use the
- *  ALSA DMA it does nothing
  *
  */
 
 static int snd_card_saa7134_hw_params(snd_pcm_substream_t * substream,
 				    snd_pcm_hw_params_t * hw_params)
 {
-	return 0;
+	snd_card_saa7134_t *saa7134 = snd_pcm_substream_chip(substream);
+	struct saa7134_dev *dev;
+	unsigned int period_size, periods;
+	int err;
+
+	period_size = params_period_bytes(hw_params);
+	periods = params_periods(hw_params);
+
+	snd_assert(period_size >= 0x100 && period_size <= 0x10000,
+		   return -EINVAL);
+	snd_assert(periods >= 2, return -EINVAL);
+	snd_assert(period_size * periods <= 1024 * 1024, return -EINVAL);
+
+	dev = saa7134->dev;
+
+	if (dev->dmasound.blocks == periods &&
+	    dev->dmasound.blksize == period_size)
+		return 0;
+
+	/* release the old buffer */
+	if (substream->runtime->dma_area) {
+		saa7134_pgtable_free(dev->pci, &dev->dmasound.pt);
+		videobuf_dma_pci_unmap(dev->pci, &dev->dmasound.dma);
+		dsp_buffer_free(dev);
+		substream->runtime->dma_area = NULL;
+	}
+	dev->dmasound.blocks  = periods;
+	dev->dmasound.blksize = period_size;
+	dev->dmasound.bufsize = period_size * periods;
+
+	err = dsp_buffer_init(dev);
+	if (0 != err) {
+		dev->dmasound.blocks  = 0;
+		dev->dmasound.blksize = 0;
+		dev->dmasound.bufsize = 0;
+		return err;
+	}
+
+	if (0 != (err = videobuf_dma_pci_map(dev->pci, &dev->dmasound.dma))) {
+		dsp_buffer_free(dev);
+		return err;
+	}
+	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->dmasound.pt))) {
+		videobuf_dma_pci_unmap(dev->pci, &dev->dmasound.dma);
+		dsp_buffer_free(dev);
+		return err;
+	}
+	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->dmasound.pt,
+						dev->dmasound.dma.sglist,
+						dev->dmasound.dma.sglen,
+						0))) {
+		saa7134_pgtable_free(dev->pci, &dev->dmasound.pt);
+		videobuf_dma_pci_unmap(dev->pci, &dev->dmasound.dma);
+		dsp_buffer_free(dev);
+		return err;
+	}
+
+	/* I should be able to use runtime->dma_addr in the control
+	   byte, but it doesn't work. So I allocate the DMA using the
+	   V4L functions, and force ALSA to use that as the DMA area */
+
+	substream->runtime->dma_area = dev->dmasound.dma.vmalloc;
+
+	return 1;
 
 }
 
@@ -561,33 +557,23 @@ static int snd_card_saa7134_hw_params(sn
  *   - One of the ALSA capture callbacks.
  *
  *   Called after closing the device, but before snd_card_saa7134_capture_close
- *   Usually used in ALSA to free the DMA, but since we don't use the
- *  ALSA DMA it does nothing
+ *   It stops the DMA audio and releases the buffers.
  *
  */
 
 static int snd_card_saa7134_hw_free(snd_pcm_substream_t * substream)
 {
-	return 0;
-}
-
-/*
- * DMA buffer release
- *
- *   Called after closing the device, during snd_card_saa7134_capture_close
- *
- */
-
-static int dsp_buffer_free(struct saa7134_dev *dev)
-{
-	if (!dev->dmasound.blksize)
-		BUG();
+	snd_card_saa7134_t *saa7134 = snd_pcm_substream_chip(substream);
+	struct saa7134_dev *dev;
 
-	videobuf_dma_free(&dev->dmasound.dma);
+	dev = saa7134->dev;
 
-	dev->dmasound.blocks  = 0;
-	dev->dmasound.blksize = 0;
-	dev->dmasound.bufsize = 0;
+	if (substream->runtime->dma_area) {
+		saa7134_pgtable_free(dev->pci, &dev->dmasound.pt);
+		videobuf_dma_pci_unmap(dev->pci, &dev->dmasound.dma);
+		dsp_buffer_free(dev);
+		substream->runtime->dma_area = NULL;
+	}
 
 	return 0;
 }
@@ -597,21 +583,12 @@ static int dsp_buffer_free(struct saa713
  *
  *   - One of the ALSA capture callbacks.
  *
- *   Called after closing the device. It stops the DMA audio and releases
- *  the buffers
+ *   Called after closing the device.
  *
  */
 
 static int snd_card_saa7134_capture_close(snd_pcm_substream_t * substream)
 {
-	snd_card_saa7134_t *chip = snd_pcm_substream_chip(substream);
-	struct saa7134_dev *dev = chip->dev;
-
-	/* unlock buffer */
-	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
-	videobuf_dma_pci_unmap(dev->pci,&dev->dmasound.dma);
-
-	dsp_buffer_free(dev);
 	return 0;
 }
 
@@ -724,7 +701,6 @@ static int snd_saa7134_volume_get(snd_kc
 static int snd_saa7134_volume_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	snd_card_saa7134_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
 	int change, addr = kcontrol->private_value;
 	int left, right;
 
@@ -738,12 +714,12 @@ static int snd_saa7134_volume_put(snd_kc
 		right = 0;
 	if (right > 20)
 		right = 20;
-	spin_lock_irqsave(&chip->mixer_lock, flags);
+	spin_lock_irq(&chip->mixer_lock);
 	change = chip->mixer_volume[addr][0] != left ||
 		 chip->mixer_volume[addr][1] != right;
 	chip->mixer_volume[addr][0] = left;
 	chip->mixer_volume[addr][1] = right;
-	spin_unlock_irqrestore(&chip->mixer_lock, flags);
+	spin_unlock_irq(&chip->mixer_lock);
 	return change;
 }
 
@@ -765,13 +741,12 @@ static int snd_saa7134_capsrc_info(snd_k
 static int snd_saa7134_capsrc_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	snd_card_saa7134_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
 	int addr = kcontrol->private_value;
 
-	spin_lock_irqsave(&chip->mixer_lock, flags);
+	spin_lock_irq(&chip->mixer_lock);
 	ucontrol->value.integer.value[0] = chip->capture_source[addr][0];
 	ucontrol->value.integer.value[1] = chip->capture_source[addr][1];
-	spin_unlock_irqrestore(&chip->mixer_lock, flags);
+	spin_unlock_irq(&chip->mixer_lock);
 
 	return 0;
 }
@@ -888,15 +863,10 @@ static int snd_card_saa7134_new_mixer(sn
 
 static void snd_saa7134_free(snd_card_t * card)
 {
-	return;
-}
-
-static int snd_saa7134_dev_free(snd_device_t *device)
-{
-	snd_card_saa7134_t *chip = device->device_data;
+	snd_card_saa7134_t *chip = card->private_data;
 
 	if (chip->dev->dmasound.priv_data == NULL)
-		return 0;
+		return;
 
 	if (chip->irq >= 0) {
 		synchronize_irq(chip->irq);
@@ -905,7 +875,6 @@ static int snd_saa7134_dev_free(snd_devi
 
 	chip->dev->dmasound.priv_data = NULL;
 
-	return 0;
 }
 
 /*
@@ -922,9 +891,6 @@ int alsa_card_saa7134_create(struct saa7
 	snd_card_t *card;
 	snd_card_saa7134_t *chip;
 	int err;
-	static snd_device_ops_t ops = {
-		.dev_free =     snd_saa7134_dev_free,
-	};
 
 
 	if (devnum >= SNDRV_CARDS)
@@ -952,7 +918,6 @@ int alsa_card_saa7134_create(struct saa7
 	chip->card = card;
 
 	chip->pci = dev->pci;
-	chip->irq = dev->pci->irq;
 	chip->iobase = pci_resource_start(dev->pci, 0);
 
 
@@ -966,11 +931,9 @@ int alsa_card_saa7134_create(struct saa7
 		goto __nodev;
 	}
 
-	init_MUTEX(&dev->dmasound.lock);
+	chip->irq = dev->pci->irq;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		goto __nodev;
-	}
+	init_MUTEX(&dev->dmasound.lock);
 
 	if ((err = snd_card_saa7134_new_mixer(chip)) < 0)
 		goto __nodev;


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
