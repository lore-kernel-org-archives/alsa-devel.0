From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/33] ALSA: nm256: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:53:07 +0100
Message-ID: <1420818796-30852-25-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B24D261A5F
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 12824ADAF
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
 sound/pci/nm256/nm256.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 4e41a4e29a1e..8598f2b47eb3 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1392,7 +1392,6 @@ snd_nm256_peek_for_sig(struct nm256 *chip)
  */
 static int nm256_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct nm256 *chip = card->private_data;
 
@@ -1400,15 +1399,11 @@ static int nm256_suspend(struct device *dev)
 	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 	chip->coeffs_current = 0;
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
 	return 0;
 }
 
 static int nm256_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct nm256 *chip = card->private_data;
 	int i;
@@ -1416,15 +1411,6 @@ static int nm256_resume(struct device *dev)
 	/* Perform a full reset on the hardware */
 	chip->in_resume = 1;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-	if (pci_enable_device(pci) < 0) {
-		dev_err(dev, "pci_enable_device failed, disabling device\n");
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-	pci_set_master(pci);
-
 	snd_nm256_init_chip(chip);
 
 	/* restore ac97 */
-- 
2.2.1
