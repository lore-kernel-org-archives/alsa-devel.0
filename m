From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 37/39] ALSA: seq: optimize query_subs function
	to new design
Date: Sun,  7 Aug 2016 18:49:13 +0900
Message-ID: <1470563355-18368-38-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 8B36E265DA9
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
 sound/core/seq/seq_clientmgr.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index cd4073d..e4a9754 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1923,25 +1923,24 @@ static int seq_ioctl_get_subscription(struct snd_seq_client *client, void *arg)
 /*
  * get subscription info - check only its presence
  */
-static int seq_ioctl_query_subs(struct snd_seq_client *client, void __user *arg)
+static int seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_query_subs *subs = arg;
 	int result = -ENXIO;
 	struct snd_seq_client *cptr = NULL;
 	struct snd_seq_client_port *port = NULL;
-	struct snd_seq_query_subs subs;
 	struct snd_seq_port_subs_info *group;
 	struct list_head *p;
 	int i;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
-	if ((cptr = snd_seq_client_use_ptr(subs.root.client)) == NULL)
+	cptr = snd_seq_client_use_ptr(subs->root.client);
+	if (cptr == NULL)
 		goto __end;
-	if ((port = snd_seq_port_use_ptr(cptr, subs.root.port)) == NULL)
+	port = snd_seq_port_use_ptr(cptr, subs->root.port);
+	if (cptr == NULL)
 		goto __end;
 
-	switch (subs.type) {
+	switch (subs->type) {
 	case SNDRV_SEQ_QUERY_SUBS_READ:
 		group = &port->c_src;
 		break;
@@ -1954,22 +1953,22 @@ static int seq_ioctl_query_subs(struct snd_seq_client *client, void __user *arg)
 
 	down_read(&group->list_mutex);
 	/* search for the subscriber */
-	subs.num_subs = group->count;
+	subs->num_subs = group->count;
 	i = 0;
 	result = -ENOENT;
 	list_for_each(p, &group->list_head) {
-		if (i++ == subs.index) {
+		if (i++ == subs->index) {
 			/* found! */
 			struct snd_seq_subscribers *s;
-			if (subs.type == SNDRV_SEQ_QUERY_SUBS_READ) {
+			if (subs->type == SNDRV_SEQ_QUERY_SUBS_READ) {
 				s = list_entry(p, struct snd_seq_subscribers, src_list);
-				subs.addr = s->info.dest;
+				subs->addr = s->info.dest;
 			} else {
 				s = list_entry(p, struct snd_seq_subscribers, dest_list);
-				subs.addr = s->info.sender;
+				subs->addr = s->info.sender;
 			}
-			subs.flags = s->info.flags;
-			subs.queue = s->info.queue;
+			subs->flags = s->info.flags;
+			subs->queue = s->info.queue;
 			result = 0;
 			break;
 		}
@@ -1981,10 +1980,7 @@ static int seq_ioctl_query_subs(struct snd_seq_client *client, void __user *arg)
 		snd_seq_port_unlock(port);
 	if (cptr)
 		snd_seq_client_unlock(cptr);
-	if (result >= 0) {
-		if (copy_to_user(arg, &subs, sizeof(subs)))
-			return -EFAULT;
-	}
+
 	return result;
 }
 
-- 
2.7.4
