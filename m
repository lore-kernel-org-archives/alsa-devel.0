From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: timer: Code cleanup
Date: Fri, 15 Jan 2016 16:02:21 +0100
Message-ID: <1452870141-13340-2-git-send-email-tiwai@suse.de>
References: <1452870141-13340-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 72DA926044B
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 16:02:25 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 00B98ABB5
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 15:02:23 +0000 (UTC)
In-Reply-To: <1452870141-13340-1-git-send-email-tiwai@suse.de>
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

This is a minor code cleanup without any functional changes:
- Kill keep_flag argument from _snd_timer_stop(), as all callers pass
  only it false.
- Remove redundant NULL check in _snd_timer_stop().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 4e8d7bfffff6..cb25aded5349 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -301,8 +301,7 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	return 0;
 }
 
-static int _snd_timer_stop(struct snd_timer_instance *timeri,
-			   int keep_flag, int event);
+static int _snd_timer_stop(struct snd_timer_instance *timeri, int event);
 
 /*
  * close a timer instance
@@ -344,7 +343,7 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 		spin_unlock_irq(&timer->lock);
 		mutex_lock(&register_mutex);
 		list_del(&timeri->open_list);
-		if (timer && list_empty(&timer->open_list_head) &&
+		if (list_empty(&timer->open_list_head) &&
 		    timer->hw.close)
 			timer->hw.close(timer);
 		/* remove slave links */
@@ -484,8 +483,7 @@ int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
 	return result;
 }
 
-static int _snd_timer_stop(struct snd_timer_instance * timeri,
-			   int keep_flag, int event)
+static int _snd_timer_stop(struct snd_timer_instance *timeri, int event)
 {
 	struct snd_timer *timer;
 	unsigned long flags;
@@ -494,13 +492,11 @@ static int _snd_timer_stop(struct snd_timer_instance * timeri,
 		return -ENXIO;
 
 	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		if (!keep_flag) {
-			spin_lock_irqsave(&slave_active_lock, flags);
-			timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
-			list_del_init(&timeri->ack_list);
-			list_del_init(&timeri->active_list);
-			spin_unlock_irqrestore(&slave_active_lock, flags);
-		}
+		spin_lock_irqsave(&slave_active_lock, flags);
+		timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
+		list_del_init(&timeri->ack_list);
+		list_del_init(&timeri->active_list);
+		spin_unlock_irqrestore(&slave_active_lock, flags);
 		goto __end;
 	}
 	timer = timeri->timer;
@@ -521,9 +517,7 @@ static int _snd_timer_stop(struct snd_timer_instance * timeri,
 			}
 		}
 	}
-	if (!keep_flag)
-		timeri->flags &=
-			~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
+	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
 	spin_unlock_irqrestore(&timer->lock, flags);
       __end:
 	if (event != SNDRV_TIMER_EVENT_RESOLUTION)
@@ -542,7 +536,7 @@ int snd_timer_stop(struct snd_timer_instance *timeri)
 	unsigned long flags;
 	int err;
 
-	err = _snd_timer_stop(timeri, 0, SNDRV_TIMER_EVENT_STOP);
+	err = _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_STOP);
 	if (err < 0)
 		return err;
 	timer = timeri->timer;
@@ -586,7 +580,7 @@ int snd_timer_continue(struct snd_timer_instance *timeri)
  */
 int snd_timer_pause(struct snd_timer_instance * timeri)
 {
-	return _snd_timer_stop(timeri, 0, SNDRV_TIMER_EVENT_PAUSE);
+	return _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_PAUSE);
 }
 
 /*
-- 
2.7.0
