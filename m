From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: x86: Handle reset at prepare callback
Date: Mon, 13 Feb 2017 15:39:16 +0100
Message-ID: <20170213143919.19543-2-tiwai@suse.de>
References: <20170213143919.19543-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E840A266917
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 15:39:23 +0100 (CET)
In-Reply-To: <20170213143919.19543-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Currently the driver handles some reset procedure at the trigger STOP
and the underrun functions, where both are executed in the interrupt
context.  Especially the underrun function has a sync-loop to clear
the UNDERRUN status bit, and this is supposed to be one of plausible
causes of GPU hangup.

Since the job to be done in the interrupt handler should be minimum,
we move the reset function out of trigger and underrun, and push it
into the prepare (and hw_free) callbacks instead.  Here a new flag,
need_reset, is introduced to indicate the requirement of the reset
procedure.  This is for avoiding the multiple resets when PCM prepare
is called sequentially.

Also in the UNDERRUN bit-clear sync loop, take a longer pause to be in
the safer side.  Taking a longer delay is no longer a problem now
because we're running in the normal context.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 39 +++++++++++++++++++++++++--------------
 sound/x86/intel_hdmi_audio.h |  1 +
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c0a080e5d1f4..015d57cd9725 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
+#include <linux/delay.h>
 #include <asm/cacheflush.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
@@ -976,8 +977,6 @@ static void had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	had_substream_put(intelhaddata);
 }
 
-#define MAX_CNT			0xFF
-
 /*
  * The interrupt status 'sticky' bits might not be cleared by
  * setting '1' to that bit once...
@@ -987,31 +986,37 @@ static void wait_clear_underrun_bit(struct snd_intelhad *intelhaddata)
 	int i;
 	u32 val;
 
-	for (i = 0; i < MAX_CNT; i++) {
+	for (i = 0; i < 100; i++) {
 		/* clear bit30, 31 AUD_HDMI_STATUS */
 		had_read_register(intelhaddata, AUD_HDMI_STATUS, &val);
 		if (!(val & AUD_HDMI_STATUS_MASK_UNDERRUN))
 			return;
+		udelay(100);
+		cond_resched();
 		had_write_register(intelhaddata, AUD_HDMI_STATUS, val);
 	}
 	dev_err(intelhaddata->dev, "Unable to clear UNDERRUN bits\n");
 }
 
-/* called from irq handler */
-static void had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
+/* Perform some reset procedure but only when need_reset is set;
+ * this is called from prepare or hw_free callbacks once after trigger STOP
+ * or underrun has been processed in order to settle down the h/w state.
+ */
+static void had_do_reset(struct snd_intelhad *intelhaddata)
 {
-	struct snd_pcm_substream *substream;
+	if (!intelhaddata->need_reset)
+		return;
 
-	/* Handle Underrun interrupt within Audio Unit */
-	had_write_register(intelhaddata, AUD_CONFIG, 0);
-	intelhaddata->aud_config.regval = 0;
 	/* Reset buffer pointers */
 	had_reset_audio(intelhaddata);
-
 	wait_clear_underrun_bit(intelhaddata);
+	intelhaddata->need_reset = false;
+}
 
-	if (!intelhaddata->connected)
-		return; /* disconnected? - bail out */
+/* called from irq handler */
+static void had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
+{
+	struct snd_pcm_substream *substream;
 
 	/* Report UNDERRUN error to above layers */
 	substream = had_substream_get(intelhaddata);
@@ -1019,6 +1024,7 @@ static void had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 		snd_pcm_stop_xrun(substream);
 		had_substream_put(intelhaddata);
 	}
+	intelhaddata->need_reset = true;
 }
 
 /*
@@ -1134,9 +1140,13 @@ static int had_pcm_hw_params(struct snd_pcm_substream *substream,
  */
 static int had_pcm_hw_free(struct snd_pcm_substream *substream)
 {
+	struct snd_intelhad *intelhaddata;
 	unsigned long addr;
 	u32 pages;
 
+	intelhaddata = snd_pcm_substream_chip(substream);
+	had_do_reset(intelhaddata);
+
 	/* mark back the pages as cached/writeback region before the free */
 	if (substream->runtime->dma_area != NULL) {
 		addr = (unsigned long) substream->runtime->dma_area;
@@ -1188,8 +1198,7 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
 		had_enable_audio(intelhaddata, false);
-		/* Reset buffer pointers */
-		had_reset_audio(intelhaddata);
+		intelhaddata->need_reset = true;
 		break;
 
 	default:
@@ -1227,6 +1236,8 @@ static int had_pcm_prepare(struct snd_pcm_substream *substream)
 	dev_dbg(intelhaddata->dev, "rate=%d\n", runtime->rate);
 	dev_dbg(intelhaddata->dev, "channels=%d\n", runtime->channels);
 
+	had_do_reset(intelhaddata);
+
 	/* Get N value in KHz */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
 
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index a96728a4e7bc..8b9e184fef44 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -130,6 +130,7 @@ struct snd_intelhad {
 	union aud_cfg aud_config;	/* AUD_CONFIG reg value cache */
 	struct work_struct hdmi_audio_wq;
 	struct mutex mutex; /* for protecting chmap and eld */
+	bool need_reset;
 };
 
 #endif /* _INTEL_HDMI_AUDIO_ */
-- 
2.11.1
