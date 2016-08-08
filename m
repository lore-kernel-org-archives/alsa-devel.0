From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/27] ALSA: seq: optimize get/set_client_pool
	function to new design
Date: Mon,  8 Aug 2016 23:54:50 +0900
Message-ID: <1470668093-31027-25-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6CFD12671D0
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
 sound/core/seq/seq_clientmgr.c | 68 +++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 5f3489b..9998632 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1805,78 +1805,72 @@ static int snd_seq_ioctl_set_queue_client(struct snd_seq_client *client,
 
 /* GET_CLIENT_POOL ioctl() */
 static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_client_pool info;
+	struct snd_seq_client_pool *info = arg;
 	struct snd_seq_client *cptr;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	cptr = snd_seq_client_use_ptr(info.client);
+	cptr = snd_seq_client_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;
-	memset(&info, 0, sizeof(info));
-	info.client = cptr->number;
-	info.output_pool = cptr->pool->size;
-	info.output_room = cptr->pool->room;
-	info.output_free = info.output_pool;
-	info.output_free = snd_seq_unused_cells(cptr->pool);
+	memset(info, 0, sizeof(*info));
+	info->client = cptr->number;
+	info->output_pool = cptr->pool->size;
+	info->output_room = cptr->pool->room;
+	info->output_free = info->output_pool;
+	info->output_free = snd_seq_unused_cells(cptr->pool);
 	if (cptr->type == USER_CLIENT) {
-		info.input_pool = cptr->data.user.fifo_pool_size;
-		info.input_free = info.input_pool;
+		info->input_pool = cptr->data.user.fifo_pool_size;
+		info->input_free = info->input_pool;
 		if (cptr->data.user.fifo)
-			info.input_free = snd_seq_unused_cells(cptr->data.user.fifo->pool);
+			info->input_free = snd_seq_unused_cells(cptr->data.user.fifo->pool);
 	} else {
-		info.input_pool = 0;
-		info.input_free = 0;
+		info->input_pool = 0;
+		info->input_free = 0;
 	}
 	snd_seq_client_unlock(cptr);
 	
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
 /* SET_CLIENT_POOL ioctl() */
 static int snd_seq_ioctl_set_client_pool(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_client_pool info;
+	struct snd_seq_client_pool *info = arg;
 	int rc;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	if (client->number != info.client)
+	if (client->number != info->client)
 		return -EINVAL; /* can't change other clients */
 
-	if (info.output_pool >= 1 && info.output_pool <= SNDRV_SEQ_MAX_EVENTS &&
-	    (! snd_seq_write_pool_allocated(client) ||
-	     info.output_pool != client->pool->size)) {
+	if (info->output_pool >= 1 &&
+	    info->output_pool <= SNDRV_SEQ_MAX_EVENTS &&
+	    (!snd_seq_write_pool_allocated(client) ||
+	     info->output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
 			/* remove all existing cells */
 			snd_seq_queue_client_leave_cells(client->number);
 			snd_seq_pool_done(client->pool);
 		}
-		client->pool->size = info.output_pool;
+		client->pool->size = info->output_pool;
 		rc = snd_seq_pool_init(client->pool);
 		if (rc < 0)
 			return rc;
 	}
 	if (client->type == USER_CLIENT && client->data.user.fifo != NULL &&
-	    info.input_pool >= 1 &&
-	    info.input_pool <= SNDRV_SEQ_MAX_CLIENT_EVENTS &&
-	    info.input_pool != client->data.user.fifo_pool_size) {
+	    info->input_pool >= 1 &&
+	    info->input_pool <= SNDRV_SEQ_MAX_CLIENT_EVENTS &&
+	    info->input_pool != client->data.user.fifo_pool_size) {
 		/* change pool size */
-		rc = snd_seq_fifo_resize(client->data.user.fifo, info.input_pool);
+		rc = snd_seq_fifo_resize(client->data.user.fifo,
+					 info->input_pool);
 		if (rc < 0)
 			return rc;
-		client->data.user.fifo_pool_size = info.input_pool;
+		client->data.user.fifo_pool_size = info->input_pool;
 	}
-	if (info.output_room >= 1 &&
-	    info.output_room <= client->pool->size) {
-		client->pool->room  = info.output_room;
+	if (info->output_room >= 1 &&
+	    info->output_room <= client->pool->size) {
+		client->pool->room  = info->output_room;
 	}
 
 	return snd_seq_ioctl_get_client_pool(client, arg);
-- 
2.7.4
