From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: timer: Introduce disconnect op to
	snd_timer_instance
Date: Thu, 21 Jan 2016 17:53:03 +0100
Message-ID: <1453395183-27947-2-git-send-email-tiwai@suse.de>
References: <1453395183-27947-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4464826062B
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 17:53:06 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8D119ACA7
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 16:53:04 +0000 (UTC)
In-Reply-To: <1453395183-27947-1-git-send-email-tiwai@suse.de>
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

Instead of the previous ugly hack, introduce a new op, disconnect, to
snd_timer_instance object for handling the wake up of pending tasks
more cleanly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=109431
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/timer.h |  1 +
 sound/core/timer.c    | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/sound/timer.h b/include/sound/timer.h
index 7990469a44ce..c4d76ff056c6 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -104,6 +104,7 @@ struct snd_timer_instance {
 			   int event,
 			   struct timespec * tstamp,
 			   unsigned long resolution);
+	void (*disconnect)(struct snd_timer_instance *timeri);
 	void *callback_data;
 	unsigned long ticks;		/* auto-load ticks when expired */
 	unsigned long cticks;		/* current ticks */
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 681fb051b9eb..af1f68f7e315 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -899,11 +899,6 @@ static int snd_timer_dev_register(struct snd_device *dev)
 	return 0;
 }
 
-/* just for reference in snd_timer_dev_disconnect() below */
-static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
-				     int event, struct timespec *tstamp,
-				     unsigned long resolution);
-
 static int snd_timer_dev_disconnect(struct snd_device *device)
 {
 	struct snd_timer *timer = device->device_data;
@@ -913,13 +908,8 @@ static int snd_timer_dev_disconnect(struct snd_device *device)
 	list_del_init(&timer->device_list);
 	/* wake up pending sleepers */
 	list_for_each_entry(ti, &timer->open_list_head, open_list) {
-		/* FIXME: better to have a ti.disconnect() op */
-		if (ti->ccallback == snd_timer_user_ccallback) {
-			struct snd_timer_user *tu = ti->callback_data;
-
-			tu->disconnected = true;
-			wake_up(&tu->qchange_sleep);
-		}
+		if (ti->disconnect)
+			ti->disconnect(ti);
 	}
 	mutex_unlock(&register_mutex);
 	return 0;
@@ -1227,6 +1217,14 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 	wake_up(&tu->qchange_sleep);
 }
 
+static void snd_timer_user_disconnect(struct snd_timer_instance *timeri)
+{
+	struct snd_timer_user *tu = timeri->callback_data;
+
+	tu->disconnected = true;
+	wake_up(&tu->qchange_sleep);
+}
+
 static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 				      unsigned long resolution,
 				      unsigned long ticks)
@@ -1600,6 +1598,7 @@ static int snd_timer_user_tselect(struct file *file,
 			? snd_timer_user_tinterrupt : snd_timer_user_interrupt;
 		tu->timeri->ccallback = snd_timer_user_ccallback;
 		tu->timeri->callback_data = (void *)tu;
+		tu->timeri->disconnect = snd_timer_user_disconnect;
 	}
 
       __err:
-- 
2.7.0
