From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/33] ALSA: sis7019: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:53:11 +0100
Message-ID: <1420818796-30852-29-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D78B261A97
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 23036ABFC
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
 sound/pci/sis7019.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 7f6a0a0d115a..be8952f6804d 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1211,7 +1211,6 @@ static int sis_chip_init(struct sis7019 *sis)
 #ifdef CONFIG_PM_SLEEP
 static int sis_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct sis7019 *sis = card->private_data;
 	void __iomem *ioaddr = sis->ioaddr;
@@ -1240,9 +1239,6 @@ static int sis_suspend(struct device *dev)
 		ioaddr += 4096;
 	}
 
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
 	return 0;
 }
 
@@ -1254,14 +1250,6 @@ static int sis_resume(struct device *dev)
 	void __iomem *ioaddr = sis->ioaddr;
 	int i;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-
-	if (pci_enable_device(pci) < 0) {
-		dev_err(&pci->dev, "unable to re-enable device\n");
-		goto error;
-	}
-
 	if (sis_chip_init(sis)) {
 		dev_err(&pci->dev, "unable to re-init controller\n");
 		goto error;
@@ -1284,7 +1272,6 @@ static int sis_resume(struct device *dev)
 	memset(sis->suspend_state[0], 0, 4096);
 
 	sis->irq = pci->irq;
-	pci_set_master(pci);
 
 	if (sis->codecs_present & SIS_PRIMARY_CODEC_PRESENT)
 		snd_ac97_resume(sis->ac97[0]);
-- 
2.2.1
