From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] sound/isa/sscape.c: add missing resource-release code
Date: Mon,  9 Apr 2012 10:16:35 +0200
Message-ID: <1333959395-18960-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

At the point of this error-handling code, both regions and the dma have
been allocated, so free it as done in previous and subsequent
error-handling code.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/isa/sscape.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index b4a6aa9..131dd98 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -1019,13 +1019,15 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	irq_cfg = get_irq_config(sscape->type, irq[dev]);
 	if (irq_cfg == INVALID_IRQ) {
 		snd_printk(KERN_ERR "sscape: Invalid IRQ %d\n", irq[dev]);
-		return -ENXIO;
+		err = -ENXIO;
+		goto _release_dma;
 	}
 
 	mpu_irq_cfg = get_irq_config(sscape->type, mpu_irq[dev]);
 	if (mpu_irq_cfg == INVALID_IRQ) {
 		snd_printk(KERN_ERR "sscape: Invalid IRQ %d\n", mpu_irq[dev]);
-		return -ENXIO;
+		err = -ENXIO;
+		goto _release_dma;
 	}
 
 	/*
