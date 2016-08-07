From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/39] ALSA: seq: optimize delete_queue
	function to new design
Date: Sun,  7 Aug 2016 18:48:58 +0900
Message-ID: <1470563355-18368-23-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4D0A8265D8A
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
 sound/core/seq/seq_clientmgr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index aa937c0..167be82 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1538,15 +1538,11 @@ static int seq_ioctl_create_queue(struct snd_seq_client *client, void *arg)
 }
 
 /* DELETE_QUEUE ioctl() */
-static int seq_ioctl_delete_queue(struct snd_seq_client *client,
-				  void __user *arg)
+static int seq_ioctl_delete_queue(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_info info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
+	struct snd_seq_queue_info *info = arg;
 
-	return snd_seq_queue_delete(client->number, info.queue);
+	return snd_seq_queue_delete(client->number, info->queue);
 }
 
 /* GET_QUEUE_INFO ioctl() */
-- 
2.7.4
