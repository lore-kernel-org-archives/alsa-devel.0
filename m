From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/48] ALSA: rme96: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:23 +0100
Message-ID: <1393430030-26704-22-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 37EE72657BC
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BD4B375034
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
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

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index f5014a8e69ad..76169929770d 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1609,13 +1609,15 @@ snd_rme96_create(struct rme96 *rme96)
 
 	rme96->iobase = ioremap_nocache(rme96->port, RME96_IO_SIZE);
 	if (!rme96->iobase) {
-		snd_printk(KERN_ERR "unable to remap memory region 0x%lx-0x%lx\n", rme96->port, rme96->port + RME96_IO_SIZE - 1);
+		dev_err(rme96->card->dev,
+			"unable to remap memory region 0x%lx-0x%lx\n",
+			rme96->port, rme96->port + RME96_IO_SIZE - 1);
 		return -ENOMEM;
 	}
 
 	if (request_irq(pci->irq, snd_rme96_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, rme96)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(rme96->card->dev, "unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
 	rme96->irq = pci->irq;
@@ -2414,7 +2416,7 @@ static int rme96_resume(struct device *dev)
 
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "rme96: pci_enable_device failed, disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -2494,14 +2496,14 @@ snd_rme96_probe(struct pci_dev *pci,
 #ifdef CONFIG_PM_SLEEP
 	rme96->playback_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
 	if (!rme96->playback_suspend_buffer) {
-		snd_printk(KERN_ERR
+		dev_err(card->dev,
 			   "Failed to allocate playback suspend buffer!\n");
 		snd_card_free(card);
 		return -ENOMEM;
 	}
 	rme96->capture_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
 	if (!rme96->capture_suspend_buffer) {
-		snd_printk(KERN_ERR
+		dev_err(card->dev,
 			   "Failed to allocate capture suspend buffer!\n");
 		snd_card_free(card);
 		return -ENOMEM;
-- 
1.9.0
