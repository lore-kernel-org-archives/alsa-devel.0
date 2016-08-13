From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v4 4/4] ALSA: seq: obsolete change of address
	limit
Date: Sat, 13 Aug 2016 10:13:36 +0900
Message-ID: <1471050816-26416-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1471050816-26416-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 7C3A0266011
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 03:13:44 +0200 (CEST)
In-Reply-To: <1471050816-26416-1-git-send-email-o-takashi@sakamocchi.jp>
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

Former commits change existent functions so that they don't handle data in
kernel space. Copying from/to userspace is done outside of the functions,
thus no need to change address limit of running task.

This commit obsoletes get_fs()/set_fs() and applies corresponding changes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 73 +++---------------------------------------
 sound/core/seq/seq_compat.c    | 12 ++-----
 2 files changed, 7 insertions(+), 78 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index e07a539..286394b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -87,21 +87,6 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
 
 /*
  */
- 
-static inline mm_segment_t snd_enter_user(void)
-{
-	mm_segment_t fs = get_fs();
-	set_fs(get_ds());
-	return fs;
-}
-
-static inline void snd_leave_user(mm_segment_t fs)
-{
-	set_fs(fs);
-}
-
-/*
- */
 static inline unsigned short snd_seq_file_flags(struct file *file)
 {
         switch (file->f_mode & (FMODE_READ | FMODE_WRITE)) {
@@ -2094,14 +2079,8 @@ static const struct ioctl_handler {
 	{ 0, NULL },
 };
 
-static struct seq_ioctl_table {
-	unsigned int cmd;
-	int (*func)(struct snd_seq_client *client, void __user * arg);
-} ioctl_tables[] = {
-	{ 0, NULL },
-};
-
-static long seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long snd_seq_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
 	/* To use kernel stack for ioctl data. */
@@ -2158,45 +2137,6 @@ static long seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-static int snd_seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
-			    void __user *arg)
-{
-	struct seq_ioctl_table *p;
-
-	switch (cmd) {
-	case SNDRV_SEQ_IOCTL_PVERSION:
-		/* return sequencer version number */
-		return put_user(SNDRV_SEQ_VERSION, (int __user *)arg) ? -EFAULT : 0;
-	case SNDRV_SEQ_IOCTL_CLIENT_ID:
-		/* return the id of this client */
-		return put_user(client->number, (int __user *)arg) ? -EFAULT : 0;
-	}
-
-	if (! arg)
-		return -EFAULT;
-	for (p = ioctl_tables; p->cmd; p++) {
-		if (p->cmd == cmd)
-			return p->func(client, arg);
-	}
-	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
-		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
-	return -ENOTTY;
-}
-
-
-static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct snd_seq_client *client = file->private_data;
-
-	if (seq_ioctl(file, cmd, arg) >= 0)
-		return 0;
-
-	if (snd_BUG_ON(!client))
-		return -ENXIO;
-
-	return snd_seq_do_ioctl(client, cmd, (void __user *) arg);
-}
-
 #ifdef CONFIG_COMPAT
 #include "seq_compat.c"
 #else
@@ -2396,8 +2336,6 @@ int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 {
 	const struct ioctl_handler *handler;
 	struct snd_seq_client *client;
-	mm_segment_t fs;
-	int result;
 
 	client = clientptr(clientid);
 	if (client == NULL)
@@ -2408,10 +2346,9 @@ int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 			return handler->func(client, arg);
 	}
 
-	fs = snd_enter_user();
-	result = snd_seq_do_ioctl(client, cmd, (void __force __user *)arg);
-	snd_leave_user(fs);
-	return result;
+	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
+		 cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
+	return -ENOTTY;
 }
 
 EXPORT_SYMBOL(snd_seq_kernel_client_ctl);
diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 4cfc505..fce5697 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -47,7 +47,6 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 {
 	int err = -EFAULT;
 	struct snd_seq_port_info *data;
-	mm_segment_t fs;
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -59,12 +58,7 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 		goto error;
 	data->kernel = NULL;
 
-	if (snd_seq_kernel_client_ctl(client->number, cmd, &data) >= 0)
-		return 0;
-
-	fs = snd_enter_user();
-	err = snd_seq_do_ioctl(client, cmd, data);
-	snd_leave_user(fs);
+	err = snd_seq_kernel_client_ctl(client->number, cmd, &data);
 	if (err < 0)
 		goto error;
 
@@ -126,9 +120,7 @@ static long snd_seq_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_SEQ_IOCTL_GET_SUBSCRIPTION:
 	case SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT:
 	case SNDRV_SEQ_IOCTL_RUNNING_MODE:
-		if (seq_ioctl(file, cmd, arg) >= 0)
-			return 0;
-		return snd_seq_do_ioctl(client, cmd, argp);
+		return snd_seq_ioctl(file, cmd, arg);
 	case SNDRV_SEQ_IOCTL_CREATE_PORT32:
 		return snd_seq_call_port_info_ioctl(client, SNDRV_SEQ_IOCTL_CREATE_PORT, argp);
 	case SNDRV_SEQ_IOCTL_DELETE_PORT32:
-- 
2.7.4
