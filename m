From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] gus: update debug messages
Date: Thu, 29 Jan 2009 11:46:45 +0100
Message-ID: <20090129114645.3b3d867f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id B4B65103851
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 11:43:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Convert some of them to snd_printdd() and
update arguments to make them compilable.
---
 sound/isa/gus/gus_dma.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/isa/gus/gus_dma.c b/sound/isa/gus/gus_dma.c
index f45f611..cf8cd3c 100644
--- a/sound/isa/gus/gus_dma.c
+++ b/sound/isa/gus/gus_dma.c
@@ -45,7 +45,8 @@ static void snd_gf1_dma_program(struct snd_gus_card * gus,
 	unsigned char dma_cmd;
 	unsigned int address_high;
 
-	// snd_printk("dma_transfer: addr=0x%x, buf=0x%lx, count=0x%x\n", addr, (long) buf, count);
+	snd_printdd("dma_transfer: addr=0x%x, buf=0x%lx, count=0x%x\n",
+		    addr, buf_addr, count);
 
 	if (gus->gf1.dma1 > 3) {
 		if (gus->gf1.enh_mode) {
@@ -142,7 +143,9 @@ static void snd_gf1_dma_interrupt(struct snd_gus_card * gus)
 	snd_gf1_dma_program(gus, block->addr, block->buf_addr, block->count, (unsigned short) block->cmd);
 	kfree(block);
 #if 0
-	printk("program dma (IRQ) - addr = 0x%x, buffer = 0x%lx, count = 0x%x, cmd = 0x%x\n", addr, (long) buffer, count, cmd);
+	snd_printd(KERN_DEBUG "program dma (IRQ) - "
+		   "addr = 0x%x, buffer = 0x%lx, count = 0x%x, cmd = 0x%x\n",
+		   block->addr, block->buf_addr, block->count, block->cmd);
 #endif
 }
 
@@ -203,13 +206,16 @@ int snd_gf1_dma_transfer_block(struct snd_gus_card * gus,
 	}
 	*block = *__block;
 	block->next = NULL;
-#if 0
-	printk("addr = 0x%x, buffer = 0x%lx, count = 0x%x, cmd = 0x%x\n", block->addr, (long) block->buffer, block->count, block->cmd);
-#endif
-#if 0
-	printk("gus->gf1.dma_data_pcm_last = 0x%lx\n", (long)gus->gf1.dma_data_pcm_last);
-	printk("gus->gf1.dma_data_pcm = 0x%lx\n", (long)gus->gf1.dma_data_pcm);
-#endif
+
+	snd_printdd("addr = 0x%x, buffer = 0x%lx, count = 0x%x, cmd = 0x%x\n",
+		    block->addr, (long) block->buffer, block->count,
+		    block->cmd);
+
+	snd_printdd("gus->gf1.dma_data_pcm_last = 0x%lx\n",
+		    (long)gus->gf1.dma_data_pcm_last);
+	snd_printdd("gus->gf1.dma_data_pcm = 0x%lx\n",
+		    (long)gus->gf1.dma_data_pcm);
+
 	spin_lock_irqsave(&gus->dma_lock, flags);
 	if (synth) {
 		if (gus->gf1.dma_data_synth_last) {
-- 
1.5.2.2


----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
