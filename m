From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/27] ALSA: seq: optimize get/set_queue_timer
	function to new design
Date: Mon,  8 Aug 2016 23:54:48 +0900
Message-ID: <1470668093-31027-23-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6C51A2671C9
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:03 +0200 (CEST)
In-Reply-To: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In former commit, actual operations of each ioctl command get argument
in kernel space. Copying from/to user space is performed outside of
the function.

This commit optimizes to the new design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 44 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2f10bdd..11709da 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1699,16 +1699,13 @@ static int snd_seq_ioctl_set_queue_tempo(struct snd_seq_client *client,
 
 /* GET_QUEUE_TIMER ioctl() */
 static int snd_seq_ioctl_get_queue_timer(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_queue_timer timer;
+	struct snd_seq_queue_timer *timer = arg;
 	struct snd_seq_queue *queue;
 	struct snd_seq_timer *tmr;
 
-	if (copy_from_user(&timer, arg, sizeof(timer)))
-		return -EFAULT;
-
-	queue = queueptr(timer.queue);
+	queue = queueptr(timer->queue);
 	if (queue == NULL)
 		return -EINVAL;
 
@@ -1717,41 +1714,36 @@ static int snd_seq_ioctl_get_queue_timer(struct snd_seq_client *client,
 		return -ERESTARTSYS;
 	}
 	tmr = queue->timer;
-	memset(&timer, 0, sizeof(timer));
-	timer.queue = queue->queue;
+	memset(timer, 0, sizeof(*timer));
+	timer->queue = queue->queue;
 
-	timer.type = tmr->type;
+	timer->type = tmr->type;
 	if (tmr->type == SNDRV_SEQ_TIMER_ALSA) {
-		timer.u.alsa.id = tmr->alsa_id;
-		timer.u.alsa.resolution = tmr->preferred_resolution;
+		timer->u.alsa.id = tmr->alsa_id;
+		timer->u.alsa.resolution = tmr->preferred_resolution;
 	}
 	mutex_unlock(&queue->timer_mutex);
 	queuefree(queue);
 	
-	if (copy_to_user(arg, &timer, sizeof(timer)))
-		return -EFAULT;
 	return 0;
 }
 
 
 /* SET_QUEUE_TIMER ioctl() */
 static int snd_seq_ioctl_set_queue_timer(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_queue_timer *timer = arg;
 	int result = 0;
-	struct snd_seq_queue_timer timer;
-
-	if (copy_from_user(&timer, arg, sizeof(timer)))
-		return -EFAULT;
 
-	if (timer.type != SNDRV_SEQ_TIMER_ALSA)
+	if (timer->type != SNDRV_SEQ_TIMER_ALSA)
 		return -EINVAL;
 
-	if (snd_seq_queue_check_access(timer.queue, client->number)) {
+	if (snd_seq_queue_check_access(timer->queue, client->number)) {
 		struct snd_seq_queue *q;
 		struct snd_seq_timer *tmr;
 
-		q = queueptr(timer.queue);
+		q = queueptr(timer->queue);
 		if (q == NULL)
 			return -ENXIO;
 		if (mutex_lock_interruptible(&q->timer_mutex)) {
@@ -1759,13 +1751,13 @@ static int snd_seq_ioctl_set_queue_timer(struct snd_seq_client *client,
 			return -ERESTARTSYS;
 		}
 		tmr = q->timer;
-		snd_seq_queue_timer_close(timer.queue);
-		tmr->type = timer.type;
+		snd_seq_queue_timer_close(timer->queue);
+		tmr->type = timer->type;
 		if (tmr->type == SNDRV_SEQ_TIMER_ALSA) {
-			tmr->alsa_id = timer.u.alsa.id;
-			tmr->preferred_resolution = timer.u.alsa.resolution;
+			tmr->alsa_id = timer->u.alsa.id;
+			tmr->preferred_resolution = timer->u.alsa.resolution;
 		}
-		result = snd_seq_queue_timer_open(timer.queue);
+		result = snd_seq_queue_timer_open(timer->queue);
 		mutex_unlock(&q->timer_mutex);
 		queuefree(q);
 	} else {
-- 
2.7.4
