From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/27] ALSA: seq: optimize create/delete_port
	function to new design
Date: Mon,  8 Aug 2016 23:54:39 +0900
Message-ID: <1470668093-31027-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 1F7EB267186
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
 sound/core/seq/seq_clientmgr.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index e346786..36ac29f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1255,30 +1255,27 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 /* 
  * CREATE PORT ioctl() 
  */
-static int snd_seq_ioctl_create_port(struct snd_seq_client *client,
-				     void __user *arg)
+static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client_port *port;
-	struct snd_seq_port_info info;
 	struct snd_seq_port_callback *callback;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
 	/* it is not allowed to create the port for an another client */
-	if (info.addr.client != client->number)
+	if (info->addr.client != client->number)
 		return -EPERM;
 
-	port = snd_seq_create_port(client, (info.flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT) ? info.addr.port : -1);
+	port = snd_seq_create_port(client, (info->flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT) ? info->addr.port : -1);
 	if (port == NULL)
 		return -ENOMEM;
 
-	if (client->type == USER_CLIENT && info.kernel) {
+	if (client->type == USER_CLIENT && info->kernel) {
 		snd_seq_delete_port(client, port->addr.port);
 		return -EINVAL;
 	}
 	if (client->type == KERNEL_CLIENT) {
-		if ((callback = info.kernel) != NULL) {
+		callback = info->kernel;
+		if (callback != NULL) {
 			if (callback->owner)
 				port->owner = callback->owner;
 			port->private_data = callback->private_data;
@@ -1291,37 +1288,30 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client,
 		}
 	}
 
-	info.addr = port->addr;
+	info->addr = port->addr;
 
-	snd_seq_set_port_info(port, &info);
+	snd_seq_set_port_info(port, info);
 	snd_seq_system_client_ev_port_start(port->addr.client, port->addr.port);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
 /* 
  * DELETE PORT ioctl() 
  */
-static int snd_seq_ioctl_delete_port(struct snd_seq_client *client,
-				     void __user *arg)
+static int snd_seq_ioctl_delete_port(struct snd_seq_client *client, void *arg)
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
