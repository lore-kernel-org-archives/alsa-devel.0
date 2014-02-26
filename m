From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/48] ALSA: als4000: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:06 +0100
Message-ID: <1393430030-26704-5-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75E6526576F
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 468AB75023
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
 sound/pci/als4000.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 2b2bb0fa3bc7..b751c381d25e 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -578,7 +578,7 @@ static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id)
 		snd_als4k_iobase_readb(chip->alt_port,
 					ALS4K_IOB_16_ACK_FOR_CR1E);
 
-	/* printk(KERN_INFO "als4000: irq 0x%04x 0x%04x\n",
+	/* dev_dbg(chip->card->dev, "als4000: irq 0x%04x 0x%04x\n",
 					 pci_irqstatus, sb_irqstatus); */
 
 	/* only ack the things we actually handled above */
@@ -791,13 +791,13 @@ static int snd_als4000_create_gameport(struct snd_card_als4000 *acard, int dev)
 	}
 
 	if (!r) {
-		printk(KERN_WARNING "als4000: cannot reserve joystick ports\n");
+		dev_warn(&acard->pci->dev, "cannot reserve joystick ports\n");
 		return -EBUSY;
 	}
 
 	acard->gameport = gp = gameport_allocate_port();
 	if (!gp) {
-		printk(KERN_ERR "als4000: cannot allocate memory for gameport\n");
+		dev_err(&acard->pci->dev, "cannot allocate memory for gameport\n");
 		release_and_free_resource(r);
 		return -ENOMEM;
 	}
@@ -873,7 +873,7 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(24)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(24)) < 0) {
-		snd_printk(KERN_ERR "architecture does not support 24bit PCI busmaster DMA\n");
+		dev_err(&pci->dev, "architecture does not support 24bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -933,7 +933,7 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 					MPU401_INFO_INTEGRATED |
 					MPU401_INFO_IRQ_HOOK,
 					-1, &chip->rmidi)) < 0) {
-		printk(KERN_ERR "als4000: no MPU-401 device at 0x%lx?\n",
+		dev_err(&pci->dev, "no MPU-401 device at 0x%lx?\n",
 				iobase + ALS4K_IOB_30_MIDI_DATA);
 		goto out_err;
 	}
@@ -954,7 +954,7 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 				iobase + ALS4K_IOB_10_ADLIB_ADDR0,
 				iobase + ALS4K_IOB_12_ADLIB_ADDR2,
 			    OPL3_HW_AUTO, 1, &opl3) < 0) {
-		printk(KERN_ERR "als4000: no OPL device at 0x%lx-0x%lx?\n",
+		dev_err(&pci->dev, "no OPL device at 0x%lx-0x%lx?\n",
 			   iobase + ALS4K_IOB_10_ADLIB_ADDR0,
 			   iobase + ALS4K_IOB_12_ADLIB_ADDR2);
 	} else {
@@ -1014,8 +1014,7 @@ static int snd_als4000_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "als4000: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
-- 
1.9.0
