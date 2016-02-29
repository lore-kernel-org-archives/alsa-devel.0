From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 6/6] ALSA: timer: Fix ioctls for X32 ABI
Date: Mon, 29 Feb 2016 17:16:45 +0100
Message-ID: <1456762605-2451-7-git-send-email-tiwai@suse.de>
References: <1456762605-2451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9140E261A73
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:16:50 +0100 (CET)
In-Reply-To: <1456762605-2451-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

X32 ABI takes the 64bit timespec, thus the timer user status ioctl becomes
incompatible with IA32.  This results in NOTTY error when the ioctl is
issued.

Meanwhile, this struct in X32 is essentially identical with the one in
X86-64, so we can just bypassing to the existing code for this
specific compat ioctl.

Cc: <stable@vger.kernel.org> # v3.4+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer_compat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 8e7eddf35c6a..2e908225d754 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -89,12 +89,21 @@ static int snd_timer_user_status_compat(struct file *file,
 	return 0;
 }
 
+#ifdef CONFIG_X86_X32
+/* X32 ABI has the same struct as x86-64 */
+#define snd_timer_user_status_x32(file, s) \
+	snd_timer_user_status(file, s)
+#endif /* CONFIG_X86_X32 */
+
 /*
  */
 
 enum {
 	SNDRV_TIMER_IOCTL_INFO32 = _IOR('T', 0x11, struct snd_timer_info32),
 	SNDRV_TIMER_IOCTL_STATUS32 = _IOW('T', 0x14, struct snd_timer_status32),
+#ifdef CONFIG_X86_X32
+	SNDRV_TIMER_IOCTL_STATUS_X32 = _IOW('T', 0x14, struct snd_timer_status),
+#endif /* CONFIG_X86_X32 */
 };
 
 static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -123,6 +132,10 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
 		return snd_timer_user_info_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_STATUS32:
 		return snd_timer_user_status_compat(file, argp);
+#ifdef CONFIG_X86_X32
+	case SNDRV_TIMER_IOCTL_STATUS_X32:
+		return snd_timer_user_status_x32(file, argp);
+#endif /* CONFIG_X86_X32 */
 	}
 	return -ENOIOCTLCMD;
 }
-- 
2.7.2
