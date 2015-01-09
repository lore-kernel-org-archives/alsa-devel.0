From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/33] ALSA: ctxfi: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:52:55 +0100
Message-ID: <1420818796-30852-13-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D200261A01
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2ED8FAC79
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
 sound/pci/ctxfi/cthw20k1.c |  9 ---------
 sound/pci/ctxfi/cthw20k2.c | 12 ------------
 2 files changed, 21 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index b425aa8ee578..f16bec129c0a 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -2099,20 +2099,11 @@ static int hw_suspend(struct hw *hw)
 		pci_write_config_dword(pci, UAA_CFG_SPACE_FLAG, 0x0);
 	}
 
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
-
 	return 0;
 }
 
 static int hw_resume(struct hw *hw, struct card_conf *info)
 {
-	struct pci_dev *pci = hw->pci;
-
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-
 	/* Re-initialize card hardware. */
 	return hw_card_init(hw, info);
 }
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 253899d13790..613671d330b1 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -2209,24 +2209,12 @@ static int hw_card_init(struct hw *hw, struct card_conf *info)
 #ifdef CONFIG_PM_SLEEP
 static int hw_suspend(struct hw *hw)
 {
-	struct pci_dev *pci = hw->pci;
-
 	hw_card_stop(hw);
-
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
-
 	return 0;
 }
 
 static int hw_resume(struct hw *hw, struct card_conf *info)
 {
-	struct pci_dev *pci = hw->pci;
-
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-
 	/* Re-initialize card hardware. */
 	return hw_card_init(hw, info);
 }
-- 
2.2.1
