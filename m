From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ALSA - hda: Add support for link audio
	time reporting
Date: Mon, 11 Jul 2016 15:43:28 +0530
Message-ID: <1468232009-14130-3-git-send-email-vinod.koul@intel.com>
References: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 26CFD2654D5
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 12:06:33 +0200 (CEST)
In-Reply-To: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Skylake onwards HDA controller supports reprting link audio
time, so add support for that.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_controller.c | 159 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 9833666c6108..5613a403d720 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <asm/tsc.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include "hda_controller.h"
@@ -34,6 +35,8 @@
 #define CREATE_TRACE_POINTS
 #include "hda_controller_trace.h"
 
+#define SEC_TO_NSEC	1000000000LL
+
 /* DSP lock helpers */
 #define dsp_lock(dev)		snd_hdac_dsp_lock(azx_stream(dev))
 #define dsp_unlock(dev)		snd_hdac_dsp_unlock(azx_stream(dev))
@@ -337,12 +340,136 @@ static snd_pcm_uframes_t azx_pcm_pointer(struct snd_pcm_substream *substream)
 			       azx_get_position(chip, azx_dev));
 }
 
+static u64 azx_scale64(u64 base, u32 num, u32 den)
+{
+	u64 rem;
+
+	rem = do_div(base, den);
+
+	base *= num;
+	rem *= num;
+
+	do_div(rem, den);
+
+	return base + rem;
+}
+
+static int azx_get_sync_time(ktime_t *device,
+		struct system_counterval_t *system, void *ctx)
+{
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)ctx;
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	struct snd_pcm_runtime *runtime;
+	u64 ll_counter, ll_counter_l, ll_counter_h;
+	u64 tsc_counter, tsc_counter_l, tsc_counter_h;
+	u32 wallclk_ctr, wallclk_cycles;
+	bool direction;
+	u32 dma_select;
+	u32 timeout = 200;
+	u32 retry_count = 0;
+
+	runtime = substream->runtime;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		direction = 1;
+	else
+		direction = 0;
+
+	/* 0th stream tag is not used, so DMA ch 0 is for 1st stream tag */
+	do {
+		timeout = 100;
+		dma_select = (direction << GTSCC_CDMAS_DMA_DIR_SHIFT) |
+					(azx_dev->core.stream_tag - 1);
+		_snd_hdac_chip_write(l, azx_bus(chip), AZX_REG_GTSCC,
+						dma_select);
+		/* Enable the capture */
+		_snd_hdac_chip_write(l, azx_bus(chip), AZX_REG_GTSCC,
+				     _snd_hdac_chip_read(l, azx_bus(chip),
+					AZX_REG_GTSCC) | GTSCC_TSCCI_MASK);
+
+		while (timeout) {
+			if (_snd_hdac_chip_read(l, azx_bus(chip),
+				AZX_REG_GTSCC) & GTSCC_TSCCD_MASK)
+				break;
+			timeout--;
+		}
+
+		if (!timeout) {
+			dev_err(chip->card->dev, "GTSCC capture Timedout!\n");
+			return -EIO;
+		}
+
+		/* Read wall clock counter */
+		wallclk_ctr = _snd_hdac_chip_read(l, azx_bus(chip),
+						  AZX_REG_WALFCC);
+
+		/* Read TSC counter */
+		tsc_counter_l = _snd_hdac_chip_read(l, azx_bus(chip),
+						    AZX_REG_TSCCL);
+		tsc_counter_h = _snd_hdac_chip_read(l, azx_bus(chip),
+						    AZX_REG_TSCCU);
+
+		/* Read Link counter */
+		ll_counter_l = _snd_hdac_chip_read(l, azx_bus(chip),
+						   AZX_REG_LLPCL);
+		ll_counter_h = _snd_hdac_chip_read(l, azx_bus(chip),
+						   AZX_REG_LLPCU);
+
+		/* Ack: registers read done */
+		_snd_hdac_chip_write(l, azx_bus(chip),
+				     AZX_REG_GTSCC,
+				     (0x1 << GTSCC_TSCCD_SHIFT));
+
+		tsc_counter = (tsc_counter_h << TSCCU_CCU_SHIFT) |
+						tsc_counter_l;
+
+		ll_counter = (ll_counter_h << LLPC_CCU_SHIFT) |	ll_counter_l;
+		wallclk_cycles = wallclk_ctr & WALFCC_CIF_MASK;
+
+		if (wallclk_cycles < HDA_MAX_CYCLE_VALUE - HDA_MAX_CYCLE_OFFSET
+		    && wallclk_cycles > HDA_MAX_CYCLE_OFFSET)
+			break;
+
+		/*
+		 * Sleep before we read again, else we may again get
+		 * value near to MAX_CYCLE. Try to sleep for different
+		 * amount of time so we dont hit the same number again
+		 */
+		udelay(retry_count++);
+	} while (retry_count != HDA_MAX_CYCLE_READ_RETRY);
+
+	if (retry_count == HDA_MAX_CYCLE_READ_RETRY) {
+		dev_err(chip->card->dev, "Error in WALFCC cycle count\n");
+		return -EIO;
+	}
+
+	*device = ns_to_ktime(azx_scale64(ll_counter,
+				SEC_TO_NSEC, runtime->rate));
+	*device = ktime_add_ns(*device, (wallclk_cycles * SEC_TO_NSEC) /
+			       ((HDA_MAX_CYCLE_VALUE+1) * runtime->rate));
+
+	*system = convert_art_to_tsc(tsc_counter);
+
+	return 0;
+}
+
+static int azx_get_crosststamp(struct snd_pcm_substream *substream,
+			      struct system_device_crosststamp *xtstamp)
+{
+	return get_device_system_crosststamp(azx_get_sync_time,
+					substream, NULL, xtstamp);
+}
+
 static int azx_get_time_info(struct snd_pcm_substream *substream,
 			struct timespec *system_ts, struct timespec *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
 {
 	struct azx_dev *azx_dev = get_azx_dev(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct system_device_crosststamp xtstamp;
 	u64 nsec;
 
 	if ((substream->runtime->hw.info & SNDRV_PCM_INFO_HAS_LINK_ATIME) &&
@@ -361,8 +488,38 @@ static int azx_get_time_info(struct snd_pcm_substream *substream,
 		audio_tstamp_report->accuracy_report = 1; /* rest of structure is valid */
 		audio_tstamp_report->accuracy = 42; /* 24 MHz WallClock == 42ns resolution */
 
-	} else
+	} else if ((runtime->hw.info &
+			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME) &&
+			(audio_tstamp_config->type_requested ==
+			SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED)) {
+
+		azx_get_crosststamp(substream, &xtstamp);
+
+		switch (runtime->tstamp_type) {
+		case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC:
+			return -EINVAL;
+
+		case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
+			*system_ts = ktime_to_timespec(xtstamp.sys_monoraw);
+			break;
+
+		default:
+			*system_ts = ktime_to_timespec(xtstamp.sys_realtime);
+			break;
+
+		}
+
+		*audio_ts = ktime_to_timespec(xtstamp.device);
+
+		audio_tstamp_report->actual_type =
+			SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED;
+		audio_tstamp_report->accuracy_report = 1;
+		/* 24 MHz WallClock == 42ns resolution */
+		audio_tstamp_report->accuracy = 42;
+
+	} else {
 		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT;
+	}
 
 	return 0;
 }
-- 
1.9.1
