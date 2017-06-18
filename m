From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 2/2] pcm: add support for interface
	version 2.0.14
Date: Mon, 19 Jun 2017 01:49:21 +0900
Message-ID: <20170618164921.9881-4-o-takashi@sakamocchi.jp>
References: <20170618164921.9881-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C00E2266C25
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 18:49:25 +0200 (CEST)
In-Reply-To: <20170618164921.9881-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: vinod.koul@intel.com, subhransu.s.prusty@intel.com, alsa-devel@alsa-project.org, clemens@ladisch.de, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

In interface version 2.0.14, ALSA PCM core request feedback to
applications when they operate any PCM frames in mmap operation for a
type of devices with SNDRV_PCM_INFO_ACK_APPLPTR flag.

This commit adds support for this change to keep compatibility for
existent applications which uses alsa-lib API.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 30cd5d0f..880109ad 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -105,6 +105,7 @@ typedef struct {
 	/* for chmap */
 	unsigned int chmap_caps;
 	snd_pcm_chmap_query_t **chmap_override;
+	int ack_applptr;
 } snd_pcm_hw_t;
 
 #define SNDRV_FILE_PCM_STREAM_PLAYBACK		ALSA_DEVICE_DIRECTORY "pcmC%iD%ip"
@@ -128,11 +129,12 @@ struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t *pcm)
 }
 #endif /* DOC_HIDDEN */
 
-static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
+static int sync_ptr1(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *sync_ptr,
+		     unsigned int flags)
 {
 	int err;
-	hw->sync_ptr->flags = flags;
-	err = ioctl((hw)->fd, SNDRV_PCM_IOCTL_SYNC_PTR, (hw)->sync_ptr);
+	sync_ptr->flags = flags;
+	err = ioctl((hw)->fd, SNDRV_PCM_IOCTL_SYNC_PTR, sync_ptr);
 	if (err < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
@@ -143,7 +145,7 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
 
 static inline int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 {
-	return hw->sync_ptr ? sync_ptr1(hw, flags) : 0;
+	return hw->sync_ptr ? sync_ptr1(hw, hw->sync_ptr, flags) : 0;
 }
 
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
@@ -295,6 +297,14 @@ static int snd_pcm_hw_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 			return err;
 	}
 
+	/*
+	 * For drivers with SNDRV_PCM_INFO_ACK_APPLPTR, this has an effect
+	 * to tell that user land can perform MMAP operation as corresponding
+	 * hardware expects. For the other drivers, this has no side-effect.
+	 */
+	if (hw->version >= SNDRV_PROTOCOL_VERSION(2, 0, 14))
+		params->flags |= SNDRV_PCM_INFO_ACK_APPLPTR;
+
 	if (hw_refine_call(hw, params) < 0) {
 		err = -errno;
 		// SYSMSG("SNDRV_PCM_IOCTL_HW_REFINE failed");
@@ -322,6 +332,15 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
 	int err;
+
+	/*
+	 * For drivers with SNDRV_PCM_INFO_ACK_APPLPTR, this has an effect
+	 * to tell that user land can perform MMAP operation as corresponding
+	 * hardware expects. For the other drivers, this has no side-effect.
+	 */
+	if (hw->version >= SNDRV_PROTOCOL_VERSION(2, 0, 14))
+		params->flags |= SNDRV_PCM_INFO_ACK_APPLPTR;
+
 	if (hw_params_call(hw, params) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_HW_PARAMS failed (%i)", err);
@@ -337,6 +356,11 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
 				     SNDRV_PCM_MMAP_OFFSET_CONTROL);
 	}
+
+	if (hw->version >= SNDRV_PROTOCOL_VERSION(2, 0, 14) &&
+	    (params->info & SNDRV_PCM_INFO_ACK_APPLPTR))
+		hw->ack_applptr = 1;
+
 	return 0;
 }
 
@@ -568,7 +592,8 @@ static int snd_pcm_hw_hwsync(snd_pcm_t *pcm)
 	int fd = hw->fd, err;
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 3) <= hw->version) {
 		if (hw->sync_ptr) {
-			err = sync_ptr1(hw, SNDRV_PCM_SYNC_PTR_HWSYNC);
+			err = sync_ptr1(hw, hw->sync_ptr,
+					SNDRV_PCM_SYNC_PTR_HWSYNC);
 			if (err < 0)
 				return err;
 		} else {
@@ -995,7 +1020,13 @@ static snd_pcm_sframes_t snd_pcm_hw_mmap_commit(snd_pcm_t *pcm,
 	snd_pcm_hw_t *hw = pcm->private_data;
 
 	snd_pcm_mmap_appl_forward(pcm, size);
-	sync_ptr(hw, 0);
+	if (hw->sync_ptr) {
+		sync_ptr1(hw, hw->sync_ptr, 0);
+	} else if (hw->ack_applptr) {
+		struct snd_pcm_sync_ptr sync_ptr = {0};
+		sync_ptr.c.control = *hw->mmap_control;
+		sync_ptr1(hw, &sync_ptr, 0);
+	}
 #ifdef DEBUG_MMAP
 	fprintf(stderr, "appl_forward: hw_ptr = %li, appl_ptr = %li, size = %li\n", *pcm->hw.ptr, *pcm->appl.ptr, size);
 #endif
-- 
2.11.0
