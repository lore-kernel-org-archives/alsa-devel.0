From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/27] ALSA: seq: optimize get/set_queue_info
	function to new design
Date: Mon,  8 Aug 2016 23:54:43 +0900
Message-ID: <1470668093-31027-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6D2D32671D3
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
 sound/core/seq/seq_clientmgr.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 44b58dc..a5e1c0a 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1551,28 +1551,22 @@ static int snd_seq_ioctl_delete_queue(struct snd_seq_client *client, void *arg)
 
 /* GET_QUEUE_INFO ioctl() */
 static int snd_seq_ioctl_get_queue_info(struct snd_seq_client *client,
-					void __user *arg)
+					void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	q = queueptr(info.queue);
+	q = queueptr(info->queue);
 	if (q == NULL)
 		return -EINVAL;
 
-	memset(&info, 0, sizeof(info));
-	info.queue = q->queue;
-	info.owner = q->owner;
-	info.locked = q->locked;
-	strlcpy(info.name, q->name, sizeof(info.name));
+	memset(info, 0, sizeof(*info));
+	info->queue = q->queue;
+	info->owner = q->owner;
+	info->locked = q->locked;
+	strlcpy(info->name, q->name, sizeof(info->name));
 	queuefree(q);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
-- 
2.7.4
