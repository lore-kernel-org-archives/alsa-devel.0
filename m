From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: seq: Simplify
	snd_seq_kernel_client_enqueue() helper
Date: Fri, 12 Apr 2019 14:29:34 +0200
Message-ID: <20190412122935.4092-3-tiwai@suse.de>
References: <20190412122935.4092-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3AF2F8971D
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 14:29:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6F7C9AD02
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 12:29:36 +0000 (UTC)
In-Reply-To: <20190412122935.4092-1-tiwai@suse.de>
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

We have two helpers for queuing a sequencer event from the kernel
client, and both are used only from OSS sequencer layer without any
hop and atomic set.  Let's simplify and unify two helpers into one.

No functional change, just a call pattern change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_kernel.h          |  3 ++-
 sound/core/seq/oss/seq_oss_rw.c     | 11 ++++-------
 sound/core/seq/oss/seq_oss_writeq.c |  2 +-
 sound/core/seq/seq_clientmgr.c      | 37 +++++++------------------------------
 sound/core/seq/seq_clientmgr.h      |  4 ----
 5 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index 4b9ee3009aa0..c7a5433e109a 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -73,7 +73,8 @@ __printf(3, 4)
 int snd_seq_create_kernel_client(struct snd_card *card, int client_index,
 				 const char *name_fmt, ...);
 int snd_seq_delete_kernel_client(int client);
-int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev, int atomic, int hop);
+int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev,
+				  struct file *file, bool blocking);
 int snd_seq_kernel_client_dispatch(int client, struct snd_seq_event *ev, int atomic, int hop);
 int snd_seq_kernel_client_ctl(int client, unsigned int cmd, void *arg);
 
diff --git a/sound/core/seq/oss/seq_oss_rw.c b/sound/core/seq/oss/seq_oss_rw.c
index 30886f5fb100..eb1ef12181f3 100644
--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -180,14 +180,11 @@ insert_queue(struct seq_oss_devinfo *dp, union evrec *rec, struct file *opt)
 		return 0; /* invalid event - no need to insert queue */
 
 	event.time.tick = snd_seq_oss_timer_cur_tick(dp->timer);
-	if (dp->timer->realtime || !dp->timer->running) {
+	if (dp->timer->realtime || !dp->timer->running)
 		snd_seq_oss_dispatch(dp, &event, 0, 0);
-	} else {
-		if (is_nonblock_mode(dp->file_mode))
-			rc = snd_seq_kernel_client_enqueue(dp->cseq, &event, 0, 0);
-		else
-			rc = snd_seq_kernel_client_enqueue_blocking(dp->cseq, &event, opt, 0, 0);
-	}
+	else
+		rc = snd_seq_kernel_client_enqueue(dp->cseq, &event, opt,
+						   !is_nonblock_mode(dp->file_mode));
 	return rc;
 }
 		
diff --git a/sound/core/seq/oss/seq_oss_writeq.c b/sound/core/seq/oss/seq_oss_writeq.c
index 5e04f4df10e4..b2f69617591f 100644
--- a/sound/core/seq/oss/seq_oss_writeq.c
+++ b/sound/core/seq/oss/seq_oss_writeq.c
@@ -116,7 +116,7 @@ snd_seq_oss_writeq_sync(struct seq_oss_writeq *q)
 		rec->t.code = SEQ_SYNCTIMER;
 		rec->t.time = time;
 		q->sync_event_put = 1;
-		snd_seq_kernel_client_enqueue_blocking(dp->cseq, &ev, NULL, 0, 0);
+		snd_seq_kernel_client_enqueue(dp->cseq, &ev, NULL, true);
 	}
 
 	wait_event_interruptible_timeout(q->sync_sleep, ! q->sync_event_put, HZ);
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index de320b1b90de..0af5b1440b33 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2218,12 +2218,13 @@ int snd_seq_delete_kernel_client(int client)
 }
 EXPORT_SYMBOL(snd_seq_delete_kernel_client);
 
-/* skeleton to enqueue event, called from snd_seq_kernel_client_enqueue
- * and snd_seq_kernel_client_enqueue_blocking
+/*
+ * exported, called by kernel clients to enqueue events (w/o blocking)
+ *
+ * RETURN VALUE: zero if succeed, negative if error
  */
-static int kernel_client_enqueue(int client, struct snd_seq_event *ev,
-				 struct file *file, int blocking,
-				 int atomic, int hop)
+int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev,
+				  struct file *file, bool blocking)
 {
 	struct snd_seq_client *cptr;
 	int result;
@@ -2250,37 +2251,13 @@ static int kernel_client_enqueue(int client, struct snd_seq_event *ev,
 		result = -EPERM;
 	else /* send it */
 		result = snd_seq_client_enqueue_event(cptr, ev, file, blocking,
-						      atomic, hop, NULL);
+						      false, 0, NULL);
 
 	snd_seq_client_unlock(cptr);
 	return result;
 }
-
-/*
- * exported, called by kernel clients to enqueue events (w/o blocking)
- *
- * RETURN VALUE: zero if succeed, negative if error
- */
-int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event * ev,
-				  int atomic, int hop)
-{
-	return kernel_client_enqueue(client, ev, NULL, 0, atomic, hop);
-}
 EXPORT_SYMBOL(snd_seq_kernel_client_enqueue);
 
-/*
- * exported, called by kernel clients to enqueue events (with blocking)
- *
- * RETURN VALUE: zero if succeed, negative if error
- */
-int snd_seq_kernel_client_enqueue_blocking(int client, struct snd_seq_event * ev,
-					   struct file *file,
-					   int atomic, int hop)
-{
-	return kernel_client_enqueue(client, ev, file, 1, atomic, hop);
-}
-EXPORT_SYMBOL(snd_seq_kernel_client_enqueue_blocking);
-
 /* 
  * exported, called by kernel clients to dispatch events directly to other
  * clients, bypassing the queues.  Event time-stamp will be updated.
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 0611e1e0ed5b..66ad3d547916 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -93,10 +93,6 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid);
 /* dispatch event to client(s) */
 int snd_seq_dispatch_event(struct snd_seq_event_cell *cell, int atomic, int hop);
 
-/* exported to other modules */
-int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev, int atomic, int hop);
-int snd_seq_kernel_client_enqueue_blocking(int client, struct snd_seq_event * ev,
-					   struct file *file, int atomic, int hop);
 int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table *wait);
 int snd_seq_client_notify_subscription(int client, int port,
 				       struct snd_seq_port_subscribe *info, int evtype);
-- 
2.16.4
