From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: remove MIDI instances counting with
	limit ULONG_MAX
Date: Fri, 2 Oct 2009 18:41:29 +0200
Message-ID: <20091002184129.2a3ab307.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id A2E7B2453C
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 18:25:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

There is no sense to limit open MIDI connections with limit
as high as ULONG_MAX.

Also, convert more messages to use the snd_printk.

Correct few old and misleading comments as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This is the second version of this patch with improved issues pointed by Takashi.

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 1ce465c..c739374 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -147,12 +147,6 @@ struct soundscape {
 	struct snd_wss *chip;
 	struct snd_mpu401 *mpu;
 
-	/*
-	 * The MIDI device won't work until we've loaded
-	 * its firmware via a hardware-dependent device IOCTL
-	 */
-	spinlock_t fwlock;
-	unsigned long midi_usage;
 	unsigned char midi_vol;
 };
 
@@ -164,11 +158,6 @@ static inline struct soundscape *get_card_soundscape(struct snd_card *c)
 	return (struct soundscape *) (c->private_data);
 }
 
-static inline struct soundscape *get_mpu401_soundscape(struct snd_mpu401 * mpu)
-{
-	return (struct soundscape *) (mpu->private_data);
-}
-
 /*
  * Allocates some kernel memory that we can use for DMA.
  * I think this means that the memory has to map to
@@ -179,7 +168,9 @@ static struct snd_dma_buffer *get_dmabuf(struct snd_dma_buffer *buf, unsigned lo
 	if (buf) {
 		if (snd_dma_alloc_pages_fallback(SNDRV_DMA_TYPE_DEV, snd_dma_isa_data(),
 						 size, buf) < 0) {
-			snd_printk(KERN_ERR "sscape: Failed to allocate %lu bytes for DMA\n", size);
+			snd_printk(KERN_ERR "sscape: Failed to allocate "
+					    "%lu bytes for DMA\n",
+					    size);
 			return NULL;
 		}
 	}
@@ -482,7 +473,8 @@ static int upload_dma_data(struct soundscape *s,
 			 */
 			spin_unlock_irqrestore(&s->lock, flags);
 
-			snd_printk(KERN_ERR "sscape: DMA upload has timed out\n");
+			snd_printk(KERN_ERR
+					"sscape: DMA upload has timed out\n");
 			ret = -EAGAIN;
 			goto _release_dma;
 		}
@@ -504,10 +496,12 @@ static int upload_dma_data(struct soundscape *s,
 	 */
 	ret = 0;
 	if (!obp_startup_ack(s, 5000)) {
-		snd_printk(KERN_ERR "sscape: No response from on-board processor after upload\n");
+		snd_printk(KERN_ERR "sscape: No response "
+				    "from on-board processor after upload\n");
 		ret = -EAGAIN;
 	} else if (!host_startup_ack(s, 5000)) {
-		snd_printk(KERN_ERR "sscape: SoundScape failed to initialise\n");
+		snd_printk(KERN_ERR
+				"sscape: SoundScape failed to initialise\n");
 		ret = -EAGAIN;
 	}
 
@@ -536,7 +530,7 @@ static int sscape_upload_bootblock(struct snd_card *card)
 
 	ret = request_firmware(&init_fw, "scope.cod", card->dev);
 	if (ret < 0) {
-		snd_printk(KERN_ERR "Error loading scope.cod");
+		snd_printk(KERN_ERR "sscape: Error loading scope.cod");
 		return ret;
 	}
 	ret = upload_dma_data(sscape, init_fw->data, init_fw->size);
@@ -554,7 +548,8 @@ static int sscape_upload_bootblock(struct snd_card *card)
 
 	data &= 0xf;
 	if (ret == 0 && data > 7) {
-		snd_printk(KERN_ERR "timeout reading firmware version\n");
+		snd_printk(KERN_ERR
+				"sscape: timeout reading firmware version\n");
 		ret = -EAGAIN;
 	}
 
@@ -575,12 +570,13 @@ static int sscape_upload_microcode(struct snd_card *card, int version)
 
 	err = request_firmware(&init_fw, name, card->dev);
 	if (err < 0) {
-		snd_printk(KERN_ERR "Error loading sndscape.co%d", version);
+		snd_printk(KERN_ERR "sscape: Error loading sndscape.co%d",
+				version);
 		return err;
 	}
 	err = upload_dma_data(sscape, init_fw->data, init_fw->size);
 	if (err == 0)
-		snd_printk(KERN_INFO "MIDI firmware loaded %d KBs\n",
+		snd_printk(KERN_INFO "sscape: MIDI firmware loaded %d KBs\n",
 				init_fw->size >> 10);
 
 	release_firmware(init_fw);
@@ -750,7 +746,6 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 		msleep(1);
 		spin_lock_irqsave(&s->lock, flags);
 	}
-	snd_printd(KERN_INFO "init delay = %d ms\n", d);
 
 	if ((inb(wss_io) & 0x80) != 0)
 		goto _done;
@@ -774,7 +769,6 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
 		msleep(1);
 		spin_lock_irqsave(&s->lock, flags);
 	}
-	snd_printd(KERN_INFO "init delay = %d ms\n", d);
 
 	/*
 	 * SoundScape successfully detected!
@@ -794,38 +788,13 @@ static int __devinit detect_sscape(struct soundscape *s, long wss_io)
  */
 static int mpu401_open(struct snd_mpu401 * mpu)
 {
-	int err;
-
 	if (!verify_mpu401(mpu)) {
-		snd_printk(KERN_ERR "sscape: MIDI disabled, please load firmware\n");
-		err = -ENODEV;
-	} else {
-		register struct soundscape *sscape = get_mpu401_soundscape(mpu);
-		unsigned long flags;
-
-		spin_lock_irqsave(&sscape->fwlock, flags);
-
-		if (sscape->midi_usage == ULONG_MAX) {
-			err = -EBUSY;
-		} else {
-			++(sscape->midi_usage);
-			err = 0;
-		}
-
-		spin_unlock_irqrestore(&sscape->fwlock, flags);
+		snd_printk(KERN_ERR "sscape: MIDI disabled, "
+				    "please load firmware\n");
+		return -ENODEV;
 	}
 
-	return err;
-}
-
-static void mpu401_close(struct snd_mpu401 * mpu)
-{
-	register struct soundscape *sscape = get_mpu401_soundscape(mpu);
-	unsigned long flags;
-
-	spin_lock_irqsave(&sscape->fwlock, flags);
-	--(sscape->midi_usage);
-	spin_unlock_irqrestore(&sscape->fwlock, flags);
+	return 0;
 }
 
 /*
@@ -845,8 +814,6 @@ static int __devinit create_mpu401(struct snd_card *card, int devnum, unsigned l
 		struct snd_mpu401 *mpu = (struct snd_mpu401 *) rawmidi->private_data;
 		mpu->open_input = mpu401_open;
 		mpu->open_output = mpu401_open;
-		mpu->close_input = mpu401_close;
-		mpu->close_output = mpu401_close;
 		mpu->private_data = sscape;
 		sscape->mpu = mpu;
 
@@ -993,13 +960,13 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	}
 
 	spin_lock_init(&sscape->lock);
-	spin_lock_init(&sscape->fwlock);
 	sscape->io_res = io_res;
 	sscape->wss_res = wss_res;
 	sscape->io_base = port[dev];
 
 	if (!detect_sscape(sscape, wss_port[dev])) {
-		printk(KERN_ERR "sscape: hardware not detected at 0x%x\n", sscape->io_base);
+		printk(KERN_ERR "sscape: hardware not detected at 0x%x\n",
+			sscape->io_base);
 		err = -ENODEV;
 		goto _release_dma;
 	}
@@ -1036,7 +1003,7 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 
 	mpu_irq_cfg = get_irq_config(sscape->type, mpu_irq[dev]);
 	if (mpu_irq_cfg == INVALID_IRQ) {
-		printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
+		snd_printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
 		return -ENXIO;
 	}
 
@@ -1073,8 +1040,9 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	err = create_ad1845(card, wss_port[dev], irq[dev],
 			    dma[dev], dma2[dev]);
 	if (err < 0) {
-		printk(KERN_ERR "sscape: No AD1845 device at 0x%lx, IRQ %d\n",
-		       wss_port[dev], irq[dev]);
+		snd_printk(KERN_ERR
+				"sscape: No AD1845 device at 0x%lx, IRQ %d\n",
+				wss_port[dev], irq[dev]);
 		goto _release_dma;
 	}
 	strcpy(card->driver, "SoundScape");
@@ -1094,7 +1062,7 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 			err = create_mpu401(card, MIDI_DEVNUM, port[dev],
 					    mpu_irq[dev]);
 			if (err < 0) {
-				printk(KERN_ERR "sscape: Failed to create "
+				snd_printk(KERN_ERR "sscape: Failed to create "
 						"MPU-401 device at 0x%lx\n",
 						port[dev]);
 				goto _release_dma;
@@ -1191,7 +1159,7 @@ static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
 		goto _release_card;
 
 	if ((ret = snd_card_register(card)) < 0) {
-		printk(KERN_ERR "sscape: Failed to register sound card\n");
+		snd_printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
 	}
 	dev_set_drvdata(pdev, card);
@@ -1250,18 +1218,7 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 	 * We have found a candidate ISA PnP card. Now we
 	 * have to check that it has the devices that we
 	 * expect it to have.
-	 *
-	 * We will NOT try and autoconfigure all of the resources
-	 * needed and then activate the card as we are assuming that
-	 * has already been done at boot-time using /proc/isapnp.
-	 * We shall simply try to give each active card the resources
-	 * that it wants. This is a sensible strategy for a modular
-	 * system where unused modules are unloaded regularly.
-	 *
-	 * This strategy is utterly useless if we compile the driver
-	 * into the kernel, of course.
 	 */
-	// printk(KERN_INFO "sscape: %s\n", card->name);
 
 	/*
 	 * Check that we still have room for another sound card ...
@@ -1272,7 +1229,7 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 
 	if (!pnp_is_active(dev)) {
 		if (pnp_activate_dev(dev) < 0) {
-			printk(KERN_INFO "sscape: device is inactive\n");
+			snd_printk(KERN_INFO "sscape: device is inactive\n");
 			return -EBUSY;
 		}
 	}
@@ -1317,7 +1274,7 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 		goto _release_card;
 
 	if ((ret = snd_card_register(card)) < 0) {
-		printk(KERN_ERR "sscape: Failed to register sound card\n");
+		snd_printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
 	}
 
-- 
1.6.0.3



---------------------------------------------------------------
Zobacz jak pracuje sie na wysokosciach.
Kliknij >>> http://link.interia.pl/f2384
