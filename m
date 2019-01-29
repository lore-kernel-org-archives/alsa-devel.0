From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 1/3] ALSA: pcm: implement the anonymous dup
	(inode file descriptor)
Date: Tue, 29 Jan 2019 18:59:07 +0100
Message-ID: <20190129175909.17423-2-perex@perex.cz>
References: <20190129175909.17423-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E6722674A3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 18:59:46 +0100 (CET)
In-Reply-To: <20190129175909.17423-1-perex@perex.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch implements new SNDRV_PCM_IOCTL_ANONYMOUS_DUP ioctl which
returns the new duplicated anonymous inode file descriptor
(anon_inode:snd-pcm) which can be passed to the restricted clients.

This patch is meant to be the alternative for the dma-buf interface. Both
implementation have some pros and cons:

anon_inode:dmabuf

- a bit standard export API for the DMA buffers
- fencing for the concurrent access [1]
- driver/kernel interface for the DMA buffer [1]
- multiple attach/detach scheme [1]

[1] the real usage for the sound PCM is unknown at the moment for this feature

anon_inode:snd-pcm

- simple (no problem with ref-counting, non-standard mmap implementation etc.)
- allow to use more sound interfaces for the file descriptor like status ioctls
- more fine grained security policies (another anon_inode name unshared with
  other drivers)
---
 include/sound/pcm.h         |  8 +++---
 include/uapi/sound/asound.h |  3 +-
 sound/core/oss/pcm_oss.c    |  2 +-
 sound/core/pcm.c            | 48 ++++++++++++++++++++------------
 sound/core/pcm_compat.c     |  1 +
 sound/core/pcm_native.c     | 67 +++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 101 insertions(+), 28 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2c30c1ad1b0d..e7deb03b6702 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -590,11 +590,11 @@ static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)
 }
 #endif
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
-int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
-			   struct snd_pcm_substream **rsubstream);
+int snd_pcm_open_substream(struct snd_pcm *pcm, struct snd_pcm_substream *clone,
+			   int stream, struct file *file, struct snd_pcm_substream **rsubstream);
 void snd_pcm_release_substream(struct snd_pcm_substream *substream);
-int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream, struct file *file,
-			     struct snd_pcm_substream **rsubstream);
+int snd_pcm_attach_substream(struct snd_pcm *pcm, struct snd_pcm_substream *clone, int stream,
+			     struct file *file, struct snd_pcm_substream **rsubstream);
 void snd_pcm_detach_substream(struct snd_pcm_substream *substream);
 int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file, struct vm_area_struct *area);
 
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 404d4b9ffe76..ebc17d5a3490 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -153,7 +153,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 15)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -576,6 +576,7 @@ enum {
 #define SNDRV_PCM_IOCTL_TSTAMP		_IOW('A', 0x02, int)
 #define SNDRV_PCM_IOCTL_TTSTAMP		_IOW('A', 0x03, int)
 #define SNDRV_PCM_IOCTL_USER_PVERSION	_IOW('A', 0x04, int)
+#define SNDRV_PCM_IOCTL_ANONYMOUS_DUP   _IOWR('A', 0x05, int)
 #define SNDRV_PCM_IOCTL_HW_REFINE	_IOWR('A', 0x10, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_PARAMS	_IOWR('A', 0x11, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_FREE		_IO('A', 0x12)
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 467039b342b5..b3738c228f39 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2420,7 +2420,7 @@ static int snd_pcm_oss_open_file(struct file *file,
 			if (! (f_mode & FMODE_READ))
 				continue;
 		}
-		err = snd_pcm_open_substream(pcm, idx, file, &substream);
+		err = snd_pcm_open_substream(pcm, NULL, idx, file, &substream);
 		if (err < 0) {
 			snd_pcm_oss_release_file(pcm_oss_file);
 			return err;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index ca1ea3cf9350..6461dafdc5fb 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -964,15 +964,16 @@ static int snd_pcm_dev_free(struct snd_device *device)
 	return snd_pcm_free(pcm);
 }
 
-int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
-			     struct file *file,
+int snd_pcm_attach_substream(struct snd_pcm *pcm,
+			     struct snd_pcm_substream *clone,
+			     int stream, struct file *file,
 			     struct snd_pcm_substream **rsubstream)
 {
 	struct snd_pcm_str * pstr;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
 	struct snd_card *card;
-	int prefer_subdevice;
+	int prefer_subdevice = -1;
 	size_t size;
 
 	if (snd_BUG_ON(!pcm || !rsubstream))
@@ -986,7 +987,9 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 		return -ENODEV;
 
 	card = pcm->card;
-	prefer_subdevice = snd_ctl_get_preferred_subdevice(card, SND_CTL_SUBDEV_PCM);
+	if (!clone)
+		prefer_subdevice =
+			snd_ctl_get_preferred_subdevice(card, SND_CTL_SUBDEV_PCM);
 
 	if (pcm->info_flags & SNDRV_PCM_INFO_HALF_DUPLEX) {
 		int opposite = !stream;
@@ -999,15 +1002,19 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	}
 
 	if (file->f_flags & O_APPEND) {
-		if (prefer_subdevice < 0) {
-			if (pstr->substream_count > 1)
-				return -EINVAL; /* must be unique */
-			substream = pstr->substream;
+		if (clone) {
+			substream = clone;
 		} else {
-			for (substream = pstr->substream; substream;
-			     substream = substream->next)
-				if (substream->number == prefer_subdevice)
-					break;
+			if (prefer_subdevice < 0) {
+				if (pstr->substream_count > 1)
+					return -EINVAL; /* must be unique */
+				substream = pstr->substream;
+			} else {
+				for (substream = pstr->substream; substream;
+				     substream = substream->next)
+					if (substream->number == prefer_subdevice)
+						break;
+			}
 		}
 		if (! substream)
 			return -ENODEV;
@@ -1018,11 +1025,18 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 		return 0;
 	}
 
-	for (substream = pstr->substream; substream; substream = substream->next) {
-		if (!SUBSTREAM_BUSY(substream) &&
-		    (prefer_subdevice == -1 ||
-		     substream->number == prefer_subdevice))
-			break;
+	if (clone) {
+		substream = clone;
+		if (SUBSTREAM_BUSY(substream))
+			return -EAGAIN;
+	} else {
+		for (substream = pstr->substream; substream;
+		     substream = substream->next) {
+			if (!SUBSTREAM_BUSY(substream) &&
+			    (prefer_subdevice == -1 ||
+			     substream->number == prefer_subdevice))
+				break;
+		}
 	}
 	if (substream == NULL)
 		return -EAGAIN;
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 946ab080ac00..22446cd574ee 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -675,6 +675,7 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_PCM_IOCTL_TSTAMP:
 	case SNDRV_PCM_IOCTL_TTSTAMP:
 	case SNDRV_PCM_IOCTL_USER_PVERSION:
+	case SNDRV_PCM_IOCTL_ANONYMOUS_DUP:
 	case SNDRV_PCM_IOCTL_HWSYNC:
 	case SNDRV_PCM_IOCTL_PREPARE:
 	case SNDRV_PCM_IOCTL_RESET:
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 26afb6b0889a..a6d2a5024ab5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -37,6 +37,8 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 #include <linux/delay.h>
+#include <linux/anon_inodes.h>
+#include <linux/syscalls.h>
 
 #include "pcm_local.h"
 
@@ -2393,14 +2395,14 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL(snd_pcm_release_substream);
 
-int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
-			   struct file *file,
+int snd_pcm_open_substream(struct snd_pcm *pcm, struct snd_pcm_substream *clone,
+			   int stream, struct file *file,
 			   struct snd_pcm_substream **rsubstream)
 {
 	struct snd_pcm_substream *substream;
 	int err;
 
-	err = snd_pcm_attach_substream(pcm, stream, file, &substream);
+	err = snd_pcm_attach_substream(pcm, clone, stream, file, &substream);
 	if (err < 0)
 		return err;
 	if (substream->ref_count > 1) {
@@ -2436,13 +2438,14 @@ EXPORT_SYMBOL(snd_pcm_open_substream);
 
 static int snd_pcm_open_file(struct file *file,
 			     struct snd_pcm *pcm,
+			     struct snd_pcm_substream *clone,
 			     int stream)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	int err;
 
-	err = snd_pcm_open_substream(pcm, stream, file, &substream);
+	err = snd_pcm_open_substream(pcm, clone, stream, file, &substream);
 	if (err < 0)
 		return err;
 
@@ -2509,7 +2512,7 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 	add_wait_queue(&pcm->open_wait, &wait);
 	mutex_lock(&pcm->open_mutex);
 	while (1) {
-		err = snd_pcm_open_file(file, pcm, stream);
+		err = snd_pcm_open_file(file, pcm, NULL, stream);
 		if (err >= 0)
 			break;
 		if (err == -EAGAIN) {
@@ -2553,6 +2556,9 @@ static int snd_pcm_release(struct inode *inode, struct file *file)
 	struct snd_pcm_file *pcm_file;
 
 	pcm_file = file->private_data;
+	/* a problem in the anonymous dup can hit the NULL pcm_file */
+	if (pcm_file == NULL)
+		return 0;
 	substream = pcm_file->substream;
 	if (snd_BUG_ON(!substream))
 		return -ENXIO;
@@ -2836,6 +2842,55 @@ static int snd_pcm_forward_ioctl(struct snd_pcm_substream *substream,
 	return result < 0 ? result : 0;
 }
 
+static int snd_pcm_anonymous_dup(struct file *file,
+				 struct snd_pcm_substream *substream,
+				 int __user *arg)
+{
+	int fd;
+	int err;
+	int perm;
+	int flags;
+	struct file *nfile;
+	struct snd_pcm *pcm = substream->pcm;
+
+	if (get_user(perm, (int __user *)arg))
+		return -EFAULT;
+	if (perm < 0)
+		return -ENOSYS;
+	flags = file->f_flags & (O_ACCMODE | O_NONBLOCK);
+	flags |= O_APPEND | O_CLOEXEC;
+	fd = get_unused_fd_flags(flags);
+	if (fd < 0)
+		return fd;
+	nfile = anon_inode_getfile("snd-pcm", file->f_op, NULL, flags);
+	if (IS_ERR(nfile)) {
+		put_unused_fd(fd);
+		return PTR_ERR(nfile);
+	}
+	/* anon_inode_getfile() filters the O_APPEND flag out */
+	nfile->f_flags |= O_APPEND;
+	fd_install(fd, nfile);
+	if (!try_module_get(pcm->card->module)) {
+		err = -EFAULT;
+		goto __error1;
+	}
+	err = snd_card_file_add(substream->pcm->card, nfile);
+	if (err < 0)
+		goto __error2;
+	err = snd_pcm_open_file(nfile, substream->pcm,
+				substream, substream->stream);
+	if (err >= 0) {
+		put_user(fd, (int __user *)arg);
+		return 0;
+	}
+	snd_card_file_remove(substream->pcm->card, nfile);
+      __error2:
+	module_put(pcm->card->module);
+      __error1:
+	ksys_close(fd);
+	return err;
+}
+
 static int snd_pcm_common_ioctl(struct file *file,
 				 struct snd_pcm_substream *substream,
 				 unsigned int cmd, void __user *arg)
@@ -2864,6 +2919,8 @@ static int snd_pcm_common_ioctl(struct file *file,
 			     (unsigned int __user *)arg))
 			return -EFAULT;
 		return 0;
+	case SNDRV_PCM_IOCTL_ANONYMOUS_DUP:
+		return snd_pcm_anonymous_dup(file, substream, (int __user *)arg);
 	case SNDRV_PCM_IOCTL_HW_REFINE:
 		return snd_pcm_hw_refine_user(substream, arg);
 	case SNDRV_PCM_IOCTL_HW_PARAMS:
-- 
2.13.6
