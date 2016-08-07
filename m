From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 30/39] ALSA: seq: optimize seq_queue_timer
	function to new design
Date: Sun,  7 Aug 2016 18:49:06 +0900
Message-ID: <1470563355-18368-31-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 859A4265DA4
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:39 +0200 (CEST)
In-Reply-To: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
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
 sound/core/seq/seq_clientmgr.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 383f5d3..667ad23 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1719,23 +1719,19 @@ static int seq_ioctl_get_queue_timer(struct snd_seq_client *client, void *arg)
 
 
 /* SET_QUEUE_TIMER ioctl() */
-static int seq_ioctl_set_queue_timer(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_set_queue_timer(struct snd_seq_client *client, void *arg)
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
@@ -1743,13 +1739,13 @@ static int seq_ioctl_set_queue_timer(struct snd_seq_client *client,
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
