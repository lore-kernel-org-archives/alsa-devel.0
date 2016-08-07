From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/39] ALSA: seq: optimize set_client_info
	function to new design
Date: Sun,  7 Aug 2016 18:48:50 +0900
Message-ID: <1470563355-18368-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 339B5265B8F
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
 sound/core/seq/seq_clientmgr.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 3e7431e..46e040b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1227,28 +1227,24 @@ static int seq_ioctl_get_client_info(struct snd_seq_client *client, void *arg)
 
 
 /* CLIENT_INFO ioctl() */
-static int seq_ioctl_set_client_info(struct snd_seq_client *client,
-				     void __user *arg)
+static int seq_ioctl_set_client_info(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_client_info client_info;
-
-	if (copy_from_user(&client_info, arg, sizeof(client_info)))
-		return -EFAULT;
+	struct snd_seq_client_info *client_info = arg;
 
 	/* it is not allowed to set the info fields for an another client */
-	if (client->number != client_info.client)
+	if (client->number != client_info->client)
 		return -EPERM;
 	/* also client type must be set now */
-	if (client->type != client_info.type)
+	if (client->type != client_info->type)
 		return -EINVAL;
 
 	/* fill the info fields */
-	if (client_info.name[0])
-		strlcpy(client->name, client_info.name, sizeof(client->name));
+	if (client_info->name[0])
+		strlcpy(client->name, client_info->name, sizeof(client->name));
 
-	client->filter = client_info.filter;
-	client->event_lost = client_info.event_lost;
-	memcpy(client->event_filter, client_info.event_filter, 32);
+	client->filter = client_info->filter;
+	client->event_lost = client_info->event_lost;
+	memcpy(client->event_filter, client_info->event_filter, 32);
 
 	return 0;
 }
-- 
2.7.4
