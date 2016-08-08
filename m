From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/27] ALSA: seq: optimize get/set_port_info
	function to new design
Date: Mon,  8 Aug 2016 23:54:40 +0900
Message-ID: <1470668093-31027-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 35B25267191
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
 sound/core/seq/seq_clientmgr.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 36ac29f..7815f88 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1319,32 +1319,27 @@ static int snd_seq_ioctl_delete_port(struct snd_seq_client *client, void *arg)
 /* 
  * GET_PORT_INFO ioctl() (on any client) 
  */
-static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client,
-				       void __user *arg)
+static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port;
-	struct snd_seq_port_info info;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-	cptr = snd_seq_client_use_ptr(info.addr.client);
+	cptr = snd_seq_client_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
-	port = snd_seq_port_use_ptr(cptr, info.addr.port);
+	port = snd_seq_port_use_ptr(cptr, info->addr.port);
 	if (port == NULL) {
 		snd_seq_client_unlock(cptr);
 		return -ENOENT;			/* don't change */
 	}
 
 	/* get port info */
-	snd_seq_get_port_info(port, &info);
+	snd_seq_get_port_info(port, info);
 	snd_seq_port_unlock(port);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -1352,20 +1347,16 @@ static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client,
 /* 
  * SET_PORT_INFO ioctl() (only ports on this/own client) 
  */
-static int snd_seq_ioctl_set_port_info(struct snd_seq_client *client,
-				       void __user *arg)
+static int snd_seq_ioctl_set_port_info(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client_port *port;
-	struct snd_seq_port_info info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
 
-	if (info.addr.client != client->number) /* only set our own ports ! */
+	if (info->addr.client != client->number) /* only set our own ports ! */
 		return -EPERM;
-	port = snd_seq_port_use_ptr(client, info.addr.port);
+	port = snd_seq_port_use_ptr(client, info->addr.port);
 	if (port) {
-		snd_seq_set_port_info(port, &info);
+		snd_seq_set_port_info(port, info);
 		snd_seq_port_unlock(port);
 	}
 	return 0;
-- 
2.7.4
