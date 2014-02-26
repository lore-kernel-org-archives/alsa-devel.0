From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/48] ALSA: es1938: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:16 +0100
Message-ID: <1393430030-26704-15-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DBB7626579E
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7164F75032
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
Some debug prints are replaced with dev_dbg(), too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1938.c | 74 +++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 33489bcc0aff..34d95bf916b5 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -254,7 +254,6 @@ MODULE_DEVICE_TABLE(pci, snd_es1938_ids);
 #define WRITE_LOOP_TIMEOUT	0x10000
 #define GET_LOOP_TIMEOUT	0x01000
 
-#undef REG_DEBUG
 /* -----------------------------------------------------------------
  * Write to a mixer register
  * -----------------------------------------------------------------*/
@@ -265,9 +264,7 @@ static void snd_es1938_mixer_write(struct es1938 *chip, unsigned char reg, unsig
 	outb(reg, SLSB_REG(chip, MIXERADDR));
 	outb(val, SLSB_REG(chip, MIXERDATA));
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);
-#ifdef REG_DEBUG
-	snd_printk(KERN_DEBUG "Mixer reg %02x set to %02x\n", reg, val);
-#endif
+	dev_dbg(chip->card->dev, "Mixer reg %02x set to %02x\n", reg, val);
 }
 
 /* -----------------------------------------------------------------
@@ -281,9 +278,7 @@ static int snd_es1938_mixer_read(struct es1938 *chip, unsigned char reg)
 	outb(reg, SLSB_REG(chip, MIXERADDR));
 	data = inb(SLSB_REG(chip, MIXERDATA));
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);
-#ifdef REG_DEBUG
-	snd_printk(KERN_DEBUG "Mixer reg %02x now is %02x\n", reg, data);
-#endif
+	dev_dbg(chip->card->dev, "Mixer reg %02x now is %02x\n", reg, data);
 	return data;
 }
 
@@ -302,10 +297,9 @@ static int snd_es1938_mixer_bits(struct es1938 *chip, unsigned char reg,
 	if (val != oval) {
 		new = (old & ~mask) | (val & mask);
 		outb(new, SLSB_REG(chip, MIXERDATA));
-#ifdef REG_DEBUG
-		snd_printk(KERN_DEBUG "Mixer reg %02x was %02x, set to %02x\n",
+		dev_dbg(chip->card->dev,
+			"Mixer reg %02x was %02x, set to %02x\n",
 			   reg, old, new);
-#endif
 	}
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);
 	return oval;
@@ -324,7 +318,8 @@ static void snd_es1938_write_cmd(struct es1938 *chip, unsigned char cmd)
 			return;
 		}
 	}
-	printk(KERN_ERR "snd_es1938_write_cmd timeout (0x02%x/0x02%x)\n", cmd, v);
+	dev_err(chip->card->dev,
+		"snd_es1938_write_cmd timeout (0x02%x/0x02%x)\n", cmd, v);
 }
 
 /* -----------------------------------------------------------------
@@ -337,7 +332,7 @@ static int snd_es1938_get_byte(struct es1938 *chip)
 	for (i = GET_LOOP_TIMEOUT; i; i--)
 		if ((v = inb(SLSB_REG(chip, STATUS))) & 0x80)
 			return inb(SLSB_REG(chip, READDATA));
-	snd_printk(KERN_ERR "get_byte timeout: status 0x02%x\n", v);
+	dev_err(chip->card->dev, "get_byte timeout: status 0x02%x\n", v);
 	return -ENODEV;
 }
 
@@ -351,9 +346,7 @@ static void snd_es1938_write(struct es1938 *chip, unsigned char reg, unsigned ch
 	snd_es1938_write_cmd(chip, reg);
 	snd_es1938_write_cmd(chip, val);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-#ifdef REG_DEBUG
-	snd_printk(KERN_DEBUG "Reg %02x set to %02x\n", reg, val);
-#endif
+	dev_dbg(chip->card->dev, "Reg %02x set to %02x\n", reg, val);
 }
 
 /* -----------------------------------------------------------------
@@ -368,9 +361,7 @@ static unsigned char snd_es1938_read(struct es1938 *chip, unsigned char reg)
 	snd_es1938_write_cmd(chip, reg);
 	val = snd_es1938_get_byte(chip);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-#ifdef REG_DEBUG
-	snd_printk(KERN_DEBUG "Reg %02x now is %02x\n", reg, val);
-#endif
+	dev_dbg(chip->card->dev, "Reg %02x now is %02x\n", reg, val);
 	return val;
 }
 
@@ -391,10 +382,8 @@ static int snd_es1938_bits(struct es1938 *chip, unsigned char reg, unsigned char
 		snd_es1938_write_cmd(chip, reg);
 		new = (old & ~mask) | (val & mask);
 		snd_es1938_write_cmd(chip, new);
-#ifdef REG_DEBUG
-		snd_printk(KERN_DEBUG "Reg %02x was %02x, set to %02x\n",
+		dev_dbg(chip->card->dev, "Reg %02x was %02x, set to %02x\n",
 			   reg, old, new);
-#endif
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return oval;
@@ -416,7 +405,7 @@ static void snd_es1938_reset(struct es1938 *chip)
 				goto __next;
 		}
 	}
-	snd_printk(KERN_ERR "ESS Solo-1 reset failed\n");
+	dev_err(chip->card->dev, "ESS Solo-1 reset failed\n");
 
      __next:
 	snd_es1938_write_cmd(chip, ESS_CMD_ENABLEEXT);
@@ -1504,16 +1493,15 @@ static int es1938_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "es1938: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
 
 	if (request_irq(pci->irq, snd_es1938_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-		printk(KERN_ERR "es1938: unable to grab IRQ %d, "
-		       "disabling device\n", pci->irq);
+		dev_err(dev, "unable to grab IRQ %d, disabling device\n",
+			pci->irq);
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -1545,7 +1533,8 @@ static int snd_es1938_create_gameport(struct es1938 *chip)
 
 	chip->gameport = gp = gameport_allocate_port();
 	if (!gp) {
-		printk(KERN_ERR "es1938: cannot allocate memory for gameport\n");
+		dev_err(chip->card->dev,
+			"cannot allocate memory for gameport\n");
 		return -ENOMEM;
 	}
 
@@ -1612,7 +1601,8 @@ static int snd_es1938_create(struct snd_card *card,
         /* check, if we can restrict PCI DMA transfers to 24 bits */
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(24)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(24)) < 0) {
-		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
+		dev_err(card->dev,
+			"architecture does not support 24bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
                 return -ENXIO;
         }
@@ -1639,15 +1629,14 @@ static int snd_es1938_create(struct snd_card *card,
 	chip->game_port = pci_resource_start(pci, 4);
 	if (request_irq(pci->irq, snd_es1938_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_es1938_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-#ifdef ES1938_DDEBUG
-	snd_printk(KERN_DEBUG "create: io: 0x%lx, sb: 0x%lx, vc: 0x%lx, mpu: 0x%lx, game: 0x%lx\n",
+	dev_dbg(card->dev,
+		"create: io: 0x%lx, sb: 0x%lx, vc: 0x%lx, mpu: 0x%lx, game: 0x%lx\n",
 		   chip->io_port, chip->sb_port, chip->vc_port, chip->mpu_port, chip->game_port);
-#endif
 
 	chip->ddma_port = chip->vc_port + 0x00;		/* fix from Thomas Sailer */
 
@@ -1673,21 +1662,22 @@ static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id)
 
 	status = inb(SLIO_REG(chip, IRQCONTROL));
 #if 0
-	printk(KERN_DEBUG "Es1938debug - interrupt status: =0x%x\n", status);
+	dev_dbg(chip->card->dev,
+		"Es1938debug - interrupt status: =0x%x\n", status);
 #endif
 	
 	/* AUDIO 1 */
 	if (status & 0x10) {
 #if 0
-                printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 1 interrupt\n");
-		printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 1 DMAC DMA count: %u\n",
 		       inw(SLDM_REG(chip, DMACOUNT)));
-		printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 1 DMAC DMA base: %u\n",
 		       inl(SLDM_REG(chip, DMAADDR)));
-		printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 1 DMAC DMA status: 0x%x\n",
 		       inl(SLDM_REG(chip, DMASTATUS)));
 #endif
@@ -1703,12 +1693,12 @@ static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id)
 	/* AUDIO 2 */
 	if (status & 0x20) {
 #if 0
-                printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 2 interrupt\n");
-		printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 2 DMAC DMA count: %u\n",
 		       inw(SLIO_REG(chip, AUDIO2DMACOUNT)));
-		printk(KERN_DEBUG
+		dev_dbg(chip->card->dev,
 		       "Es1938debug - AUDIO channel 2 DMAC DMA base: %u\n",
 		       inl(SLIO_REG(chip, AUDIO2DMAADDR)));
 
@@ -1842,7 +1832,7 @@ static int snd_es1938_probe(struct pci_dev *pci,
 			    SLSB_REG(chip, FMLOWADDR),
 			    SLSB_REG(chip, FMHIGHADDR),
 			    OPL3_HW_OPL3, 1, &opl3) < 0) {
-		printk(KERN_ERR "es1938: OPL3 not detected at 0x%lx\n",
+		dev_err(card->dev, "OPL3 not detected at 0x%lx\n",
 			   SLSB_REG(chip, FMLOWADDR));
 	} else {
 	        if ((err = snd_opl3_timer_new(opl3, 0, 1)) < 0) {
@@ -1858,7 +1848,7 @@ static int snd_es1938_probe(struct pci_dev *pci,
 				chip->mpu_port,
 				MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
 				-1, &chip->rmidi) < 0) {
-		printk(KERN_ERR "es1938: unable to initialize MPU-401\n");
+		dev_err(card->dev, "unable to initialize MPU-401\n");
 	} else {
 		// this line is vital for MIDI interrupt handling on ess-solo1
 		// andreas@flying-snail.de
-- 
1.9.0
