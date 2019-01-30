From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/2] ALSA: pcm: implement the ioctl/mmap filter
	for the anonymous dup
Date: Wed, 30 Jan 2019 09:47:33 +0100
Message-ID: <20190130084733.979-3-perex@perex.cz>
References: <20190130084733.979-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 89D18267950
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 09:48:19 +0100 (CET)
In-Reply-To: <20190130084733.979-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Create seven control bits to allow the various restrictions for the
anonymous file descriptor.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 include/sound/pcm.h         |  1 +
 include/uapi/sound/asound.h |  9 +++++
 sound/core/pcm_native.c     | 85 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b79ffaa0241d..e0469b2c1115 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -227,6 +227,7 @@ struct snd_pcm_ops {
 struct snd_pcm_file {
 	struct snd_pcm_substream *substream;
 	int no_compat_mmap;
+	unsigned int perm;		/* file descriptor permissions */
 	unsigned int user_pversion;	/* supported protocol version */
 };
 
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ebc17d5a3490..8d99aa8916f0 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -571,6 +571,15 @@ enum {
 #define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)
 #define SNDRV_CHMAP_DRIVER_SPEC		(0x02 << 16)
 
+#define SNDRV_PCM_PERM_MMAP		(1<<0)
+#define SNDRV_PCM_PERM_MMAP_STATUS	(1<<1)
+#define SNDRV_PCM_PERM_MMAP_CONTROL	(1<<2)
+#define SNDRV_PCM_PERM_RW		(1<<3)
+#define SNDRV_PCM_PERM_CONTROL		(1<<4)
+#define SNDRV_PCM_PERM_STATUS		(1<<5)
+#define SNDRV_PCM_PERM_SYNC		(1<<6)
+#define SNDRV_PCM_PERM_MASK		((SNDRV_PCM_PERM_SYNC<<1)-1)
+
 #define SNDRV_PCM_IOCTL_PVERSION	_IOR('A', 0x00, int)
 #define SNDRV_PCM_IOCTL_INFO		_IOR('A', 0x01, struct snd_pcm_info)
 #define SNDRV_PCM_IOCTL_TSTAMP		_IOW('A', 0x02, int)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8874a685f1e8..0fceed62b839 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2502,6 +2502,7 @@ static int snd_pcm_open_file(struct file *file,
 		return -ENOMEM;
 	}
 	pcm_file->substream = substream;
+	pcm_file->perm = ~0;
 	if (substream->ref_count == 1)
 		substream->pcm_release = pcm_release_private;
 	file->private_data = pcm_file;
@@ -2897,10 +2898,11 @@ static int snd_pcm_anonymous_dup(struct file *file,
 	int flags;
 	struct file *nfile;
 	struct snd_pcm *pcm = substream->pcm;
+	struct snd_pcm_file *pcm_file;
 
 	if (get_user(perm, (int __user *)arg))
 		return -EFAULT;
-	if (perm < 0)
+	if (perm & ~SNDRV_PCM_PERM_MASK)
 		return -EPERM;
 	flags = file->f_flags & (O_ACCMODE | O_NONBLOCK);
 	flags |= O_APPEND | O_CLOEXEC;
@@ -2925,6 +2927,8 @@ static int snd_pcm_anonymous_dup(struct file *file,
 	err = snd_pcm_open_file(nfile, substream->pcm,
 				substream->stream, substream->number);
 	if (err >= 0) {
+		pcm_file = nfile->private_data;
+		pcm_file->perm = perm;
 		put_user(fd, (int __user *)arg);
 		return 0;
 	}
@@ -2936,6 +2940,73 @@ static int snd_pcm_anonymous_dup(struct file *file,
 	return err;
 }
 
+static int snd_pcm_ioctl_check_perm(struct snd_pcm_file *pcm_file,
+				    unsigned int cmd)
+{
+	if (pcm_file->perm == ~0)
+		return 1;
+	/*
+	 * the setup, linking and anonymous dup is not allowed
+	 * for the restricted file descriptors
+	 */
+	switch (cmd) {
+	case SNDRV_PCM_IOCTL_PVERSION:
+	case SNDRV_PCM_IOCTL_INFO:
+	case SNDRV_PCM_IOCTL_USER_PVERSION:
+	case SNDRV_PCM_IOCTL_CHANNEL_INFO:
+		return 1;
+	}
+	if (pcm_file->perm & SNDRV_PCM_PERM_CONTROL) {
+		switch (cmd) {
+		case SNDRV_PCM_IOCTL_PREPARE:
+		case SNDRV_PCM_IOCTL_RESET:
+		case SNDRV_PCM_IOCTL_START:
+		case SNDRV_PCM_IOCTL_XRUN:
+		case SNDRV_PCM_IOCTL_RESUME:
+		case SNDRV_PCM_IOCTL_DRAIN:
+		case SNDRV_PCM_IOCTL_DROP:
+		case SNDRV_PCM_IOCTL_PAUSE:
+			return 1;
+		default:
+			break;
+		}
+	}
+	if (pcm_file->perm & SNDRV_PCM_PERM_STATUS) {
+		switch (cmd) {
+		case SNDRV_PCM_IOCTL_STATUS:
+		case SNDRV_PCM_IOCTL_STATUS_EXT:
+		case SNDRV_PCM_IOCTL_DELAY:
+			return 1;
+		default:
+			break;
+		}
+	}
+	if (pcm_file->perm & SNDRV_PCM_PERM_SYNC) {
+		switch (cmd) {
+		case SNDRV_PCM_IOCTL_HWSYNC:
+		case SNDRV_PCM_IOCTL_SYNC_PTR:
+		case SNDRV_PCM_IOCTL_REWIND:
+		case SNDRV_PCM_IOCTL_FORWARD:
+			return 1;
+		default:
+			break;
+		}
+	}
+	if (pcm_file->perm & SNDRV_PCM_PERM_RW) {
+		switch (cmd) {
+		case SNDRV_PCM_IOCTL_WRITEI_FRAMES:
+		case SNDRV_PCM_IOCTL_READI_FRAMES:
+		case SNDRV_PCM_IOCTL_WRITEN_FRAMES:
+		case SNDRV_PCM_IOCTL_READN_FRAMES:
+			return 1;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int snd_pcm_common_ioctl(struct file *file,
 				 struct snd_pcm_substream *substream,
 				 unsigned int cmd, void __user *arg)
@@ -2950,6 +3021,9 @@ static int snd_pcm_common_ioctl(struct file *file,
 	if (res < 0)
 		return res;
 
+	if (!snd_pcm_ioctl_check_perm(pcm_file, cmd))
+		return -EPERM;
+
 	switch (cmd) {
 	case SNDRV_PCM_IOCTL_PVERSION:
 		return put_user(SNDRV_PCM_VERSION, (int __user *)arg) ? -EFAULT : 0;
@@ -3298,6 +3372,9 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 			       struct vm_area_struct *area)
 {
 	long size;
+	struct snd_pcm_file *pcm_file = file->private_data;
+	if (!(pcm_file->perm & SNDRV_PCM_PERM_MMAP_STATUS))
+		return -EPERM;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3334,6 +3411,9 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 				struct vm_area_struct *area)
 {
 	long size;
+	struct snd_pcm_file *pcm_file = file->private_data;
+	if (!(pcm_file->perm & SNDRV_PCM_PERM_MMAP_CONTROL))
+		return -EPERM;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3508,11 +3588,14 @@ int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file,
 		      struct vm_area_struct *area)
 {
 	struct snd_pcm_runtime *runtime;
+	struct snd_pcm_file *pcm_file = file->private_data;
 	long size;
 	unsigned long offset;
 	size_t dma_bytes;
 	int err;
 
+	if (!(pcm_file->perm & SNDRV_PCM_PERM_MMAP))
+		return -EPERM;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (!(area->vm_flags & (VM_WRITE|VM_READ)))
 			return -EINVAL;
-- 
2.13.6
