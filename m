From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: seq: Remove superfluous irqsave flags
Date: Tue,  9 Apr 2019 19:00:18 +0200
Message-ID: <20190409170020.20685-4-tiwai@suse.de>
References: <20190409170020.20685-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F66DF89625
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:00:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8D7A1B06B
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:00:23 +0000 (UTC)
In-Reply-To: <20190409170020.20685-1-tiwai@suse.de>
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

spin_lock_irqsave() is used unnecessarily in various places in
sequencer core code although it's pretty obvious that the context is
sleepable.  Remove irqsave and use the plain spin_lock_irq() in such
places for simplicity.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 19 ++++++++-----------
 sound/core/seq/seq_fifo.c      | 10 ++++------
 sound/core/seq/seq_memory.c    | 16 +++++++---------
 sound/core/seq/seq_ports.c     | 15 ++++++---------
 4 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 7d4640d1fe9f..933bde3843d9 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -203,7 +203,6 @@ int __init client_init_data(void)
 
 static struct snd_seq_client *seq_create_client1(int client_index, int poolsize)
 {
-	unsigned long flags;
 	int c;
 	struct snd_seq_client *client;
 
@@ -224,7 +223,7 @@ static struct snd_seq_client *seq_create_client1(int client_index, int poolsize)
 	mutex_init(&client->ioctl_mutex);
 
 	/* find free slot in the client table */
-	spin_lock_irqsave(&clients_lock, flags);
+	spin_lock_irq(&clients_lock);
 	if (client_index < 0) {
 		for (c = SNDRV_SEQ_DYNAMIC_CLIENTS_BEGIN;
 		     c < SNDRV_SEQ_MAX_CLIENTS;
@@ -232,17 +231,17 @@ static struct snd_seq_client *seq_create_client1(int client_index, int poolsize)
 			if (clienttab[c] || clienttablock[c])
 				continue;
 			clienttab[client->number = c] = client;
-			spin_unlock_irqrestore(&clients_lock, flags);
+			spin_unlock_irq(&clients_lock);
 			return client;
 		}
 	} else {
 		if (clienttab[client_index] == NULL && !clienttablock[client_index]) {
 			clienttab[client->number = client_index] = client;
-			spin_unlock_irqrestore(&clients_lock, flags);
+			spin_unlock_irq(&clients_lock);
 			return client;
 		}
 	}
-	spin_unlock_irqrestore(&clients_lock, flags);
+	spin_unlock_irq(&clients_lock);
 	snd_seq_pool_delete(&client->pool);
 	kfree(client);
 	return NULL;	/* no free slot found or busy, return failure code */
@@ -251,23 +250,21 @@ static struct snd_seq_client *seq_create_client1(int client_index, int poolsize)
 
 static int seq_free_client1(struct snd_seq_client *client)
 {
-	unsigned long flags;
-
 	if (!client)
 		return 0;
-	spin_lock_irqsave(&clients_lock, flags);
+	spin_lock_irq(&clients_lock);
 	clienttablock[client->number] = 1;
 	clienttab[client->number] = NULL;
-	spin_unlock_irqrestore(&clients_lock, flags);
+	spin_unlock_irq(&clients_lock);
 	snd_seq_delete_all_ports(client);
 	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
 	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
 		snd_seq_pool_delete(&client->pool);
-	spin_lock_irqsave(&clients_lock, flags);
+	spin_lock_irq(&clients_lock);
 	clienttablock[client->number] = 0;
-	spin_unlock_irqrestore(&clients_lock, flags);
+	spin_unlock_irq(&clients_lock);
 	return 0;
 }
 
diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index 613ae10d33b8..97ee89cb6426 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -98,18 +98,17 @@ static struct snd_seq_event_cell *fifo_cell_out(struct snd_seq_fifo *f);
 void snd_seq_fifo_clear(struct snd_seq_fifo *f)
 {
 	struct snd_seq_event_cell *cell;
-	unsigned long flags;
 
 	/* clear overflow flag */
 	atomic_set(&f->overflow, 0);
 
 	snd_use_lock_sync(&f->use_lock);
-	spin_lock_irqsave(&f->lock, flags);
+	spin_lock_irq(&f->lock);
 	/* drain the fifo */
 	while ((cell = fifo_cell_out(f)) != NULL) {
 		snd_seq_cell_free(cell);
 	}
-	spin_unlock_irqrestore(&f->lock, flags);
+	spin_unlock_irq(&f->lock);
 }
 
 
@@ -239,7 +238,6 @@ int snd_seq_fifo_poll_wait(struct snd_seq_fifo *f, struct file *file,
 /* change the size of pool; all old events are removed */
 int snd_seq_fifo_resize(struct snd_seq_fifo *f, int poolsize)
 {
-	unsigned long flags;
 	struct snd_seq_pool *newpool, *oldpool;
 	struct snd_seq_event_cell *cell, *next, *oldhead;
 
@@ -255,7 +253,7 @@ int snd_seq_fifo_resize(struct snd_seq_fifo *f, int poolsize)
 		return -ENOMEM;
 	}
 
-	spin_lock_irqsave(&f->lock, flags);
+	spin_lock_irq(&f->lock);
 	/* remember old pool */
 	oldpool = f->pool;
 	oldhead = f->head;
@@ -265,7 +263,7 @@ int snd_seq_fifo_resize(struct snd_seq_fifo *f, int poolsize)
 	f->tail = NULL;
 	f->cells = 0;
 	/* NOTE: overflow flag is not cleared */
-	spin_unlock_irqrestore(&f->lock, flags);
+	spin_unlock_irq(&f->lock);
 
 	/* close the old pool and wait until all users are gone */
 	snd_seq_pool_mark_closing(oldpool);
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index ae0b8971f6ce..19b718e871c5 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -384,7 +384,6 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 {
 	int cell;
 	struct snd_seq_event_cell *cellptr;
-	unsigned long flags;
 
 	if (snd_BUG_ON(!pool))
 		return -EINVAL;
@@ -395,9 +394,9 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 		return -ENOMEM;
 
 	/* add new cells to the free cell list */
-	spin_lock_irqsave(&pool->lock, flags);
+	spin_lock_irq(&pool->lock);
 	if (pool->ptr) {
-		spin_unlock_irqrestore(&pool->lock, flags);
+		spin_unlock_irq(&pool->lock);
 		kvfree(cellptr);
 		return 0;
 	}
@@ -416,7 +415,7 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 	/* init statistics */
 	pool->max_used = 0;
 	pool->total_elements = pool->size;
-	spin_unlock_irqrestore(&pool->lock, flags);
+	spin_unlock_irq(&pool->lock);
 	return 0;
 }
 
@@ -435,7 +434,6 @@ void snd_seq_pool_mark_closing(struct snd_seq_pool *pool)
 /* remove events */
 int snd_seq_pool_done(struct snd_seq_pool *pool)
 {
-	unsigned long flags;
 	struct snd_seq_event_cell *ptr;
 
 	if (snd_BUG_ON(!pool))
@@ -449,18 +447,18 @@ int snd_seq_pool_done(struct snd_seq_pool *pool)
 		schedule_timeout_uninterruptible(1);
 	
 	/* release all resources */
-	spin_lock_irqsave(&pool->lock, flags);
+	spin_lock_irq(&pool->lock);
 	ptr = pool->ptr;
 	pool->ptr = NULL;
 	pool->free = NULL;
 	pool->total_elements = 0;
-	spin_unlock_irqrestore(&pool->lock, flags);
+	spin_unlock_irq(&pool->lock);
 
 	kvfree(ptr);
 
-	spin_lock_irqsave(&pool->lock, flags);
+	spin_lock_irq(&pool->lock);
 	pool->closing = 0;
-	spin_unlock_irqrestore(&pool->lock, flags);
+	spin_unlock_irq(&pool->lock);
 
 	return 0;
 }
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 24d90abfc64d..1e2239240f21 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -128,7 +128,6 @@ static void port_subs_info_init(struct snd_seq_port_subs_info *grp)
 struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 						int port)
 {
-	unsigned long flags;
 	struct snd_seq_client_port *new_port, *p;
 	int num = -1;
 	
@@ -157,7 +156,7 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 
 	num = port >= 0 ? port : 0;
 	mutex_lock(&client->ports_mutex);
-	write_lock_irqsave(&client->ports_lock, flags);
+	write_lock_irq(&client->ports_lock);
 	list_for_each_entry(p, &client->ports_list_head, list) {
 		if (p->addr.port > num)
 			break;
@@ -169,7 +168,7 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 	client->num_ports++;
 	new_port->addr.port = num;	/* store the port number in the port */
 	sprintf(new_port->name, "port-%d", num);
-	write_unlock_irqrestore(&client->ports_lock, flags);
+	write_unlock_irq(&client->ports_lock);
 	mutex_unlock(&client->ports_mutex);
 
 	return new_port;
@@ -283,11 +282,10 @@ static int port_delete(struct snd_seq_client *client,
 /* delete a port with the given port id */
 int snd_seq_delete_port(struct snd_seq_client *client, int port)
 {
-	unsigned long flags;
 	struct snd_seq_client_port *found = NULL, *p;
 
 	mutex_lock(&client->ports_mutex);
-	write_lock_irqsave(&client->ports_lock, flags);
+	write_lock_irq(&client->ports_lock);
 	list_for_each_entry(p, &client->ports_list_head, list) {
 		if (p->addr.port == port) {
 			/* ok found.  delete from the list at first */
@@ -297,7 +295,7 @@ int snd_seq_delete_port(struct snd_seq_client *client, int port)
 			break;
 		}
 	}
-	write_unlock_irqrestore(&client->ports_lock, flags);
+	write_unlock_irq(&client->ports_lock);
 	mutex_unlock(&client->ports_mutex);
 	if (found)
 		return port_delete(client, found);
@@ -308,7 +306,6 @@ int snd_seq_delete_port(struct snd_seq_client *client, int port)
 /* delete the all ports belonging to the given client */
 int snd_seq_delete_all_ports(struct snd_seq_client *client)
 {
-	unsigned long flags;
 	struct list_head deleted_list;
 	struct snd_seq_client_port *port, *tmp;
 	
@@ -316,7 +313,7 @@ int snd_seq_delete_all_ports(struct snd_seq_client *client)
 	 * clear the port list in the client data.
 	 */
 	mutex_lock(&client->ports_mutex);
-	write_lock_irqsave(&client->ports_lock, flags);
+	write_lock_irq(&client->ports_lock);
 	if (! list_empty(&client->ports_list_head)) {
 		list_add(&deleted_list, &client->ports_list_head);
 		list_del_init(&client->ports_list_head);
@@ -324,7 +321,7 @@ int snd_seq_delete_all_ports(struct snd_seq_client *client)
 		INIT_LIST_HEAD(&deleted_list);
 	}
 	client->num_ports = 0;
-	write_unlock_irqrestore(&client->ports_lock, flags);
+	write_unlock_irq(&client->ports_lock);
 
 	/* remove each port in deleted_list */
 	list_for_each_entry_safe(port, tmp, &deleted_list, list) {
-- 
2.16.4
