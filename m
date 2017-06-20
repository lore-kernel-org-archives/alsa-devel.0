From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 2/4] pcm: hw: Call USER_PVERSION ioctl
	at open
Date: Tue, 20 Jun 2017 17:35:22 +0200
Message-ID: <20170620153524.28099-3-tiwai@suse.de>
References: <20170620153524.28099-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D14FD267352
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:35:28 +0200 (CEST)
In-Reply-To: <20170620153524.28099-1-tiwai@suse.de>
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

Up from the new PCM protocol 2.0.14, user-space can inform the
protocol version it supports to kernel, so that the kernel may switch
its behavior depending on it.  Add this ioctl call in the PCM hw
plugin at opening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h |  3 ++-
 src/pcm/pcm_hw.c       | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 346db40e5932..9ea2a638321c 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
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
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 8855868f5ea2..2775483f1933 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1475,6 +1475,16 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
 	if (SNDRV_PROTOCOL_INCOMPATIBLE(ver, SNDRV_PCM_VERSION_MAX))
 		return -SND_ERROR_INCOMPATIBLE_VERSION;
 
+	if (SNDRV_PROTOCOL_VERSION(2, 0, 14) <= ver) {
+		/* inform the protocol version we're supporting */
+		unsigned int user_ver = SNDRV_PCM_VERSION;
+		if (ioctl(fd, SNDRV_PCM_IOCTL_USER_PVERSION, &user_ver) < 0) {
+			ret = -errno;
+			SNDMSG("USER_PVERSION failed\n");
+			return ret;
+		}
+	}
+
 #if defined(HAVE_CLOCK_GETTIME) && defined(CLOCK_MONOTONIC)
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 9) <= ver) {
 		struct timespec timespec;
-- 
2.13.1
