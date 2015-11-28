From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/16] ASoC: Intel: Skylake: Add helper routine
	to handle Algo parameter
Date: Sat, 28 Nov 2015 15:01:48 +0530
Message-ID: <1448703121-5831-4-git-send-email-vinod.koul@intel.com>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6085B26682F
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:32:43 +0100 (CET)
In-Reply-To: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Divya Prakash <divya1.prakash@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Some DSP modules has user configurable parameters, which are
required by some modules at module initialization.

To configure the module algorithm parameter during initialization
we add helpers here

Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c       | 31 ++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       |  5 +++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  3 ++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 30762734d859..7770a7e4162f 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -387,6 +387,28 @@ static void skl_set_copier_format(struct skl_sst *ctx,
 	skl_setup_cpr_gateway_cfg(ctx, mconfig, cpr_mconfig);
 }
 
+/*
+ * Algo module are DSP pre processing modules. Algo module take base module
+ * configuration and params
+ */
+
+static void skl_set_algo_format(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig,
+			struct skl_algo_cfg *algo_mcfg)
+{
+	struct skl_base_cfg *base_cfg = (struct skl_base_cfg *)algo_mcfg;
+
+	skl_set_base_module_format(ctx, mconfig, base_cfg);
+
+	if (mconfig->formats_config.caps_size == 0)
+		return;
+
+	memcpy(algo_mcfg->params,
+			mconfig->formats_config.caps,
+			mconfig->formats_config.caps_size);
+
+}
+
 static u16 skl_get_module_param_size(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig)
 {
@@ -404,6 +426,11 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
 	case SKL_MODULE_TYPE_UPDWMIX:
 		return sizeof(struct skl_up_down_mixer_cfg);
 
+	case SKL_MODULE_TYPE_ALGO:
+		param_size = sizeof(struct skl_base_cfg);
+		param_size += mconfig->formats_config.caps_size;
+		return param_size;
+
 	default:
 		/*
 		 * return only base cfg when no specific module type is
@@ -450,6 +477,10 @@ static int skl_set_module_format(struct skl_sst *ctx,
 		skl_set_updown_mixer_format(ctx, module_config, *param_data);
 		break;
 
+	case SKL_MODULE_TYPE_ALGO:
+		skl_set_algo_format(ctx, module_config, *param_data);
+		break;
+
 	default:
 		skl_set_base_module_format(ctx, module_config, *param_data);
 		break;
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 5ba985b36227..0a66fab59828 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -140,6 +140,11 @@ struct skl_up_down_mixer_cfg {
 	s32 coeff[UP_DOWN_MIXER_MAX_COEFF];
 } __packed;
 
+struct skl_algo_cfg {
+	struct skl_base_cfg  base_cfg;
+	char params[0];
+} __packed;
+
 enum skl_dma_type {
 	SKL_DMA_HDA_HOST_OUTPUT_CLASS = 0,
 	SKL_DMA_HDA_HOST_INPUT_CLASS = 1,
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 20c068754d08..63c83a3eeb7e 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -81,7 +81,8 @@ enum skl_module_type {
 	SKL_MODULE_TYPE_MIXER = 0,
 	SKL_MODULE_TYPE_COPIER,
 	SKL_MODULE_TYPE_UPDWMIX,
-	SKL_MODULE_TYPE_SRCINT
+	SKL_MODULE_TYPE_SRCINT,
+	SKL_MODULE_TYPE_ALGO
 };
 
 enum skl_core_affinity {
-- 
2.4.3
