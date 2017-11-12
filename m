From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: als4000: Use common error handling code
 in snd_card_als4000_probe()
Date: Sun, 12 Nov 2017 14:04:55 +0100
Message-ID: <c954ffd3-ef05-295f-1318-f05aab0aace4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 63790266A73
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 14:05:06 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Nov 2017 13:50:48 +0100

* Adjust jump targets so that a bit of exception handling can be better
  reused at the end of this function.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix eight affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/als4000.c | 90 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 26b097edec8c..e63598c036f6 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -867,21 +867,22 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	}
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0) {
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
-	}
+
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(24)) < 0) {
 		dev_err(&pci->dev, "architecture does not support 24bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 
-	if ((err = pci_request_regions(pci, "ALS4000")) < 0) {
-		pci_disable_device(pci);
-		return err;
-	}
+	err = pci_request_regions(pci, "ALS4000");
+	if (err < 0)
+		goto disable_device;
+
 	iobase = pci_resource_start(pci, 0);
 
 	pci_read_config_word(pci, PCI_COMMAND, &word);
@@ -893,8 +894,7 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 			   &card);
 	if (err < 0) {
 		pci_release_regions(pci);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 
 	acard = card->private_data;
@@ -905,17 +905,18 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	/* disable all legacy ISA stuff */
 	snd_als4000_set_addr(acard->iobase, 0, 0, 0, 0);
 
-	if ((err = snd_sbdsp_create(card,
-				    iobase + ALS4K_IOB_10_ADLIB_ADDR0,
-				    pci->irq,
+	err = snd_sbdsp_create(card,
+			       iobase + ALS4K_IOB_10_ADLIB_ADDR0,
+			       pci->irq,
 		/* internally registered as IRQF_SHARED in case of ALS4000 SB */
-				    snd_als4000_interrupt,
-				    -1,
-				    -1,
-				    SB_HW_ALS4000,
-				    &chip)) < 0) {
-		goto out_err;
-	}
+			       snd_als4000_interrupt,
+			       -1,
+			       -1,
+			       SB_HW_ALS4000,
+			       &chip);
+	if (err < 0)
+		goto free_card;
+
 	acard->chip = chip;
 
 	chip->pci = pci;
@@ -928,14 +929,14 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->alt_port, chip->irq);
 
-	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_ALS4000,
-					iobase + ALS4K_IOB_30_MIDI_DATA,
-					MPU401_INFO_INTEGRATED |
-					MPU401_INFO_IRQ_HOOK,
-					-1, &chip->rmidi)) < 0) {
+	err = snd_mpu401_uart_new(card, 0, MPU401_HW_ALS4000,
+				  iobase + ALS4K_IOB_30_MIDI_DATA,
+				  MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
+				  -1, &chip->rmidi);
+	if (err < 0) {
 		dev_err(&pci->dev, "no MPU-401 device at 0x%lx?\n",
 				iobase + ALS4K_IOB_30_MIDI_DATA);
-		goto out_err;
+		goto free_card;
 	}
 	/* FIXME: ALS4000 has interesting MPU401 configuration features
 	 * at ALS4K_CR1A_MPU401_UART_MODE_CONTROL
@@ -943,12 +944,13 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	 * however there doesn't seem to be an ALSA API for this...
 	 * SPECS_PAGE: 21 */
 
-	if ((err = snd_als4000_pcm(chip, 0)) < 0) {
-		goto out_err;
-	}
-	if ((err = snd_sbmixer_new(chip)) < 0) {
-		goto out_err;
-	}	    
+	err = snd_als4000_pcm(chip, 0);
+	if (err < 0)
+		goto free_card;
+
+	err = snd_sbmixer_new(chip);
+	if (err < 0)
+		goto free_card;
 
 	if (snd_opl3_create(card,
 				iobase + ALS4K_IOB_10_ADLIB_ADDR0,
@@ -958,25 +960,27 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 			   iobase + ALS4K_IOB_10_ADLIB_ADDR0,
 			   iobase + ALS4K_IOB_12_ADLIB_ADDR2);
 	} else {
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-			goto out_err;
-		}
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0)
+			goto free_card;
 	}
 
 	snd_als4000_create_gameport(acard, dev);
 
-	if ((err = snd_card_register(card)) < 0) {
-		goto out_err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	dev++;
-	err = 0;
-	goto out;
+	return 0;
 
-out_err:
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+free_card:
 	snd_card_free(card);
-	
-out:
 	return err;
 }
 
-- 
2.15.0
