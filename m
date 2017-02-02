From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/53] ALSA: x86: Drop the global platform
	device reference
Date: Thu,  2 Feb 2017 18:02:27 +0100
Message-ID: <20170202170307.24484-15-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24D4B26757C
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
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

Instead of referring to the global hlpe_pdev variable, pass the
platform device object to each function properly.  Accessing to the
global object is really ugly and error-prone.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     |  15 ++--
 sound/x86/intel_hdmi_lpe_audio.c | 146 ++++++++++++++++++---------------------
 sound/x86/intel_hdmi_lpe_audio.h |  17 +++--
 3 files changed, 87 insertions(+), 91 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 571ec07a3611..ed9db2ebe9cf 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -172,11 +172,12 @@ int had_get_hwstate(struct snd_intelhad *intelhaddata)
 int had_get_caps(struct snd_intelhad *intelhaddata,
 		 enum had_caps_list query, void *caps)
 {
+	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = mid_hdmi_audio_get_caps(query, caps);
+		retval = mid_hdmi_audio_get_caps(pdev, query, caps);
 
 	return retval;
 }
@@ -184,33 +185,36 @@ int had_get_caps(struct snd_intelhad *intelhaddata,
 int had_set_caps(struct snd_intelhad *intelhaddata,
 		 enum had_caps_list set_element, void *caps)
 {
+	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = mid_hdmi_audio_set_caps(set_element, caps);
+		retval = mid_hdmi_audio_set_caps(pdev, set_element, caps);
 
 	return retval;
 }
 
 int had_read_register(struct snd_intelhad *intelhaddata, u32 offset, u32 *data)
 {
+	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = mid_hdmi_audio_read(offset, data);
+		retval = mid_hdmi_audio_read(pdev, offset, data);
 
 	return retval;
 }
 
 int had_write_register(struct snd_intelhad *intelhaddata, u32 offset, u32 data)
 {
+	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = mid_hdmi_audio_write(offset, data);
+		retval = mid_hdmi_audio_write(pdev, offset, data);
 
 	return retval;
 }
@@ -218,11 +222,12 @@ int had_write_register(struct snd_intelhad *intelhaddata, u32 offset, u32 data)
 int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
 		    u32 data, u32 mask)
 {
+	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = mid_hdmi_audio_rmw(offset, data, mask);
+		retval = mid_hdmi_audio_rmw(pdev, offset, data, mask);
 
 	return retval;
 }
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 452128a941cb..09c21346071c 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -37,11 +37,11 @@
 #include "intel_hdmi_audio.h"
 
 /* globals*/
-static struct platform_device *hlpe_pdev;
 static int hlpe_state;
 static union otm_hdmi_eld_t hlpe_eld;
 
 struct hdmi_lpe_audio_ctx {
+	struct platform_device *pdev;
 	int irq;
 	void __iomem *mmio_start;
 	struct snd_intelhad *had;
@@ -74,22 +74,12 @@ static int hdmi_get_eld(void *eld)
 	return 0;
 }
 
-
-static struct hdmi_lpe_audio_ctx *get_hdmi_context(void)
+static void mid_hdmi_audio_signal_event(struct platform_device *pdev,
+					enum had_event_type event)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-	return ctx;
-}
-
-void mid_hdmi_audio_signal_event(enum had_event_type event)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	dev_dbg(&hlpe_pdev->dev, "%s: Enter\n", __func__);
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
-	ctx = platform_get_drvdata(hlpe_pdev);
+	dev_dbg(&pdev->dev, "%s: Enter\n", __func__);
 
 	/* The handler is protected in the respective
 	 * event handlers to avoid races
@@ -100,13 +90,11 @@ void mid_hdmi_audio_signal_event(enum had_event_type event)
 /*
  * used to write into display controller HDMI audio registers.
  */
-int mid_hdmi_audio_write(u32 reg, u32 val)
+int mid_hdmi_audio_write(struct platform_device *pdev, u32 reg, u32 val)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
-	dev_dbg(&hlpe_pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, val);
+	dev_dbg(&pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, val);
 
 	if (ctx->dp_output) {
 		if (reg == AUD_CONFIG && (val & AUD_CONFIG_VALID_BIT))
@@ -121,13 +109,12 @@ int mid_hdmi_audio_write(u32 reg, u32 val)
  * used to get the register value read from
  * display controller HDMI audio registers.
  */
-int mid_hdmi_audio_read(u32 reg, u32 *val)
+int mid_hdmi_audio_read(struct platform_device *pdev, u32 reg, u32 *val)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
-	ctx = platform_get_drvdata(hlpe_pdev);
 	*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
-	dev_dbg(&hlpe_pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, *val);
+	dev_dbg(&pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, *val);
 	return 0;
 }
 
@@ -135,13 +122,12 @@ int mid_hdmi_audio_read(u32 reg, u32 *val)
  * used to update the masked bits in display controller HDMI
  * audio registers.
  */
-int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask)
+int mid_hdmi_audio_rmw(struct platform_device *pdev,
+		       u32 reg, u32 val, u32 mask)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 	u32 val_tmp = 0;
 
-	ctx = platform_get_drvdata(hlpe_pdev);
-
 	val_tmp = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
 	val_tmp &= ~mask;
 	val_tmp |= (val & mask);
@@ -152,7 +138,7 @@ int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask)
 	}
 
 	iowrite32(val_tmp, ctx->mmio_start + ctx->had_config_offset + reg);
-	dev_dbg(&hlpe_pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__,
+	dev_dbg(&pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__,
 				reg, val_tmp);
 
 	return 0;
@@ -162,15 +148,14 @@ int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask)
  * used to return the HDMI audio capabilities.
  * e.g. resolution, frame rate.
  */
-int mid_hdmi_audio_get_caps(enum had_caps_list get_element,
+int mid_hdmi_audio_get_caps(struct platform_device *pdev,
+			    enum had_caps_list get_element,
 			    void *capabilities)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 	int ret = 0;
 
-	ctx = get_hdmi_context();
-
-	dev_dbg(&hlpe_pdev->dev, "%s: Enter\n", __func__);
+	dev_dbg(&pdev->dev, "%s: Enter\n", __func__);
 
 	switch (get_element) {
 	case HAD_GET_ELD:
@@ -179,18 +164,18 @@ int mid_hdmi_audio_get_caps(enum had_caps_list get_element,
 	case HAD_GET_DISPLAY_RATE:
 		/* ToDo: Verify if sampling freq logic is correct */
 		*(u32 *)capabilities = ctx->tmds_clock_speed;
-		dev_dbg(&hlpe_pdev->dev, "%s: tmds_clock_speed = 0x%x\n",
+		dev_dbg(&pdev->dev, "%s: tmds_clock_speed = 0x%x\n",
 			__func__, ctx->tmds_clock_speed);
 		break;
 	case HAD_GET_LINK_RATE:
 		/* ToDo: Verify if sampling freq logic is correct */
 		*(u32 *)capabilities = ctx->link_rate;
-		dev_dbg(&hlpe_pdev->dev, "%s: link rate = 0x%x\n",
+		dev_dbg(&pdev->dev, "%s: link rate = 0x%x\n",
 			__func__, ctx->link_rate);
 		break;
 	case HAD_GET_DP_OUTPUT:
 		*(u32 *)capabilities = ctx->dp_output;
-		dev_dbg(&hlpe_pdev->dev, "%s: dp_output = %d\n",
+		dev_dbg(&pdev->dev, "%s: dp_output = %d\n",
 			__func__, ctx->dp_output);
 		break;
 	default:
@@ -204,25 +189,25 @@ int mid_hdmi_audio_get_caps(enum had_caps_list get_element,
  * used to set the HDMI audio capabilities.
  * e.g. Audio INT.
  */
-int mid_hdmi_audio_set_caps(enum had_caps_list set_element,
+int mid_hdmi_audio_set_caps(struct platform_device *pdev,
+			    enum had_caps_list set_element,
 			    void *capabilties)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-
-	dev_dbg(&hlpe_pdev->dev, "%s: cap_id = 0x%x\n", __func__, set_element);
+	dev_dbg(&pdev->dev, "%s: cap_id = 0x%x\n", __func__, set_element);
 
 	switch (set_element) {
 	case HAD_SET_ENABLE_AUDIO_INT:
 		{
 			u32 status_reg;
 
-			mid_hdmi_audio_read(AUD_HDMI_STATUS_v2, &status_reg);
+			mid_hdmi_audio_read(pdev, AUD_HDMI_STATUS_v2,
+					    &status_reg);
 			status_reg |=
 				HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
-			mid_hdmi_audio_write(AUD_HDMI_STATUS_v2, status_reg);
-			mid_hdmi_audio_read(AUD_HDMI_STATUS_v2, &status_reg);
+			mid_hdmi_audio_write(pdev, AUD_HDMI_STATUS_v2,
+					     status_reg);
+			mid_hdmi_audio_read(pdev, AUD_HDMI_STATUS_v2,
+					    &status_reg);
 		}
 		break;
 	default:
@@ -234,31 +219,34 @@ int mid_hdmi_audio_set_caps(enum had_caps_list set_element,
 
 static void _had_wq(struct work_struct *work)
 {
-	mid_hdmi_audio_signal_event(HAD_EVENT_HOT_PLUG);
+	struct hdmi_lpe_audio_ctx *ctx =
+		container_of(work, struct hdmi_lpe_audio_ctx, hdmi_audio_wq);
+
+	mid_hdmi_audio_signal_event(ctx->pdev, HAD_EVENT_HOT_PLUG);
 }
 
 static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 {
+	struct platform_device *pdev = dev_id;
 	u32 audio_stat, audio_reg;
-
 	struct hdmi_lpe_audio_ctx *ctx;
 
-	dev_dbg(&hlpe_pdev->dev, "%s: Enter\n", __func__);
+	dev_dbg(&pdev->dev, "%s: Enter\n", __func__);
 
-	ctx = platform_get_drvdata(hlpe_pdev);
+	ctx = platform_get_drvdata(pdev);
 
 	audio_reg = AUD_HDMI_STATUS_v2;
-	mid_hdmi_audio_read(audio_reg, &audio_stat);
+	mid_hdmi_audio_read(pdev, audio_reg, &audio_stat);
 
 	if (audio_stat & HDMI_AUDIO_UNDERRUN) {
-		mid_hdmi_audio_write(audio_reg, HDMI_AUDIO_UNDERRUN);
-		mid_hdmi_audio_signal_event(
+		mid_hdmi_audio_write(pdev, audio_reg, HDMI_AUDIO_UNDERRUN);
+		mid_hdmi_audio_signal_event(pdev,
 				HAD_EVENT_AUDIO_BUFFER_UNDERRUN);
 	}
 
 	if (audio_stat & HDMI_AUDIO_BUFFER_DONE) {
-		mid_hdmi_audio_write(audio_reg, HDMI_AUDIO_BUFFER_DONE);
-		mid_hdmi_audio_signal_event(
+		mid_hdmi_audio_write(pdev, audio_reg, HDMI_AUDIO_BUFFER_DONE);
+		mid_hdmi_audio_signal_event(pdev,
 				HAD_EVENT_AUDIO_BUFFER_DONE);
 	}
 
@@ -280,7 +268,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 			hlpe_state =
 				hdmi_connector_status_disconnected;
 
-			mid_hdmi_audio_signal_event(
+			mid_hdmi_audio_signal_event(pdev,
 				HAD_EVENT_HOT_UNPLUG);
 		} else
 			dev_dbg(&pdev->dev, "%s: Already Unplugged!\n",
@@ -307,7 +295,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 
 		hdmi_set_eld(eld->eld_data);
 
-		mid_hdmi_audio_signal_event(HAD_EVENT_HOT_PLUG);
+		mid_hdmi_audio_signal_event(pdev, HAD_EVENT_HOT_PLUG);
 
 		hlpe_state = hdmi_connector_status_connected;
 
@@ -318,7 +306,8 @@ static void notify_audio_lpe(struct platform_device *pdev)
 			ctx->tmds_clock_speed = pdata->tmds_clock_speed;
 			ctx->dp_output = pdata->dp_output;
 			ctx->link_rate = pdata->link_rate;
-			mid_hdmi_audio_signal_event(HAD_EVENT_MODE_CHANGING);
+			mid_hdmi_audio_signal_event(pdev,
+						    HAD_EVENT_MODE_CHANGING);
 		}
 	}
 }
@@ -347,33 +336,32 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		{}
 	};
 
-	dev_dbg(&hlpe_pdev->dev, "Enter %s\n", __func__);
+	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
 
 	/*TBD:remove globals*/
-	hlpe_pdev = pdev;
 	hlpe_state = hdmi_connector_status_disconnected;
 
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&hlpe_pdev->dev, "Could not get irq resource\n");
+		dev_err(&pdev->dev, "Could not get irq resource\n");
 		return -ENODEV;
 	}
 
 	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_mmio) {
-		dev_err(&hlpe_pdev->dev, "Could not get IO_MEM resources\n");
+		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
 		return -ENXIO;
 	}
 
-	dev_dbg(&hlpe_pdev->dev, "%s: mmio_start = 0x%x, mmio_end = 0x%x\n",
+	dev_dbg(&pdev->dev, "%s: mmio_start = 0x%x, mmio_end = 0x%x\n",
 		__func__, (unsigned int)res_mmio->start,
 		(unsigned int)res_mmio->end);
 
 	mmio_start = ioremap_nocache(res_mmio->start,
 				     (size_t)(resource_size(res_mmio)));
 	if (!mmio_start) {
-		dev_err(&hlpe_pdev->dev, "Could not get ioremap\n");
+		dev_err(&pdev->dev, "Could not get ioremap\n");
 		return -EACCES;
 	}
 
@@ -384,17 +372,18 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		goto error_ctx;
 	}
 
+	ctx->pdev = pdev;
 	ctx->irq = irq;
-	dev_dbg(&hlpe_pdev->dev, "hdmi lpe audio: irq num = %d\n", irq);
+	dev_dbg(&pdev->dev, "hdmi lpe audio: irq num = %d\n", irq);
 	ctx->mmio_start = mmio_start;
 	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
 	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
 
 	if (pci_dev_present(cherryview_ids))
-		dev_dbg(&hlpe_pdev->dev, "%s: Cherrytrail LPE - Detected\n",
+		dev_dbg(&pdev->dev, "%s: Cherrytrail LPE - Detected\n",
 				__func__);
 	else
-		dev_dbg(&hlpe_pdev->dev, "%s: Baytrail LPE - Assume\n",
+		dev_dbg(&pdev->dev, "%s: Baytrail LPE - Assume\n",
 				__func__);
 
 	/* assume pipe A as default */
@@ -403,7 +392,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	pdata = pdev->dev.platform_data;
 
 	if (pdata == NULL) {
-		dev_err(&hlpe_pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
+		dev_err(&pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
 		ret = -ENOMEM;
 		goto error_irq;
 	}
@@ -411,12 +400,11 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	/* setup interrupt handler */
-	ret = request_irq(irq, display_pipe_interrupt_handler,
-			0,
-			pdev->name,
-			NULL);
+	ret = request_irq(irq, display_pipe_interrupt_handler, 0,
+			  pdev->name, pdev);
+
 	if (ret < 0) {
-		dev_err(&hlpe_pdev->dev, "request_irq failed\n");
+		dev_err(&pdev->dev, "request_irq failed\n");
 		goto error_irq;
 	}
 
@@ -424,12 +412,12 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error_probe;
 
-	dev_dbg(&hlpe_pdev->dev, "hdmi lpe audio: setting pin eld notify callback\n");
+	dev_dbg(&pdev->dev, "hdmi lpe audio: setting pin eld notify callback\n");
 
 	/* The Audio driver is loading now and we need to notify
 	 * it if there is an HDMI device attached
 	 */
-	dev_dbg(&hlpe_pdev->dev, "%s: Scheduling HDMI audio work queue\n",
+	dev_dbg(&pdev->dev, "%s: Scheduling HDMI audio work queue\n",
 				__func__);
 	schedule_work(&ctx->hdmi_audio_wq);
 
@@ -437,7 +425,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	pdata->notify_audio_lpe = notify_audio_lpe;
 	if (pdata->notify_pending) {
 
-		dev_dbg(&hlpe_pdev->dev, "%s: handle pending notification\n", __func__);
+		dev_dbg(&pdev->dev, "%s: handle pending notification\n", __func__);
 		notify_audio_lpe(pdev);
 		pdata->notify_pending = false;
 	}
@@ -446,7 +434,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	return ret;
 
  error_probe:
-	free_irq(irq, NULL);
+	free_irq(irq, pdev);
  error_irq:
 	kfree(ctx);
  error_ctx:
@@ -464,13 +452,13 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 {
 	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
-	dev_dbg(&hlpe_pdev->dev, "Enter %s\n", __func__);
+	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
 
 	hdmi_audio_remove(ctx->had);
 
 	/* release resources */
 	iounmap(ctx->mmio_start);
-	free_irq(ctx->irq, NULL);
+	free_irq(ctx->irq, pdev);
 	kfree(ctx);
 	return 0;
 }
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index a1c3aa0fbc57..a9d51b7c5bae 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -31,6 +31,8 @@
 #include <sound/control.h>
 #include <sound/pcm.h>
 
+struct platform_device;
+
 #define AUD_CONFIG_VALID_BIT			(1<<9)
 #define AUD_CONFIG_DP_MODE			(1<<15)
 #define AUD_CONFIG_BLOCK_BIT			(1<<7)
@@ -642,15 +644,16 @@ struct hdmi_audio_event {
 	int type;
 };
 
-void mid_hdmi_audio_signal_event(enum had_event_type event);
-
-int mid_hdmi_audio_read(u32 reg, u32 *val);
-int mid_hdmi_audio_write(u32 reg, u32 val);
-int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask);
+int mid_hdmi_audio_read(struct platform_device *pdev, u32 reg, u32 *val);
+int mid_hdmi_audio_write(struct platform_device *pdev, u32 reg, u32 val);
+int mid_hdmi_audio_rmw(struct platform_device *pdev,
+		       u32 reg, u32 val, u32 mask);
 
-int mid_hdmi_audio_get_caps(enum had_caps_list get_element,
+int mid_hdmi_audio_get_caps(struct platform_device *pdev,
+			    enum had_caps_list get_element,
 			    void *capabilities);
-int mid_hdmi_audio_set_caps(enum had_caps_list set_element,
+int mid_hdmi_audio_set_caps(struct platform_device *pdev,
+			    enum had_caps_list set_element,
 			    void *capabilties);
 
 #endif
-- 
2.11.0
