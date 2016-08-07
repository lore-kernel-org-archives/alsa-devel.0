From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 33/39] ALSA: seq: optimize get_client_pool
	function to new design
Date: Sun,  7 Aug 2016 18:49:09 +0900
Message-ID: <1470563355-18368-34-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 15D73265D42
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
 sound/core/seq/seq_clientmgr.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6c1b406..2e63082 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1790,37 +1790,31 @@ static int seq_ioctl_set_queue_client(struct snd_seq_client *client, void *arg)
 
 
 /* GET_CLIENT_POOL ioctl() */
-static int seq_ioctl_get_client_pool(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_get_client_pool(struct snd_seq_client *client, void *arg)
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
 
-- 
2.7.4
