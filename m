From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 4/7] ALSA: core: add report of max inflight
	bytes
Date: Fri, 30 Sep 2016 18:13:27 +0530
Message-ID: <1475239410-16548-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C935826657F
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:16 +0200 (CEST)
In-Reply-To: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Report size of data burst before updating the hw_ptr, e.g. while DMA
operations are on-going.

This can help fix two issues with stale data discussed many times over
on the alsa-devel mailing list (refilling/reading ring buffer too late
during capture or rewinding too close to the hw_ptr during playback)

This patch only reports the maximum burst of data and does not provide
hooks to negotiate its size. This might be useful to lower power or
reduce latency, but isn't typically supported by fixed-function DMA
hardware.

The use of IOCTL1 is not really required but keep for symmetry with
existing code used to retried fifo_size

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/sound/pcm.h         |  2 ++
 include/uapi/sound/asound.h |  5 +++--
 sound/core/pcm_lib.c        | 20 ++++++++++++++++++++
 sound/core/pcm_native.c     |  7 +++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1accb8b..8c9d80a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -56,6 +56,7 @@ struct snd_pcm_hardware {
 	unsigned int periods_min;	/* min # of periods */
 	unsigned int periods_max;	/* max # of periods */
 	size_t fifo_size;		/* fifo size in bytes */
+	unsigned int max_inflight_bytes;/* hw_ptr precision/fuzziness, e.g. due to DMA transfers */
 };
 
 struct snd_pcm_substream;
@@ -105,6 +106,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_IOCTL1_CHANNEL_INFO	2
 #define SNDRV_PCM_IOCTL1_GSTATE		3
 #define SNDRV_PCM_IOCTL1_FIFO_SIZE	4
+#define SNDRV_PCM_IOCTL1_MAX_INFLIGHT_BYTES	5
 
 #define SNDRV_PCM_TRIGGER_STOP		0
 #define SNDRV_PCM_TRIGGER_START		1
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 6828ed2..5f539d7 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -392,8 +392,9 @@ struct snd_pcm_hw_params {
 	unsigned int msbits;		/* R: used most significant bits */
 	unsigned int rate_num;		/* R: rate numerator */
 	unsigned int rate_den;		/* R: rate denominator */
-	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
-	unsigned char reserved[64];	/* reserved for future */
+	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames, indicates buffering after hw_ptr updates */
+	unsigned int max_inflight_bytes;/* R: typically DMA burst in bytes, indicates buffering before hw_ptr updates */
+	unsigned char reserved[60];	/* reserved for future */
 };
 
 enum {
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 1656ca9..06b44ed 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1827,6 +1827,23 @@ static int snd_pcm_lib_ioctl_fifo_size(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int snd_pcm_lib_ioctl_max_inflight_bytes(
+	struct snd_pcm_substream *substream,
+	void *arg)
+{
+	struct snd_pcm_hw_params *params = arg;
+
+	params->max_inflight_bytes = substream->runtime->hw.max_inflight_bytes;
+	/*
+	 * Sanity check that max_inflight_bytes isn't larger than buffer_size,
+	 * couldn't think of any other checks
+	 */
+	if (params->max_inflight_bytes > substream->runtime->buffer_size)
+		params->max_inflight_bytes = substream->runtime->buffer_size;
+
+	return 0;
+}
+
 /**
  * snd_pcm_lib_ioctl - a generic PCM ioctl callback
  * @substream: the pcm substream instance
@@ -1850,6 +1867,9 @@ int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		return snd_pcm_lib_ioctl_channel_info(substream, arg);
 	case SNDRV_PCM_IOCTL1_FIFO_SIZE:
 		return snd_pcm_lib_ioctl_fifo_size(substream, arg);
+	case SNDRV_PCM_IOCTL1_MAX_INFLIGHT_BYTES:
+		return snd_pcm_lib_ioctl_max_inflight_bytes(substream, arg);
+
 	}
 	return -ENXIO;
 }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1965d83..a29b5af 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -292,6 +292,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 
 	params->info = 0;
 	params->fifo_size = 0;
+	params->max_inflight_bytes = 0;
 	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_SAMPLE_BITS))
 		params->msbits = 0;
 	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_RATE)) {
@@ -449,6 +450,12 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 				return changed;
 		}
 	}
+	if (!params->max_inflight_bytes) {
+		changed = substream->ops->ioctl(substream,
+				SNDRV_PCM_IOCTL1_MAX_INFLIGHT_BYTES, params);
+		if (changed < 0)
+			return changed;
+	}
 	params->rmask = 0;
 	return 0;
 }
-- 
1.9.1
