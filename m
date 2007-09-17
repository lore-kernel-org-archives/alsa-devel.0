From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] sscape: support for audio part of VIVO cards
	(2nd rev)
Date: Mon, 17 Sep 2007 17:19:12 +0200
Message-ID: <20070917171912.8c3c6aa5.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 83869103863
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 17:11:54 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so695691wri
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 08:11:53 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds support for audio part of the Ensoniq
SoundScape VIVO cards. The MIDI part is not supported.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

I created waiting loop and the previous magic write
after the code in the OSS driver. The whole detection
is magic from the OSS driver.

The MPU is not created on VIVO cards as it does not work.

The linear frequency setting for the AD1845 does not work
for me (the frequency is incorrectly set).

This patch has fixed all issues pointed by Takashi.

diff -urp linux-ref/sound/isa/sscape.c linux-2.6.23/sound/isa/sscape.c
--- linux-ref/sound/isa/sscape.c	2007-09-17 16:10:26.236133255 +0200
+++ linux-2.6.23/sound/isa/sscape.c	2007-09-17 16:13:29.094553764 +0200
@@ -142,10 +142,12 @@ enum card_type {
 struct soundscape {
 	spinlock_t lock;
 	unsigned io_base;
+	unsigned wss_base;
 	int codec_type;
 	int ic_type;
 	enum card_type type;
 	struct resource *io_res;
+	struct resource *wss_res;
 	struct snd_cs4231 *chip;
 	struct snd_mpu401 *mpu;
 	struct snd_hwdep *hw;
@@ -356,8 +358,9 @@ static inline void activate_ad1845_unsaf
  */
 static void soundscape_free(struct snd_card *c)
 {
-	register struct soundscape *sscape = get_card_soundscape(c);
+	struct soundscape *sscape = get_card_soundscape(c);
 	release_and_free_resource(sscape->io_res);
+	release_and_free_resource(sscape->wss_res);
 	free_dma(sscape->chip->dma1);
 }
 
@@ -818,6 +821,7 @@ static int __devinit detect_sscape(struc
 	unsigned long flags;
 	unsigned d;
 	int retval = 0;
+	int codec = s->wss_base;
 
 	spin_lock_irqsave(&s->lock, flags);
 
@@ -849,9 +853,27 @@ static int __devinit detect_sscape(struc
 	outb(0xfe, ODIE_ADDR_IO(s->io_base));
 	if ((inb(ODIE_ADDR_IO(s->io_base)) & 0x9f) != 0x0e)
 		goto _done;
-	if ((inb(ODIE_DATA_IO(s->io_base)) & 0x9f) != 0x0e)
+
+	outb(0xfe, ODIE_ADDR_IO(s->io_base));
+	d = inb(ODIE_DATA_IO(s->io_base));
+	if (s->type != SSCAPE_VIVO && (d & 0x9f) != 0x0e)
 		goto _done;
 
+	d  = sscape_read_unsafe(s->io_base, GA_HMCTL_REG) & 0x3f;
+	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, d | 0xc0);
+
+	if (s->type == SSCAPE_VIVO)
+		codec += 4;
+	/* wait for WSS codec */
+	for (d = 0; d < 500; d++) {
+		if ((inb(codec) & 0x80) == 0)
+			break;
+		spin_unlock_irqrestore(&s->lock, flags);
+		msleep(1);
+		spin_lock_irqsave(&s->lock, flags);
+	}
+	snd_printd(KERN_INFO "init delay = %d ms\n", d);
+
 	/*
 	 * SoundScape successfully detected!
 	 */
@@ -1018,6 +1040,9 @@ static int __devinit create_ad1845(struc
 	struct snd_cs4231 *chip;
 	int err;
 
+	if (sscape->type == SSCAPE_VIVO)
+		port += 4;
+
 	if (dma1 == dma2)
 		dma2 = -1;
 
@@ -1046,50 +1071,72 @@ static int __devinit create_ad1845(struc
     snd_cs4231_mce_down(chip);
  */
 
-		/*
-		 * The input clock frequency on the SoundScape must
-		 * be 14.31818 MHz, because we must set this register
-		 * to get the playback to sound correct ...
-		 */
-		snd_cs4231_mce_up(chip);
-		spin_lock_irqsave(&chip->reg_lock, flags);
-		snd_cs4231_out(chip, AD1845_CRYS_CLOCK_SEL, 0x20);
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		snd_cs4231_mce_down(chip);
+		if (sscape->type != SSCAPE_VIVO) {
+			int val;
+			/*
+			 * The input clock frequency on the SoundScape must
+			 * be 14.31818 MHz, because we must set this register
+			 * to get the playback to sound correct ...
+			 */
+			snd_cs4231_mce_up(chip);
+			spin_lock_irqsave(&chip->reg_lock, flags);
+			snd_cs4231_out(chip, AD1845_CRYS_CLOCK_SEL, 0x20);
+			spin_unlock_irqrestore(&chip->reg_lock, flags);
+			snd_cs4231_mce_down(chip);
 
-		/*
-		 * More custom configuration:
-		 * a) select "mode 2", and provide a current drive of 8 mA
-		 * b) enable frequency selection (for capture/playback)
-		 */
-		spin_lock_irqsave(&chip->reg_lock, flags);
-		snd_cs4231_out(chip, CS4231_MISC_INFO, (CS4231_MODE2 | 0x10));
-		snd_cs4231_out(chip, AD1845_PWR_DOWN_CTRL, snd_cs4231_in(chip, AD1845_PWR_DOWN_CTRL) | AD1845_FREQ_SEL_ENABLE);
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
+			/*
+			 * More custom configuration:
+			 * a) select "mode 2" and provide a current drive of 8mA
+			 * b) enable frequency selection (for capture/playback)
+			 */
+			spin_lock_irqsave(&chip->reg_lock, flags);
+			snd_cs4231_out(chip, CS4231_MISC_INFO,
+					CS4231_MODE2 | 0x10);
+			val = snd_cs4231_in(chip, AD1845_PWR_DOWN_CTRL);
+			snd_cs4231_out(chip, AD1845_PWR_DOWN_CTRL,
+					val | AD1845_FREQ_SEL_ENABLE);
+			spin_unlock_irqrestore(&chip->reg_lock, flags);
+		}
 
-		if ((err = snd_cs4231_pcm(chip, 0, &pcm)) < 0) {
-			snd_printk(KERN_ERR "sscape: No PCM device for AD1845 chip\n");
+		err = snd_cs4231_pcm(chip, 0, &pcm);
+		if (err < 0) {
+			snd_printk(KERN_ERR "sscape: No PCM device "
+					    "for AD1845 chip\n");
 			goto _error;
 		}
 
-		if ((err = snd_cs4231_mixer(chip)) < 0) {
-			snd_printk(KERN_ERR "sscape: No mixer device for AD1845 chip\n");
+		err = snd_cs4231_mixer(chip);
+		if (err < 0) {
+			snd_printk(KERN_ERR "sscape: No mixer device "
+					    "for AD1845 chip\n");
 			goto _error;
 		}
-
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&midi_mixer_ctl, chip))) < 0) {
-			snd_printk(KERN_ERR "sscape: Could not create MIDI mixer control\n");
+		err = snd_cs4231_timer(chip, 0, NULL);
+		if (err < 0) {
+			snd_printk(KERN_ERR "sscape: No timer device "
+					    "for AD1845 chip\n");
 			goto _error;
 		}
 
+		if (sscape->type != SSCAPE_VIVO) {
+			err = snd_ctl_add(card,
+					  snd_ctl_new1(&midi_mixer_ctl, chip));
+			if (err < 0) {
+				snd_printk(KERN_ERR "sscape: Could not create "
+						    "MIDI mixer control\n");
+				goto _error;
+			}
+			chip->set_playback_format = ad1845_playback_format;
+			chip->set_capture_format = ad1845_capture_format;
+		}
+
 		strcpy(card->driver, "SoundScape");
 		strcpy(card->shortname, pcm->name);
 		snprintf(card->longname, sizeof(card->longname),
 			 "%s at 0x%lx, IRQ %d, DMA1 %d, DMA2 %d\n",
 			 pcm->name, chip->port, chip->irq,
 			 chip->dma1, chip->dma2);
-		chip->set_playback_format = ad1845_playback_format;
-		chip->set_capture_format = ad1845_capture_format;
+
 		sscape->chip = chip;
 	}
 
@@ -1104,12 +1151,13 @@ static int __devinit create_ad1845(struc
  */
 static int __devinit create_sscape(int dev, struct snd_card *card)
 {
-	register struct soundscape *sscape;
-	register unsigned dma_cfg;
+	struct soundscape *sscape = get_card_soundscape(card);
+	unsigned dma_cfg;
 	unsigned irq_cfg;
 	unsigned mpu_irq_cfg;
 	unsigned xport;
 	struct resource *io_res;
+	struct resource *wss_res;
 	unsigned long flags;
 	int err;
 
@@ -1133,13 +1181,24 @@ static int __devinit create_sscape(int d
 	 * Grab IO ports that we will need to probe so that we
 	 * can detect and control this hardware ...
 	 */
-	if ((io_res = request_region(xport, 8, "SoundScape")) == NULL) {
+	io_res = request_region(xport, 8, "SoundScape");
+	if (!io_res) {
 		snd_printk(KERN_ERR "sscape: can't grab port 0x%x\n", xport);
 		return -EBUSY;
 	}
+	wss_res = NULL;
+	if (sscape->type == SSCAPE_VIVO) {
+		wss_res = request_region(wss_port[dev], 4, "SoundScape");
+		if (!wss_res) {
+			snd_printk(KERN_ERR "sscape: can't grab port 0x%lx\n",
+					    wss_port[dev]);
+			err = -EBUSY;
+			goto _release_region;
+		}
+	}
 
 	/*
-	 * Grab both DMA channels (OK, only one for now) ...
+	 * Grab one DMA channel ...
 	 */
 	err = request_dma(dma[dev], "SoundScape");
 	if (err < 0) {
@@ -1147,11 +1206,12 @@ static int __devinit create_sscape(int d
 		goto _release_region;
 	}
 
-	sscape = get_card_soundscape(card);
 	spin_lock_init(&sscape->lock);
 	spin_lock_init(&sscape->fwlock);
 	sscape->io_res = io_res;
+	sscape->wss_res = wss_res;
 	sscape->io_base = xport;
+	sscape->wss_base = wss_port[dev];
 
 	if (!detect_sscape(sscape)) {
 		printk(KERN_ERR "sscape: hardware not detected at 0x%x\n", sscape->io_base);
@@ -1162,23 +1222,28 @@ static int __devinit create_sscape(int d
 	printk(KERN_INFO "sscape: hardware detected at 0x%x, using IRQ %d, DMA %d\n",
 			 sscape->io_base, irq[dev], dma[dev]);
 
-	/*
-	 * Now create the hardware-specific device so that we can
-	 * load the microcode into the on-board processor.
-	 * We cannot use the MPU-401 MIDI system until this firmware
-	 * has been loaded into the card.
-	 */
-	if ((err = snd_hwdep_new(card, "MC68EC000", 0, &(sscape->hw))) < 0) {
-		printk(KERN_ERR "sscape: Failed to create firmware device\n");
-		goto _release_dma;
+	if (sscape->type != SSCAPE_VIVO) {
+		/*
+		 * Now create the hardware-specific device so that we can
+		 * load the microcode into the on-board processor.
+		 * We cannot use the MPU-401 MIDI system until this firmware
+		 * has been loaded into the card.
+		 */
+		err = snd_hwdep_new(card, "MC68EC000", 0, &(sscape->hw));
+		if (err < 0) {
+			printk(KERN_ERR "sscape: Failed to create "
+					"firmware device\n");
+			goto _release_dma;
+		}
+		strlcpy(sscape->hw->name, "SoundScape M68K",
+			sizeof(sscape->hw->name));
+		sscape->hw->name[sizeof(sscape->hw->name) - 1] = '\0';
+		sscape->hw->iface = SNDRV_HWDEP_IFACE_SSCAPE;
+		sscape->hw->ops.open = sscape_hw_open;
+		sscape->hw->ops.release = sscape_hw_release;
+		sscape->hw->ops.ioctl = sscape_hw_ioctl;
+		sscape->hw->private_data = sscape;
 	}
-	strlcpy(sscape->hw->name, "SoundScape M68K", sizeof(sscape->hw->name));
-	sscape->hw->name[sizeof(sscape->hw->name) - 1] = '\0';
-	sscape->hw->iface = SNDRV_HWDEP_IFACE_SSCAPE;
-	sscape->hw->ops.open = sscape_hw_open;
-	sscape->hw->ops.release = sscape_hw_release;
-	sscape->hw->ops.ioctl = sscape_hw_ioctl;
-	sscape->hw->private_data = sscape;
 
 	/*
 	 * Tell the on-board devices where their resources are (I think -
@@ -1220,24 +1285,29 @@ static int __devinit create_sscape(int d
 		goto _release_dma;
 	}
 #define MIDI_DEVNUM  0
-	if ((err = create_mpu401(card, MIDI_DEVNUM, MPU401_IO(xport), mpu_irq[dev])) < 0) {
-		printk(KERN_ERR "sscape: Failed to create MPU-401 device at 0x%x\n",
-		                MPU401_IO(xport));
-		goto _release_dma;
-	}
+	if (sscape->type != SSCAPE_VIVO) {
+		err = create_mpu401(card, MIDI_DEVNUM,
+				    MPU401_IO(xport), mpu_irq[dev]);
+		if (err < 0) {
+			printk(KERN_ERR "sscape: Failed to create "
+					"MPU-401 device at 0x%x\n",
+					MPU401_IO(xport));
+			goto _release_dma;
+		}
 
-	/*
-	 * Enable the master IRQ ...
-	 */
-	sscape_write(sscape, GA_INTENA_REG, 0x80);
+		/*
+		 * Enable the master IRQ ...
+		 */
+		sscape_write(sscape, GA_INTENA_REG, 0x80);
 
-	/*
-	 * Initialize mixer
-	 */
-	sscape->midi_vol = 0;
-	host_write_ctrl_unsafe(sscape->io_base, CMD_SET_MIDI_VOL, 100);
-	host_write_ctrl_unsafe(sscape->io_base, 0, 100);
-	host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI_VOL, 100);
+		/*
+		 * Initialize mixer
+		 */
+		sscape->midi_vol = 0;
+		host_write_ctrl_unsafe(sscape->io_base, CMD_SET_MIDI_VOL, 100);
+		host_write_ctrl_unsafe(sscape->io_base, 0, 100);
+		host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI_VOL, 100);
+	}
 
 	/*
 	 * Now that we have successfully created this sound card,
@@ -1253,6 +1323,7 @@ _release_dma:
 	free_dma(dma[dev]);
 
 _release_region:
+	release_and_free_resource(wss_res);
 	release_and_free_resource(io_res);
 
 	return err;
@@ -1404,12 +1475,6 @@ static int __devinit sscape_pnp_detect(s
 	else
 		sscape->type = SSCAPE_PNP;
 
-	/* VIVO fails for now */
-	if (sscape->type == SSCAPE_VIVO) {
-		ret = -ENODEV;
-		goto _release_card;
-	}
-
 	/*
 	 * Read the correct parameters off the ISA PnP bus ...
 	 */
@@ -1417,8 +1482,13 @@ static int __devinit sscape_pnp_detect(s
 	irq[idx] = pnp_irq(dev, 0);
 	mpu_irq[idx] = pnp_irq(dev, 1);
 	dma[idx] = pnp_dma(dev, 0) & 0x03;
-	dma2[idx] = dma[idx];
-	wss_port[idx] = CODEC_IO(port[idx]);
+	if (sscape->type == SSCAPE_PNP) {
+		dma2[idx] = dma[idx];
+		wss_port[idx] = CODEC_IO(port[idx]);
+	} else {
+		wss_port[idx] = pnp_port_start(dev, 1);
+		dma2[idx] = pnp_dma(dev, 1);
+	}
 
 	ret = create_sscape(idx, card);
 	if (ret < 0)
