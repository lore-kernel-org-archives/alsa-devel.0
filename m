From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Add IPC to configure the
	copier secondary pins
Date: Fri,  1 Sep 2017 13:36:13 +0530
Message-ID: <1504253173-16647-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CFD4C266B70
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 10:07:02 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com, Pradeep Tewani <pradeep.d.tewani@intel.com>
List-Id: alsa-devel@alsa-project.org

Copier can support upto 4 output pins. However, only pin 0 is configured
as a part of copier initialization. Configuring rest of pins require the
separate IPC to be sent to fw.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 53 ++++++++++++++++++++++++++++++----
 sound/soc/intel/skylake/skl-topology.h |  5 ++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ea83e8b..89f7013 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1083,6 +1083,21 @@ int skl_unbind_modules(struct skl_sst *ctx,
 	return ret;
 }
 
+static void fill_pin_params(struct skl_audio_data_format *pin_fmt,
+				struct skl_module_fmt *format)
+{
+	pin_fmt->number_of_channels = format->channels;
+	pin_fmt->s_freq = format->s_freq;
+	pin_fmt->bit_depth = format->bit_depth;
+	pin_fmt->valid_bit_depth = format->valid_bit_depth;
+	pin_fmt->ch_cfg = format->ch_cfg;
+	pin_fmt->sample_type = format->sample_type;
+	pin_fmt->channel_map = format->ch_map;
+	pin_fmt->interleaving = format->interleaving_style;
+}
+
+#define CPR_SINK_FMT_PARAM_ID 2
+
 /*
  * Once a module is instantiated it need to be 'bind' with other modules in
  * the pipeline. For binding we need to find the module pins which are bind
@@ -1094,11 +1109,15 @@ int skl_bind_modules(struct skl_sst *ctx,
 			struct skl_module_cfg *src_mcfg,
 			struct skl_module_cfg *dst_mcfg)
 {
-	int ret;
+	int ret = 0;
 	struct skl_ipc_bind_unbind_msg msg;
 	int in_max = dst_mcfg->module->max_input_pins;
 	int out_max = src_mcfg->module->max_output_pins;
 	int src_index, dst_index;
+	struct skl_module_fmt *format;
+	struct skl_cpr_pin_fmt pin_fmt;
+	struct skl_module *module;
+	struct skl_module_iface *fmt;
 
 	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
 
@@ -1117,6 +1136,29 @@ int skl_bind_modules(struct skl_sst *ctx,
 		return -EINVAL;
 	}
 
+	/*
+	 * Copier module requires the separate large_config_set_ipc to
+	 * configure the pins other than 0
+	 */
+	if (src_mcfg->m_type == SKL_MODULE_TYPE_COPIER && src_index > 0) {
+		pin_fmt.sink_id = src_index;
+		module = src_mcfg->module;
+		fmt = &module->formats[src_mcfg->fmt_idx];
+
+		/* Input fmt is same as that of src module input cfg */
+		format = &fmt->inputs[0].fmt;
+		fill_pin_params(&(pin_fmt.src_fmt), format);
+
+		format = &fmt->outputs[src_index].fmt;
+		fill_pin_params(&(pin_fmt.dst_fmt), format);
+		ret = skl_set_module_params(ctx, (void *)&pin_fmt,
+					sizeof(struct skl_cpr_pin_fmt),
+					CPR_SINK_FMT_PARAM_ID, src_mcfg);
+
+		if (ret < 0)
+			goto out;
+	}
+
 	msg.dst_queue = dst_index;
 
 	dev_dbg(ctx->dev, "src queue = %d dst queue =%d\n",
@@ -1134,11 +1176,12 @@ int skl_bind_modules(struct skl_sst *ctx,
 		src_mcfg->m_state = SKL_MODULE_BIND_DONE;
 		src_mcfg->m_out_pin[src_index].pin_state = SKL_PIN_BIND_DONE;
 		dst_mcfg->m_in_pin[dst_index].pin_state = SKL_PIN_BIND_DONE;
-	} else {
-		/* error case , if IPC fails, clear the queue index */
-		skl_free_queue(src_mcfg->m_out_pin, src_index);
-		skl_free_queue(dst_mcfg->m_in_pin, dst_index);
+		return ret;
 	}
+out:
+	/* error case , if IPC fails, clear the queue index */
+	skl_free_queue(src_mcfg->m_out_pin, src_index);
+	skl_free_queue(dst_mcfg->m_in_pin, dst_index);
 
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 4975904..2717db92 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -138,6 +138,11 @@ struct skl_cpr_cfg {
 	struct skl_cpr_gtw_cfg gtw_cfg;
 } __packed;
 
+struct skl_cpr_pin_fmt {
+	u32 sink_id;
+	struct skl_audio_data_format src_fmt;
+	struct skl_audio_data_format dst_fmt;
+} __packed;
 
 struct skl_src_module_cfg {
 	struct skl_base_cfg base_cfg;
-- 
2.7.4
