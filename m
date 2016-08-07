From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/39] ALSA: seq: copy ioctl data from user
	space to kernel stack
Date: Sun,  7 Aug 2016 18:48:40 +0900
Message-ID: <1470563355-18368-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 6E95926058F
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:36 +0200 (CEST)
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

ALSA sequencer core allows kernel-mode tasks to execute operations
corresponding to ioctls by user-mode tasks. This is for compatibility
layers such as ABIs for 32/64 bit and I/O operations via Open Sound
System.

This design requires to handle ioctl data in kernel space. For this
requirement, ALSA sequencer core temporarily changes address limit for the
task by get_fs()/set_fs() macro.

Although, this way get shape of code worse, because even when an pointer
has '__user' qualifier, actually it refers to kernel space, depending on
the task. This easily misleads readers.

This commit is a preparation for following patches to solve this issue.
Data from user space is once copied to kernel stack, then operated and
copied to user space, in a consistent manner. This manner forces all ioctl
operations to copy the data from/to user space, even if it's read-only or
write-only. Thus, it has an overhead for simpler ioctl commands.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 136 ++++++++++++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 35 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index d6c1219..17d988a 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2182,40 +2182,70 @@ static int seq_ioctl_query_next_port(struct snd_seq_client *client,
 
 static const struct seq_ioctl_table {
 	unsigned int cmd;
-	int (*func)(struct snd_seq_client *client, void __user * arg);
+	int (*func)(struct snd_seq_client *client, void *arg);
+	size_t arg_size;
 } ioctl_tables[] = {
-	{ SNDRV_SEQ_IOCTL_PVERSION, seq_ioctl_pversion },
-	{ SNDRV_SEQ_IOCTL_CLIENT_ID, seq_ioctl_client_id },
-	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, seq_ioctl_system_info },
-	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, seq_ioctl_running_mode },
-	{ SNDRV_SEQ_IOCTL_GET_CLIENT_INFO, seq_ioctl_get_client_info },
-	{ SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, seq_ioctl_set_client_info },
-	{ SNDRV_SEQ_IOCTL_CREATE_PORT, seq_ioctl_create_port },
-	{ SNDRV_SEQ_IOCTL_DELETE_PORT, seq_ioctl_delete_port },
-	{ SNDRV_SEQ_IOCTL_GET_PORT_INFO, seq_ioctl_get_port_info },
-	{ SNDRV_SEQ_IOCTL_SET_PORT_INFO, seq_ioctl_set_port_info },
-	{ SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT, seq_ioctl_subscribe_port },
-	{ SNDRV_SEQ_IOCTL_UNSUBSCRIBE_PORT, seq_ioctl_unsubscribe_port },
-	{ SNDRV_SEQ_IOCTL_CREATE_QUEUE, seq_ioctl_create_queue },
-	{ SNDRV_SEQ_IOCTL_DELETE_QUEUE, seq_ioctl_delete_queue },
-	{ SNDRV_SEQ_IOCTL_GET_QUEUE_INFO, seq_ioctl_get_queue_info },
-	{ SNDRV_SEQ_IOCTL_SET_QUEUE_INFO, seq_ioctl_set_queue_info },
-	{ SNDRV_SEQ_IOCTL_GET_NAMED_QUEUE, seq_ioctl_get_named_queue },
-	{ SNDRV_SEQ_IOCTL_GET_QUEUE_STATUS, seq_ioctl_get_queue_status },
-	{ SNDRV_SEQ_IOCTL_GET_QUEUE_TEMPO, seq_ioctl_get_queue_tempo },
-	{ SNDRV_SEQ_IOCTL_SET_QUEUE_TEMPO, seq_ioctl_set_queue_tempo },
-	{ SNDRV_SEQ_IOCTL_GET_QUEUE_TIMER, seq_ioctl_get_queue_timer },
-	{ SNDRV_SEQ_IOCTL_SET_QUEUE_TIMER, seq_ioctl_set_queue_timer },
-	{ SNDRV_SEQ_IOCTL_GET_QUEUE_CLIENT, seq_ioctl_get_queue_client },
-	{ SNDRV_SEQ_IOCTL_SET_QUEUE_CLIENT, seq_ioctl_set_queue_client },
-	{ SNDRV_SEQ_IOCTL_GET_CLIENT_POOL, seq_ioctl_get_client_pool },
-	{ SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, seq_ioctl_set_client_pool },
-	{ SNDRV_SEQ_IOCTL_GET_SUBSCRIPTION, seq_ioctl_get_subscription },
-	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT, seq_ioctl_query_next_client },
-	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT, seq_ioctl_query_next_port },
-	{ SNDRV_SEQ_IOCTL_REMOVE_EVENTS, seq_ioctl_remove_events },
-	{ SNDRV_SEQ_IOCTL_QUERY_SUBS, seq_ioctl_query_subs },
-	{ 0, NULL },
+	{ SNDRV_SEQ_IOCTL_PVERSION, seq_ioctl_pversion, sizeof(int) },
+	{ SNDRV_SEQ_IOCTL_CLIENT_ID, seq_ioctl_client_id, sizeof(int) },
+	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, seq_ioctl_system_info,
+	  sizeof(struct snd_seq_system_info) },
+	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, seq_ioctl_running_mode,
+	  sizeof(struct snd_seq_running_info) },
+	{ SNDRV_SEQ_IOCTL_GET_CLIENT_INFO, seq_ioctl_get_client_info,
+	  sizeof(struct snd_seq_client_info) },
+	{ SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, seq_ioctl_set_client_info,
+	  sizeof(struct snd_seq_client_info) },
+	{ SNDRV_SEQ_IOCTL_CREATE_PORT, seq_ioctl_create_port,
+	  sizeof(struct snd_seq_port_info) },
+	{ SNDRV_SEQ_IOCTL_DELETE_PORT, seq_ioctl_delete_port,
+	  sizeof(struct snd_seq_port_info) },
+	{ SNDRV_SEQ_IOCTL_GET_PORT_INFO, seq_ioctl_get_port_info,
+	  sizeof(struct snd_seq_port_info) },
+	{ SNDRV_SEQ_IOCTL_SET_PORT_INFO, seq_ioctl_set_port_info,
+	  sizeof(struct snd_seq_port_info) },
+	{ SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT, seq_ioctl_subscribe_port,
+	  sizeof(struct snd_seq_port_subscribe) },
+	{ SNDRV_SEQ_IOCTL_UNSUBSCRIBE_PORT, seq_ioctl_unsubscribe_port,
+	  sizeof(struct snd_seq_port_subscribe) },
+	{ SNDRV_SEQ_IOCTL_CREATE_QUEUE, seq_ioctl_create_queue,
+	  sizeof(struct snd_seq_queue_info) },
+	{ SNDRV_SEQ_IOCTL_DELETE_QUEUE, seq_ioctl_delete_queue,
+	  sizeof(struct snd_seq_queue_info) },
+	{ SNDRV_SEQ_IOCTL_GET_QUEUE_INFO, seq_ioctl_get_queue_info,
+	  sizeof(struct snd_seq_queue_info) },
+	{ SNDRV_SEQ_IOCTL_SET_QUEUE_INFO, seq_ioctl_set_queue_info,
+	  sizeof(struct snd_seq_queue_info) },
+	{ SNDRV_SEQ_IOCTL_GET_NAMED_QUEUE, seq_ioctl_get_named_queue,
+	  sizeof(struct snd_seq_queue_info) },
+	{ SNDRV_SEQ_IOCTL_GET_QUEUE_STATUS, seq_ioctl_get_queue_status,
+	  sizeof(struct snd_seq_queue_status) },
+	{ SNDRV_SEQ_IOCTL_GET_QUEUE_TEMPO, seq_ioctl_get_queue_tempo,
+	  sizeof(struct snd_seq_queue_tempo) },
+	{ SNDRV_SEQ_IOCTL_SET_QUEUE_TEMPO, seq_ioctl_set_queue_tempo,
+	  sizeof(struct snd_seq_queue_tempo) },
+	{ SNDRV_SEQ_IOCTL_GET_QUEUE_TIMER, seq_ioctl_get_queue_timer,
+	  sizeof(struct snd_seq_queue_timer) },
+	{ SNDRV_SEQ_IOCTL_SET_QUEUE_TIMER, seq_ioctl_set_queue_timer,
+	  sizeof(struct snd_seq_queue_timer) },
+	{ SNDRV_SEQ_IOCTL_GET_QUEUE_CLIENT, seq_ioctl_get_queue_client,
+	  sizeof(struct snd_seq_queue_client) },
+	{ SNDRV_SEQ_IOCTL_SET_QUEUE_CLIENT, seq_ioctl_set_queue_client,
+	  sizeof(struct snd_seq_queue_client) },
+	{ SNDRV_SEQ_IOCTL_GET_CLIENT_POOL, seq_ioctl_get_client_pool,
+	  sizeof(struct snd_seq_client_pool) },
+	{ SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, seq_ioctl_set_client_pool,
+	  sizeof(struct snd_seq_client_pool) },
+	{ SNDRV_SEQ_IOCTL_GET_SUBSCRIPTION, seq_ioctl_get_subscription,
+	  sizeof(struct snd_seq_port_subscribe) },
+	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT, seq_ioctl_query_next_client,
+	  sizeof(struct snd_seq_client_info) },
+	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT, seq_ioctl_query_next_port,
+	  sizeof(struct snd_seq_port_info) },
+	{ SNDRV_SEQ_IOCTL_REMOVE_EVENTS, seq_ioctl_remove_events,
+	  sizeof(struct snd_seq_remove_events) },
+	{ SNDRV_SEQ_IOCTL_QUERY_SUBS, seq_ioctl_query_subs,
+	  sizeof(struct snd_seq_query_subs) },
+	{ 0, NULL, 0 },
 };
 
 static int seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
@@ -2235,14 +2265,50 @@ static int seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
 }
 
 
-static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long snd_seq_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
+	const struct seq_ioctl_table *p;
+	union ioctl_arg {
+		int pversion;
+		int client_id;
+		struct snd_seq_system_info	system_info;
+		struct snd_seq_running_info	running_info;
+		struct snd_seq_client_info	client_info;
+		struct snd_seq_port_info	port_info;
+		struct snd_seq_port_subscribe	port_subscribe;
+		struct snd_seq_queue_info	queue_info;
+		struct snd_seq_queue_status	queue_status;
+		struct snd_seq_queue_tempo	tempo;
+		struct snd_seq_queue_timer	queue_timer;
+		struct snd_seq_queue_client	queue_client;
+		struct snd_seq_client_pool	client_pool;
+		struct snd_seq_remove_events	remove_events;
+		struct snd_seq_query_subs	query_subs;
+	} buf = {0};
+	int err;
 
 	if (snd_BUG_ON(!client))
 		return -ENXIO;
+
+	for (p = ioctl_tables; p->cmd > 0; ++p) {
+		if (p->cmd == cmd)
+			break;
+	}
+	if (p->cmd == 0)
+		return -ENOTTY;
+
+	if (copy_from_user(&buf, (const void __user *)arg, p->arg_size))
+		return -EFAULT;
 		
-	return seq_do_ioctl(client, cmd, (void __user *) arg);
+	err = p->func(client, &buf);
+	if (err >= 0) {
+		if (copy_to_user((void __user *)arg, &buf, p->arg_size))
+			return -EFAULT;
+	}
+
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.7.4
