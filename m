From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 31/39] ALSA: seq: optimize get_queue_client
	function to new design
Date: Sun,  7 Aug 2016 18:49:07 +0900
Message-ID: <1470563355-18368-32-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 07A12265D12
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
 sound/core/seq/seq_clientmgr.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 667ad23..30aac28 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1757,23 +1757,17 @@ static int seq_ioctl_set_queue_timer(struct snd_seq_client *client, void *arg)
 
 
 /* GET_QUEUE_CLIENT ioctl() */
-static int seq_ioctl_get_queue_client(struct snd_seq_client *client,
-				      void __user *arg)
+static int seq_ioctl_get_queue_client(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_client info;
+	struct snd_seq_queue_client *info = arg;
 	int used;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	used = snd_seq_queue_is_used(info.queue, client->number);
+	used = snd_seq_queue_is_used(info->queue, client->number);
 	if (used < 0)
 		return -EINVAL;
-	info.used = used;
-	info.client = client->number;
+	info->used = used;
+	info->client = client->number;
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
-- 
2.7.4
