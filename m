From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 4/6] ALSA: rawmidi: Fix ioctls X32 ABI
Date: Mon, 29 Feb 2016 17:16:43 +0100
Message-ID: <1456762605-2451-5-git-send-email-tiwai@suse.de>
References: <1456762605-2451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 657C92607F7
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

Like the previous fixes for ctl and PCM, we need a fix for
incompatible X32 ABI regarding the rawmidi: namely, struct
snd_rawmidi_status has the timespec, and the size and the alignment on
X32 differ from IA32.

This patch fixes the incompatible ioctl for X32.

Cc: <stable@vger.kernel.org> # v3.4+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi_compat.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index 836d1c9fc2cc..f69764d7cdd7 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -93,9 +93,58 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
 	return 0;
 }
 
+#ifdef CONFIG_X86_X32
+/* X32 ABI has 64bit timespec and 64bit alignment */
+struct snd_rawmidi_status_x32 {
+	s32 stream;
+	u32 rsvd; /* alignment */
+	struct timespec tstamp;
+	u32 avail;
+	u32 xruns;
+	unsigned char reserved[16];
+} __attribute__((packed));
+
+#define put_timespec(src, dst) copy_to_user(dst, src, sizeof(*dst))
+
+static int snd_rawmidi_ioctl_status_x32(struct snd_rawmidi_file *rfile,
+					struct snd_rawmidi_status_x32 __user *src)
+{
+	int err;
+	struct snd_rawmidi_status status;
+
+	if (rfile->output == NULL)
+		return -EINVAL;
+	if (get_user(status.stream, &src->stream))
+		return -EFAULT;
+
+	switch (status.stream) {
+	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		err = snd_rawmidi_output_status(rfile->output, &status);
+		break;
+	case SNDRV_RAWMIDI_STREAM_INPUT:
+		err = snd_rawmidi_input_status(rfile->input, &status);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	if (put_timespec(&status.tstamp, &src->tstamp) ||
+	    put_user(status.avail, &src->avail) ||
+	    put_user(status.xruns, &src->xruns))
+		return -EFAULT;
+
+	return 0;
+}
+#endif /* CONFIG_X86_X32 */
+
 enum {
 	SNDRV_RAWMIDI_IOCTL_PARAMS32 = _IOWR('W', 0x10, struct snd_rawmidi_params32),
 	SNDRV_RAWMIDI_IOCTL_STATUS32 = _IOWR('W', 0x20, struct snd_rawmidi_status32),
+#ifdef CONFIG_X86_X32
+	SNDRV_RAWMIDI_IOCTL_STATUS_X32 = _IOWR('W', 0x20, struct snd_rawmidi_status_x32),
+#endif /* CONFIG_X86_X32 */
 };
 
 static long snd_rawmidi_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -114,6 +163,10 @@ static long snd_rawmidi_ioctl_compat(struct file *file, unsigned int cmd, unsign
 		return snd_rawmidi_ioctl_params_compat(rfile, argp);
 	case SNDRV_RAWMIDI_IOCTL_STATUS32:
 		return snd_rawmidi_ioctl_status_compat(rfile, argp);
+#ifdef CONFIG_X86_X32
+	case SNDRV_RAWMIDI_IOCTL_STATUS_X32:
+		return snd_rawmidi_ioctl_status_x32(rfile, argp);
+#endif /* CONFIG_X86_X32 */
 	}
 	return -ENOIOCTLCMD;
 }
-- 
2.7.2
