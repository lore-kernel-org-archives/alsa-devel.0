From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/27] ALSA: seq: optimize running mode
	function to new design
Date: Mon,  8 Aug 2016 23:54:37 +0900
Message-ID: <1470668093-31027-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DCBEF26714E
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
 sound/core/seq/seq_clientmgr.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 624d001..59de125 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1149,37 +1149,34 @@ static int snd_seq_ioctl_system_info(struct snd_seq_client *client, void *arg)
 
 
 /* RUNNING_MODE ioctl() */
-static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void __user *arg)
+static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_running_info info;
+	struct snd_seq_running_info *info = arg;
 	struct snd_seq_client *cptr;
 	int err = 0;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(info.client);
+	cptr = snd_seq_client_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
 #ifdef SNDRV_BIG_ENDIAN
-	if (! info.big_endian) {
+	if (!info->big_endian) {
 		err = -EINVAL;
 		goto __err;
 	}
 #else
-	if (info.big_endian) {
+	if (info->big_endian) {
 		err = -EINVAL;
 		goto __err;
 	}
 
 #endif
-	if (info.cpu_mode > sizeof(long)) {
+	if (info->cpu_mode > sizeof(long)) {
 		err = -EINVAL;
 		goto __err;
 	}
-	cptr->convert32 = (info.cpu_mode < sizeof(long));
+	cptr->convert32 = (info->cpu_mode < sizeof(long));
  __err:
 	snd_seq_client_unlock(cptr);
 	return err;
-- 
2.7.4
