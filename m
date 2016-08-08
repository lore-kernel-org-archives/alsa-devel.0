From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/27] ALSA: seq: optimize get_subscription
	function to new design
Date: Mon,  8 Aug 2016 23:54:52 +0900
Message-ID: <1470668093-31027-27-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6D6DA2671DB
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:03 +0200 (CEST)
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
 sound/core/seq/seq_clientmgr.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index e2f332c..c0e54b3 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1905,26 +1905,25 @@ static int snd_seq_ioctl_remove_events(struct snd_seq_client *client, void *arg)
  * get subscription info
  */
 static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result;
 	struct snd_seq_client *sender = NULL;
 	struct snd_seq_client_port *sport = NULL;
-	struct snd_seq_port_subscribe subs;
 	struct snd_seq_subscribers *p;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
 	result = -EINVAL;
-	if ((sender = snd_seq_client_use_ptr(subs.sender.client)) == NULL)
+	sender = snd_seq_client_use_ptr(subs->sender.client);
+	if (sender == NULL)
 		goto __end;
-	if ((sport = snd_seq_port_use_ptr(sender, subs.sender.port)) == NULL)
+	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
+	if (sport == NULL)
 		goto __end;
-	p = snd_seq_port_get_subscription(&sport->c_src, &subs.dest);
+	p = snd_seq_port_get_subscription(&sport->c_src, &subs->dest);
 	if (p) {
 		result = 0;
-		subs = p->info;
+		*subs = p->info;
 	} else
 		result = -ENOENT;
 
@@ -1933,10 +1932,7 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 		snd_seq_port_unlock(sport);
 	if (sender)
 		snd_seq_client_unlock(sender);
-	if (result >= 0) {
-		if (copy_to_user(arg, &subs, sizeof(subs)))
-			return -EFAULT;
-	}
+
 	return result;
 }
 
-- 
2.7.4
