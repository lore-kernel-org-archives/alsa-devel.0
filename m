From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/33] ALSA: ice1712: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:53:02 +0100
Message-ID: <1420818796-30852-20-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 70526261A3B
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 09762ADA5
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
 sound/pci/ice1712/ice1712.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index b039b46152c6..e1560bf0d26a 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2798,7 +2798,6 @@ static void snd_ice1712_remove(struct pci_dev *pci)
 #ifdef CONFIG_PM_SLEEP
 static int snd_ice1712_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ice1712 *ice = card->private_data;
 
@@ -2820,16 +2819,11 @@ static int snd_ice1712_suspend(struct device *dev)
 
 	if (ice->pm_suspend)
 		ice->pm_suspend(ice);
-
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
 	return 0;
 }
 
 static int snd_ice1712_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ice1712 *ice = card->private_data;
 	int rate;
@@ -2837,16 +2831,6 @@ static int snd_ice1712_resume(struct device *dev)
 	if (!ice->pm_suspend_enabled)
 		return 0;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-
-	if (pci_enable_device(pci) < 0) {
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-
-	pci_set_master(pci);
-
 	if (ice->cur_rate)
 		rate = ice->cur_rate;
 	else
-- 
2.2.1
