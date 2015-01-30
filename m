From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 07/10] ALSA: core: pass audio tstamp config
	from userspace in compat mode
Date: Fri, 30 Jan 2015 17:56:00 -0600
Message-ID: <1422662163-7391-8-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FB30261B35
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:34 +0100 (CET)
In-Reply-To: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Let userspace select audio timestamp config, ignore and zero all
other fields
Use audio_tstamp_data to retrieve config and pass report back to
user space

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_compat.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 2d957ba..188b991 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -194,18 +194,36 @@ struct snd_pcm_status32 {
 	u32 avail_max;
 	u32 overrange;
 	s32 suspended_state;
-	u32 reserved_alignment;
+	u32 audio_tstamp_data;
 	struct compat_timespec audio_tstamp;
-	unsigned char reserved[56-sizeof(struct compat_timespec)];
+	struct compat_timespec driver_tstamp;
+	u32 audio_tstamp_accuracy;
+	unsigned char reserved[52-2*sizeof(struct compat_timespec)];
 } __attribute__((packed));
 
 
 static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
-				      struct snd_pcm_status32 __user *src)
+				      struct snd_pcm_status32 __user *src,
+				      bool ext)
 {
 	struct snd_pcm_status status;
 	int err;
-
+	u32  audio_tstamp_data;
+	u32  __user *_audio_tstamp_data;
+
+	if (ext == false) {
+		memset(&status, 0, sizeof(status));
+	}  else {
+		/*
+		 * parameters are read/write, get audio_tstamp_data from user,
+		 * ignore rest of status structure
+		 */
+		_audio_tstamp_data = (u32 __user *)(&src->audio_tstamp_data);
+		if (get_user(audio_tstamp_data, _audio_tstamp_data))
+			return -EFAULT;
+		memset(&status, 0, sizeof(status));
+		status.audio_tstamp_data = audio_tstamp_data;
+	}
 	err = snd_pcm_status(substream, &status);
 	if (err < 0)
 		return err;
@@ -222,7 +240,10 @@ static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
 	    put_user(status.avail_max, &src->avail_max) ||
 	    put_user(status.overrange, &src->overrange) ||
 	    put_user(status.suspended_state, &src->suspended_state) ||
-	    compat_put_timespec(&status.audio_tstamp, &src->audio_tstamp))
+	    put_user(status.audio_tstamp_data, &src->audio_tstamp_data) ||
+	    compat_put_timespec(&status.audio_tstamp, &src->audio_tstamp) ||
+	    compat_put_timespec(&status.driver_tstamp, &src->driver_tstamp) ||
+	    put_user(status.audio_tstamp_accuracy, &src->audio_tstamp_accuracy))
 		return -EFAULT;
 
 	return err;
@@ -457,6 +478,7 @@ enum {
 	SNDRV_PCM_IOCTL_HW_PARAMS32 = _IOWR('A', 0x11, struct snd_pcm_hw_params32),
 	SNDRV_PCM_IOCTL_SW_PARAMS32 = _IOWR('A', 0x13, struct snd_pcm_sw_params32),
 	SNDRV_PCM_IOCTL_STATUS32 = _IOR('A', 0x20, struct snd_pcm_status32),
+	SNDRV_PCM_IOCTL_STATUS_EXT32 = _IOWR('A', 0x24, struct snd_pcm_status32),
 	SNDRV_PCM_IOCTL_DELAY32 = _IOR('A', 0x21, s32),
 	SNDRV_PCM_IOCTL_CHANNEL_INFO32 = _IOR('A', 0x32, struct snd_pcm_channel_info32),
 	SNDRV_PCM_IOCTL_REWIND32 = _IOW('A', 0x46, u32),
@@ -517,7 +539,9 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_PCM_IOCTL_SW_PARAMS32:
 		return snd_pcm_ioctl_sw_params_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_STATUS32:
-		return snd_pcm_status_user_compat(substream, argp);
+		return snd_pcm_status_user_compat(substream, argp, false);
+	case SNDRV_PCM_IOCTL_STATUS_EXT32:
+		return snd_pcm_status_user_compat(substream, argp, true);
 	case SNDRV_PCM_IOCTL_SYNC_PTR32:
 		return snd_pcm_ioctl_sync_ptr_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO32:
-- 
1.9.1
