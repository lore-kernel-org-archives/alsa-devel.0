From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: timer: Protect the whole
	snd_timer_close() with open race
Date: Fri, 12 Feb 2016 15:10:25 +0100
Message-ID: <1455286226-351-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1701A2604A3
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 15:10:30 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B6A6BAB5D
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 14:10:29 +0000 (UTC)
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

In order to make the open/close more robust, widen the register_mutex
protection over the whole snd_timer_close() function.  Also, the close
procedure is slightly shuffled to be in the safer order, as well as a
few code refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This is no urgent fix, so queued for 4.6.

 sound/core/timer.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index dca817fc7894..b572a9bc31ad 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -318,25 +318,14 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 	if (snd_BUG_ON(!timeri))
 		return -ENXIO;
 
+	mutex_lock(&register_mutex);
+	list_del(&timeri->open_list);
+
 	/* force to stop the timer */
 	snd_timer_stop(timeri);
 
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		/* wait, until the active callback is finished */
-		spin_lock_irq(&slave_active_lock);
-		while (timeri->flags & SNDRV_TIMER_IFLG_CALLBACK) {
-			spin_unlock_irq(&slave_active_lock);
-			udelay(10);
-			spin_lock_irq(&slave_active_lock);
-		}
-		spin_unlock_irq(&slave_active_lock);
-		mutex_lock(&register_mutex);
-		list_del(&timeri->open_list);
-		mutex_unlock(&register_mutex);
-	} else {
-		timer = timeri->timer;
-		if (snd_BUG_ON(!timer))
-			goto out;
+	timer = timeri->timer;
+	if (timer) {
 		/* wait, until the active callback is finished */
 		spin_lock_irq(&timer->lock);
 		while (timeri->flags & SNDRV_TIMER_IFLG_CALLBACK) {
@@ -345,11 +334,7 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 			spin_lock_irq(&timer->lock);
 		}
 		spin_unlock_irq(&timer->lock);
-		mutex_lock(&register_mutex);
-		list_del(&timeri->open_list);
-		if (list_empty(&timer->open_list_head) &&
-		    timer->hw.close)
-			timer->hw.close(timer);
+
 		/* remove slave links */
 		spin_lock_irq(&slave_active_lock);
 		spin_lock(&timer->lock);
@@ -363,18 +348,27 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 		}
 		spin_unlock(&timer->lock);
 		spin_unlock_irq(&slave_active_lock);
-		/* release a card refcount for safe disconnection */
-		if (timer->card)
-			put_device(&timer->card->card_dev);
-		mutex_unlock(&register_mutex);
+
+		/* slave doesn't need to release timer resources below */
+		if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+			timer = NULL;
 	}
- out:
+
 	if (timeri->private_free)
 		timeri->private_free(timeri);
 	kfree(timeri->owner);
 	kfree(timeri);
-	if (timer)
+
+	if (timer) {
+		if (list_empty(&timer->open_list_head) && timer->hw.close)
+			timer->hw.close(timer);
+		/* release a card refcount for safe disconnection */
+		if (timer->card)
+			put_device(&timer->card->card_dev);
 		module_put(timer->module);
+	}
+
+	mutex_unlock(&register_mutex);
 	return 0;
 }
 
-- 
2.7.1
