From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/27] ALSA: seq: optimize get/set_queue_info
	function to new design
Date: Mon,  8 Aug 2016 23:54:44 +0900
Message-ID: <1470668093-31027-19-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6CC432671CD
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
 sound/core/seq/seq_clientmgr.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index a5e1c0a..1502794 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1572,35 +1572,32 @@ static int snd_seq_ioctl_get_queue_info(struct snd_seq_client *client,
 
 /* SET_QUEUE_INFO ioctl() */
 static int snd_seq_ioctl_set_queue_info(struct snd_seq_client *client,
-					void __user *arg)
+					void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	if (info.owner != client->number)
+	if (info->owner != client->number)
 		return -EINVAL;
 
 	/* change owner/locked permission */
-	if (snd_seq_queue_check_access(info.queue, client->number)) {
-		if (snd_seq_queue_set_owner(info.queue, client->number, info.locked) < 0)
+	if (snd_seq_queue_check_access(info->queue, client->number)) {
+		if (snd_seq_queue_set_owner(info->queue, client->number, info->locked) < 0)
 			return -EPERM;
-		if (info.locked)
-			snd_seq_queue_use(info.queue, client->number, 1);
+		if (info->locked)
+			snd_seq_queue_use(info->queue, client->number, 1);
 	} else {
 		return -EPERM;
 	}	
 
-	q = queueptr(info.queue);
-	if (! q)
+	q = queueptr(info->queue);
+	if (!q)
 		return -EINVAL;
 	if (q->owner != client->number) {
 		queuefree(q);
 		return -EPERM;
 	}
-	strlcpy(q->name, info.name, sizeof(q->name));
+	strlcpy(q->name, info->name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;
-- 
2.7.4
