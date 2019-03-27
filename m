From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: timer: Unify timer callback process
	code
Date: Wed, 27 Mar 2019 17:52:14 +0100
Message-ID: <20190327165217.4240-2-tiwai@suse.de>
References: <20190327165217.4240-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DFD2F80C17
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 17:52:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E72B8AF5F
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 16:52:18 +0000 (UTC)
In-Reply-To: <20190327165217.4240-1-tiwai@suse.de>
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

The timer core has two almost identical code for processing callbacks:
once in snd_timer_interrupt() for fast callbacks and another in
snd_timer_tasklet() for delayed callbacks.  Let's unify them.

In the new version, the resolution is read from ti->resolution at each
call, and this must be fine; ti->resolution is set in the preparation
step in snd_timer_interrupt().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 62 +++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 61a0cec6e1f6..fdcddfb756b4 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -720,29 +720,19 @@ static void snd_timer_reschedule(struct snd_timer * timer, unsigned long ticks_l
 	timer->sticks = ticks;
 }
 
-/*
- * timer tasklet
- *
- */
-static void snd_timer_tasklet(unsigned long arg)
+/* call callbacks in timer ack list */
+static void snd_timer_process_callbacks(struct snd_timer *timer,
+					struct list_head *head)
 {
-	struct snd_timer *timer = (struct snd_timer *) arg;
 	struct snd_timer_instance *ti;
-	struct list_head *p;
 	unsigned long resolution, ticks;
-	unsigned long flags;
 
-	if (timer->card && timer->card->shutdown)
-		return;
-
-	spin_lock_irqsave(&timer->lock, flags);
-	/* now process all callbacks */
-	while (!list_empty(&timer->sack_list_head)) {
-		p = timer->sack_list_head.next;		/* get first item */
-		ti = list_entry(p, struct snd_timer_instance, ack_list);
+	while (!list_empty(head)) {
+		ti = list_first_entry(head, struct snd_timer_instance,
+				      ack_list);
 
 		/* remove from ack_list and make empty */
-		list_del_init(p);
+		list_del_init(&ti->ack_list);
 
 		ticks = ti->pticks;
 		ti->pticks = 0;
@@ -755,6 +745,22 @@ static void snd_timer_tasklet(unsigned long arg)
 		spin_lock(&timer->lock);
 		ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
 	}
+}
+
+/*
+ * timer tasklet
+ *
+ */
+static void snd_timer_tasklet(unsigned long arg)
+{
+	struct snd_timer *timer = (struct snd_timer *) arg;
+	unsigned long flags;
+
+	if (timer->card && timer->card->shutdown)
+		return;
+
+	spin_lock_irqsave(&timer->lock, flags);
+	snd_timer_process_callbacks(timer, &timer->sack_list_head);
 	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
@@ -767,8 +773,8 @@ static void snd_timer_tasklet(unsigned long arg)
 void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 {
 	struct snd_timer_instance *ti, *ts, *tmp;
-	unsigned long resolution, ticks;
-	struct list_head *p, *ack_list_head;
+	unsigned long resolution;
+	struct list_head *ack_list_head;
 	unsigned long flags;
 	int use_tasklet = 0;
 
@@ -839,23 +845,7 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 	}
 
 	/* now process all fast callbacks */
-	while (!list_empty(&timer->ack_list_head)) {
-		p = timer->ack_list_head.next;		/* get first item */
-		ti = list_entry(p, struct snd_timer_instance, ack_list);
-
-		/* remove from ack_list and make empty */
-		list_del_init(p);
-
-		ticks = ti->pticks;
-		ti->pticks = 0;
-
-		ti->flags |= SNDRV_TIMER_IFLG_CALLBACK;
-		spin_unlock(&timer->lock);
-		if (ti->callback)
-			ti->callback(ti, resolution, ticks);
-		spin_lock(&timer->lock);
-		ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
-	}
+	snd_timer_process_callbacks(timer, &timer->ack_list_head);
 
 	/* do we have any slow callbacks? */
 	use_tasklet = !list_empty(&timer->sack_list_head);
-- 
2.16.4
