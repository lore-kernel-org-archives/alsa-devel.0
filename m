From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 29/39] ALSA: seq: optimize get_queue_timer
	function to new design
Date: Sun,  7 Aug 2016 18:49:05 +0900
Message-ID: <1470563355-18368-30-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 084E9265D3D
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
 sound/core/seq/seq_clientmgr.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index a90a4a3..383f5d3 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1688,17 +1688,13 @@ static int seq_ioctl_set_queue_tempo(struct snd_seq_client *client, void *arg)
 
 
 /* GET_QUEUE_TIMER ioctl() */
-static int seq_ioctl_get_queue_timer(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_get_queue_timer(struct snd_seq_client *client, void *arg)
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
 
@@ -1707,19 +1703,17 @@ static int seq_ioctl_get_queue_timer(struct snd_seq_client *client,
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
 
-- 
2.7.4
