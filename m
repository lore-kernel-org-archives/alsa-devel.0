From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/27] ALSA: seq: optimize client_id function
	to new design
Date: Mon,  8 Aug 2016 23:54:35 +0900
Message-ID: <1470668093-31027-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DE011267174
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:01 +0200 (CEST)
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
 sound/core/seq/seq_clientmgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 439e2df6..9cf5a82 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1122,9 +1122,12 @@ static int seq_ioctl_pversion(struct snd_seq_client *client, void *arg)
 	return 0;
 }
 
-static int seq_ioctl_client_id(struct snd_seq_client *client, void __user *arg)
+static int seq_ioctl_client_id(struct snd_seq_client *client, void *arg)
 {
-	return put_user(client->number, (int __user *)arg) ? -EFAULT : 0;
+	int *number = arg;
+
+	*number = client->number;
+	return 0;
 }
 
 /* SYSTEM_INFO ioctl() */
-- 
2.7.4
