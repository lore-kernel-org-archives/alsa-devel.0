From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/33] ALSA: intel8x0: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:53:04 +0100
Message-ID: <1420818796-30852-22-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FEB22617AD
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0E478ADAA
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 15:53:27 +0000 (UTC)
In-Reply-To: <1420818796-30852-1-git-send-email-tiwai@suse.de>
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

This is a similar cleanup like the commit [3db084fd0af5: ALSA: fm801:
PCI core handles power state for us].

Since pci_set_power_state(), pci_save_state() and pci_restore_state()
are already done in the PCI core side, so we don't need to it doubly.

Also, pci_enable_device(), pci_disable_device() and pci_set_master()
calls in PM callbacks are superfluous nowadays, too, so get rid of
them as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 4a28252a42b9..67f9e8b77385 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2654,7 +2654,6 @@ static int snd_intel8x0_free(struct intel8x0 *chip)
  */
 static int intel8x0_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct intel8x0 *chip = card->private_data;
 	int i;
@@ -2682,12 +2681,6 @@ static int intel8x0_suspend(struct device *dev)
 		free_irq(chip->irq, chip);
 		chip->irq = -1;
 	}
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	/* The call below may disable built-in speaker on some laptops
-	 * after S2RAM.  So, don't touch it.
-	 */
-	/* pci_set_power_state(pci, PCI_D3hot); */
 	return 0;
 }
 
@@ -2698,14 +2691,6 @@ static int intel8x0_resume(struct device *dev)
 	struct intel8x0 *chip = card->private_data;
 	int i;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-	if (pci_enable_device(pci) < 0) {
-		dev_err(dev, "pci_enable_device failed, disabling device\n");
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-	pci_set_master(pci);
 	snd_intel8x0_chip_init(chip, 0);
 	if (request_irq(pci->irq, snd_intel8x0_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-- 
2.2.1
