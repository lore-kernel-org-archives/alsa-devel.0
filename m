From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: x86: Allow single period PCM
	operation
Date: Tue,  7 Feb 2017 14:11:21 +0100
Message-ID: <20170207131122.6345-6-tiwai@suse.de>
References: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1A1266FD4
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:11:26 +0100 (CET)
In-Reply-To: <20170207131122.6345-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

This is an implementation of PCM streaming with only 1 period.
Since the hardware requires the refresh of BDs after each BD
processing finishes, we'd need at least two BDs.  The trick is that
both BDs point to the same content: the address of the PCM buffer
head, and the whole buffer size.  Then it loops over to the whole
buffer again after it finished once.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 9 ++++++++-
 sound/x86/intel_hdmi_lpe_audio.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 8f87ac3057c6..979b396272ae 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -846,6 +846,11 @@ static int had_prog_n(u32 aud_samp_freq, u32 *n_param,
  *
  * For nperiods < 4, the remaining BDs out of 4 are marked as invalid, so that
  * the hardware skips those BDs in the loop.
+ *
+ * An exceptional setup is the case with nperiods=1.  Since we have to update
+ * BDs after finishing one BD processing, we'd need at least two BDs, where
+ * both BDs point to the same content, the same address, the same size of the
+ * whole PCM buffer.
  */
 
 #define AUD_BUF_ADDR(x)		(AUD_BUF_A_ADDR + (x) * HAD_REG_WIDTH)
@@ -888,6 +893,8 @@ static void had_init_ringbuf(struct snd_pcm_substream *substream,
 
 	num_periods = runtime->periods;
 	intelhaddata->num_bds = min(num_periods, HAD_NUM_OF_RING_BUFS);
+	/* set the minimum 2 BDs for num_periods=1 */
+	intelhaddata->num_bds = max(intelhaddata->num_bds, 2U);
 	intelhaddata->period_bytes =
 		frames_to_bytes(runtime, runtime->period_size);
 	WARN_ON(intelhaddata->period_bytes & 0x3f);
@@ -897,7 +904,7 @@ static void had_init_ringbuf(struct snd_pcm_substream *substream,
 	intelhaddata->pcmbuf_filled = 0;
 
 	for (i = 0; i < HAD_NUM_OF_RING_BUFS; i++) {
-		if (i < num_periods)
+		if (i < intelhaddata->num_bds)
 			had_prog_bd(substream, intelhaddata);
 		else /* invalidate the rest */
 			had_invalidate_bd(intelhaddata, i);
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index a13a66771f73..195918f1a4ae 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -31,7 +31,7 @@
 #define HAD_MAX_BUFFER		((1024 * 1024 - 1) & ~0x3f)
 #define HAD_DEFAULT_BUFFER	(600 * 1024) /* default prealloc size */
 #define HAD_MAX_PERIODS		256	/* arbitrary, but should suffice */
-#define HAD_MIN_PERIODS		2
+#define HAD_MIN_PERIODS		1
 #define HAD_MAX_PERIOD_BYTES	((HAD_MAX_BUFFER / HAD_MIN_PERIODS) & ~0x3f)
 #define HAD_MIN_PERIOD_BYTES	1024	/* might be smaller */
 #define HAD_FIFO_SIZE		0 /* fifo not being used */
-- 
2.11.0
