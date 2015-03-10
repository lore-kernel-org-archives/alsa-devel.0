From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: seq: Drop superfluous error/debug
	messages after malloc failures
Date: Tue, 10 Mar 2015 15:43:18 +0100
Message-ID: <1425998599-9481-2-git-send-email-tiwai@suse.de>
References: <1425998599-9481-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 88F952606FE
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 15:43:23 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3A4DFACF2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 14:43:23 +0000 (UTC)
In-Reply-To: <1425998599-9481-1-git-send-email-tiwai@suse.de>
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

The kernel memory allocators already report the errors when the
requested allocation fails, thus we don't need to warn it again in
each caller side.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_fifo.c   | 4 +---
 sound/core/seq/seq_memory.c | 8 ++------
 sound/core/seq/seq_ports.c  | 4 +---
 sound/core/seq/seq_prioq.c  | 4 +---
 sound/core/seq/seq_queue.c  | 4 +---
 sound/core/seq/seq_timer.c  | 4 +---
 6 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index 53a403e17c5b..1d5acbe0c08b 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -33,10 +33,8 @@ struct snd_seq_fifo *snd_seq_fifo_new(int poolsize)
 	struct snd_seq_fifo *f;
 
 	f = kzalloc(sizeof(*f), GFP_KERNEL);
-	if (f == NULL) {
-		pr_debug("ALSA: seq: malloc failed for snd_seq_fifo_new() \n");
+	if (!f)
 		return NULL;
-	}
 
 	f->pool = snd_seq_pool_new(poolsize);
 	if (f->pool == NULL) {
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index ba8e4a64e13e..801076687bb1 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -387,10 +387,8 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 		return 0;
 
 	pool->ptr = vmalloc(sizeof(struct snd_seq_event_cell) * pool->size);
-	if (pool->ptr == NULL) {
-		pr_debug("ALSA: seq: malloc for sequencer events failed\n");
+	if (!pool->ptr)
 		return -ENOMEM;
-	}
 
 	/* add new cells to the free cell list */
 	spin_lock_irqsave(&pool->lock, flags);
@@ -463,10 +461,8 @@ struct snd_seq_pool *snd_seq_pool_new(int poolsize)
 
 	/* create pool block */
 	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
-	if (pool == NULL) {
-		pr_debug("ALSA: seq: malloc failed for pool\n");
+	if (!pool)
 		return NULL;
-	}
 	spin_lock_init(&pool->lock);
 	pool->ptr = NULL;
 	pool->free = NULL;
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 46ff593f618d..55170a20ae72 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -141,10 +141,8 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 
 	/* create a new port */
 	new_port = kzalloc(sizeof(*new_port), GFP_KERNEL);
-	if (! new_port) {
-		pr_debug("ALSA: seq: malloc failed for registering client port\n");
+	if (!new_port)
 		return NULL;	/* failure, out of memory */
-	}
 	/* init port data */
 	new_port->addr.client = client->number;
 	new_port->addr.port = -1;
diff --git a/sound/core/seq/seq_prioq.c b/sound/core/seq/seq_prioq.c
index 021b02bc9330..bc1c8488fc2a 100644
--- a/sound/core/seq/seq_prioq.c
+++ b/sound/core/seq/seq_prioq.c
@@ -59,10 +59,8 @@ struct snd_seq_prioq *snd_seq_prioq_new(void)
 	struct snd_seq_prioq *f;
 
 	f = kzalloc(sizeof(*f), GFP_KERNEL);
-	if (f == NULL) {
-		pr_debug("ALSA: seq: malloc failed for snd_seq_prioq_new()\n");
+	if (!f)
 		return NULL;
-	}
 	
 	spin_lock_init(&f->lock);
 	f->head = NULL;
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index aad4878cee55..a0cda38205b9 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -111,10 +111,8 @@ static struct snd_seq_queue *queue_new(int owner, int locked)
 	struct snd_seq_queue *q;
 
 	q = kzalloc(sizeof(*q), GFP_KERNEL);
-	if (q == NULL) {
-		pr_debug("ALSA: seq: malloc failed for snd_seq_queue_new()\n");
+	if (!q)
 		return NULL;
-	}
 
 	spin_lock_init(&q->owner_lock);
 	spin_lock_init(&q->check_lock);
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index e73605393eee..186f1611103c 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -56,10 +56,8 @@ struct snd_seq_timer *snd_seq_timer_new(void)
 	struct snd_seq_timer *tmr;
 	
 	tmr = kzalloc(sizeof(*tmr), GFP_KERNEL);
-	if (tmr == NULL) {
-		pr_debug("ALSA: seq: malloc failed for snd_seq_timer_new() \n");
+	if (!tmr)
 		return NULL;
-	}
 	spin_lock_init(&tmr->lock);
 
 	/* reset setup to defaults */
-- 
2.3.2
