From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 03/12] ASoC: Intel: Skylake: Add support for
	Mic Select module
Date: Thu,  3 Dec 2015 23:29:52 +0530
Message-ID: <1449165601-11226-4-git-send-email-vinod.koul@intel.com>
References: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DC7C3260525
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:12 +0100 (CET)
In-Reply-To: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Dharageswari R" <dharageswari.r@intel.com>

Mic select is a DSP module which is used to select one or many
inputs to form an output. This is useful to select data
selectively from PDM input and hence the name. This module is of
generic module type.

This patch adds support to add and configure Mic select module in
firmware topology.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c       | 26 ++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |  5 +++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  3 ++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 5297b345839a..a91161be7f5d 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -410,6 +410,25 @@ static void skl_set_algo_format(struct skl_sst *ctx,
 
 }
 
+/*
+ * Mic select module allows selecting one or many input channels, thus
+ * acting as a demux.
+ *
+ * Mic select module take base module configuration and out-format
+ * configuration
+ */
+static void skl_set_base_outfmt_format(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig,
+			struct skl_base_outfmt_cfg *base_outfmt_mcfg)
+{
+	struct skl_audio_data_format *out_fmt = &base_outfmt_mcfg->out_fmt;
+	struct skl_base_cfg *base_cfg =
+				(struct skl_base_cfg *)base_outfmt_mcfg;
+
+	skl_set_base_module_format(ctx, mconfig, base_cfg);
+	skl_setup_out_format(ctx, mconfig, out_fmt);
+}
+
 static u16 skl_get_module_param_size(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig)
 {
@@ -432,6 +451,9 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
 		param_size += mconfig->formats_config.caps_size;
 		return param_size;
 
+	case SKL_MODULE_TYPE_BASE_OUTFMT:
+		return sizeof(struct skl_base_outfmt_cfg);
+
 	default:
 		/*
 		 * return only base cfg when no specific module type is
@@ -482,6 +504,10 @@ static int skl_set_module_format(struct skl_sst *ctx,
 		skl_set_algo_format(ctx, module_config, *param_data);
 		break;
 
+	case SKL_MODULE_TYPE_BASE_OUTFMT:
+		skl_set_base_outfmt_format(ctx, module_config, *param_data);
+		break;
+
 	default:
 		skl_set_base_module_format(ctx, module_config, *param_data);
 		break;
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 04318e2091fd..349f2a3b6613 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -145,6 +145,11 @@ struct skl_algo_cfg {
 	char params[0];
 } __packed;
 
+struct skl_base_outfmt_cfg {
+	struct skl_base_cfg base_cfg;
+	struct skl_audio_data_format out_fmt;
+} __packed;
+
 enum skl_dma_type {
 	SKL_DMA_HDA_HOST_OUTPUT_CLASS = 0,
 	SKL_DMA_HDA_HOST_INPUT_CLASS = 1,
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 3f1908e3ae80..626b148317fe 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -79,7 +79,8 @@ enum skl_module_type {
 	SKL_MODULE_TYPE_COPIER,
 	SKL_MODULE_TYPE_UPDWMIX,
 	SKL_MODULE_TYPE_SRCINT,
-	SKL_MODULE_TYPE_ALGO
+	SKL_MODULE_TYPE_ALGO,
+	SKL_MODULE_TYPE_BASE_OUTFMT
 };
 
 enum skl_core_affinity {
-- 
1.9.1
