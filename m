From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/27] ALSA: seq: optimize subscribe_port
	function to new design
Date: Mon,  8 Aug 2016 23:54:41 +0900
Message-ID: <1470668093-31027-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 99CB02671A7
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
 sound/core/seq/seq_clientmgr.c | 62 +++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 7815f88..7b32daa 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1422,34 +1422,37 @@ int snd_seq_client_notify_subscription(int client, int port,
  * add to port's subscription list IOCTL interface 
  */
 static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
-					void __user *arg)
+					void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result = -EINVAL;
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
-	struct snd_seq_port_subscribe subs;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
-	if ((receiver = snd_seq_client_use_ptr(subs.dest.client)) == NULL)
+	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	if (receiver == NULL)
 		goto __end;
-	if ((sender = snd_seq_client_use_ptr(subs.sender.client)) == NULL)
+	sender = snd_seq_client_use_ptr(subs->sender.client);
+	if (sender == NULL)
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
 
 	/* connect them */
-	result = snd_seq_port_connect(client, sender, sport, receiver, dport, &subs);
-	if (! result) /* broadcast announce */
-		snd_seq_client_notify_subscription(SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0,
-						   &subs, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
+	result = snd_seq_port_connect(client, sender, sport, receiver, dport,
+				      subs);
+	if (!result) /* broadcast announce */
+		snd_seq_client_notify_subscription(
+					SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0,
+					subs, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
       __end:
       	if (sport)
 		snd_seq_port_unlock(sport);
@@ -1467,33 +1470,36 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
  * remove from port's subscription list 
  */
 static int snd_seq_ioctl_unsubscribe_port(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result = -ENXIO;
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
-	struct snd_seq_port_subscribe subs;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
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
