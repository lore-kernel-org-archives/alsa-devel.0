From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/39] ALSA: seq: optimize get_queue_status
	function to new design
Date: Sun,  7 Aug 2016 18:49:02 +0900
Message-ID: <1470563355-18368-27-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 915C5265DC3
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
 sound/core/seq/seq_clientmgr.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9afb0aa..40346f2 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1615,35 +1615,29 @@ static int seq_ioctl_get_named_queue(struct snd_seq_client *client, void *arg)
 }
 
 /* GET_QUEUE_STATUS ioctl() */
-static int seq_ioctl_get_queue_status(struct snd_seq_client *client,
-				      void __user *arg)
+static int seq_ioctl_get_queue_status(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_status status;
+	struct snd_seq_queue_status *status = arg;
 	struct snd_seq_queue *queue;
 	struct snd_seq_timer *tmr;
 
-	if (copy_from_user(&status, arg, sizeof(status)))
-		return -EFAULT;
-
-	queue = queueptr(status.queue);
+	queue = queueptr(status->queue);
 	if (queue == NULL)
 		return -EINVAL;
-	memset(&status, 0, sizeof(status));
-	status.queue = queue->queue;
+	memset(status, 0, sizeof(*status));
+	status->queue = queue->queue;
 	
 	tmr = queue->timer;
-	status.events = queue->tickq->cells + queue->timeq->cells;
+	status->events = queue->tickq->cells + queue->timeq->cells;
 
-	status.time = snd_seq_timer_get_cur_time(tmr);
-	status.tick = snd_seq_timer_get_cur_tick(tmr);
+	status->time = snd_seq_timer_get_cur_time(tmr);
+	status->tick = snd_seq_timer_get_cur_tick(tmr);
 
-	status.running = tmr->running;
+	status->running = tmr->running;
 
-	status.flags = queue->flags;
+	status->flags = queue->flags;
 	queuefree(queue);
 
-	if (copy_to_user(arg, &status, sizeof(status)))
-		return -EFAULT;
 	return 0;
 }
 
-- 
2.7.4
