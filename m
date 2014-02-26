From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/48] ALSA: cmipci: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:12 +0100
Message-ID: <1393430030-26704-11-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CCBD8265796
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 632DA7502E
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
Some commented debug prints are also enabled as dev_dbg().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cmipci.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 66c0558ce449..12c318e175f4 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -796,7 +796,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 	if (runtime->channels > 1)
 		rec->fmt |= 0x01;
 	if (rec->is_dac && set_dac_channels(cm, rec, runtime->channels) < 0) {
-		snd_printd("cannot set dac channels\n");
+		dev_dbg(cm->card->dev, "cannot set dac channels\n");
 		return -EINVAL;
 	}
 
@@ -827,7 +827,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 	else
 		cm->ctrl |= val;
 	snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
-	//snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl);
+	/* dev_dbg(cm->card->dev, "functrl0 = %08x\n", cm->ctrl); */
 
 	/* set sample rate */
 	freq = 0;
@@ -850,7 +850,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 		val |= (freq << CM_ASFC_SHIFT) & CM_ASFC_MASK;
 	}
 	snd_cmipci_write(cm, CM_REG_FUNCTRL1, val);
-	//snd_printd("cmipci: functrl1 = %08x\n", val);
+	dev_dbg(cm->card->dev, "functrl1 = %08x\n", val);
 
 	/* set format */
 	val = snd_cmipci_read(cm, CM_REG_CHFORMAT);
@@ -866,7 +866,7 @@ static int snd_cmipci_pcm_prepare(struct cmipci *cm, struct cmipci_pcm *rec,
 		val |= freq_ext << (rec->ch * 2);
 	}
 	snd_cmipci_write(cm, CM_REG_CHFORMAT, val);
-	//snd_printd("cmipci: chformat = %08x\n", val);
+	dev_dbg(cm->card->dev, "chformat = %08x\n", val);
 
 	if (!rec->is_dac && cm->chip_version) {
 		if (runtime->rate > 44100)
@@ -904,7 +904,7 @@ static int snd_cmipci_pcm_trigger(struct cmipci *cm, struct cmipci_pcm *rec,
 		cm->ctrl |= chen;
 		/* enable channel */
 		snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
-		//snd_printd("cmipci: functrl0 = %08x\n", cm->ctrl);
+		dev_dbg(cm->card->dev, "functrl0 = %08x\n", cm->ctrl);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		rec->running = 0;
@@ -952,7 +952,7 @@ static snd_pcm_uframes_t snd_cmipci_pcm_pointer(struct cmipci *cm, struct cmipci
 		if (rem < rec->dma_size)
 			goto ok;
 	} 
-	printk(KERN_ERR "cmipci: invalid PCM pointer: %#x\n", rem);
+	dev_err(cm->card->dev, "invalid PCM pointer: %#x\n", rem);
 	return SNDRV_PCM_POS_XRUN;
 ok:
 	ptr = (rec->dma_size - (rem + 1)) >> rec->shift;
@@ -2889,13 +2889,13 @@ static int snd_cmipci_create_gameport(struct cmipci *cm, int dev)
 	}
 
 	if (!r) {
-		printk(KERN_WARNING "cmipci: cannot reserve joystick ports\n");
+		dev_warn(cm->card->dev, "cannot reserve joystick ports\n");
 		return -EBUSY;
 	}
 
 	cm->gameport = gp = gameport_allocate_port();
 	if (!gp) {
-		printk(KERN_ERR "cmipci: cannot allocate memory for gameport\n");
+		dev_err(cm->card->dev, "cannot allocate memory for gameport\n");
 		release_and_free_resource(r);
 		return -ENOMEM;
 	}
@@ -2995,13 +2995,14 @@ static int snd_cmipci_create_fm(struct cmipci *cm, long fm_port)
 
 		if (snd_opl3_create(cm->card, iosynth, iosynth + 2,
 				    OPL3_HW_OPL3, 0, &opl3) < 0) {
-			printk(KERN_ERR "cmipci: no OPL device at %#lx, "
-			       "skipping...\n", iosynth);
+			dev_err(cm->card->dev,
+				"no OPL device at %#lx, skipping...\n",
+				iosynth);
 			goto disable_fm;
 		}
 	}
 	if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-		printk(KERN_ERR "cmipci: cannot create OPL3 hwdep\n");
+		dev_err(cm->card->dev, "cannot create OPL3 hwdep\n");
 		return err;
 	}
 	return 0;
@@ -3060,7 +3061,7 @@ static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 
 	if (request_irq(pci->irq, snd_cmipci_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, cm)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_cmipci_free(cm);
 		return -EBUSY;
 	}
@@ -3192,8 +3193,9 @@ static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 			/* enable UART */
 			snd_cmipci_set_bit(cm, CM_REG_FUNCTRL1, CM_UART_EN);
 			if (inb(iomidi + 1) == 0xff) {
-				snd_printk(KERN_ERR "cannot enable MPU-401 port"
-					   " at %#lx\n", iomidi);
+				dev_err(cm->card->dev,
+					"cannot enable MPU-401 port at %#lx\n",
+					iomidi);
 				snd_cmipci_clear_bit(cm, CM_REG_FUNCTRL1,
 						     CM_UART_EN);
 				iomidi = 0;
@@ -3237,7 +3239,8 @@ static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 						MPU401_INFO_INTEGRATED : 0) |
 					       MPU401_INFO_IRQ_HOOK,
 					       -1, &cm->rmidi)) < 0) {
-			printk(KERN_ERR "cmipci: no UART401 device at 0x%lx\n", iomidi);
+			dev_err(cm->card->dev,
+				"no UART401 device at 0x%lx\n", iomidi);
 		}
 	}
 
@@ -3380,8 +3383,7 @@ static int snd_cmipci_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "cmipci: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
-- 
1.9.0
