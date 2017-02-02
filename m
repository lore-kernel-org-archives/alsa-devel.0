From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/53] ALSA: x86: Drop snd_intel_had_interface
	indirect calls
Date: Thu,  2 Feb 2017 18:02:20 +0100
Message-ID: <20170202170307.24484-8-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF752668C9
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

Yet another indirection is killed: at this time, it's
snd_intel_had_interface.  It contains also the name string, but it's
nowhere used, thus we can kill it, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     |  9 +----
 sound/x86/intel_hdmi_audio.h     |  2 +-
 sound/x86/intel_hdmi_audio_if.c  |  3 +-
 sound/x86/intel_hdmi_lpe_audio.c | 87 +++++++++-------------------------------
 sound/x86/intel_hdmi_lpe_audio.h | 13 +-----
 5 files changed, 23 insertions(+), 91 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index a4c2f3f8d669..bff46061e5c5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1568,13 +1568,6 @@ static struct snd_kcontrol_new had_control_iec958 = {
 	.put =          had_iec958_put
 };
 
-static struct snd_intel_had_interface had_interface = {
-	.name =         "hdmi-audio",
-	.query =        hdmi_audio_query,
-	.suspend =      hdmi_audio_suspend,
-	.resume =       hdmi_audio_resume,
-};
-
 /**
  * hdmi_audio_probe - to create sound card instance for HDMI audio playabck
  *
@@ -1704,7 +1697,7 @@ int hdmi_audio_probe(void *deviceptr)
 	pm_runtime_enable(intelhaddata->dev);
 
 	mutex_unlock(&had_mutex);
-	retval = mid_hdmi_audio_register(&had_interface, intelhaddata);
+	retval = mid_hdmi_audio_register(intelhaddata);
 	if (retval) {
 		pr_err("registering with display driver failed %#x\n", retval);
 		snd_card_free(card);
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index e7c7432c5078..ba13ae63bea3 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -149,7 +149,7 @@ struct snd_intelhad {
 int had_event_handler(enum had_event_type event_type, void *data);
 
 int hdmi_audio_query(void *drv_data, struct hdmi_audio_event event);
-int hdmi_audio_suspend(void *drv_data, struct hdmi_audio_event event);
+int hdmi_audio_suspend(void *drv_data);
 int hdmi_audio_resume(void *drv_data);
 int hdmi_audio_mode_change(struct snd_pcm_substream *substream);
 extern struct snd_pcm_ops snd_intelhad_playback_ops;
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index 4334be100655..88ebcb5f7388 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -91,12 +91,11 @@ int hdmi_audio_query(void *haddata, struct hdmi_audio_event event)
  * hdmi_audio_suspend - power management suspend function
  *
  *@haddata: pointer to HAD private data
- *@event: pm event for which this method is invoked
  *
  * This function is called by client driver to suspend the
  * hdmi audio.
  */
-int hdmi_audio_suspend(void *haddata, struct hdmi_audio_event event)
+int hdmi_audio_suspend(void *haddata)
 {
 	int caps, retval = 0;
 	struct had_pvt_data *had_stream;
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 1747ff259903..51ba3493ff30 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -45,7 +45,6 @@ struct hdmi_lpe_audio_ctx {
 	int irq;
 	void __iomem *mmio_start;
 	had_event_call_back had_event_callbacks;
-	struct snd_intel_had_interface *had_interface;
 	void *had_pvt_data;
 	int tmds_clock_speed;
 	bool dp_output;
@@ -103,63 +102,9 @@ bool mid_hdmi_audio_is_busy(void *ddev)
 		return false;
 	}
 
-	if (ctx->had_interface) {
-		hdmi_audio_event.type = HAD_EVENT_QUERY_IS_AUDIO_BUSY;
-		hdmi_audio_busy = ctx->had_interface->query(
-				ctx->had_pvt_data,
-				hdmi_audio_event);
-		return hdmi_audio_busy != 0;
-	}
-	return false;
-}
-
-/*
- * return true if HDMI audio device is suspended/ disconnected
- */
-bool mid_hdmi_audio_suspend(void *ddev)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-	struct hdmi_audio_event hdmi_audio_event;
-	int ret = 0;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-
-	if (hlpe_state == hdmi_connector_status_disconnected) {
-		/* HDMI is not connected, assuming audio device
-		 * is suspended already.
-		 */
-		return true;
-	}
-
-	dev_dbg(&hlpe_pdev->dev, "%s: hlpe_state %d",  __func__,
-			hlpe_state);
-
-	if (ctx->had_interface) {
-		hdmi_audio_event.type = 0;
-		ret = ctx->had_interface->suspend(ctx->had_pvt_data,
-				hdmi_audio_event);
-		return (ret == 0) ? true : false;
-	}
-	return true;
-}
-
-void mid_hdmi_audio_resume(void *ddev)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-
-	if (hlpe_state == hdmi_connector_status_disconnected) {
-		/* HDMI is not connected, there is no need
-		 * to resume audio device.
-		 */
-		return;
-	}
-
-	dev_dbg(&hlpe_pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
-
-	if (ctx->had_interface)
-		ctx->had_interface->resume(ctx->had_pvt_data);
+	hdmi_audio_event.type = HAD_EVENT_QUERY_IS_AUDIO_BUSY;
+	hdmi_audio_busy = hdmi_audio_query(ctx->had_pvt_data, hdmi_audio_event);
+	return hdmi_audio_busy != 0;
 }
 
 void mid_hdmi_audio_signal_event(enum had_event_type event)
@@ -331,8 +276,7 @@ static void _had_wq(struct work_struct *work)
 	mid_hdmi_audio_signal_event(HAD_EVENT_HOT_PLUG);
 }
 
-int mid_hdmi_audio_register(struct snd_intel_had_interface *driver,
-				void *had_data)
+int mid_hdmi_audio_register(void *had_data)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 
@@ -341,7 +285,6 @@ int mid_hdmi_audio_register(struct snd_intel_had_interface *driver,
 	dev_dbg(&hlpe_pdev->dev, "%s: called\n", __func__);
 
 	ctx->had_pvt_data = had_data;
-	ctx->had_interface = driver;
 
 	/* The Audio driver is loading now and we need to notify
 	 * it if there is an HDMI device attached
@@ -578,18 +521,26 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int hdmi_lpe_audio_suspend(struct platform_device *pt_dev,
-				pm_message_t state)
+static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
+				  pm_message_t state)
 {
-	dev_dbg(&hlpe_pdev->dev, "Enter %s\n", __func__);
-	mid_hdmi_audio_suspend(NULL);
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
+	/* HDMI is not connected, assuming audio device is suspended already */
+	if (hlpe_state != hdmi_connector_status_disconnected)
+		hdmi_audio_suspend(ctx->had_pvt_data);
 	return 0;
 }
 
-static int hdmi_lpe_audio_resume(struct platform_device *pt_dev)
+static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 {
-	dev_dbg(&hlpe_pdev->dev, "Enter %s\n", __func__);
-	mid_hdmi_audio_resume(NULL);
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
+	/* HDMI is not connected, there is no need to resume audio device */
+	if (hlpe_state != hdmi_connector_status_disconnected)
+		hdmi_audio_resume(ctx->had_pvt_data);
 	return 0;
 }
 
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 5e925b728302..518d897f1806 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -645,21 +645,10 @@ struct hdmi_audio_event {
 	int type;
 };
 
-struct snd_intel_had_interface {
-	const char *name;
-	int (*query)(void *had_data, struct hdmi_audio_event event);
-	int (*suspend)(void *had_data, struct hdmi_audio_event event);
-	int (*resume)(void *had_data);
-};
-
 bool mid_hdmi_audio_is_busy(void *dev);
-bool mid_hdmi_audio_suspend(void *dev);
-void mid_hdmi_audio_resume(void *dev);
 void mid_hdmi_audio_signal_event(enum had_event_type event);
 int mid_hdmi_audio_setup(had_event_call_back audio_callbacks);
-int mid_hdmi_audio_register(
-	struct snd_intel_had_interface *driver,
-	void *had_data);
+int mid_hdmi_audio_register(void *had_data);
 
 int mid_hdmi_audio_read(u32 reg, u32 *val);
 int mid_hdmi_audio_write(u32 reg, u32 val);
-- 
2.11.0
