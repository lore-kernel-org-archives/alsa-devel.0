From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v6 3/3] ALSA: pcm: implement the mmap buffer
	mode for the anonymous dup
Date: Mon,  4 Feb 2019 19:38:17 +0100
Message-ID: <20190204183817.975-4-perex@perex.cz>
References: <20190204183817.975-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 97752267595
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 19:39:29 +0100 (CET)
In-Reply-To: <20190204183817.975-1-perex@perex.cz>
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
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Android requires to allow the passing an anonymous inode file descriptor
with the restricted functionality - only the mmap operation for the DMA
sound buffer (anon_inode:snd-pcm-buffer). Android uses this access mode
for the direct EXCLUSIVE sound device access by applications.

This requirement is for the proper SELinux audit.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h         |  2 ++
 include/uapi/sound/asound.h |  3 +++
 sound/core/pcm_native.c     | 37 +++++++++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b79ffaa0241d..55b95476d15e 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -227,6 +227,7 @@ struct snd_pcm_ops {
 struct snd_pcm_file {
 	struct snd_pcm_substream *substream;
 	int no_compat_mmap;
+	unsigned int perm;		/* file descriptor permissions */
 	unsigned int user_pversion;	/* supported protocol version */
 };
 
@@ -537,6 +538,7 @@ struct snd_pcm {
  *  Registering
  */
 
+extern const struct file_operations snd_pcm_f_op_buffer;
 extern const struct file_operations snd_pcm_f_ops[2];
 
 int snd_pcm_new(struct snd_card *card, const char *id, int device,
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ebc17d5a3490..b0270d07cf4e 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -571,6 +571,9 @@ enum {
 #define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)
 #define SNDRV_CHMAP_DRIVER_SPEC		(0x02 << 16)
 
+#define SNDRV_PCM_PERM_MODE_FULL 	0	/* full access - no restrictions */
+#define SNDRV_PCM_PERM_MODE_BUFFER	1	/* allow to export only sound buffer through mmap */
+
 #define SNDRV_PCM_IOCTL_PVERSION	_IOR('A', 0x00, int)
 #define SNDRV_PCM_IOCTL_INFO		_IOR('A', 0x01, struct snd_pcm_info)
 #define SNDRV_PCM_IOCTL_TSTAMP		_IOW('A', 0x02, int)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0f3887980d9b..9b8662c50f6b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2502,6 +2502,7 @@ static int snd_pcm_open_file(struct file *file,
 		return -ENOMEM;
 	}
 	pcm_file->substream = substream;
+	pcm_file->perm = 0;
 	if (substream->ref_count == 1)
 		substream->pcm_release = pcm_release_private;
 	file->private_data = pcm_file;
@@ -2894,17 +2895,30 @@ static int snd_pcm_anonymous_dup(struct file *file,
 	int fd, err, perm, flags;
 	struct file *nfile;
 	struct snd_pcm *pcm = substream->pcm;
+	struct snd_pcm_file *pcm_file;
+	const char *aname;
+	const struct file_operations *f_op;
 
 	if (get_user(perm, arg))
 		return -EFAULT;
-	if (perm < 0)
-		return -EPERM;
+	switch (perm) {
+	case SNDRV_PCM_PERM_MODE_FULL:
+		aname = "snd-pcm";
+		f_op = file->f_op;
+		break;
+	case SNDRV_PCM_PERM_MODE_BUFFER:
+		aname = "snd-pcm-buf";
+		f_op = &snd_pcm_f_op_buffer;
+		break;
+	default:
+		return -EINVAL;
+	}
 	flags = file->f_flags & (O_ACCMODE | O_NONBLOCK);
 	flags |= O_APPEND | O_CLOEXEC;
 	fd = get_unused_fd_flags(flags);
 	if (fd < 0)
 		return fd;
-	nfile = anon_inode_getfile("snd-pcm", file->f_op, NULL, flags);
+	nfile = anon_inode_getfile(aname, f_op, NULL, flags);
 	if (IS_ERR(nfile)) {
 		put_unused_fd(fd);
 		return PTR_ERR(nfile);
@@ -2922,11 +2936,14 @@ static int snd_pcm_anonymous_dup(struct file *file,
 	mutex_lock(&pcm->open_mutex);
 	err = snd_pcm_open_file(nfile, substream->pcm,
 				substream->stream, substream->number);
-	mutex_unlock(&pcm->open_mutex);
 	if (err >= 0) {
+		pcm_file = nfile->private_data;
+		pcm_file->perm = perm;
+		mutex_unlock(&pcm->open_mutex);
 		put_user(fd, arg);
 		return 0;
 	}
+	mutex_unlock(&pcm->open_mutex);
 	snd_card_file_remove(pcm->card, nfile);
       __error2:
 	module_put(pcm->card->module);
@@ -3307,6 +3324,8 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 	if (pcm_file->user_pversion < SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
 	    (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR))
 		return -ENXIO;
+	if (pcm_file->perm != SNDRV_PCM_PERM_MODE_FULL)
+		return -EPERM;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3352,6 +3371,8 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 	 */
 	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
 		return -ENXIO;
+	if (pcm_file->perm != SNDRV_PCM_PERM_MODE_FULL)
+		return -EPERM;
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
@@ -3728,6 +3749,14 @@ static unsigned long snd_pcm_get_unmapped_area(struct file *file,
  *  Register section
  */
 
+const struct file_operations snd_pcm_f_op_buffer = {
+	.owner =		THIS_MODULE,
+	.release =		snd_pcm_release,
+	.llseek =		no_llseek,
+	.mmap =			snd_pcm_mmap,
+	.get_unmapped_area =	snd_pcm_get_unmapped_area
+};
+
 const struct file_operations snd_pcm_f_ops[2] = {
 	{
 		.owner =		THIS_MODULE,
-- 
2.13.6
