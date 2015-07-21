From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/6] ASoC: Intel: Skylake: Add helpers for SRC
	and converter modules
Date: Tue, 21 Jul 2015 23:53:58 +0530
Message-ID: <1437503040-7392-5-git-send-email-vinod.koul@intel.com>
References: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 43AAB265056
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 20:22:22 +0200 (CEST)
In-Reply-To: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Hardik T Shah <hardik.t.shah@intel.com>

SRC and converter modules module configuration helpers and format
calculation for these modules and added here

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 45 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h | 16 ++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 766729451fe3..faa0e71d4ae5 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -369,6 +369,37 @@ static void skl_setup_out_format(struct skl_sst *ctx,
 		out_fmt->number_of_channels, format->s_freq, format->bit_depth);
 }
 
+static void skl_set_src_format(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig,
+			struct skl_src_module_cfg *src_mconfig)
+{
+	struct skl_module_fmt *fmt = &mconfig->out_fmt;
+
+	skl_set_base_module_format(ctx, mconfig,
+		(struct skl_base_cfg *)src_mconfig);
+
+	src_mconfig->src_cfg = fmt->s_freq;
+}
+
+static void skl_set_updown_mixer_format(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig,
+			struct skl_up_down_mixer_cfg *mixer_mconfig)
+{
+	struct skl_module_fmt *fmt = &mconfig->out_fmt;
+	int i = 0;
+
+	skl_set_base_module_format(ctx,	mconfig,
+		(struct skl_base_cfg *)mixer_mconfig);
+	mixer_mconfig->out_ch_cfg = fmt->ch_cfg;
+
+	/* Select F/W default coefficient */
+	mixer_mconfig->coeff_sel = 0x0;
+
+	/* User coeff, don't care since we are selecting F/W defaults */
+	for (i = 0; i < UP_DOWN_MIXER_MAX_COEFF; i++)
+		mixer_mconfig->coeff[i] = 0xDEADBEEF;
+}
+
 /*
  * copier_module_config is sent as input buffer with INIT_INSTANCE IPC msg
  */
@@ -396,6 +427,12 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
 		param_size += mconfig->formats_config.caps_size;
 		return param_size;
 
+	case SKL_MODULE_TYPE_SRCINT:
+		return sizeof(struct skl_src_module_cfg);
+
+	case SKL_MODULE_TYPE_UPDWMIX:
+		return sizeof(struct skl_up_down_mixer_cfg);
+
 	default:
 		/*
 		 * return only base cfg when no specific module type is
@@ -427,6 +464,14 @@ static int skl_set_module_format(struct skl_sst *ctx,
 		skl_set_copier_format(ctx, module_config, *param_data);
 		break;
 
+	case SKL_MODULE_TYPE_SRCINT:
+		skl_set_src_format(ctx, module_config, *param_data);
+		break;
+
+	case SKL_MODULE_TYPE_UPDWMIX:
+		skl_set_updown_mixer_format(ctx, module_config, *param_data);
+		break;
+
 	default:
 		skl_set_base_module_format(ctx, module_config, *param_data);
 	}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 6ba137a43e68..e4b2a339b2f4 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -123,6 +123,21 @@ struct skl_cpr_cfg {
 	struct skl_cpr_gtw_cfg gtw_cfg;
 } __packed;
 
+
+struct skl_src_module_cfg {
+	struct skl_base_cfg base_cfg;
+	enum skl_s_freq src_cfg;
+} __packed;
+
+struct skl_up_down_mixer_cfg {
+	struct skl_base_cfg base_cfg;
+	enum skl_ch_cfg out_ch_cfg;
+	/* This should be set to 1 if user coefficients are required */
+	u32 coeff_sel;
+	/* Pass the user coeff in this array */
+	s32 coeff[UP_DOWN_MIXER_MAX_COEFF];
+} __packed;
+
 enum skl_dma_type {
 	SKL_DMA_HDA_HOST_OUTPUT_CLASS = 0,
 	SKL_DMA_HDA_HOST_INPUT_CLASS = 1,
@@ -247,5 +262,6 @@ struct skl_module_cfg {
 	struct skl_pipe *pipe;
 	struct skl_specific_cfg formats_config;
 };
+
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
1.9.1
