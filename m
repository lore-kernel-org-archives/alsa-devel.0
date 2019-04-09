From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: seq: Align temporary re-locking with
	irqsave version
Date: Tue,  9 Apr 2019 19:00:17 +0200
Message-ID: <20190409170020.20685-3-tiwai@suse.de>
References: <20190409170020.20685-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F6E5F80765
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:00:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 801E6AFD6
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:00:23 +0000 (UTC)
In-Reply-To: <20190409170020.20685-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a few places in sequencer core, we temporarily unlock / re-lock the
pool spin lock while waiting for the allocation in the blocking mode.
There spin_unlock_irq() / spin_lock_irq() pairs are called while
initially spin_lock_irqsave() is used (and spin_lock_irqrestore() at
the end of the function again).  This is likely OK for now, but it's a
bit confusing and error-prone.

This patch replaces these temporary relocking lines with the irqsave
variant to make the lock/unlock sequence more consistently.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_fifo.c   | 4 ++--
 sound/core/seq/seq_memory.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index 72c0302a55d2..613ae10d33b8 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -195,9 +195,9 @@ int snd_seq_fifo_cell_out(struct snd_seq_fifo *f,
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&f->input_sleep, &wait);
-		spin_unlock_irq(&f->lock);
+		spin_unlock_irqrestore(&f->lock, flags);
 		schedule();
-		spin_lock_irq(&f->lock);
+		spin_lock_irqsave(&f->lock, flags);
 		remove_wait_queue(&f->input_sleep, &wait);
 		if (signal_pending(current)) {
 			spin_unlock_irqrestore(&f->lock, flags);
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 6ea4d8a5a71e..ae0b8971f6ce 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -244,13 +244,13 @@ static int snd_seq_cell_alloc(struct snd_seq_pool *pool,
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&pool->output_sleep, &wait);
-		spin_unlock_irq(&pool->lock);
+		spin_unlock_irqrestore(&pool->lock, flags);
 		if (mutexp)
 			mutex_unlock(mutexp);
 		schedule();
 		if (mutexp)
 			mutex_lock(mutexp);
-		spin_lock_irq(&pool->lock);
+		spin_lock_irqsave(&pool->lock, flags);
 		remove_wait_queue(&pool->output_sleep, &wait);
 		/* interrupted? */
 		if (signal_pending(current)) {
-- 
2.16.4
