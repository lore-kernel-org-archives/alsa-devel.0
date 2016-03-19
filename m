From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: timer: fix ioctl compatibility for
	different data models
Date: Sat, 19 Mar 2016 22:58:21 +0900
Message-ID: <1458395901-2223-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1458395901-2223-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DCBC6261507
 for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2016 14:58:30 +0100 (CET)
In-Reply-To: <1458395901-2223-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'struct snd_timer_gparams' includes some members with 'unsigned long',
therefore its size differs depending on data models (ILP32/LP64). As a
result, x86/x32 applications fail to execute ioctl(2) with
SNDRV_TIMER_GPARAMS on x86_64 machine.

This commit fixes this bug by adding a pair of structure and ioctl
command for the compatibility.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/timer_compat.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 2e90822..5809387 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -22,6 +22,18 @@
 
 #include <linux/compat.h>
 
+/*
+ * In LP64, 64 bit storage alignment is used, therefore the size of this
+ * structure is expanded to multiple of 8. But the size should be aligned to
+ * multiple of 4 for ILP32. This is a reason to use 'packed' attribute.
+ */
+struct snd_timer_gparams32 {
+	struct snd_timer_id tid;
+	u32 period_num;
+	u32 period_den;
+	unsigned char reserved[32];
+}__attribute__((packed));
+
 struct snd_timer_info32 {
 	u32 flags;
 	s32 card;
@@ -32,6 +44,19 @@ struct snd_timer_info32 {
 	unsigned char reserved[64];
 };
 
+static int snd_timer_user_gparams_compat(struct file *file,
+					struct snd_timer_gparams32 __user *user)
+{
+	struct snd_timer_gparams gparams;
+
+	if (copy_from_user(&gparams, user,
+		sizeof(struct snd_timer_id) + sizeof(u32) + sizeof(u32)))
+		return -EFAULT;
+
+	return snd_timer_user_gparams(file,
+				(struct snd_timer_gparams __user *)&gparams);
+}
+
 static int snd_timer_user_info_compat(struct file *file,
 				      struct snd_timer_info32 __user *_info)
 {
@@ -99,6 +124,7 @@ static int snd_timer_user_status_compat(struct file *file,
  */
 
 enum {
+	SNDRV_TIMER_IOCTL_GPARAMS32 = _IOR('T', 0x04, struct snd_timer_gparams32),
 	SNDRV_TIMER_IOCTL_INFO32 = _IOR('T', 0x11, struct snd_timer_info32),
 	SNDRV_TIMER_IOCTL_STATUS32 = _IOW('T', 0x14, struct snd_timer_status32),
 #ifdef CONFIG_X86_X32
@@ -114,7 +140,6 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
 	case SNDRV_TIMER_IOCTL_PVERSION:
 	case SNDRV_TIMER_IOCTL_TREAD:
 	case SNDRV_TIMER_IOCTL_GINFO:
-	case SNDRV_TIMER_IOCTL_GPARAMS:
 	case SNDRV_TIMER_IOCTL_GSTATUS:
 	case SNDRV_TIMER_IOCTL_SELECT:
 	case SNDRV_TIMER_IOCTL_PARAMS:
@@ -128,6 +153,8 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
 	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
 		return snd_timer_user_ioctl(file, cmd, (unsigned long)argp);
+	case SNDRV_TIMER_IOCTL_GPARAMS32:
+		return snd_timer_user_gparams_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_INFO32:
 		return snd_timer_user_info_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_STATUS32:
-- 
2.7.3
