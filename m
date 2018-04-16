From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: emu10k1: Reduce GFP_ATOMIC allocation
Date: Mon, 16 Apr 2018 14:12:06 +0200
Message-ID: <20180416121206.27131-3-tiwai@suse.de>
References: <20180416121206.27131-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 76DA6267217
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 14:12:09 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B4580AEF8
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 12:12:08 +0000 (UTC)
In-Reply-To: <20180416121206.27131-1-tiwai@suse.de>
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

The emu10k1 fx8010 code allocates each irq resource dynamically and
links to the list at PCM trigger callback.  Due to the nature of
trigger callback, the allocation is done with GFP_ATOMIC, hence it
may fail more often.  Moreover, the irq resource isn't big at all, and
using the kmalloc for this won't save many bytes, either.

This patch removes the dynamic allocation and embeds the irq resource
into struct snd_emu10k1_fx8010_pcm.irq field instead of keeping a
pointer.  As a result, it simplifies the code and removes the
unnecessary GFP_ATOMIC usage.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/emu10k1.h    | 4 ++--
 sound/pci/emu10k1/emufx.c  | 9 +--------
 sound/pci/emu10k1/emupcm.c | 2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 5ebcc51c0a6a..8c1572de44c5 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1610,7 +1610,7 @@ struct snd_emu10k1_fx8010_pcm {
 	struct snd_pcm_indirect pcm_rec;
 	unsigned int tram_pos;
 	unsigned int tram_shift;
-	struct snd_emu10k1_fx8010_irq *irq;
+	struct snd_emu10k1_fx8010_irq irq;
 };
 
 struct snd_emu10k1_fx8010 {
@@ -1902,7 +1902,7 @@ int snd_emu10k1_fx8010_register_irq_handler(struct snd_emu10k1 *emu,
 					    snd_fx8010_irq_handler_t *handler,
 					    unsigned char gpr_running,
 					    void *private_data,
-					    struct snd_emu10k1_fx8010_irq **r_irq);
+					    struct snd_emu10k1_fx8010_irq *irq);
 int snd_emu10k1_fx8010_unregister_irq_handler(struct snd_emu10k1 *emu,
 					      struct snd_emu10k1_fx8010_irq *irq);
 
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index a2b56b188be4..608ff4857d70 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -421,14 +421,10 @@ int snd_emu10k1_fx8010_register_irq_handler(struct snd_emu10k1 *emu,
 					    snd_fx8010_irq_handler_t *handler,
 					    unsigned char gpr_running,
 					    void *private_data,
-					    struct snd_emu10k1_fx8010_irq **r_irq)
+					    struct snd_emu10k1_fx8010_irq *irq)
 {
-	struct snd_emu10k1_fx8010_irq *irq;
 	unsigned long flags;
 	
-	irq = kmalloc(sizeof(*irq), GFP_ATOMIC);
-	if (irq == NULL)
-		return -ENOMEM;
 	irq->handler = handler;
 	irq->gpr_running = gpr_running;
 	irq->private_data = private_data;
@@ -443,8 +439,6 @@ int snd_emu10k1_fx8010_register_irq_handler(struct snd_emu10k1 *emu,
 		emu->fx8010.irq_handlers = irq;
 	}
 	spin_unlock_irqrestore(&emu->fx8010.irq_lock, flags);
-	if (r_irq)
-		*r_irq = irq;
 	return 0;
 }
 
@@ -468,7 +462,6 @@ int snd_emu10k1_fx8010_unregister_irq_handler(struct snd_emu10k1 *emu,
 			tmp->next = tmp->next->next;
 	}
 	spin_unlock_irqrestore(&emu->fx8010.irq_lock, flags);
-	kfree(irq);
 	return 0;
 }
 
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index cefe613ef7b7..d39458ab251f 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1724,7 +1724,7 @@ static int snd_emu10k1_fx8010_playback_trigger(struct snd_pcm_substream *substre
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		snd_emu10k1_fx8010_unregister_irq_handler(emu, pcm->irq); pcm->irq = NULL;
+		snd_emu10k1_fx8010_unregister_irq_handler(emu, &pcm->irq);
 		snd_emu10k1_ptr_write(emu, emu->gpr_base + pcm->gpr_trigger, 0, 0);
 		pcm->tram_pos = INITIAL_TRAM_POS(pcm->buffer_size);
 		pcm->tram_shift = 0;
-- 
2.16.3
