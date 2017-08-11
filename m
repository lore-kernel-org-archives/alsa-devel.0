From: Daniel Mentz <danielmentz@google.com>
Subject: [PATCH] ALSA: seq: 2nd attempt at fixing race creating a q
Date: Thu, 10 Aug 2017 20:07:34 -0700
Message-ID: <20170811030734.37741-1-danielmentz@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@perex.cz
Cc: Daniel Mentz <danielmentz@google.com>, stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

commit 4842e98f26dd80be3623c4714a244ba52ea096a8 ("ALSA: seq: Fix race at
creating a queue") attempted to fix a race reported by syzkaller. That
fix has been described as follows:

"
When a sequencer queue is created in snd_seq_queue_alloc(),it adds the
new queue element to the public list before referencing it.  Thus the
queue might be deleted before the call of snd_seq_queue_use(), and it
results in the use-after-free error, as spotted by syzkaller.

The fix is to reference the queue object at the right time.
"

The last phrase in that commit message refers to calling queue_use(q, client,
1) which increments queue->clients, but that does not prevent the
DELETE_QUEUE ioctl() and queue_delete() from kfree()ing the queue.
Hence, the commit is not effective at preventing the race.

This commit adds code to effectively prevent the removal of the queue by
calling snd_use_lock_use().

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 sound/core/seq/seq_clientmgr.c | 13 ++++---------
 sound/core/seq/seq_queue.c     | 14 +++++++++-----
 sound/core/seq/seq_queue.h     |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 272c55fe17c8..ea2d0ae85bd3 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1502,16 +1502,11 @@ static int snd_seq_ioctl_unsubscribe_port(struct snd_seq_client *client,
 static int snd_seq_ioctl_create_queue(struct snd_seq_client *client, void *arg)
 {
 	struct snd_seq_queue_info *info = arg;
-	int result;
 	struct snd_seq_queue *q;
 
-	result = snd_seq_queue_alloc(client->number, info->locked, info->flags);
-	if (result < 0)
-		return result;
-
-	q = queueptr(result);
-	if (q == NULL)
-		return -EINVAL;
+	q = snd_seq_queue_alloc(client->number, info->locked, info->flags);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
 
 	info->queue = q->queue;
 	info->locked = q->locked;
@@ -1521,7 +1516,7 @@ static int snd_seq_ioctl_create_queue(struct snd_seq_client *client, void *arg)
 	if (!info->name[0])
 		snprintf(info->name, sizeof(info->name), "Queue-%d", q->queue);
 	strlcpy(q->name, info->name, sizeof(q->name));
-	queuefree(q);
+	snd_use_lock_free(&q->use_lock);
 
 	return 0;
 }
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index 450c5187eecb..79e0c5604ef8 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -184,22 +184,26 @@ void __exit snd_seq_queues_delete(void)
 static void queue_use(struct snd_seq_queue *queue, int client, int use);
 
 /* allocate a new queue -
- * return queue index value or negative value for error
+ * return pointer to new queue or ERR_PTR(-errno) for error
+ * The new queue's use_lock is set to 1. It is the caller's responsibility to
+ * call snd_use_lock_free(&q->use_lock).
  */
-int snd_seq_queue_alloc(int client, int locked, unsigned int info_flags)
+struct snd_seq_queue *snd_seq_queue_alloc(int client, int locked, unsigned int info_flags)
 {
 	struct snd_seq_queue *q;
 
 	q = queue_new(client, locked);
 	if (q == NULL)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	q->info_flags = info_flags;
 	queue_use(q, client, 1);
+	snd_use_lock_use(&q->use_lock);
 	if (queue_list_add(q) < 0) {
+		snd_use_lock_free(&q->use_lock);
 		queue_delete(q);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
-	return q->queue;
+	return q;
 }
 
 /* delete a queue - queue must be owned by the client */
diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
index 30c8111477f6..719093489a2c 100644
--- a/sound/core/seq/seq_queue.h
+++ b/sound/core/seq/seq_queue.h
@@ -71,7 +71,7 @@ void snd_seq_queues_delete(void);
 
 
 /* create new queue (constructor) */
-int snd_seq_queue_alloc(int client, int locked, unsigned int flags);
+struct snd_seq_queue *snd_seq_queue_alloc(int client, int locked, unsigned int flags);
 
 /* delete queue (destructor) */
 int snd_seq_queue_delete(int client, int queueid);
-- 
2.14.0.434.g98096fd7a8-goog
