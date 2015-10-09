From: Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
Subject: [PATCH] ALSA: seq_oss: fix waitqueue_active without memory barrier
 in snd-seq-oss
Date: Fri, 9 Oct 2015 00:35:54 +0000
Message-ID: <17EC94B0A072C34B8DCF0D30AD16044A028747B2@BPXM09GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus Elfring <elfring@users.sourceforge.net>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_seq_oss_readq_put_event() seems to be missing a memory barrier which
might cause the waker to not notice the waiter and miss sending a
wake_up as in the following figure.

    snd_seq_oss_readq_put_event		    snd_seq_oss_readq_wait
------------------------------------------------------------------------
					/* wait_event_interruptible_timeout */
					 /* __wait_event_interruptible_timeout */
					  /* ___wait_event */
					  for (;;) {									 prepare_to_wait_event(&wq, &__wait,
					    state);
spin_lock_irqsave(&q->lock, flags);
if (waitqueue_active(&q->midi_sleep))
/* The CPU might reorder the test for
   the waitqueue up here, before
   prior writes complete */
					  if ((q->qlen>0 || q->head==q->tail)
					  ...
					  __ret = schedule_timeout(__ret)
if (q->qlen >= q->maxlen - 1) {
memcpy(&q->q[q->tail], ev, sizeof(*ev));
q->tail = (q->tail + 1) % q->maxlen;
q->qlen++;
------------------------------------------------------------------------

There are two other place in sound/core/seq/oss/ which have similar
code.  The attached patch removes the call to waitqueue_active() leaving
just wake_up() behind.  This fixes the problem because the call to
spin_lock_irqsave() in wake_up() will be an ACQUIRE operation.

I found this issue when I was looking through the linux source code
for places calling waitqueue_active() before wake_up*(), but without
preceding memory barriers, after sending a patch to fix a similar
issue in drivers/tty/n_tty.c  (Details about the original issue can be
found here: https://lkml.org/lkml/2015/9/28/849).

Signed-off-by: Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
---
 sound/core/seq/oss/seq_oss_readq.c  |    6 ++----
 sound/core/seq/oss/seq_oss_writeq.c |    4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_readq.c b/sound/core/seq/oss/seq_oss_readq.c
index ccd8935..046cb58 100644
--- a/sound/core/seq/oss/seq_oss_readq.c
+++ b/sound/core/seq/oss/seq_oss_readq.c
@@ -91,8 +91,7 @@ snd_seq_oss_readq_clear(struct seq_oss_readq *q)
 		q->head = q->tail = 0;
 	}
 	/* if someone sleeping, wake'em up */
-	if (waitqueue_active(&q->midi_sleep))
-		wake_up(&q->midi_sleep);
+	wake_up(&q->midi_sleep);
 	q->input_time = (unsigned long)-1;
 }
 
@@ -138,8 +137,7 @@ snd_seq_oss_readq_put_event(struct seq_oss_readq *q, union evrec *ev)
 	q->qlen++;
 
 	/* wake up sleeper */
-	if (waitqueue_active(&q->midi_sleep))
-		wake_up(&q->midi_sleep);
+	wake_up(&q->midi_sleep);
 
 	spin_unlock_irqrestore(&q->lock, flags);
 
diff --git a/sound/core/seq/oss/seq_oss_writeq.c b/sound/core/seq/oss/seq_oss_writeq.c
index d50338b..1f6788a 100644
--- a/sound/core/seq/oss/seq_oss_writeq.c
+++ b/sound/core/seq/oss/seq_oss_writeq.c
@@ -138,9 +138,7 @@ snd_seq_oss_writeq_wakeup(struct seq_oss_writeq *q, abstime_t time)
 	spin_lock_irqsave(&q->sync_lock, flags);
 	q->sync_time = time;
 	q->sync_event_put = 0;
-	if (waitqueue_active(&q->sync_sleep)) {
-		wake_up(&q->sync_sleep);
-	}
+	wake_up(&q->sync_sleep);
 	spin_unlock_irqrestore(&q->sync_lock, flags);
 }
 
-- 
1.7.1
