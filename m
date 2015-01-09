From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/33] ALSA: azt3328: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:52:49 +0100
Message-ID: <1420818796-30852-7-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5F1260647
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E1E2FAD27
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 15:53:26 +0000 (UTC)
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
 sound/pci/azt3328.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index fdbb9c05c77b..bbacc75c902a 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2694,7 +2694,6 @@ snd_azf3328_resume_ac97(const struct snd_azf3328 *chip)
 static int
 snd_azf3328_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_azf3328 *chip = card->private_data;
 	u16 *saved_regs_ctrl_u16;
@@ -2720,29 +2719,15 @@ snd_azf3328_suspend(struct device *dev)
 		ARRAY_SIZE(chip->saved_regs_mpu), chip->saved_regs_mpu);
 	snd_azf3328_suspend_regs(chip, chip->opl3_io,
 		ARRAY_SIZE(chip->saved_regs_opl3), chip->saved_regs_opl3);
-
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
 	return 0;
 }
 
 static int
 snd_azf3328_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	const struct snd_azf3328 *chip = card->private_data;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-	if (pci_enable_device(pci) < 0) {
-		dev_err(dev, "pci_enable_device failed, disabling device\n");
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-	pci_set_master(pci);
-
 	snd_azf3328_resume_regs(chip, chip->saved_regs_game, chip->game_io,
 					ARRAY_SIZE(chip->saved_regs_game));
 	snd_azf3328_resume_regs(chip, chip->saved_regs_mpu, chip->mpu_io,
-- 
2.2.1
