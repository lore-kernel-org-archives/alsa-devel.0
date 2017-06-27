From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib v2] pcm: hw: Call USER_PVERSION ioctl
	at open
Date: Tue, 27 Jun 2017 12:39:47 +0200
Message-ID: <20170627103947.7351-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26DB8266B63
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 12:39:52 +0200 (CEST)
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

The patch contains also the addition of SNDRV_PCM_INFO_SYNC_APPLPTR
carried from the upstream kernel commit 42f945970af9 ("ALSA: pcm: Add
the explicit appl_ptr sync support"), as well as the trivial change
(an addition of comma) to sync with the kernel asound.h.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h |  6 ++++--
 src/pcm/pcm_hw.c       | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index fb8d7d7ef8ad..1949923a40bf 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -111,7 +111,7 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_FIREFACE,	/* RME Fireface series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREFACE,
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREFACE
 };
 
 struct snd_hwdep_info {
@@ -152,7 +152,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 13)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -268,6 +268,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid during transfer */
 #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
 #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
+#define SNDRV_PCM_INFO_SYNC_APPLPTR	0x00000020	/* need the explicit sync of appl_ptr update */
 #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */
 #define SNDRV_PCM_INFO_NONINTERLEAVED	0x00000200	/* channels are not interleaved */
 #define SNDRV_PCM_INFO_COMPLEX		0x00000400	/* complex frame organization (mmap only) */
@@ -563,6 +564,7 @@ enum {
 #define SNDRV_PCM_IOCTL_INFO		_IOR('A', 0x01, struct snd_pcm_info)
 #define SNDRV_PCM_IOCTL_TSTAMP		_IOW('A', 0x02, int)
 #define SNDRV_PCM_IOCTL_TTSTAMP		_IOW('A', 0x03, int)
+#define SNDRV_PCM_IOCTL_USER_PVERSION	_IOW('A', 0x04, int)
 #define SNDRV_PCM_IOCTL_HW_REFINE	_IOWR('A', 0x10, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_PARAMS	_IOWR('A', 0x11, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_FREE		_IO('A', 0x12)
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 5573fce2d43d..64188b2258d6 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1494,6 +1494,16 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
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
2.13.2
