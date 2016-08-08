From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/27] ALSA: seq: optimize get_queue_status
	function to new design
Date: Mon,  8 Aug 2016 23:54:46 +0900
Message-ID: <1470668093-31027-21-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id A1BD62671AB
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:02 +0200 (CEST)
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
 sound/core/seq/seq_clientmgr.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 3b17e72..8a43272 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1623,34 +1623,29 @@ static int snd_seq_ioctl_get_named_queue(struct snd_seq_client *client,
 
 /* GET_QUEUE_STATUS ioctl() */
 static int snd_seq_ioctl_get_queue_status(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
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
