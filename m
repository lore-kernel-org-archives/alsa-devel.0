From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: remove MIDI instances counting with
	limit ULONG_MAX
Date: Thu, 1 Oct 2009 20:07:14 +0200
Message-ID: <20091001200714.9ed2d03d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3115878120735359838=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 4A8262454E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 19:50:59 +0200 (CEST)
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

--===============3115878120735359838==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

There is no sense to limit open MIDI connections with limit
as high as ULONG_MAX.

Also, remove redundant "sscape:" prefix in messages printed
by snd_printk and convert more messages to use the snd_printk.

Correct few old and misleading comments as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/sscape.c |   85 +++++++++++++---------------------------------------
 1 files changed, 21 insertions(+), 64 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 1ce465c..ece2bb9 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -149,9 +149,8 @@ struct soundscape {
 
 	/*
 	 * The MIDI device won't work until we've loaded
-	 * its firmware via a hardware-dependent device IOCTL
+	 * its firmware.
 	 */
-	spinlock_t fwlock;
 	unsigned long midi_usage;
 	unsigned char midi_vol;
 };
@@ -164,11 +163,6 @@ static inline struct soundscape *get_card_soundscape(struct snd_card *c)
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
@@ -179,7 +173,9 @@ static struct snd_dma_buffer *get_dmabuf(struct snd_dma_buffer *buf, unsigned lo
 	if (buf) {
 		if (snd_dma_alloc_pages_fallback(SNDRV_DMA_TYPE_DEV, snd_dma_isa_data(),
 						 size, buf) < 0) {
-			snd_printk(KERN_ERR "sscape: Failed to allocate %lu bytes for DMA\n", size);
+			snd_printk(KERN_ERR
+				   "Failed to allocate %lu bytes for DMA\n",
+				   size);
 			return NULL;
 		}
 	}
@@ -797,37 +793,13 @@ static int mpu401_open(struct snd_mpu401 * mpu)
 	int err;
 
 	if (!verify_mpu401(mpu)) {
-		snd_printk(KERN_ERR "sscape: MIDI disabled, please load firmware\n");
+		snd_printk(KERN_ERR "MIDI disabled, please load firmware\n");
 		err = -ENODEV;
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
 	}
 
 	return err;
 }
 
-static void mpu401_close(struct snd_mpu401 * mpu)
-{
-	register struct soundscape *sscape = get_mpu401_soundscape(mpu);
-	unsigned long flags;
-
-	spin_lock_irqsave(&sscape->fwlock, flags);
-	--(sscape->midi_usage);
-	spin_unlock_irqrestore(&sscape->fwlock, flags);
-}
-
 /*
  * Initialse an MPU-401 subdevice for MIDI support on the SoundScape.
  */
@@ -845,8 +817,6 @@ static int __devinit create_mpu401(struct snd_card *card, int devnum, unsigned l
 		struct snd_mpu401 *mpu = (struct snd_mpu401 *) rawmidi->private_data;
 		mpu->open_input = mpu401_open;
 		mpu->open_output = mpu401_open;
-		mpu->close_input = mpu401_close;
-		mpu->close_output = mpu401_close;
 		mpu->private_data = sscape;
 		sscape->mpu = mpu;
 
@@ -908,21 +878,20 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 
 		err = snd_wss_pcm(chip, 0, &pcm);
 		if (err < 0) {
-			snd_printk(KERN_ERR "sscape: No PCM device "
-					    "for AD1845 chip\n");
+			snd_printk(KERN_ERR "No PCM device for AD1845 chip\n");
 			goto _error;
 		}
 
 		err = snd_wss_mixer(chip);
 		if (err < 0) {
-			snd_printk(KERN_ERR "sscape: No mixer device "
+			snd_printk(KERN_ERR "No mixer device "
 					    "for AD1845 chip\n");
 			goto _error;
 		}
 		if (chip->hardware != WSS_HW_AD1848) {
 			err = snd_wss_timer(chip, 0, NULL);
 			if (err < 0) {
-				snd_printk(KERN_ERR "sscape: No timer device "
+				snd_printk(KERN_ERR "No timer device "
 						    "for AD1845 chip\n");
 				goto _error;
 			}
@@ -932,7 +901,7 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 			err = snd_ctl_add(card,
 					  snd_ctl_new1(&midi_mixer_ctl, chip));
 			if (err < 0) {
-				snd_printk(KERN_ERR "sscape: Could not create "
+				snd_printk(KERN_ERR "Could not create "
 						    "MIDI mixer control\n");
 				goto _error;
 			}
@@ -968,15 +937,14 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	 */
 	io_res = request_region(port[dev], 8, "SoundScape");
 	if (!io_res) {
-		snd_printk(KERN_ERR
-			   "sscape: can't grab port 0x%lx\n", port[dev]);
+		snd_printk(KERN_ERR "can't grab port 0x%lx\n", port[dev]);
 		return -EBUSY;
 	}
 	wss_res = NULL;
 	if (sscape->type == SSCAPE_VIVO) {
 		wss_res = request_region(wss_port[dev], 4, "SoundScape");
 		if (!wss_res) {
-			snd_printk(KERN_ERR "sscape: can't grab port 0x%lx\n",
+			snd_printk(KERN_ERR "can't grab port 0x%lx\n",
 					    wss_port[dev]);
 			err = -EBUSY;
 			goto _release_region;
@@ -988,18 +956,18 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	 */
 	err = request_dma(dma[dev], "SoundScape");
 	if (err < 0) {
-		snd_printk(KERN_ERR "sscape: can't grab DMA %d\n", dma[dev]);
+		snd_printk(KERN_ERR "can't grab DMA %d\n", dma[dev]);
 		goto _release_region;
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
@@ -1030,13 +998,13 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	 */
 	irq_cfg = get_irq_config(sscape->type, irq[dev]);
 	if (irq_cfg == INVALID_IRQ) {
-		snd_printk(KERN_ERR "sscape: Invalid IRQ %d\n", irq[dev]);
+		snd_printk(KERN_ERR "Invalid IRQ %d\n", irq[dev]);
 		return -ENXIO;
 	}
 
 	mpu_irq_cfg = get_irq_config(sscape->type, mpu_irq[dev]);
 	if (mpu_irq_cfg == INVALID_IRQ) {
-		printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
+		snd_printk(KERN_ERR "Invalid IRQ %d\n", mpu_irq[dev]);
 		return -ENXIO;
 	}
 
@@ -1073,7 +1041,7 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	err = create_ad1845(card, wss_port[dev], irq[dev],
 			    dma[dev], dma2[dev]);
 	if (err < 0) {
-		printk(KERN_ERR "sscape: No AD1845 device at 0x%lx, IRQ %d\n",
+		snd_printk(KERN_ERR "No AD1845 device at 0x%lx, IRQ %d\n",
 		       wss_port[dev], irq[dev]);
 		goto _release_dma;
 	}
@@ -1094,7 +1062,7 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 			err = create_mpu401(card, MIDI_DEVNUM, port[dev],
 					    mpu_irq[dev]);
 			if (err < 0) {
-				printk(KERN_ERR "sscape: Failed to create "
+				snd_printk(KERN_ERR "Failed to create "
 						"MPU-401 device at 0x%lx\n",
 						port[dev]);
 				goto _release_dma;
@@ -1191,7 +1159,7 @@ static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
 		goto _release_card;
 
 	if ((ret = snd_card_register(card)) < 0) {
-		printk(KERN_ERR "sscape: Failed to register sound card\n");
+		snd_printk(KERN_ERR "Failed to register sound card\n");
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
+			snd_printk(KERN_INFO "device is inactive\n");
 			return -EBUSY;
 		}
 	}
@@ -1317,7 +1274,7 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 		goto _release_card;
 
 	if ((ret = snd_card_register(card)) < 0) {
-		printk(KERN_ERR "sscape: Failed to register sound card\n");
+		snd_printk(KERN_ERR "Failed to register sound card\n");
 		goto _release_card;
 	}
 
-- 
1.6.0.3

---------------------------------------------------------------
2012 rok wcale nie musi byæ tragiczny! 
Kliknij >>> http://link.interia.pl/f238b


--===============3115878120735359838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3115878120735359838==--
