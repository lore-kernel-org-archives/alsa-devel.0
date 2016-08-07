From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/39] ALSA: seq: optimize pversion function to
	new design
Date: Sun,  7 Aug 2016 18:48:45 +0900
Message-ID: <1470563355-18368-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 25E3D265B4C
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
 sound/core/seq/seq_clientmgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index a643b4e..5e81d4f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1114,9 +1114,12 @@ static unsigned int snd_seq_poll(struct file *file, poll_table * wait)
 /*-----------------------------------------------------*/
 
 
-static int seq_ioctl_pversion(struct snd_seq_client *client, void __user *arg)
+static int seq_ioctl_pversion(struct snd_seq_client *client, void *arg)
 {
-	return put_user(SNDRV_SEQ_VERSION, (int __user *)arg) ? -EFAULT : 0;
+	int *version = arg;
+
+	*version = SNDRV_SEQ_VERSION;
+	return 0;
 }
 
 static int seq_ioctl_client_id(struct snd_seq_client *client, void __user *arg)
-- 
2.7.4
