From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/53] ALSA: x86: Replace indirect register ops
	with direct calls
Date: Thu,  2 Feb 2017 18:02:18 +0100
Message-ID: <20170202170307.24484-6-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8947226688A
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

Now about the indirect register ops: they are replaced with direct
calls, too.

The read / write / modify ops are simply replaced with the
corresponding functions.  The difference is that we calculate the
offset inside the function now.  So all the had_config_offset
references in the caller side are dropped.  This also simplifies the
DP-audio check in hdmi_audio_write() and hdmi_audio_rmw().

The hdmi_audio_get_register_base is dropped since it's no longer used
when the base address and config offset are referred in the read/write
functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 11 ++---
 sound/x86/intel_hdmi_audio.h     |  2 -
 sound/x86/intel_hdmi_audio_if.c  | 21 ----------
 sound/x86/intel_hdmi_lpe_audio.c | 91 ++++++++++------------------------------
 sound/x86/intel_hdmi_lpe_audio.h | 14 ++-----
 5 files changed, 30 insertions(+), 109 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 84ce4e09ada5..d101a27e4a27 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -205,8 +205,7 @@ int had_read_register(u32 offset, u32 *data)
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = intelhaddata->reg_ops.hdmi_audio_read_register(
-				offset + intelhaddata->audio_cfg_offset, data);
+		retval = mid_hdmi_audio_read(offset, data);
 
 	return retval;
 }
@@ -218,8 +217,7 @@ int had_write_register(u32 offset, u32 data)
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = intelhaddata->reg_ops.hdmi_audio_write_register(
-				offset + intelhaddata->audio_cfg_offset, data);
+		retval = mid_hdmi_audio_write(offset, data);
 
 	return retval;
 }
@@ -231,9 +229,7 @@ int had_read_modify(u32 offset, u32 data, u32 mask)
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = intelhaddata->reg_ops.hdmi_audio_read_modify(
-				offset + intelhaddata->audio_cfg_offset,
-				data, mask);
+		retval = mid_hdmi_audio_rmw(offset, data, mask);
 
 	return retval;
 }
@@ -1622,7 +1618,6 @@ int hdmi_audio_probe(void *deviceptr)
 
 	retval = mid_hdmi_audio_setup(
 			ops_cb.intel_had_event_call_back,
-			&(intelhaddata->reg_ops),
 			&(intelhaddata->query_ops));
 	if (retval) {
 		pr_err("querying display driver APIs failed %#x\n", retval);
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 394959f0bd2e..5ba06042f669 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -107,7 +107,6 @@ struct had_callback_ops {
  * @card: ptr to hold card details
  * @card_index: sound card index
  * @card_id: detected sound card id
- * @reg_ops: register operations to program registers
  * @query_ops: caps call backs for get/set operations
  * @drv_status: driver status
  * @buf_info: ring buffer info
@@ -128,7 +127,6 @@ struct snd_intelhad {
 	struct snd_card	*card;
 	int		card_index;
 	char		*card_id;
-	struct hdmi_audio_registers_ops	reg_ops;
 	struct hdmi_audio_query_set_ops	query_ops;
 	enum had_drv_status	drv_status;
 	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index d92fe48d916b..4334be100655 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -392,22 +392,6 @@ int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 
 	pr_debug("Processing HOT_PLUG, buf_id = %d\n", buf_id);
 
-	 /* Query display driver for audio register base */
-	if (intelhaddata->reg_ops.hdmi_audio_get_register_base(
-		&intelhaddata->audio_reg_base,
-		&intelhaddata->audio_cfg_offset)) {
-		pr_err("Unable to get audio reg base from Display driver\n");
-		goto err;
-	}
-
-	if (intelhaddata->audio_reg_base == NULL) {
-		pr_err("audio reg base value is NULL\n");
-		goto err;
-	}
-
-	pr_debug("%s audio_reg_base = 0x%p\n", __func__,
-			intelhaddata->audio_reg_base);
-
 	/* Safety check */
 	if (substream) {
 		pr_debug("There should not be active PB from ALSA\n");
@@ -420,11 +404,6 @@ int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	had_build_channel_allocation_map(intelhaddata);
 
 	return 0;
-
-err:
-	pm_runtime_disable(intelhaddata->dev);
-	intelhaddata->dev = NULL;
-	return 0;
 }
 
 int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 3cb0f642575c..a7a07bfe52ed 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -178,10 +178,10 @@ void mid_hdmi_audio_signal_event(enum had_event_type event)
 			ctx->had_pvt_data);
 }
 
-/**
+/*
  * used to write into display controller HDMI audio registers.
  */
-static int hdmi_audio_write(u32 reg, u32 val)
+int mid_hdmi_audio_write(u32 reg, u32 val)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 
@@ -190,58 +190,49 @@ static int hdmi_audio_write(u32 reg, u32 val)
 	dev_dbg(&hlpe_pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, val);
 
 	if (ctx->dp_output) {
-		if ((reg == AUDIO_HDMI_CONFIG_A) ||
-		    (reg == AUDIO_HDMI_CONFIG_B) ||
-		    (reg == AUDIO_HDMI_CONFIG_C)) {
-			if (val & AUD_CONFIG_VALID_BIT)
-				val = val | AUD_CONFIG_DP_MODE |
-					AUD_CONFIG_BLOCK_BIT;
-		}
+		if (reg == AUD_CONFIG && (val & AUD_CONFIG_VALID_BIT))
+			val |= AUD_CONFIG_DP_MODE | AUD_CONFIG_BLOCK_BIT;
 	}
-	iowrite32(val, (ctx->mmio_start+reg));
+	iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
 
 	return 0;
 }
 
-/**
+/*
  * used to get the register value read from
  * display controller HDMI audio registers.
  */
-static int hdmi_audio_read(u32 reg, u32 *val)
+int mid_hdmi_audio_read(u32 reg, u32 *val)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 
 	ctx = platform_get_drvdata(hlpe_pdev);
-	*val = ioread32(ctx->mmio_start+reg);
+	*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
 	dev_dbg(&hlpe_pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, *val);
 	return 0;
 }
 
-/**
+/*
  * used to update the masked bits in display controller HDMI
  * audio registers.
  */
-static int hdmi_audio_rmw(u32 reg, u32 val, u32 mask)
+int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 	u32 val_tmp = 0;
 
 	ctx = platform_get_drvdata(hlpe_pdev);
 
-	val_tmp = (val & mask) |
-			((ioread32(ctx->mmio_start + reg)) & ~mask);
+	val_tmp = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
+	val_tmp &= ~mask;
+	val_tmp |= (val & mask);
 
 	if (ctx->dp_output) {
-		if ((reg == AUDIO_HDMI_CONFIG_A) ||
-		    (reg == AUDIO_HDMI_CONFIG_B) ||
-		    (reg == AUDIO_HDMI_CONFIG_C)) {
-			if (val_tmp & AUD_CONFIG_VALID_BIT)
-				val_tmp = val_tmp | AUD_CONFIG_DP_MODE |
-					AUD_CONFIG_BLOCK_BIT;
-		}
+		if (reg == AUD_CONFIG && (val_tmp & AUD_CONFIG_VALID_BIT))
+			val_tmp |= AUD_CONFIG_DP_MODE | AUD_CONFIG_BLOCK_BIT;
 	}
 
-	iowrite32(val_tmp, (ctx->mmio_start+reg));
+	iowrite32(val_tmp, ctx->mmio_start + ctx->had_config_offset + reg);
 	dev_dbg(&hlpe_pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__,
 				reg, val_tmp);
 
@@ -291,22 +282,6 @@ static int hdmi_audio_get_caps(enum had_caps_list get_element,
 }
 
 /**
- * used to get the current hdmi base address
- */
-int hdmi_audio_get_register_base(u32 **reg_base,
-		u32 *config_offset)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-	*reg_base = (u32 *)(ctx->mmio_start);
-	*config_offset = ctx->had_config_offset;
-	dev_dbg(&hlpe_pdev->dev, "%s: reg_base = 0x%p, cfg_off = 0x%x\n",
-				__func__, *reg_base, *config_offset);
-	return 0;
-}
-
-/**
  * used to set the HDMI audio capabilities.
  * e.g. Audio INT.
  */
@@ -324,15 +299,11 @@ int hdmi_audio_set_caps(enum had_caps_list set_element,
 		{
 			u32 status_reg;
 
-			hdmi_audio_read(AUD_HDMI_STATUS_v2 +
-				ctx->had_config_offset, &status_reg);
+			mid_hdmi_audio_read(AUD_HDMI_STATUS_v2, &status_reg);
 			status_reg |=
 				HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
-			hdmi_audio_write(AUD_HDMI_STATUS_v2 +
-				ctx->had_config_offset, status_reg);
-			hdmi_audio_read(AUD_HDMI_STATUS_v2 +
-				ctx->had_config_offset, &status_reg);
-
+			mid_hdmi_audio_write(AUD_HDMI_STATUS_v2, status_reg);
+			mid_hdmi_audio_read(AUD_HDMI_STATUS_v2, &status_reg);
 		}
 		break;
 	default:
@@ -342,13 +313,6 @@ int hdmi_audio_set_caps(enum had_caps_list set_element,
 	return 0;
 }
 
-static struct  hdmi_audio_registers_ops hdmi_audio_reg_ops = {
-	.hdmi_audio_get_register_base = hdmi_audio_get_register_base,
-	.hdmi_audio_read_register = hdmi_audio_read,
-	.hdmi_audio_write_register = hdmi_audio_write,
-	.hdmi_audio_read_modify = hdmi_audio_rmw,
-};
-
 static struct hdmi_audio_query_set_ops hdmi_audio_get_set_ops = {
 	.hdmi_audio_get_caps = hdmi_audio_get_caps,
 	.hdmi_audio_set_caps = hdmi_audio_set_caps,
@@ -356,7 +320,6 @@ static struct hdmi_audio_query_set_ops hdmi_audio_get_set_ops = {
 
 int mid_hdmi_audio_setup(
 		had_event_call_back audio_callbacks,
-		struct hdmi_audio_registers_ops *reg_ops,
 		struct hdmi_audio_query_set_ops *query_ops)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
@@ -365,14 +328,6 @@ int mid_hdmi_audio_setup(
 
 	dev_dbg(&hlpe_pdev->dev, "%s: called\n",  __func__);
 
-	reg_ops->hdmi_audio_get_register_base =
-		(hdmi_audio_reg_ops.hdmi_audio_get_register_base);
-	reg_ops->hdmi_audio_read_register =
-		(hdmi_audio_reg_ops.hdmi_audio_read_register);
-	reg_ops->hdmi_audio_write_register =
-		(hdmi_audio_reg_ops.hdmi_audio_write_register);
-	reg_ops->hdmi_audio_read_modify =
-		(hdmi_audio_reg_ops.hdmi_audio_read_modify);
 	query_ops->hdmi_audio_get_caps =
 		hdmi_audio_get_set_ops.hdmi_audio_get_caps;
 	query_ops->hdmi_audio_set_caps =
@@ -421,17 +376,17 @@ static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 
 	ctx = platform_get_drvdata(hlpe_pdev);
 
-	audio_reg = ctx->had_config_offset + AUD_HDMI_STATUS_v2;
-	hdmi_audio_read(audio_reg, &audio_stat);
+	audio_reg = AUD_HDMI_STATUS_v2;
+	mid_hdmi_audio_read(audio_reg, &audio_stat);
 
 	if (audio_stat & HDMI_AUDIO_UNDERRUN) {
-		hdmi_audio_write(audio_reg, HDMI_AUDIO_UNDERRUN);
+		mid_hdmi_audio_write(audio_reg, HDMI_AUDIO_UNDERRUN);
 		mid_hdmi_audio_signal_event(
 				HAD_EVENT_AUDIO_BUFFER_UNDERRUN);
 	}
 
 	if (audio_stat & HDMI_AUDIO_BUFFER_DONE) {
-		hdmi_audio_write(audio_reg, HDMI_AUDIO_BUFFER_DONE);
+		mid_hdmi_audio_write(audio_reg, HDMI_AUDIO_BUFFER_DONE);
 		mid_hdmi_audio_signal_event(
 				HAD_EVENT_AUDIO_BUFFER_DONE);
 	}
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 5d94aaf0b980..ea90cf919948 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -641,15 +641,6 @@ enum had_event_type {
 typedef int (*had_event_call_back) (enum had_event_type event_type,
 		void *ctxt_info);
 
-struct hdmi_audio_registers_ops {
-	int (*hdmi_audio_get_register_base)(u32 **reg_base,
-			u32 *config_offset);
-	int (*hdmi_audio_read_register)(u32 reg_addr, u32 *data);
-	int (*hdmi_audio_write_register)(u32 reg_addr, u32 data);
-	int (*hdmi_audio_read_modify)(u32 reg_addr, u32 data,
-			u32 mask);
-};
-
 struct hdmi_audio_query_set_ops {
 	int (*hdmi_audio_get_caps)(enum had_caps_list query_element,
 			void *capabilties);
@@ -674,10 +665,13 @@ void mid_hdmi_audio_resume(void *dev);
 void mid_hdmi_audio_signal_event(enum had_event_type event);
 int mid_hdmi_audio_setup(
 	had_event_call_back audio_callbacks,
-	struct hdmi_audio_registers_ops *reg_ops,
 	struct hdmi_audio_query_set_ops *query_ops);
 int mid_hdmi_audio_register(
 	struct snd_intel_had_interface *driver,
 	void *had_data);
 
+int mid_hdmi_audio_read(u32 reg, u32 *val);
+int mid_hdmi_audio_write(u32 reg, u32 val);
+int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask);
+
 #endif
-- 
2.11.0
