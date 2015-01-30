From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 06/10] ALSA: core: pass audio tstamp config
	from userspace
Date: Fri, 30 Jan 2015 17:55:59 -0600
Message-ID: <1422662163-7391-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D226261B28
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:33 +0100 (CET)
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

Let userspace select audio timestamp config when the
STATUS_EXT ioctl is used, ignore and zero all
other fields
No change for the existing STATUS ioctl, parameters
are treated as read-only.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_native.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4a97029..544f563 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -753,12 +753,27 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_status_user(struct snd_pcm_substream *substream,
-			       struct snd_pcm_status __user * _status)
+			       struct snd_pcm_status __user * _status,
+			       bool ext)
 {
 	struct snd_pcm_status status;
 	int res;
-	
-	memset(&status, 0, sizeof(status));
+	u32  audio_tstamp_data;
+	u32  __user *_audio_tstamp_data;
+
+	if (ext == false) {
+		memset(&status, 0, sizeof(status));
+	} else {
+		/*
+		 * parameters are read/write, get audio_tstamp_data from user,
+		 * ignore rest of status structure
+		 */
+		_audio_tstamp_data = (u32 __user *)(&_status->audio_tstamp_data);
+		if (get_user(audio_tstamp_data, _audio_tstamp_data))
+			return -EFAULT;
+		memset(&status, 0, sizeof(status));
+		status.audio_tstamp_data = audio_tstamp_data;
+	}
 	res = snd_pcm_status(substream, &status);
 	if (res < 0)
 		return res;
@@ -2723,7 +2738,9 @@ static int snd_pcm_common_ioctl1(struct file *file,
 	case SNDRV_PCM_IOCTL_SW_PARAMS:
 		return snd_pcm_sw_params_user(substream, arg);
 	case SNDRV_PCM_IOCTL_STATUS:
-		return snd_pcm_status_user(substream, arg);
+		return snd_pcm_status_user(substream, arg, false);
+	case SNDRV_PCM_IOCTL_STATUS_EXT:
+		return snd_pcm_status_user(substream, arg, true);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO:
 		return snd_pcm_channel_info_user(substream, arg);
 	case SNDRV_PCM_IOCTL_PREPARE:
-- 
1.9.1
