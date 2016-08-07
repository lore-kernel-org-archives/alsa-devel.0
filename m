From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 34/39] ALSA: seq: optimize seq_client_pool
	function to new design
Date: Sun,  7 Aug 2016 18:49:10 +0900
Message-ID: <1470563355-18368-35-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 9E986265DDF
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
 sound/core/seq/seq_clientmgr.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2e63082..bf86ca3 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1819,44 +1819,42 @@ static int seq_ioctl_get_client_pool(struct snd_seq_client *client, void *arg)
 }
 
 /* SET_CLIENT_POOL ioctl() */
-static int seq_ioctl_set_client_pool(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_set_client_pool(struct snd_seq_client *client, void *arg)
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
 
 	return seq_ioctl_get_client_pool(client, arg);
-- 
2.7.4
