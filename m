From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/39] ALSA: seq: optimize client_info function
	to new design
Date: Sun,  7 Aug 2016 18:48:49 +0900
Message-ID: <1470563355-18368-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 24BA3265B3F
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
 sound/core/seq/seq_clientmgr.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 10a2e43..3e7431e 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1209,25 +1209,19 @@ static void get_client_info(struct snd_seq_client *cptr,
 	memset(info->reserved, 0, sizeof(info->reserved));
 }
 
-static int seq_ioctl_get_client_info(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_get_client_info(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_client_info *client_info = arg;
 	struct snd_seq_client *cptr;
-	struct snd_seq_client_info client_info;
-
-	if (copy_from_user(&client_info, arg, sizeof(client_info)))
-		return -EFAULT;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(client_info.client);
+	cptr = snd_seq_client_use_ptr(client_info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
-	get_client_info(cptr, &client_info);
+	get_client_info(cptr, client_info);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &client_info, sizeof(client_info)))
-		return -EFAULT;
 	return 0;
 }
 
-- 
2.7.4
