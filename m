From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/39] ALSA: seq: optimize delete_port function
	to new design
Date: Sun,  7 Aug 2016 18:48:52 +0900
Message-ID: <1470563355-18368-17-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 36417265D57
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
 sound/core/seq/seq_clientmgr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index c2bb93b..3acec92 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1297,23 +1297,19 @@ static int seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 /* 
  * DELETE PORT ioctl() 
  */
-static int seq_ioctl_delete_port(struct snd_seq_client *client,
-				 void __user *arg)
+static int seq_ioctl_delete_port(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_port_info info;
+	struct snd_seq_port_info *info = arg;
 	int err;
 
-	/* set passed parameters */
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-	
 	/* it is not allowed to remove the port for an another client */
-	if (info.addr.client != client->number)
+	if (info->addr.client != client->number)
 		return -EPERM;
 
-	err = snd_seq_delete_port(client, info.addr.port);
+	err = snd_seq_delete_port(client, info->addr.port);
 	if (err >= 0)
-		snd_seq_system_client_ev_port_exit(client->number, info.addr.port);
+		snd_seq_system_client_ev_port_exit(client->number,
+						   info->addr.port);
 	return err;
 }
 
-- 
2.7.4
