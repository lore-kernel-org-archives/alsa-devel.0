From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/53] ALSA: x86: Call event callback directly
Date: Thu,  2 Feb 2017 18:02:24 +0100
Message-ID: <20170202170307.24484-12-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B8B266849
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:15 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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

Currently the driver calls the event callback stored in its ctx
pointer, but it's obviously inefficient.  Replace it with the direct
calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 11 -----------
 sound/x86/intel_hdmi_audio.h     |  4 ----
 sound/x86/intel_hdmi_lpe_audio.c | 17 +----------------
 sound/x86/intel_hdmi_lpe_audio.h |  4 ----
 4 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 7165f14d5229..571ec07a3611 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1591,7 +1591,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	int retval;
 	struct snd_pcm *pcm;
 	struct snd_card *card;
-	struct had_callback_ops ops_cb;
 	struct snd_intelhad *intelhaddata;
 	struct had_pvt_data *had_stream;
 
@@ -1610,16 +1609,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 		goto free_haddata;
 	}
 
-	ops_cb.intel_had_event_call_back = had_event_handler;
-
-	/* registering with display driver to get access to display APIs */
-
-	retval = mid_hdmi_audio_setup(ops_cb.intel_had_event_call_back);
-	if (retval) {
-		pr_err("querying display driver APIs failed %#x\n", retval);
-		goto free_hadstream;
-	}
-
 	spin_lock_init(&intelhaddata->had_spinlock);
 	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
 	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 5a82a3f429d7..110d1d083000 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -99,10 +99,6 @@ struct had_pvt_data {
 	enum had_status_stream		stream_type;
 };
 
-struct had_callback_ops {
-	had_event_call_back intel_had_event_call_back;
-};
-
 /**
  * struct snd_intelhad - intelhad driver structure
  *
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 0c11d82eb99b..54cc30f034f3 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -44,7 +44,6 @@ static union otm_hdmi_eld_t hlpe_eld;
 struct hdmi_lpe_audio_ctx {
 	int irq;
 	void __iomem *mmio_start;
-	had_event_call_back had_event_callbacks;
 	struct snd_intelhad *had;
 	int tmds_clock_speed;
 	bool dp_output;
@@ -118,8 +117,7 @@ void mid_hdmi_audio_signal_event(enum had_event_type event)
 	/* The handler is protected in the respective
 	 * event handlers to avoid races
 	 */
-	if (ctx->had_event_callbacks)
-		(*ctx->had_event_callbacks)(event, ctx->had);
+	had_event_handler(event, ctx->had);
 }
 
 /*
@@ -257,19 +255,6 @@ int mid_hdmi_audio_set_caps(enum had_caps_list set_element,
 	return 0;
 }
 
-int mid_hdmi_audio_setup(had_event_call_back audio_callbacks)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-
-	dev_dbg(&hlpe_pdev->dev, "%s: called\n",  __func__);
-
-	ctx->had_event_callbacks = audio_callbacks;
-
-	return 0;
-}
-
 static void _had_wq(struct work_struct *work)
 {
 	mid_hdmi_audio_signal_event(HAD_EVENT_HOT_PLUG);
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 0d285ce8d4e6..511bdc30dca1 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -638,16 +638,12 @@ enum had_event_type {
  * HDMI Display Controller Audio Interface
  *
  */
-typedef int (*had_event_call_back) (enum had_event_type event_type,
-		void *ctxt_info);
-
 struct hdmi_audio_event {
 	int type;
 };
 
 bool mid_hdmi_audio_is_busy(void *dev);
 void mid_hdmi_audio_signal_event(enum had_event_type event);
-int mid_hdmi_audio_setup(had_event_call_back audio_callbacks);
 
 int mid_hdmi_audio_read(u32 reg, u32 *val);
 int mid_hdmi_audio_write(u32 reg, u32 val);
-- 
2.11.0
