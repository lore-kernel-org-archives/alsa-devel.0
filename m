From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v6 2/7] ALSA: core: pass audio tstamp config
	from userspace
Date: Fri, 13 Feb 2015 15:14:04 -0600
Message-ID: <1423862049-4073-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1423862049-4073-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C043A260661
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 22:14:23 +0100 (CET)
In-Reply-To: <1423862049-4073-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
 sound/core/pcm_native.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b03a638..72323a8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -753,12 +753,21 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 }
 
 static int snd_pcm_status_user(struct snd_pcm_substream *substream,
-			       struct snd_pcm_status __user * _status)
+			       struct snd_pcm_status __user * _status,
+			       bool ext)
 {
 	struct snd_pcm_status status;
 	int res;
-	
+
 	memset(&status, 0, sizeof(status));
+	/*
+	 * with extension, parameters are read/write,
+	 * get audio_tstamp_data from user,
+	 * ignore rest of status structure
+	 */
+	if (ext && get_user(status.audio_tstamp_data,
+				(u32 __user *)(&_status->audio_tstamp_data)))
+		return -EFAULT;
 	res = snd_pcm_status(substream, &status);
 	if (res < 0)
 		return res;
@@ -2723,7 +2732,9 @@ static int snd_pcm_common_ioctl1(struct file *file,
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
