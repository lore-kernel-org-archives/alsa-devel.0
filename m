From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/27] ALSA: seq: copy ioctl data from user
	space to kernel stack
Date: Mon,  8 Aug 2016 23:54:29 +0900
Message-ID: <1470668093-31027-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6F31D26700C
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:00 +0200 (CEST)
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
 sound/core/seq/seq_clientmgr.c | 49 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 78fd64e..de1177f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2180,7 +2180,7 @@ static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
 
 static const struct seq_ioctl_table {
 	unsigned int cmd;
-	int (*func)(struct snd_seq_client *client, void __user * arg);
+	int (*func)(struct snd_seq_client *client, void *arg);
 } ioctl_tables[] = {
 	{ SNDRV_SEQ_IOCTL_PVERSION, seq_ioctl_pversion },
 	{ SNDRV_SEQ_IOCTL_CLIENT_ID, seq_ioctl_client_id },
@@ -2233,14 +2233,57 @@ static int snd_seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
 }
 
 
-static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long snd_seq_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
+	const struct seq_ioctl_table *p;
+	/* To use kernel stack for ioctl data. */
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
+	/*
+	 * All of ioctl commands for ALSA sequencer get an argument of size
+	 * within 13 bits. We can safely pick up the size from the command.
+	 * On the other hand, some commands includes a bug of 'read' or 'write',
+	 * thus we cannot utilize information from the access fields.
+	 */
+	if (copy_from_user(&buf, (const void __user *)arg, _IOC_SIZE(p->cmd)))
+		return -EFAULT;
 		
-	return snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	err = p->func(client, &buf);
+	if (err >= 0) {
+		if (copy_to_user((void __user *)arg, &buf, _IOC_SIZE(p->cmd)))
+			return -EFAULT;
+	}
+
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.7.4
