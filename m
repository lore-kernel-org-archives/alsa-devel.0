From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: ymfpci: Use kmalloc for register
	buffer for PM
Date: Thu, 22 Nov 2012 17:54:57 +0100
Message-ID: <1353603300-3217-6-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4278F260840
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1B1DCA4BAD
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
In-Reply-To: <1353603300-3217-1-git-send-email-tiwai@suse.de>
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

Th buffer to save registers for PM is enough small for kmalloc(), not
necessary to use vmalloc().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ymfpci/ymfpci_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 3a6f03f..60e8cb2 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -25,7 +25,6 @@
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 
@@ -2261,7 +2260,7 @@ static int snd_ymfpci_free(struct snd_ymfpci *chip)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-	vfree(chip->saved_regs);
+	kfree(chip->saved_regs);
 #endif
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
@@ -2471,7 +2470,8 @@ int __devinit snd_ymfpci_create(struct snd_card *card,
 	}
 
 #ifdef CONFIG_PM_SLEEP
-	chip->saved_regs = vmalloc(YDSXGR_NUM_SAVED_REGS * sizeof(u32));
+	chip->saved_regs = kmalloc(YDSXGR_NUM_SAVED_REGS * sizeof(u32),
+				   GFP_KERNEL);
 	if (chip->saved_regs == NULL) {
 		snd_ymfpci_free(chip);
 		return -ENOMEM;
-- 
1.8.0
