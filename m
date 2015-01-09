From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/33] ALSA: cs5535audio: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:52:54 +0100
Message-ID: <1420818796-30852-12-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 447592612C7
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EC0F1AD91
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
 sound/pci/cs5535audio/cs5535audio_pm.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pm.c b/sound/pci/cs5535audio/cs5535audio_pm.c
index 34cc60057d0c..06ac5d8da362 100644
--- a/sound/pci/cs5535audio/cs5535audio_pm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pm.c
@@ -57,7 +57,6 @@ static void snd_cs5535audio_stop_hardware(struct cs5535audio *cs5535au)
 
 static int snd_cs5535audio_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct cs5535audio *cs5535au = card->private_data;
 	int i;
@@ -72,34 +71,17 @@ static int snd_cs5535audio_suspend(struct device *dev)
 	}
 	/* save important regs, then disable aclink in hw */
 	snd_cs5535audio_stop_hardware(cs5535au);
-
-	if (pci_save_state(pci)) {
-		dev_err(dev, "pci_save_state failed!\n");
-		return -EIO;
-	}
-	pci_disable_device(pci);
-	pci_set_power_state(pci, PCI_D3hot);
 	return 0;
 }
 
 static int snd_cs5535audio_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct cs5535audio *cs5535au = card->private_data;
 	u32 tmp;
 	int timeout;
 	int i;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-	if (pci_enable_device(pci) < 0) {
-		dev_err(dev, "pci_enable_device failed, disabling device\n");
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-	pci_set_master(pci);
-
 	/* set LNK_WRM_RST to reset AC link */
 	cs_writel(cs5535au, ACC_CODEC_CNTL, ACC_CODEC_CNTL_LNK_WRM_RST);
 
-- 
2.2.1
