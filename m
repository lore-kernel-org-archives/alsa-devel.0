From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: timer: Call notifier in the same
	spinlock
Date: Fri, 12 Feb 2016 15:10:26 +0100
Message-ID: <1455286226-351-2-git-send-email-tiwai@suse.de>
References: <1455286226-351-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB7EA2604A3
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 15:10:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7AC0DAB5D
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 14:10:37 +0000 (UTC)
In-Reply-To: <1455286226-351-1-git-send-email-tiwai@suse.de>
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

snd_timer_notify1() is called outside the spinlock and it retakes the
lock after the unlock.  This is rather racy, and it's safer to move
snd_timer_notify() call inside the main spinlock.

The patch also contains a slight refactoring / cleanup of the code.
Not all start/stop/continue/pause look more symmetric and a bit better
readable.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 220 +++++++++++++++++++++++++----------------------------
 1 file changed, 102 insertions(+), 118 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index b572a9bc31ad..aa1b15c155d1 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -305,8 +305,6 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	return 0;
 }
 
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event);
-
 /*
  * close a timer instance
  */
@@ -389,7 +387,6 @@ unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
 	struct snd_timer *timer;
-	unsigned long flags;
 	unsigned long resolution = 0;
 	struct snd_timer_instance *ts;
 	struct timespec tstamp;
@@ -413,34 +410,66 @@ static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 		return;
 	if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 		return;
-	spin_lock_irqsave(&timer->lock, flags);
 	list_for_each_entry(ts, &ti->slave_active_head, active_list)
 		if (ts->ccallback)
 			ts->ccallback(ts, event + 100, &tstamp, resolution);
-	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
-static int snd_timer_start1(struct snd_timer *timer, struct snd_timer_instance *timeri,
-			    unsigned long sticks)
+/* start/continue a master timer */
+static int snd_timer_start1(struct snd_timer_instance *timeri,
+			    bool start, unsigned long ticks)
 {
+	struct snd_timer *timer;
+	int result;
+	unsigned long flags;
+
+	timer = timeri->timer;
+	if (!timer)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer->lock, flags);
+	if (timer->card && timer->card->shutdown) {
+		result = -ENODEV;
+		goto unlock;
+	}
+	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
+			     SNDRV_TIMER_IFLG_START)) {
+		result = -EBUSY;
+		goto unlock;
+	}
+
+	if (start)
+		timeri->ticks = timeri->cticks = ticks;
+	else if (!timeri->cticks)
+		timeri->cticks = 1;
+	timeri->pticks = 0;
+
 	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			goto __start_now;
 		timer->flags |= SNDRV_TIMER_FLG_RESCHED;
 		timeri->flags |= SNDRV_TIMER_IFLG_START;
-		return 1;	/* delayed start */
+		result = 1; /* delayed start */
 	} else {
-		timer->sticks = sticks;
+		if (start)
+			timer->sticks = ticks;
 		timer->hw.start(timer);
 	      __start_now:
 		timer->running++;
 		timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
-		return 0;
+		result = 0;
 	}
+	snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
+	spin_unlock_irqrestore(&timer->lock, flags);
+	return result;
 }
 
-static int snd_timer_start_slave(struct snd_timer_instance *timeri)
+/* start/continue a slave timer */
+static int snd_timer_start_slave(struct snd_timer_instance *timeri,
+				 bool start)
 {
 	unsigned long flags;
 
@@ -454,88 +483,37 @@ static int snd_timer_start_slave(struct snd_timer_instance *timeri)
 		spin_lock(&timeri->timer->lock);
 		list_add_tail(&timeri->active_list,
 			      &timeri->master->slave_active_head);
+		snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+				  SNDRV_TIMER_EVENT_CONTINUE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 1; /* delayed start */
 }
 
-/*
- *  start the timer instance
- */
-int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
-{
-	struct snd_timer *timer;
-	int result = -EINVAL;
-	unsigned long flags;
-
-	if (timeri == NULL || ticks < 1)
-		return -EINVAL;
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		result = snd_timer_start_slave(timeri);
-		if (result >= 0)
-			snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-		return result;
-	}
-	timer = timeri->timer;
-	if (timer == NULL)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
-			     SNDRV_TIMER_IFLG_START)) {
-		result = -EBUSY;
-		goto unlock;
-	}
-	timeri->ticks = timeri->cticks = ticks;
-	timeri->pticks = 0;
-	result = snd_timer_start1(timer, timeri, ticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	if (result >= 0)
-		snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-	return result;
-}
-
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event)
+/* stop/pause a master timer */
+static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 {
 	struct snd_timer *timer;
+	int result = 0;
 	unsigned long flags;
 
-	if (snd_BUG_ON(!timeri))
-		return -ENXIO;
-
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		spin_lock_irqsave(&slave_active_lock, flags);
-		if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
-			spin_unlock_irqrestore(&slave_active_lock, flags);
-			return -EBUSY;
-		}
-		if (timeri->timer)
-			spin_lock(&timeri->timer->lock);
-		timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
-		list_del_init(&timeri->ack_list);
-		list_del_init(&timeri->active_list);
-		if (timeri->timer)
-			spin_unlock(&timeri->timer->lock);
-		spin_unlock_irqrestore(&slave_active_lock, flags);
-		goto __end;
-	}
 	timer = timeri->timer;
 	if (!timer)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
 			       SNDRV_TIMER_IFLG_START))) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return -EBUSY;
+		result = -EBUSY;
+		goto unlock;
 	}
 	list_del_init(&timeri->ack_list);
 	list_del_init(&timeri->active_list);
-	if (timer->card && timer->card->shutdown) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return 0;
+	if (timer->card && timer->card->shutdown)
+		goto unlock;
+	if (stop) {
+		timeri->cticks = timeri->ticks;
+		timeri->pticks = 0;
 	}
 	if ((timeri->flags & SNDRV_TIMER_IFLG_RUNNING) &&
 	    !(--timer->running)) {
@@ -550,35 +528,60 @@ static int _snd_timer_stop(struct snd_timer_instance *timeri, int event)
 		}
 	}
 	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
+	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
 	spin_unlock_irqrestore(&timer->lock, flags);
-      __end:
-	if (event != SNDRV_TIMER_EVENT_RESOLUTION)
-		snd_timer_notify1(timeri, event);
+	return result;
+}
+
+/* stop/pause a slave timer */
+static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&slave_active_lock, flags);
+	if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
+		spin_unlock_irqrestore(&slave_active_lock, flags);
+		return -EBUSY;
+	}
+	timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
+	if (timeri->timer) {
+		spin_lock(&timeri->timer->lock);
+		list_del_init(&timeri->ack_list);
+		list_del_init(&timeri->active_list);
+		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+				  SNDRV_TIMER_EVENT_CONTINUE);
+		spin_unlock(&timeri->timer->lock);
+	}
+	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 0;
 }
 
 /*
+ *  start the timer instance
+ */
+int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
+{
+	if (timeri == NULL || ticks < 1)
+		return -EINVAL;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_start_slave(timeri, true);
+	else
+		return snd_timer_start1(timeri, true, ticks);
+}
+
+/*
  * stop the timer instance.
  *
  * do not call this from the timer callback!
  */
 int snd_timer_stop(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	unsigned long flags;
-	int err;
-
-	err = _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_STOP);
-	if (err < 0)
-		return err;
-	timer = timeri->timer;
-	if (!timer)
-		return -EINVAL;
-	spin_lock_irqsave(&timer->lock, flags);
-	timeri->cticks = timeri->ticks;
-	timeri->pticks = 0;
-	spin_unlock_irqrestore(&timer->lock, flags);
-	return 0;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, true);
+	else
+		return snd_timer_stop1(timeri, true);
 }
 
 /*
@@ -586,32 +589,10 @@ int snd_timer_stop(struct snd_timer_instance *timeri)
  */
 int snd_timer_continue(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	int result = -EINVAL;
-	unsigned long flags;
-
-	if (timeri == NULL)
-		return result;
 	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
-		return snd_timer_start_slave(timeri);
-	timer = timeri->timer;
-	if (! timer)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & SNDRV_TIMER_IFLG_RUNNING) {
-		result = -EBUSY;
-		goto unlock;
-	}
-	if (!timeri->cticks)
-		timeri->cticks = 1;
-	timeri->pticks = 0;
-	result = snd_timer_start1(timer, timeri, timer->sticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_CONTINUE);
-	return result;
+		return snd_timer_start_slave(timeri, false);
+	else
+		return snd_timer_start1(timeri, false, 0);
 }
 
 /*
@@ -619,7 +600,10 @@ int snd_timer_continue(struct snd_timer_instance *timeri)
  */
 int snd_timer_pause(struct snd_timer_instance * timeri)
 {
-	return _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_PAUSE);
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, false);
+	else
+		return snd_timer_stop1(timeri, false);
 }
 
 /*
-- 
2.7.1
