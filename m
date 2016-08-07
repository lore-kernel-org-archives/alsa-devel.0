From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/39] ALSA: seq: obsolete change of address
	limit in in-kernel path for ioctl
Date: Sun,  7 Aug 2016 18:48:43 +0900
Message-ID: <1470563355-18368-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D274A2658D9
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:37 +0200 (CEST)
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

In former commit, actual operations for each ioctl is re-designed to get
data in kernel space. Therefore, no need to cast pointer in kernel space
to user space.

This commit applies optimization to in-kernel path of ioctl.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index a09cb84..2002dac 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2248,23 +2248,6 @@ static const struct seq_ioctl_table {
 	{ 0, NULL, 0 },
 };
 
-static int seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
-			    void __user *arg)
-{
-	const struct seq_ioctl_table *p;
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
 static long snd_seq_ioctl(struct file *file, unsigned int cmd,
 			  unsigned long arg)
 {
@@ -2509,16 +2492,23 @@ EXPORT_SYMBOL(snd_seq_kernel_client_dispatch);
 int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 {
 	struct snd_seq_client *client;
-	mm_segment_t fs;
-	int result;
+	const struct seq_ioctl_table *p;
 
 	client = clientptr(clientid);
 	if (client == NULL)
 		return -ENXIO;
-	fs = snd_enter_user();
-	result = seq_do_ioctl(client, cmd, (void __force __user *)arg);
-	snd_leave_user(fs);
-	return result;
+
+	for (p = ioctl_tables; p->cmd > 0; ++p) {
+		if (p->cmd == cmd)
+			break;
+	}
+	if (p->cmd == 0) {
+		pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
+			 cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
+		return -ENOTTY;
+	}
+
+	return p->func(client, arg);
 }
 
 EXPORT_SYMBOL(snd_seq_kernel_client_ctl);
-- 
2.7.4
