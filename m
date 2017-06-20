From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 1/4] pcm: hw: Add the support for
	explicit sync of appl_ptr
Date: Tue, 20 Jun 2017 17:35:21 +0200
Message-ID: <20170620153524.28099-2-tiwai@suse.de>
References: <20170620153524.28099-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D0CCE267350
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

The recent kernel informs user-space when a driver requires the
explicit notification of appl_ptr update via a new flag,
SNDRV_PCM_INFO_SYNC_APPLPTR.  When this flag is set, the user-space is
supposed to report the appl_ptr via SNDRV_PCM_IOCTL_SYNC_PTR ioctl.

This patch implements the requested behavior in the PCM hw plugin.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h |  1 +
 src/pcm/pcm_hw.c       | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index fb8d7d7ef8ad..346db40e5932 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -268,6 +268,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid during transfer */
 #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
 #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
+#define SNDRV_PCM_INFO_SYNC_APPLPTR	0x00000020	/* need the explicit sync of appl_ptr update */
 #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */
 #define SNDRV_PCM_INFO_NONINTERLEAVED	0x00000200	/* channels are not interleaved */
 #define SNDRV_PCM_INFO_COMPLEX		0x00000400	/* complex frame organization (mmap only) */
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 30cd5d0f6503..8855868f5ea2 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -91,6 +91,7 @@ typedef struct {
 	int fd;
 	int card, device, subdevice;
 	int sync_ptr_ioctl;
+	int sync_applptr;
 	volatile struct snd_pcm_mmap_status * mmap_status;
 	struct snd_pcm_mmap_control *mmap_control;
 	struct snd_pcm_sync_ptr *sync_ptr;
@@ -128,11 +129,13 @@ struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t *pcm)
 }
 #endif /* DOC_HIDDEN */
 
-static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
+static int sync_ptr1(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *ptr,
+		     unsigned int flags)
 {
 	int err;
-	hw->sync_ptr->flags = flags;
-	err = ioctl((hw)->fd, SNDRV_PCM_IOCTL_SYNC_PTR, (hw)->sync_ptr);
+
+	ptr->flags = flags;
+	err = ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, ptr);
 	if (err < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
@@ -143,7 +146,15 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
 
 static inline int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 {
-	return hw->sync_ptr ? sync_ptr1(hw, flags) : 0;
+	return hw->sync_ptr ? sync_ptr1(hw, hw->sync_ptr, flags) : 0;
+}
+
+/* explicit notification of appl_ptr update to kernel */
+static int sync_applptr(snd_pcm_hw_t *hw)
+{
+	struct snd_pcm_sync_ptr ptr;
+	ptr.c.control = *hw->mmap_control;
+	return sync_ptr1(hw, &ptr, 0);
 }
 
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
@@ -327,6 +338,7 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		SYSMSG("SNDRV_PCM_IOCTL_HW_PARAMS failed (%i)", err);
 		return err;
 	}
+	hw->sync_applptr = !!(params->info & SNDRV_PCM_INFO_SYNC_APPLPTR);
 	params->info &= ~0xf0000000;
 	if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
 		params->info |= SND_PCM_INFO_MONOTONIC;
@@ -568,7 +580,7 @@ static int snd_pcm_hw_hwsync(snd_pcm_t *pcm)
 	int fd = hw->fd, err;
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 3) <= hw->version) {
 		if (hw->sync_ptr) {
-			err = sync_ptr1(hw, SNDRV_PCM_SYNC_PTR_HWSYNC);
+			err = sync_ptr1(hw, hw->sync_ptr, SNDRV_PCM_SYNC_PTR_HWSYNC);
 			if (err < 0)
 				return err;
 		} else {
@@ -995,7 +1007,10 @@ static snd_pcm_sframes_t snd_pcm_hw_mmap_commit(snd_pcm_t *pcm,
 	snd_pcm_hw_t *hw = pcm->private_data;
 
 	snd_pcm_mmap_appl_forward(pcm, size);
-	sync_ptr(hw, 0);
+	if (hw->sync_ptr)
+		sync_ptr(hw, 0);
+	else if (hw->sync_applptr)
+		sync_applptr(hw);
 #ifdef DEBUG_MMAP
 	fprintf(stderr, "appl_forward: hw_ptr = %li, appl_ptr = %li, size = %li\n", *pcm->hw.ptr, *pcm->appl.ptr, size);
 #endif
-- 
2.13.1
