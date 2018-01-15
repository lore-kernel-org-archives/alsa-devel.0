From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Process queue tempo/ppq change in a
	shot
Date: Mon, 15 Jan 2018 17:56:31 +0100
Message-ID: <20180115165631.12352-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E0A0266CD2
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 17:56:33 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CCC06AD6E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 16:56:32 +0000 (UTC)
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

The SNDRV_SEQ_IOCTL_SET_QUEUE_TEMPO ioctl sets the tempo and the ppq
in a single call, while the current implementation updates each value
one by one.  This is a bit racy, and also suboptimal from the
performance POV, as each call does re-acquire the lock and invokes
the update of ALSA timer resolution.

This patch reorganizes the code slightly so that we change both the
tempo and the ppq in a shot.  The skew value can be put into the same
lock, but this is rather a rarely used feature and completely
independent from the temp/ppq (it's evaluated only in the interrupt),
so it's left as it was.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_queue.c |  4 +---
 sound/core/seq/seq_timer.c | 13 ++++++++-----
 sound/core/seq/seq_timer.h |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index 79e0c5604ef8..0428e9061b47 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -497,9 +497,7 @@ int snd_seq_queue_timer_set_tempo(int queueid, int client,
 		return -EPERM;
 	}
 
-	result = snd_seq_timer_set_tempo(q->timer, info->tempo);
-	if (result >= 0)
-		result = snd_seq_timer_set_ppq(q->timer, info->ppq);
+	result = snd_seq_timer_set_tempo_ppq(q->timer, info->tempo, info->ppq);
 	if (result >= 0 && info->skew_base > 0)
 		result = snd_seq_timer_set_skew(q->timer, info->skew_value,
 						info->skew_base);
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index b80985fbc334..23167578231f 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -191,14 +191,15 @@ int snd_seq_timer_set_tempo(struct snd_seq_timer * tmr, int tempo)
 	return 0;
 }
 
-/* set current ppq */
-int snd_seq_timer_set_ppq(struct snd_seq_timer * tmr, int ppq)
+/* set current tempo and ppq in a shot */
+int snd_seq_timer_set_tempo_ppq(struct snd_seq_timer *tmr, int tempo, int ppq)
 {
+	int changed;
 	unsigned long flags;
 
 	if (snd_BUG_ON(!tmr))
 		return -EINVAL;
-	if (ppq <= 0)
+	if (tempo <= 0 || ppq <= 0)
 		return -EINVAL;
 	spin_lock_irqsave(&tmr->lock, flags);
 	if (tmr->running && (ppq != tmr->ppq)) {
@@ -208,9 +209,11 @@ int snd_seq_timer_set_ppq(struct snd_seq_timer * tmr, int ppq)
 		pr_debug("ALSA: seq: cannot change ppq of a running timer\n");
 		return -EBUSY;
 	}
-
+	changed = (tempo != tmr->tempo) || (ppq != tmr->ppq);
+	tmr->tempo = tempo;
 	tmr->ppq = ppq;
-	snd_seq_timer_set_tick_resolution(tmr);
+	if (changed)
+		snd_seq_timer_set_tick_resolution(tmr);
 	spin_unlock_irqrestore(&tmr->lock, flags);
 	return 0;
 }
diff --git a/sound/core/seq/seq_timer.h b/sound/core/seq/seq_timer.h
index 9506b661fe5b..62f390671096 100644
--- a/sound/core/seq/seq_timer.h
+++ b/sound/core/seq/seq_timer.h
@@ -131,7 +131,7 @@ int snd_seq_timer_stop(struct snd_seq_timer *tmr);
 int snd_seq_timer_start(struct snd_seq_timer *tmr);
 int snd_seq_timer_continue(struct snd_seq_timer *tmr);
 int snd_seq_timer_set_tempo(struct snd_seq_timer *tmr, int tempo);
-int snd_seq_timer_set_ppq(struct snd_seq_timer *tmr, int ppq);
+int snd_seq_timer_set_tempo_ppq(struct snd_seq_timer *tmr, int tempo, int ppq);
 int snd_seq_timer_set_position_tick(struct snd_seq_timer *tmr, snd_seq_tick_time_t position);
 int snd_seq_timer_set_position_time(struct snd_seq_timer *tmr, snd_seq_real_time_t position);
 int snd_seq_timer_set_skew(struct snd_seq_timer *tmr, unsigned int skew, unsigned int base);
-- 
2.15.1
