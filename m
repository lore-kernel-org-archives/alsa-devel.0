From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: timer: Allow backend disabling
	start/stop from handler
Date: Thu, 21 Apr 2016 16:13:40 +0200
Message-ID: <1461248021-22624-2-git-send-email-tiwai@suse.de>
References: <1461248021-22624-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D042612CC
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 16:13:42 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 493B5AB9D
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 14:13:40 +0000 (UTC)
In-Reply-To: <1461248021-22624-1-git-send-email-tiwai@suse.de>
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

Some timer backend doesn't particularly like (re)start / stop calls
from its interrupt handler.  For example, hrtimer can't stop properly
with sync, and we still seem to have some open race.

This patch introduced a new flag, SNDRV_TIMER_HW_RET_CTRL, so that the
timer backend can specify whether snd_timer_interrupt() should call hw
start() and hw.stop() callbacks or not.  If the new flag is set,
snd_timer_interrupt() won't call hw.start() and hw.stop() callbacks
but return SNDRV_TIMER_RET_START and SNDRV_TIMER_RET_STOP,
respectively.

The actual usage of this flag will be done in the later patch,
starting from hrtimer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/timer.h | 12 +++++++++++-
 sound/core/timer.c    | 24 ++++++++++++++++++------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/sound/timer.h b/include/sound/timer.h
index c4d76ff056c6..6ca6ed4169da 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -37,6 +37,7 @@
 #define SNDRV_TIMER_HW_SLAVE	0x00000004	/* only slave timer (variable resolution) */
 #define SNDRV_TIMER_HW_FIRST	0x00000008	/* first tick can be incomplete */
 #define SNDRV_TIMER_HW_TASKLET	0x00000010	/* timer is called from tasklet */
+#define SNDRV_TIMER_HW_RET_CTRL	0x00000020	/* don't start/stop at irq handler */
 
 #define SNDRV_TIMER_IFLG_SLAVE	  0x00000001
 #define SNDRV_TIMER_IFLG_RUNNING  0x00000002
@@ -50,6 +51,15 @@
 #define SNDRV_TIMER_FLG_CHANGE	0x00000001
 #define SNDRV_TIMER_FLG_RESCHED	0x00000002	/* need reschedule */
 
+/* return value from snd_timer_interrupt();
+ * START and STOP are returned only when SNDRV_TIMER_HW_RET_CTRL is set
+ */
+enum {
+	SNDRV_TIMER_RET_NONE = 0,
+	SNDRV_TIMER_RET_START = 1,
+	SNDRV_TIMER_RET_STOP = 2,
+};
+
 struct snd_timer;
 
 struct snd_timer_hardware {
@@ -139,6 +149,6 @@ int snd_timer_stop(struct snd_timer_instance *timeri);
 int snd_timer_continue(struct snd_timer_instance *timeri);
 int snd_timer_pause(struct snd_timer_instance *timeri);
 
-void snd_timer_interrupt(struct snd_timer *timer, unsigned long ticks_left);
+int snd_timer_interrupt(struct snd_timer *timer, unsigned long ticks_left);
 
 #endif /* __SOUND_TIMER_H */
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6469bedda2f3..c653c409d74d 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -683,19 +683,20 @@ static void snd_timer_tasklet(unsigned long arg)
  * ticks_left is usually equal to timer->sticks.
  *
  */
-void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
+int snd_timer_interrupt(struct snd_timer *timer, unsigned long ticks_left)
 {
 	struct snd_timer_instance *ti, *ts, *tmp;
 	unsigned long resolution, ticks;
 	struct list_head *p, *ack_list_head;
 	unsigned long flags;
 	int use_tasklet = 0;
+	int ret = 0;
 
 	if (timer == NULL)
-		return;
+		return -ENODEV;
 
 	if (timer->card && timer->card->shutdown)
-		return;
+		return -ENODEV;
 
 	spin_lock_irqsave(&timer->lock, flags);
 
@@ -747,17 +748,26 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 		snd_timer_reschedule(timer, timer->sticks);
 	if (timer->running) {
 		if (timer->hw.flags & SNDRV_TIMER_HW_STOP) {
-			timer->hw.stop(timer);
+			if (timer->hw.flags & SNDRV_TIMER_HW_RET_CTRL)
+				ret = SNDRV_TIMER_RET_STOP;
+			else
+				timer->hw.stop(timer);
 			timer->flags |= SNDRV_TIMER_FLG_CHANGE;
 		}
 		if (!(timer->hw.flags & SNDRV_TIMER_HW_AUTO) ||
 		    (timer->flags & SNDRV_TIMER_FLG_CHANGE)) {
 			/* restart timer */
 			timer->flags &= ~SNDRV_TIMER_FLG_CHANGE;
-			timer->hw.start(timer);
+			if (timer->hw.flags & SNDRV_TIMER_HW_RET_CTRL)
+				ret = SNDRV_TIMER_RET_START;
+			else
+				timer->hw.start(timer);
 		}
 	} else {
-		timer->hw.stop(timer);
+		if (timer->hw.flags & SNDRV_TIMER_HW_RET_CTRL)
+			ret = SNDRV_TIMER_RET_STOP;
+		else
+			timer->hw.stop(timer);
 	}
 
 	/* now process all fast callbacks */
@@ -785,6 +795,8 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 
 	if (use_tasklet)
 		tasklet_schedule(&timer->task_queue);
+
+	return ret;
 }
 
 /*
-- 
2.8.1
