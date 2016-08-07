From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/39] ALSA: seq: optimize system_info function
	to new design
Date: Sun,  7 Aug 2016 18:48:47 +0900
Message-ID: <1470563355-18368-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 19923265AA7
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
 sound/core/seq/seq_clientmgr.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 123d8a1..cb86190 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1131,22 +1131,19 @@ static int seq_ioctl_client_id(struct snd_seq_client *client, void *arg)
 }
 
 /* SYSTEM_INFO ioctl() */
-static int seq_ioctl_system_info(struct snd_seq_client *client,
-				 void __user *arg)
+static int seq_ioctl_system_info(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_system_info info;
+	struct snd_seq_system_info *info = arg;
 
-	memset(&info, 0, sizeof(info));
+	memset(info, 0, sizeof(*info));
 	/* fill the info fields */
-	info.queues = SNDRV_SEQ_MAX_QUEUES;
-	info.clients = SNDRV_SEQ_MAX_CLIENTS;
-	info.ports = SNDRV_SEQ_MAX_PORTS;
-	info.channels = 256;	/* fixed limit */
-	info.cur_clients = client_usage.cur;
-	info.cur_queues = snd_seq_queue_get_cur_queues();
+	info->queues = SNDRV_SEQ_MAX_QUEUES;
+	info->clients = SNDRV_SEQ_MAX_CLIENTS;
+	info->ports = SNDRV_SEQ_MAX_PORTS;
+	info->channels = 256;	/* fixed limit */
+	info->cur_clients = client_usage.cur;
+	info->cur_queues = snd_seq_queue_get_cur_queues();
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
-- 
2.7.4
