From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: timer: Make snd_timer_close() really
	kill pending actions
Date: Wed, 27 Mar 2019 17:52:17 +0100
Message-ID: <20190327165217.4240-5-tiwai@suse.de>
References: <20190327165217.4240-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86C0FF80CAB
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 17:52:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 152A0AFBC
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 16:52:19 +0000 (UTC)
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

snd_timer_close() is supposed to close the timer instance and sync
with the deactivation of pending actions.  However, there are still
some overlooked cases:

- It calls snd_timer_stop() at the beginning, but some other might
  re-trigger the timer right after that.

- snd_timer_stop() calls del_timer_sync() only when all belonging
  instances are closed.  If multiple instances were assigned to a
  timer object and one is closed, the timer is still running.  Then
  the pending action assigned to this timer might be left.

Actually either of the above is the likely cause of the reported
syzkaller UAF.

This patch plug these holes by introducing SNDRV_TIMER_IFLG_DEAD
flag.  This is set at the beginning of snd_timer_close(), and the flag
is checked at snd_timer_start*() and else, so that no longer new
action is left after snd_timer_close().

Reported-by: syzbot+d5136d4d3240cbe45a2a@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index e343de0e4f9e..bb7e90ab90f8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -38,6 +38,7 @@
 
 /* internal flags */
 #define SNDRV_TIMER_IFLG_PAUSED		0x00010000
+#define SNDRV_TIMER_IFLG_DEAD		0x00020000
 
 #if IS_ENABLED(CONFIG_SND_HRTIMER)
 #define DEFAULT_TIMER_LIMIT 4
@@ -353,15 +354,20 @@ EXPORT_SYMBOL(snd_timer_open);
  */
 static int snd_timer_close_locked(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer = NULL;
+	struct snd_timer *timer = timeri->timer;
 	struct snd_timer_instance *slave, *tmp;
 
+	if (timer) {
+		spin_lock_irq(&timer->lock);
+		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
+		spin_unlock_irq(&timer->lock);
+	}
+
 	list_del(&timeri->open_list);
 
 	/* force to stop the timer */
 	snd_timer_stop(timeri);
 
-	timer = timeri->timer;
 	if (timer) {
 		timer->num_instances--;
 		/* wait, until the active callback is finished */
@@ -497,6 +503,10 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 		return -EINVAL;
 
 	spin_lock_irqsave(&timer->lock, flags);
+	if (timeri->flags & SNDRV_TIMER_IFLG_DEAD) {
+		result = -EINVAL;
+		goto unlock;
+	}
 	if (timer->card && timer->card->shutdown) {
 		result = -ENODEV;
 		goto unlock;
@@ -541,11 +551,16 @@ static int snd_timer_start_slave(struct snd_timer_instance *timeri,
 				 bool start)
 {
 	unsigned long flags;
+	int err;
 
 	spin_lock_irqsave(&slave_active_lock, flags);
+	if (timeri->flags & SNDRV_TIMER_IFLG_DEAD) {
+		err = -EINVAL;
+		goto unlock;
+	}
 	if (timeri->flags & SNDRV_TIMER_IFLG_RUNNING) {
-		spin_unlock_irqrestore(&slave_active_lock, flags);
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 	timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
 	if (timeri->master && timeri->timer) {
@@ -556,8 +571,10 @@ static int snd_timer_start_slave(struct snd_timer_instance *timeri,
 				  SNDRV_TIMER_EVENT_CONTINUE);
 		spin_unlock(&timeri->timer->lock);
 	}
+	err = 1; /* delayed start */
+ unlock:
 	spin_unlock_irqrestore(&slave_active_lock, flags);
-	return 1; /* delayed start */
+	return err;
 }
 
 /* stop/pause a master timer */
@@ -731,14 +748,16 @@ static void snd_timer_process_callbacks(struct snd_timer *timer,
 		ti = list_first_entry(head, struct snd_timer_instance,
 				      ack_list);
 
-		ticks = ti->pticks;
-		ti->pticks = 0;
-		resolution = ti->resolution;
+		if (!(ti->flags & SNDRV_TIMER_IFLG_DEAD)) {
+			ticks = ti->pticks;
+			ti->pticks = 0;
+			resolution = ti->resolution;
 
-		spin_unlock(&timer->lock);
-		if (ti->callback)
-			ti->callback(ti, resolution, ticks);
-		spin_lock(&timer->lock);
+			spin_unlock(&timer->lock);
+			if (ti->callback)
+				ti->callback(ti, resolution, ticks);
+			spin_lock(&timer->lock);
+		}
 
 		/* remove from ack_list and make empty */
 		list_del_init(&ti->ack_list);
@@ -810,6 +829,8 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 	 */
 	list_for_each_entry_safe(ti, tmp, &timer->active_list_head,
 				 active_list) {
+		if (ti->flags & SNDRV_TIMER_IFLG_DEAD)
+			continue;
 		if (!(ti->flags & SNDRV_TIMER_IFLG_RUNNING))
 			continue;
 		ti->pticks += ticks_left;
-- 
2.16.4
