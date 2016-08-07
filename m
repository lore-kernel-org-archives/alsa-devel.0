From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/39] ALSA: seq: optimize unsubscribe_port
	function to new design
Date: Sun,  7 Aug 2016 18:48:56 +0900
Message-ID: <1470563355-18368-21-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id B61EE265CB5
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
 sound/core/seq/seq_clientmgr.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 8681f90..9f4bcf2 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1466,34 +1466,36 @@ static int seq_ioctl_subscribe_port(struct snd_seq_client *client, void *arg)
 /* 
  * remove from port's subscription list 
  */
-static int seq_ioctl_unsubscribe_port(struct snd_seq_client *client,
-				      void __user *arg)
+static int seq_ioctl_unsubscribe_port(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result = -ENXIO;
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
-	struct snd_seq_port_subscribe subs;
-
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
 
-	if ((receiver = snd_seq_client_use_ptr(subs.dest.client)) == NULL)
+	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	if (receiver == NULL)
 		goto __end;
-	if ((sender = snd_seq_client_use_ptr(subs.sender.client)) == NULL)
+	sender = snd_seq_client_use_ptr(subs->sender.client);
+	if (receiver == NULL)
 		goto __end;
-	if ((sport = snd_seq_port_use_ptr(sender, subs.sender.port)) == NULL)
+	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
+	if (sport == NULL)
 		goto __end;
-	if ((dport = snd_seq_port_use_ptr(receiver, subs.dest.port)) == NULL)
+	dport = snd_seq_port_use_ptr(receiver, subs->dest.port);
+	if (dport == NULL)
 		goto __end;
 
-	result = check_subscription_permission(client, sport, dport, &subs);
+	result = check_subscription_permission(client, sport, dport, subs);
 	if (result < 0)
 		goto __end;
 
-	result = snd_seq_port_disconnect(client, sender, sport, receiver, dport, &subs);
-	if (! result) /* broadcast announce */
-		snd_seq_client_notify_subscription(SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0,
-						   &subs, SNDRV_SEQ_EVENT_PORT_UNSUBSCRIBED);
+	result = snd_seq_port_disconnect(client, sender, sport, receiver, dport,
+					 subs);
+	if (!result) /* broadcast announce */
+		snd_seq_client_notify_subscription(
+					SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0, subs,
+					SNDRV_SEQ_EVENT_PORT_UNSUBSCRIBED);
       __end:
       	if (sport)
 		snd_seq_port_unlock(sport);
-- 
2.7.4
