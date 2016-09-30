From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 6/7] ALSA: usb: no_period_wake and
	max_inflight_bytes report
Date: Fri, 30 Sep 2016 18:13:29 +0530
Message-ID: <1475239410-16548-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id ED9D0261A1A
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:21 +0200 (CEST)
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

Enable no_period_wake and report max_inflight_bytes.

The estimate is a worst-case, it could be refined based on
actual number of packets per URB and total URBs, however this
information is only available in the prepare step

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/usb/pcm.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 44d178e..5bcc729 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -713,7 +713,8 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_usb_substream *subs = substream->runtime->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_usb_substream *subs = runtime->private_data;
 	struct audioformat *fmt;
 	int ret;
 
@@ -728,7 +729,6 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	subs->buffer_periods = params_periods(hw_params);
 	subs->channels = params_channels(hw_params);
 	subs->cur_rate = params_rate(hw_params);
-
 	fmt = find_format(subs);
 	if (!fmt) {
 		dev_dbg(&subs->dev->dev,
@@ -749,6 +749,26 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	subs->altset_idx = fmt->altset_idx;
 	subs->need_setup_ep = true;
 
+	/*
+	 * worst-case max_inflight_bytes is one URB (MAX_PACKS ms),
+	 * multiply by size of 1ms packet for this format. The delay
+	 * can be larger since there are up to MAX_URBS submitted,
+	 * we only track the max number of bytes transferred when one
+	 * URB is submitted.
+	 */
+	runtime->hw.max_inflight_bytes = DIV_ROUND_UP(
+		MAX_PACKS * subs->cur_rate * subs->channels *
+		snd_pcm_format_width(subs->pcm_format), 8 * 1000);
+
+	/*
+	 * The number of packets cannot exceed the ring buffer size, reflect
+	 * constraints for low-latency usages
+	 */
+	if (runtime->hw.max_inflight_bytes >
+		subs->period_bytes * subs->buffer_periods)
+		runtime->hw.max_inflight_bytes =
+			subs->period_bytes * subs->buffer_periods;
+
 	return 0;
 }
 
@@ -851,6 +871,7 @@ static struct snd_pcm_hardware snd_usb_hardware =
 	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_MMAP_VALID |
 				SNDRV_PCM_INFO_BATCH |
+				SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				SNDRV_PCM_INFO_PAUSE,
@@ -1225,6 +1246,7 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	subs->interface = -1;
 	subs->altset_idx = 0;
 	runtime->hw = snd_usb_hardware;
+	runtime->hw.max_inflight_bytes = 0; /* will be set in hw_params() */
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
 	/* runtime PM is also done there */
@@ -1328,7 +1350,7 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 		}
 	}
 
-	if (period_elapsed)
+	if (period_elapsed && !runtime->no_period_wakeup)
 		snd_pcm_period_elapsed(subs->pcm_substream);
 }
 
@@ -1542,7 +1564,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = bytes;
-	if (period_elapsed)
+	if (period_elapsed && !runtime->no_period_wakeup)
 		snd_pcm_period_elapsed(subs->pcm_substream);
 }
 
-- 
1.9.1
