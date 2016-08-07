From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 35/39] ALSA: seq: optimize remove_events
	function to new design
Date: Sun,  7 Aug 2016 18:49:11 +0900
Message-ID: <1470563355-18368-36-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 87D79265DA7
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
 sound/core/seq/seq_clientmgr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index bf86ca3..b608521 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1862,18 +1862,14 @@ static int seq_ioctl_set_client_pool(struct snd_seq_client *client, void *arg)
 
 
 /* REMOVE_EVENTS ioctl() */
-static int seq_ioctl_remove_events(struct snd_seq_client *client,
-				   void __user *arg)
+static int seq_ioctl_remove_events(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_remove_events info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
+	struct snd_seq_remove_events *info = arg;
 
 	/*
 	 * Input mostly not implemented XXX.
 	 */
-	if (info.remove_mode & SNDRV_SEQ_REMOVE_INPUT) {
+	if (info->remove_mode & SNDRV_SEQ_REMOVE_INPUT) {
 		/*
 		 * No restrictions so for a user client we can clear
 		 * the whole fifo
@@ -1882,8 +1878,8 @@ static int seq_ioctl_remove_events(struct snd_seq_client *client,
 			snd_seq_fifo_clear(client->data.user.fifo);
 	}
 
-	if (info.remove_mode & SNDRV_SEQ_REMOVE_OUTPUT)
-		snd_seq_queue_remove_cells(client->number, &info);
+	if (info->remove_mode & SNDRV_SEQ_REMOVE_OUTPUT)
+		snd_seq_queue_remove_cells(client->number, info);
 
 	return 0;
 }
-- 
2.7.4
