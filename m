From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/48] ALSA: es1968: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:17 +0100
Message-ID: <1393430030-26704-16-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FD712657BB
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 739E875033
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1968.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 87e9cd5d3ceb..5bb1cf603301 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -632,7 +632,7 @@ static int snd_es1968_ac97_wait(struct es1968 *chip)
 			return 0;
 		cond_resched();
 	}
-	snd_printd("es1968: ac97 timeout\n");
+	dev_dbg(chip->card->dev, "ac97 timeout\n");
 	return 1; /* timeout */
 }
 
@@ -644,7 +644,7 @@ static int snd_es1968_ac97_wait_poll(struct es1968 *chip)
 		if (!(inb(chip->io_port + ESM_AC97_INDEX) & 1))
 			return 0;
 	}
-	snd_printd("es1968: ac97 timeout\n");
+	dev_dbg(chip->card->dev, "ac97 timeout\n");
 	return 1; /* timeout */
 }
 
@@ -687,7 +687,7 @@ static void apu_index_set(struct es1968 *chip, u16 index)
 	for (i = 0; i < 1000; i++)
 		if (__maestro_read(chip, IDR1_CRAM_POINTER) == index)
 			return;
-	snd_printd("es1968: APU register select failed. (Timeout)\n");
+	dev_dbg(chip->card->dev, "APU register select failed. (Timeout)\n");
 }
 
 /* no spinlock */
@@ -699,7 +699,7 @@ static void apu_data_set(struct es1968 *chip, u16 data)
 			return;
 		__maestro_write(chip, IDR0_DATA_PORT, data);
 	}
-	snd_printd("es1968: APU register set probably failed (Timeout)!\n");
+	dev_dbg(chip->card->dev, "APU register set probably failed (Timeout)!\n");
 }
 
 /* no spinlock */
@@ -1442,13 +1442,14 @@ snd_es1968_init_dmabuf(struct es1968 *chip)
 					   snd_dma_pci_data(chip->pci),
 					   chip->total_bufsize, &chip->dma);
 	if (err < 0 || ! chip->dma.area) {
-		snd_printk(KERN_ERR "es1968: can't allocate dma pages for size %d\n",
+		dev_err(chip->card->dev,
+			"can't allocate dma pages for size %d\n",
 			   chip->total_bufsize);
 		return -ENOMEM;
 	}
 	if ((chip->dma.addr + chip->dma.bytes - 1) & ~((1 << 28) - 1)) {
 		snd_dma_free_pages(&chip->dma);
-		snd_printk(KERN_ERR "es1968: DMA buffer beyond 256MB.\n");
+		dev_err(chip->card->dev, "DMA buffer beyond 256MB.\n");
 		return -ENOMEM;
 	}
 
@@ -1489,7 +1490,8 @@ static int snd_es1968_hw_params(struct snd_pcm_substream *substream,
 	}
 	chan->memory = snd_es1968_new_memory(chip, size);
 	if (chan->memory == NULL) {
-		// snd_printd("cannot allocate dma buffer: size = %d\n", size);
+		dev_dbg(chip->card->dev,
+			"cannot allocate dma buffer: size = %d\n", size);
 		return -ENOMEM;
 	}
 	snd_pcm_set_runtime_buffer(substream, &chan->memory->buf);
@@ -1715,11 +1717,13 @@ static void es1968_measure_clock(struct es1968 *chip)
 
 	/* search 2 APUs (although one apu is enough) */
 	if ((apu = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_PLAY)) < 0) {
-		snd_printk(KERN_ERR "Hmm, cannot find empty APU pair!?\n");
+		dev_err(chip->card->dev, "Hmm, cannot find empty APU pair!?\n");
 		return;
 	}
 	if ((memory = snd_es1968_new_memory(chip, CLOCK_MEASURE_BUFSIZE)) == NULL) {
-		snd_printk(KERN_ERR "cannot allocate dma buffer - using default clock %d\n", chip->clock);
+		dev_warn(chip->card->dev,
+			 "cannot allocate dma buffer - using default clock %d\n",
+			 chip->clock);
 		snd_es1968_free_apu_pair(chip, apu);
 		return;
 	}
@@ -1780,7 +1784,7 @@ static void es1968_measure_clock(struct es1968 *chip)
 	else
 		t += stop_time.tv_usec - start_time.tv_usec;
 	if (t == 0) {
-		snd_printk(KERN_ERR "?? calculation error..\n");
+		dev_err(chip->card->dev, "?? calculation error..\n");
 	} else {
 		offset *= 1000;
 		offset = (offset / t) * 1000 + ((offset % t) * 1000) / t;
@@ -1788,7 +1792,7 @@ static void es1968_measure_clock(struct es1968 *chip)
 			if (offset >= 40000 && offset <= 50000)
 				chip->clock = (chip->clock * offset) / 48000;
 		}
-		printk(KERN_INFO "es1968: clocking to %d\n", chip->clock);
+		dev_info(chip->card->dev, "clocking to %d\n", chip->clock);
 	}
 	snd_es1968_free_memory(chip, memory);
 	snd_es1968_free_apu_pair(chip, apu);
@@ -2108,7 +2112,7 @@ static void snd_es1968_ac97_reset(struct es1968 *chip)
 	outw(inw(ioaddr + 0x3c) & 0xfffc, ioaddr + 0x3c);
 
 #if 0				/* the loop here needs to be much better if we want it.. */
-	snd_printk(KERN_INFO "trying software reset\n");
+	dev_info(chip->card->dev, "trying software reset\n");
 	/* try and do a software reset */
 	outb(0x80 | 0x7c, ioaddr + 0x30);
 	for (w = 0;; w++) {
@@ -2416,8 +2420,7 @@ static int es1968_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "es1968: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -2479,7 +2482,8 @@ static int snd_es1968_create_gameport(struct es1968 *chip, int dev)
 
 	chip->gameport = gp = gameport_allocate_port();
 	if (!gp) {
-		printk(KERN_ERR "es1968: cannot allocate memory for gameport\n");
+		dev_err(chip->card->dev,
+			"cannot allocate memory for gameport\n");
 		release_and_free_resource(r);
 		return -ENOMEM;
 	}
@@ -2706,7 +2710,8 @@ static int snd_es1968_create(struct snd_card *card,
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(28)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(28)) < 0) {
-		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
+		dev_err(card->dev,
+			"architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -2740,7 +2745,7 @@ static int snd_es1968_create(struct snd_card *card,
 	chip->io_port = pci_resource_start(pci, 0);
 	if (request_irq(pci->irq, snd_es1968_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_es1968_free(chip);
 		return -EBUSY;
 	}
@@ -2770,7 +2775,7 @@ static int snd_es1968_create(struct snd_card *card,
 		}
 		if (do_pm > 1) {
 			/* not matched; disabling pm */
-			printk(KERN_INFO "es1968: not attempting power management.\n");
+			dev_info(card->dev, "not attempting power management.\n");
 			do_pm = 0;
 		}
 	}
@@ -2800,7 +2805,7 @@ static int snd_es1968_create(struct snd_card *card,
 	for (i = 0; i < ARRAY_SIZE(snd_es1968_tea575x_gpios); i++) {
 		chip->tea575x_tuner = i;
 		if (!snd_tea575x_init(&chip->tea, THIS_MODULE)) {
-			snd_printk(KERN_INFO "es1968: detected TEA575x radio type %s\n",
+			dev_info(card->dev, "detected TEA575x radio type %s\n",
 				   get_tea575x_gpio(chip)->name);
 			strlcpy(chip->tea.card, get_tea575x_gpio(chip)->name,
 				sizeof(chip->tea.card));
@@ -2899,7 +2904,7 @@ static int snd_es1968_probe(struct pci_dev *pci,
 					       MPU401_INFO_INTEGRATED |
 					       MPU401_INFO_IRQ_HOOK,
 					       -1, &chip->rmidi)) < 0) {
-			printk(KERN_WARNING "es1968: skipping MPU-401 MIDI support..\n");
+			dev_warn(card->dev, "skipping MPU-401 MIDI support..\n");
 		}
 	}
 
@@ -2908,8 +2913,8 @@ static int snd_es1968_probe(struct pci_dev *pci,
 #ifdef CONFIG_SND_ES1968_INPUT
 	err = snd_es1968_input_register(chip);
 	if (err)
-		snd_printk(KERN_WARNING "Input device registration "
-			"failed with error %i", err);
+		dev_warn(card->dev,
+			 "Input device registration failed with error %i", err);
 #endif
 
 	snd_es1968_start_irq(chip);
-- 
1.9.0
