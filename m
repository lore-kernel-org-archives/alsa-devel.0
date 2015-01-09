From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 27/33] ALSA: rme96: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:53:10 +0100
Message-ID: <1420818796-30852-28-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 656792619E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2028CADB2
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
 sound/pci/rme96.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 2f1a85185a16..e33e79eadf83 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2358,7 +2358,6 @@ snd_rme96_create_switches(struct snd_card *card,
 
 static int rme96_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct rme96 *rme96 = card->private_data;
 
@@ -2381,26 +2380,14 @@ static int rme96_suspend(struct device *dev)
 	/* disable the DAC  */
 	rme96->areg &= ~RME96_AR_DAC_EN;
 	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
-
-	pci_disable_device(pci);
-	pci_save_state(pci);
-
 	return 0;
 }
 
 static int rme96_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct rme96 *rme96 = card->private_data;
 
-	pci_restore_state(pci);
-	if (pci_enable_device(pci) < 0) {
-		dev_err(dev, "pci_enable_device failed, disabling device\n");
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-
 	/* reset playback and record buffer pointers */
 	writel(0, rme96->iobase + RME96_IO_SET_PLAY_POS
 		  + rme96->playback_pointer);
-- 
2.2.1
