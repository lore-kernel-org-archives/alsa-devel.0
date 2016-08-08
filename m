From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 27/27] ALSA: seq: optimize query functions for
	subscribes, next client and port to new design
Date: Mon,  8 Aug 2016 23:54:53 +0900
Message-ID: <1470668093-31027-28-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B830B2671B9
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
 sound/core/seq/seq_clientmgr.c | 74 +++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index c0e54b3..04f23f1 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1940,26 +1940,24 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 /*
  * get subscription info - check only its presence
  */
-static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
-				    void __user *arg)
+static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
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
@@ -1972,22 +1970,22 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
 
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
@@ -1999,10 +1997,7 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
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
 
@@ -2011,31 +2006,26 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
  * query next client
  */
 static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
-					   void __user *arg)
+					   void *arg)
 {
+	struct snd_seq_client_info *info = arg;
 	struct snd_seq_client *cptr = NULL;
-	struct snd_seq_client_info info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
 
 	/* search for next client */
-	info.client++;
-	if (info.client < 0)
-		info.client = 0;
-	for (; info.client < SNDRV_SEQ_MAX_CLIENTS; info.client++) {
-		cptr = snd_seq_client_use_ptr(info.client);
+	info->client++;
+	if (info->client < 0)
+		info->client = 0;
+	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {
+		cptr = snd_seq_client_use_ptr(info->client);
 		if (cptr)
 			break; /* found */
 	}
 	if (cptr == NULL)
 		return -ENOENT;
 
-	get_client_info(cptr, &info);
+	get_client_info(cptr, info);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -2043,34 +2033,30 @@ static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
  * query next port
  */
 static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port = NULL;
-	struct snd_seq_port_info info;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-	cptr = snd_seq_client_use_ptr(info.addr.client);
+	cptr = snd_seq_client_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
 	/* search for next port */
-	info.addr.port++;
-	port = snd_seq_port_query_nearest(cptr, &info);
+	info->addr.port++;
+	port = snd_seq_port_query_nearest(cptr, info);
 	if (port == NULL) {
 		snd_seq_client_unlock(cptr);
 		return -ENOENT;
 	}
 
 	/* get port info */
-	info.addr = port->addr;
-	snd_seq_get_port_info(port, &info);
+	info->addr = port->addr;
+	snd_seq_get_port_info(port, info);
 	snd_seq_port_unlock(port);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
-- 
2.7.4
