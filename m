From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: emu10k1: Fix deadlock in synth voice
	lookup
Date: Tue, 14 Oct 2014 10:50:17 +0200
Message-ID: <1413276617-24401-2-git-send-email-tiwai@suse.de>
References: <1413276617-24401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A78B9260503
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 10:50:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B4D0ABCC
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 08:50:20 +0000 (UTC)
In-Reply-To: <1413276617-24401-1-git-send-email-tiwai@suse.de>
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

The emu10k1 voice allocator takes voice_lock spinlock.  When there is
no empty stream available, it tries to release a voice used by synth,
and calls get_synth_voice.  The callback function,
snd_emu10k1_synth_get_voice(), however, also takes the voice_lock,
thus it deadlocks.

The fix is simply removing the voice_lock holds in
snd_emu10k1_synth_get_voice(), as this is always called in the
spinlock context.

Reported-and-tested-by: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emu10k1_callback.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
index 3f3ef38d9b6e..874cd76c7b7f 100644
--- a/sound/pci/emu10k1/emu10k1_callback.c
+++ b/sound/pci/emu10k1/emu10k1_callback.c
@@ -85,6 +85,8 @@ snd_emu10k1_ops_setup(struct snd_emux *emux)
  * get more voice for pcm
  *
  * terminate most inactive voice and give it as a pcm voice.
+ *
+ * voice_lock is already held.
  */
 int
 snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
@@ -92,12 +94,10 @@ snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
 	struct snd_emux *emu;
 	struct snd_emux_voice *vp;
 	struct best_voice best[V_END];
-	unsigned long flags;
 	int i;
 
 	emu = hw->synth;
 
-	spin_lock_irqsave(&emu->voice_lock, flags);
 	lookup_voices(emu, hw, best, 1); /* no OFF voices */
 	for (i = 0; i < V_END; i++) {
 		if (best[i].voice >= 0) {
@@ -113,11 +113,9 @@ snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
 			vp->emu->num_voices--;
 			vp->ch = -1;
 			vp->state = SNDRV_EMUX_ST_OFF;
-			spin_unlock_irqrestore(&emu->voice_lock, flags);
 			return ch;
 		}
 	}
-	spin_unlock_irqrestore(&emu->voice_lock, flags);
 
 	/* not found */
 	return -ENOMEM;
-- 
2.1.2
