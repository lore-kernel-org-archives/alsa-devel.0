From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/33] ALSA: echoaudio: Simplify PM callbacks
Date: Fri,  9 Jan 2015 16:52:56 +0100
Message-ID: <1420818796-30852-14-git-send-email-tiwai@suse.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 509D5261521
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 16:53:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F1F96AD94
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
 sound/pci/echoaudio/echoaudio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 21228adaa70c..58960841ae7c 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2162,7 +2162,6 @@ ctl_error:
 
 static int snd_echo_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct echoaudio *chip = dev_get_drvdata(dev);
 
 	snd_pcm_suspend_all(chip->analog_pcm);
@@ -2188,9 +2187,6 @@ static int snd_echo_suspend(struct device *dev)
 	chip->dsp_code = NULL;
 	free_irq(chip->irq, chip);
 	chip->irq = -1;
-	pci_save_state(pci);
-	pci_disable_device(pci);
-
 	return 0;
 }
 
@@ -2204,7 +2200,6 @@ static int snd_echo_resume(struct device *dev)
 	u32 pipe_alloc_mask;
 	int err;
 
-	pci_restore_state(pci);
 	commpage_bak = kmalloc(sizeof(struct echoaudio), GFP_KERNEL);
 	if (commpage_bak == NULL)
 		return -ENOMEM;
-- 
2.2.1
