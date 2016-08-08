From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/27] ALSA: seq: optimize get_named_queue
	function to new design
Date: Mon,  8 Aug 2016 23:54:45 +0900
Message-ID: <1470668093-31027-20-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 9F9FC2671A8
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:02 +0200 (CEST)
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
 sound/core/seq/seq_clientmgr.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 1502794..3b17e72 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1604,25 +1604,20 @@ static int snd_seq_ioctl_set_queue_info(struct snd_seq_client *client,
 }
 
 /* GET_NAMED_QUEUE ioctl() */
-static int snd_seq_ioctl_get_named_queue(struct snd_seq_client *client, void __user *arg)
+static int snd_seq_ioctl_get_named_queue(struct snd_seq_client *client,
+					 void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	q = snd_seq_queue_find_name(info.name);
+	q = snd_seq_queue_find_name(info->name);
 	if (q == NULL)
 		return -EINVAL;
-	info.queue = q->queue;
-	info.owner = q->owner;
-	info.locked = q->locked;
+	info->queue = q->queue;
+	info->owner = q->owner;
+	info->locked = q->locked;
 	queuefree(q);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
-- 
2.7.4
