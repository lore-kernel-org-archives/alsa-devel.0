From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: pcm: Add an ioctl to specify the
	supported protocol version
Date: Tue, 20 Jun 2017 17:33:51 +0200
Message-ID: <20170620153352.27775-3-tiwai@suse.de>
References: <20170620153352.27775-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1542126680F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:33:56 +0200 (CEST)
In-Reply-To: <20170620153352.27775-1-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

We have an ioctl to inform the PCM protocol version the running kernel
supports, but there is no way to know which protocol version the
user-space can understand.  This lack of information caused headaches
in the past when we tried to extend the ABI.  For example, because we
couldn't guarantee the validity of the reserved bytes, we had to
introduce a new ioctl SNDRV_PCM_IOCTL_STATUS_EXT for assigning a few
new fields in the formerly reserved bits.  If we could know that it's
a new alsa-lib, we could assume the availability of the new fields,
thus we could have reused the existing SNDRV_PCM_IOCTL_STATUS.

In order to improve the ABI extensibility, this patch adds a new ioctl
for user-space to inform its supporting protocol version to the
kernel.  By reporting the supported protocol from user-space, the
kernel can judge which feature should be provided and which not.

With the addition of the new ioctl, the PCM protocol version is bumped
to 2.0.14, too.  User-space checks the kernel protocol version via
SNDRV_PCM_INFO_PVERSION, then it sets the supported version back via
SNDRV_PCM_INFO_USER_PVERSION.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h         | 1 +
 include/uapi/sound/asound.h | 3 ++-
 sound/core/pcm_compat.c     | 1 +
 sound/core/pcm_native.c     | 7 +++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 5a22075c5fcf..6a94f8865846 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -352,6 +352,7 @@ struct snd_pcm_runtime {
 	unsigned long hw_ptr_buffer_jiffies; /* buffer time in jiffies */
 	snd_pcm_sframes_t delay;	/* extra delay; typically FIFO size */
 	u64 hw_ptr_wrap;                /* offset for hw_ptr due to boundary wrap-around */
+	unsigned int user_pversion;	/* supported protocol version */
 
 	/* -- HW params -- */
 	snd_pcm_access_t access;	/* access mode */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 7eee52eb7462..1949923a40bf 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -152,7 +152,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 13)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -564,6 +564,7 @@ enum {
 #define SNDRV_PCM_IOCTL_INFO		_IOR('A', 0x01, struct snd_pcm_info)
 #define SNDRV_PCM_IOCTL_TSTAMP		_IOW('A', 0x02, int)
 #define SNDRV_PCM_IOCTL_TTSTAMP		_IOW('A', 0x03, int)
+#define SNDRV_PCM_IOCTL_USER_PVERSION	_IOW('A', 0x04, int)
 #define SNDRV_PCM_IOCTL_HW_REFINE	_IOWR('A', 0x10, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_PARAMS	_IOWR('A', 0x11, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_FREE		_IO('A', 0x12)
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 8a0f8d51e95d..10f537f4d735 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -676,6 +676,7 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_PCM_IOCTL_INFO:
 	case SNDRV_PCM_IOCTL_TSTAMP:
 	case SNDRV_PCM_IOCTL_TTSTAMP:
+	case SNDRV_PCM_IOCTL_USER_PVERSION:
 	case SNDRV_PCM_IOCTL_HWSYNC:
 	case SNDRV_PCM_IOCTL_PREPARE:
 	case SNDRV_PCM_IOCTL_RESET:
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ef2ce64dcdb3..df3e0303409f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2779,6 +2779,13 @@ static int snd_pcm_common_ioctl(struct file *file,
 		return 0;
 	case SNDRV_PCM_IOCTL_TTSTAMP:
 		return snd_pcm_tstamp(substream, arg);
+	case SNDRV_PCM_IOCTL_USER_PVERSION:
+		if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+			return -EBADFD;
+		if (get_user(substream->runtime->user_pversion,
+			     (unsigned int __user*)arg))
+			return -EFAULT;
+		return 0;
 	case SNDRV_PCM_IOCTL_HW_REFINE:
 		return snd_pcm_hw_refine_user(substream, arg);
 	case SNDRV_PCM_IOCTL_HW_PARAMS:
-- 
2.13.1
