From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: timer: Simplify error path in
	snd_timer_open()
Date: Tue,  9 Apr 2019 19:02:34 +0200
Message-ID: <20190409170235.20783-2-tiwai@suse.de>
References: <20190409170235.20783-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70500F896F2
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:02:39 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 357D6AFD6
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:02:39 +0000 (UTC)
In-Reply-To: <20190409170235.20783-1-tiwai@suse.de>
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

Just a minor refactoring to use the standard goto for error paths in
snd_timer_open() instead of open code.  The first mutex_lock() is
moved to the beginning of the function to make the code clearer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index df52d2960179..e8d9577a2ee4 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -255,19 +255,20 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	struct snd_timer_instance *timeri = NULL;
 	int err;
 
+	mutex_lock(&register_mutex);
 	if (tid->dev_class == SNDRV_TIMER_CLASS_SLAVE) {
 		/* open a slave instance */
 		if (tid->dev_sclass <= SNDRV_TIMER_SCLASS_NONE ||
 		    tid->dev_sclass > SNDRV_TIMER_SCLASS_OSS_SEQUENCER) {
 			pr_debug("ALSA: timer: invalid slave class %i\n",
 				 tid->dev_sclass);
-			return -EINVAL;
+			err = -EINVAL;
+			goto unlock;
 		}
-		mutex_lock(&register_mutex);
 		timeri = snd_timer_instance_new(owner, NULL);
 		if (!timeri) {
-			mutex_unlock(&register_mutex);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto unlock;
 		}
 		timeri->slave_class = tid->dev_sclass;
 		timeri->slave_id = tid->device;
@@ -278,13 +279,10 @@ int snd_timer_open(struct snd_timer_instance **ti,
 			snd_timer_close_locked(timeri);
 			timeri = NULL;
 		}
-		mutex_unlock(&register_mutex);
-		*ti = timeri;
-		return err;
+		goto unlock;
 	}
 
 	/* open a master instance */
-	mutex_lock(&register_mutex);
 	timer = snd_timer_find(tid);
 #ifdef CONFIG_MODULES
 	if (!timer) {
@@ -295,25 +293,26 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	}
 #endif
 	if (!timer) {
-		mutex_unlock(&register_mutex);
-		return -ENODEV;
+		err = -ENODEV;
+		goto unlock;
 	}
 	if (!list_empty(&timer->open_list_head)) {
 		timeri = list_entry(timer->open_list_head.next,
 				    struct snd_timer_instance, open_list);
 		if (timeri->flags & SNDRV_TIMER_IFLG_EXCLUSIVE) {
-			mutex_unlock(&register_mutex);
-			return -EBUSY;
+			err = -EBUSY;
+			timeri = NULL;
+			goto unlock;
 		}
 	}
 	if (timer->num_instances >= timer->max_instances) {
-		mutex_unlock(&register_mutex);
 		return -EBUSY;
+		goto unlock;
 	}
 	timeri = snd_timer_instance_new(owner, timer);
 	if (!timeri) {
-		mutex_unlock(&register_mutex);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unlock;
 	}
 	/* take a card refcount for safe disconnection */
 	if (timer->card)
@@ -322,16 +321,16 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	timeri->slave_id = slave_id;
 
 	if (list_empty(&timer->open_list_head) && timer->hw.open) {
-		int err = timer->hw.open(timer);
+		err = timer->hw.open(timer);
 		if (err) {
 			kfree(timeri->owner);
 			kfree(timeri);
+			timeri = NULL;
 
 			if (timer->card)
 				put_device(&timer->card->card_dev);
 			module_put(timer->module);
-			mutex_unlock(&register_mutex);
-			return err;
+			goto unlock;
 		}
 	}
 
@@ -342,6 +341,8 @@ int snd_timer_open(struct snd_timer_instance **ti,
 		snd_timer_close_locked(timeri);
 		timeri = NULL;
 	}
+
+ unlock:
 	mutex_unlock(&register_mutex);
 	*ti = timeri;
 	return err;
-- 
2.16.4
