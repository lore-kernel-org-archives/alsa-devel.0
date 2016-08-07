From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/39] ALSA: seq: optimize create_queue
	function to new design
Date: Sun,  7 Aug 2016 18:48:57 +0900
Message-ID: <1470563355-18368-22-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id BF711265CBB
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:38 +0200 (CEST)
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
 sound/core/seq/seq_clientmgr.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9f4bcf2..aa937c0 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1510,17 +1510,13 @@ static int seq_ioctl_unsubscribe_port(struct snd_seq_client *client, void *arg)
 
 
 /* CREATE_QUEUE ioctl() */
-static int seq_ioctl_create_queue(struct snd_seq_client *client,
-				  void __user *arg)
+static int seq_ioctl_create_queue(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	int result;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	result = snd_seq_queue_alloc(client->number, info.locked, info.flags);
+	result = snd_seq_queue_alloc(client->number, info->locked, info->flags);
 	if (result < 0)
 		return result;
 
@@ -1528,19 +1524,16 @@ static int seq_ioctl_create_queue(struct snd_seq_client *client,
 	if (q == NULL)
 		return -EINVAL;
 
-	info.queue = q->queue;
-	info.locked = q->locked;
-	info.owner = q->owner;
+	info->queue = q->queue;
+	info->locked = q->locked;
+	info->owner = q->owner;
 
 	/* set queue name */
-	if (! info.name[0])
-		snprintf(info.name, sizeof(info.name), "Queue-%d", q->queue);
-	strlcpy(q->name, info.name, sizeof(q->name));
+	if (!info->name[0])
+		snprintf(info->name, sizeof(info->name), "Queue-%d", q->queue);
+	strlcpy(q->name, info->name, sizeof(q->name));
 	queuefree(q);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
-- 
2.7.4
