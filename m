From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/48] ALSA: intel8x0m: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:20 +0100
Message-ID: <1393430030-26704-19-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6032657AE
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A8FF57501D
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
 sound/pci/intel8x0m.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index f8c72bd8a3cd..b54d3e93cab1 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -334,7 +334,8 @@ static int snd_intel8x0m_codec_semaphore(struct intel8x0m *chip, unsigned int co
 	/* access to some forbidden (non existent) ac97 registers will not
 	 * reset the semaphore. So even if you don't get the semaphore, still
 	 * continue the access. We don't need the semaphore anyway. */
-	snd_printk(KERN_ERR "codec_semaphore: semaphore is not ready [0x%x][0x%x]\n",
+	dev_err(chip->card->dev,
+		"codec_semaphore: semaphore is not ready [0x%x][0x%x]\n",
 			igetbyte(chip, ICHREG(ACC_SEMA)), igetdword(chip, ICHREG(GLOB_STA)));
 	iagetword(chip, 0);	/* clear semaphore flag */
 	/* I don't care about the semaphore */
@@ -349,7 +350,9 @@ static void snd_intel8x0m_codec_write(struct snd_ac97 *ac97,
 	
 	if (snd_intel8x0m_codec_semaphore(chip, ac97->num) < 0) {
 		if (! chip->in_ac97_init)
-			snd_printk(KERN_ERR "codec_write %d: semaphore is not ready for register 0x%x\n", ac97->num, reg);
+			dev_err(chip->card->dev,
+				"codec_write %d: semaphore is not ready for register 0x%x\n",
+				ac97->num, reg);
 	}
 	iaputword(chip, reg + ac97->num * 0x80, val);
 }
@@ -363,7 +366,9 @@ static unsigned short snd_intel8x0m_codec_read(struct snd_ac97 *ac97,
 
 	if (snd_intel8x0m_codec_semaphore(chip, ac97->num) < 0) {
 		if (! chip->in_ac97_init)
-			snd_printk(KERN_ERR "codec_read %d: semaphore is not ready for register 0x%x\n", ac97->num, reg);
+			dev_err(chip->card->dev,
+				"codec_read %d: semaphore is not ready for register 0x%x\n",
+				ac97->num, reg);
 		res = 0xffff;
 	} else {
 		res = iagetword(chip, reg + ac97->num * 0x80);
@@ -372,7 +377,9 @@ static unsigned short snd_intel8x0m_codec_read(struct snd_ac97 *ac97,
 			iputdword(chip, ICHREG(GLOB_STA),
 				  tmp & ~(ICH_SRI|ICH_PRI|ICH_TRI|ICH_GSCI));
 			if (! chip->in_ac97_init)
-				snd_printk(KERN_ERR "codec_read %d: read timeout for register 0x%x\n", ac97->num, reg);
+				dev_err(chip->card->dev,
+					"codec_read %d: read timeout for register 0x%x\n",
+					ac97->num, reg);
 			res = 0xffff;
 		}
 	}
@@ -412,7 +419,7 @@ static void snd_intel8x0m_setup_periods(struct intel8x0m *chip, struct ichdev *i
 			bdbar[idx + 1] = cpu_to_le32(0x80000000 | /* interrupt on completion */
 						     ichdev->fragsize >> chip->pcm_pos_shift);
 			/*
-			printk(KERN_DEBUG "bdbar[%i] = 0x%x [0x%x]\n",
+			dev_dbg(chip->card->dev, "bdbar[%i] = 0x%x [0x%x]\n",
 			       idx + 0, bdbar[idx + 0], bdbar[idx + 1]);
 			*/
 		}
@@ -424,8 +431,8 @@ static void snd_intel8x0m_setup_periods(struct intel8x0m *chip, struct ichdev *i
 	ichdev->lvi_frag = ICH_REG_LVI_MASK % ichdev->frags;
 	ichdev->position = 0;
 #if 0
-	printk(KERN_DEBUG "lvi_frag = %i, frags = %i, period_size = 0x%x, "
-	       "period_size1 = 0x%x\n",
+	dev_dbg(chip->card->dev,
+		"lvi_frag = %i, frags = %i, period_size = 0x%x, period_size1 = 0x%x\n",
 	       ichdev->lvi_frag, ichdev->frags, ichdev->fragsize,
 	       ichdev->fragsize1);
 #endif
@@ -470,8 +477,8 @@ static inline void snd_intel8x0m_update(struct intel8x0m *chip, struct ichdev *i
 							     ichdev->lvi_frag *
 							     ichdev->fragsize1);
 #if 0
-		printk(KERN_DEBUG "new: bdbar[%i] = 0x%x [0x%x], "
-		       "prefetch = %i, all = 0x%x, 0x%x\n",
+		dev_dbg(chip->card->dev,
+			"new: bdbar[%i] = 0x%x [0x%x], prefetch = %i, all = 0x%x, 0x%x\n",
 		       ichdev->lvi * 2, ichdev->bdbar[ichdev->lvi * 2],
 		       ichdev->bdbar[ichdev->lvi * 2 + 1], inb(ICH_REG_OFF_PIV + port),
 		       inl(port + 4), inb(port + ICH_REG_OFF_CR));
@@ -850,7 +857,8 @@ static int snd_intel8x0m_mixer(struct intel8x0m *chip, int ac97_clock)
 	ac97.pci = chip->pci;
 	ac97.num = glob_sta & ICH_SCR ? 1 : 0;
 	if ((err = snd_ac97_mixer(pbus, &ac97, &x97)) < 0) {
-		snd_printk(KERN_ERR "Unable to initialize codec #%d\n", ac97.num);
+		dev_err(chip->card->dev,
+			"Unable to initialize codec #%d\n", ac97.num);
 		if (ac97.num == 0)
 			goto __err;
 		return err;
@@ -901,7 +909,7 @@ static int snd_intel8x0m_ich_chip_init(struct intel8x0m *chip, int probing)
 			goto __ok;
 		schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(end_time, jiffies));
-	snd_printk(KERN_ERR "AC'97 warm reset still in progress? [0x%x]\n",
+	dev_err(chip->card->dev, "AC'97 warm reset still in progress? [0x%x]\n",
 		   igetdword(chip, ICHREG(GLOB_CNT)));
 	return -EIO;
 
@@ -921,7 +929,8 @@ static int snd_intel8x0m_ich_chip_init(struct intel8x0m *chip, int probing)
 		} while (time_after_eq(end_time, jiffies));
 		if (! status) {
 			/* no codec is found */
-			snd_printk(KERN_ERR "codec_ready: codec is not ready [0x%x]\n",
+			dev_err(chip->card->dev,
+				"codec_ready: codec is not ready [0x%x]\n",
 				   igetdword(chip, ICHREG(GLOB_STA)));
 			return -EIO;
 		}
@@ -1042,16 +1051,15 @@ static int intel8x0m_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "intel8x0m: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
 	pci_set_master(pci);
 	if (request_irq(pci->irq, snd_intel8x0m_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-		printk(KERN_ERR "intel8x0m: unable to grab IRQ %d, "
-		       "disabling device\n", pci->irq);
+		dev_err(dev, "unable to grab IRQ %d, disabling device\n",
+			pci->irq);
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -1165,7 +1173,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	else
 		chip->addr = pci_iomap(pci, 0, 0);
 	if (!chip->addr) {
-		snd_printk(KERN_ERR "AC'97 space ioremap problem\n");
+		dev_err(card->dev, "AC'97 space ioremap problem\n");
 		snd_intel8x0m_free(chip);
 		return -EIO;
 	}
@@ -1174,7 +1182,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	else
 		chip->bmaddr = pci_iomap(pci, 1, 0);
 	if (!chip->bmaddr) {
-		snd_printk(KERN_ERR "Controller space ioremap problem\n");
+		dev_err(card->dev, "Controller space ioremap problem\n");
 		snd_intel8x0m_free(chip);
 		return -EIO;
 	}
@@ -1182,7 +1190,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
  port_inited:
 	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_intel8x0m_free(chip);
 		return -EBUSY;
 	}
-- 
1.9.0
