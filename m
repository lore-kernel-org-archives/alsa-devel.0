From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [RESEND][PATCH v4 1/3] ALSA: core: let low-level
	driver or userspace disable rewinds
Date: Tue, 20 Mar 2018 21:31:06 +0530
Message-ID: <1521561668-28613-2-git-send-email-sriramx.periyasamy@intel.com>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EDB926720A
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:09:35 +0100 (CET)
In-Reply-To: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add new hw_params flag to explicitly tell driver that rewinds will never
be used. This can be used by low-level driver to optimize DMA operations
and reduce power consumption. Use this flag only when data written in
ring buffer will never be invalidated, e.g. any update of appl_ptr is
final.

Note that the update of appl_ptr include both a read/write data
operation as well as snd_pcm_forward() whose behavior is not modified.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 include/sound/pcm.h         | 1 +
 include/uapi/sound/asound.h | 1 +
 sound/core/pcm_native.c     | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e054c583d3b3..f60397eb4aab 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -379,6 +379,7 @@ struct snd_pcm_runtime {
 	unsigned int rate_num;
 	unsigned int rate_den;
 	unsigned int no_period_wakeup: 1;
+	unsigned int no_rewinds:1;
 
 	/* -- SW params -- */
 	int tstamp_mode;		/* mmap timestamp is updated */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ed0a120d4f08..ff57e4c89de4 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -377,6 +377,7 @@ typedef int snd_pcm_hw_param_t;
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
 #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
+#define SNDRV_PCM_HW_PARAMS_NO_REWINDS	        (1<<3)	/* disable rewinds */
 
 struct snd_interval {
 	unsigned int min, max;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50ddcf9e..4616420cdbf7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -692,6 +692,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->no_period_wakeup =
 			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
 			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
+	runtime->no_rewinds =
+		(params->flags & SNDRV_PCM_HW_PARAMS_NO_REWINDS) ? 1 : 0;
 
 	bits = snd_pcm_format_physical_width(runtime->format);
 	runtime->sample_bits = bits;
@@ -2614,6 +2616,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
 	if (frames == 0)
 		return 0;
 
+	if (runtime->no_rewinds)
+		return -ENODEV;
+
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
 	if (!ret)
@@ -2632,6 +2637,9 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
 	if (frames == 0)
 		return 0;
 
+	if (runtime->no_rewinds)
+		return -ENODEV;
+
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
 	if (!ret)
-- 
2.7.4
