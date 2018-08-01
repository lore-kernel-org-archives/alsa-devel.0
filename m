From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: seq: Use no intrruptible mutex_lock
Date: Wed,  1 Aug 2018 18:11:59 +0200
Message-ID: <20180801161200.3930-5-tiwai@suse.de>
References: <20180801161200.3930-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3EF2677D9
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 18:12:02 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3AB9CAD6F
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 16:12:02 +0000 (UTC)
In-Reply-To: <20180801161200.3930-1-tiwai@suse.de>
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

All usages of mutex in ALSA sequencer core would take too long, hence
we don't have to care about the user interruption that makes things
complicated.  Let's replace them with simpler mutex_lock().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index a0b768e2f697..92e6524a3a9d 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -311,10 +311,9 @@ static int snd_seq_open(struct inode *inode, struct file *file)
 	if (err < 0)
 		return err;
 
-	if (mutex_lock_interruptible(&register_mutex))
-		return -ERESTARTSYS;
+	mutex_lock(&register_mutex);
 	client = seq_create_client1(-1, SNDRV_SEQ_DEFAULT_EVENTS);
-	if (client == NULL) {
+	if (!client) {
 		mutex_unlock(&register_mutex);
 		return -ENOMEM;	/* failure code */
 	}
@@ -1704,10 +1703,7 @@ static int snd_seq_ioctl_get_queue_timer(struct snd_seq_client *client,
 	if (queue == NULL)
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&queue->timer_mutex)) {
-		queuefree(queue);
-		return -ERESTARTSYS;
-	}
+	mutex_lock(&queue->timer_mutex);
 	tmr = queue->timer;
 	memset(timer, 0, sizeof(*timer));
 	timer->queue = queue->queue;
@@ -1741,10 +1737,7 @@ static int snd_seq_ioctl_set_queue_timer(struct snd_seq_client *client,
 		q = queueptr(timer->queue);
 		if (q == NULL)
 			return -ENXIO;
-		if (mutex_lock_interruptible(&q->timer_mutex)) {
-			queuefree(q);
-			return -ERESTARTSYS;
-		}
+		mutex_lock(&q->timer_mutex);
 		tmr = q->timer;
 		snd_seq_queue_timer_close(timer->queue);
 		tmr->type = timer->type;
@@ -2180,8 +2173,7 @@ int snd_seq_create_kernel_client(struct snd_card *card, int client_index,
 	if (card == NULL && client_index >= SNDRV_SEQ_GLOBAL_CLIENTS)
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&register_mutex))
-		return -ERESTARTSYS;
+	mutex_lock(&register_mutex);
 
 	if (card) {
 		client_index += SNDRV_SEQ_GLOBAL_CLIENTS
@@ -2522,19 +2514,15 @@ int __init snd_sequencer_device_init(void)
 	snd_device_initialize(&seq_dev, NULL);
 	dev_set_name(&seq_dev, "seq");
 
-	if (mutex_lock_interruptible(&register_mutex))
-		return -ERESTARTSYS;
-
+	mutex_lock(&register_mutex);
 	err = snd_register_device(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0,
 				  &snd_seq_f_ops, NULL, &seq_dev);
+	mutex_unlock(&register_mutex);
 	if (err < 0) {
-		mutex_unlock(&register_mutex);
 		put_device(&seq_dev);
 		return err;
 	}
 	
-	mutex_unlock(&register_mutex);
-
 	return 0;
 }
 
-- 
2.18.0
