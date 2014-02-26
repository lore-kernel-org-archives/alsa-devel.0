From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/48] ALSA: rme32: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:22 +0100
Message-ID: <1393430030-26704-21-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AEE82657AB
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BC46175024
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
 sound/pci/rme32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 77465cc03e95..cc2f0c1b6484 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1349,14 +1349,15 @@ static int snd_rme32_create(struct rme32 *rme32)
 
 	rme32->iobase = ioremap_nocache(rme32->port, RME32_IO_SIZE);
 	if (!rme32->iobase) {
-		snd_printk(KERN_ERR "unable to remap memory region 0x%lx-0x%lx\n",
+		dev_err(rme32->card->dev,
+			"unable to remap memory region 0x%lx-0x%lx\n",
 			   rme32->port, rme32->port + RME32_IO_SIZE - 1);
 		return -ENOMEM;
 	}
 
 	if (request_irq(pci->irq, snd_rme32_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, rme32)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(rme32->card->dev, "unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
 	rme32->irq = pci->irq;
-- 
1.9.0
