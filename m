From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/27] ALSA: seq: fulfill callback entry for
	ioctl
Date: Mon,  8 Aug 2016 23:54:28 +0900
Message-ID: <1470668093-31027-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6C636266E3B
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

Most of callback functions corresponding to each ioctl command are in local
table, while two of them are not. This is a bit worse to handle the command
in a consistent way.

This commit adds entries for these two functions in the table.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 42be1e5..78fd64e 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1129,6 +1129,16 @@ static unsigned int snd_seq_poll(struct file *file, poll_table * wait)
 /*-----------------------------------------------------*/
 
 
+static int seq_ioctl_pversion(struct snd_seq_client *client, void __user *arg)
+{
+	return put_user(SNDRV_SEQ_VERSION, (int __user *)arg) ? -EFAULT : 0;
+}
+
+static int seq_ioctl_client_id(struct snd_seq_client *client, void __user *arg)
+{
+	return put_user(client->number, (int __user *)arg) ? -EFAULT : 0;
+}
+
 /* SYSTEM_INFO ioctl() */
 static int snd_seq_ioctl_system_info(struct snd_seq_client *client, void __user *arg)
 {
@@ -2172,6 +2182,8 @@ static const struct seq_ioctl_table {
 	unsigned int cmd;
 	int (*func)(struct snd_seq_client *client, void __user * arg);
 } ioctl_tables[] = {
+	{ SNDRV_SEQ_IOCTL_PVERSION, seq_ioctl_pversion },
+	{ SNDRV_SEQ_IOCTL_CLIENT_ID, seq_ioctl_client_id },
 	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, snd_seq_ioctl_system_info },
 	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, snd_seq_ioctl_running_mode },
 	{ SNDRV_SEQ_IOCTL_GET_CLIENT_INFO, snd_seq_ioctl_get_client_info },
@@ -2209,15 +2221,6 @@ static int snd_seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
 {
 	const struct seq_ioctl_table *p;
 
-	switch (cmd) {
-	case SNDRV_SEQ_IOCTL_PVERSION:
-		/* return sequencer version number */
-		return put_user(SNDRV_SEQ_VERSION, (int __user *)arg) ? -EFAULT : 0;
-	case SNDRV_SEQ_IOCTL_CLIENT_ID:
-		/* return the id of this client */
-		return put_user(client->number, (int __user *)arg) ? -EFAULT : 0;
-	}
-
 	if (! arg)
 		return -EFAULT;
 	for (p = ioctl_tables; p->cmd; p++) {
-- 
2.7.4
