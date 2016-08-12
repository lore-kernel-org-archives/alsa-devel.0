From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Skylake: Remove dfw config
	and associated structures
Date: Fri, 12 Aug 2016 12:29:52 +0530
Message-ID: <1470985193-10680-4-git-send-email-vinod.koul@intel.com>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 88DBC266F55
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 08:52:18 +0200 (CEST)
In-Reply-To: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

The skl_dfw_config structure is no longer required as the module
config is populated by parsing and reading the token values.

So, remove the structure.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-utils.c      |  5 --
 sound/soc/intel/skylake/skl-tplg-interface.h | 73 ----------------------------
 2 files changed, 78 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 0f990ebbe620..3a508b7a0041 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -28,11 +28,6 @@
 /* FW Extended Manifest Header id = $AE1 */
 #define SKL_EXT_MANIFEST_HEADER_MAGIC   0x31454124
 
-struct skl_dfw_module_mod {
-	char name[100];
-	struct skl_dfw_module skl_dfw_mod;
-};
-
 struct UUID {
 	u8 id[16];
 };
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 281762eca0ab..e208724f9db3 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -148,79 +148,6 @@ enum skl_module_param_type {
 	SKL_PARAM_BIND
 };
 
-struct skl_dfw_module_pin {
-	u16 module_id;
-	u16 instance_id;
-} __packed;
-
-struct skl_dfw_module_fmt {
-	u32 channels;
-	u32 freq;
-	u32 bit_depth;
-	u32 valid_bit_depth;
-	u32 ch_cfg;
-	u32 interleaving_style;
-	u32 sample_type;
-	u32 ch_map;
-} __packed;
-
-struct skl_dfw_module_caps {
-	u32 set_params:2;
-	u32 rsvd:30;
-	u32 param_id;
-	u32 caps_size;
-	u32 caps[HDA_SST_CFG_MAX];
-};
-
-struct skl_dfw_pipe {
-	u8 pipe_id;
-	u8 pipe_priority;
-	u16 conn_type:4;
-	u16 rsvd:4;
-	u16 memory_pages:8;
-} __packed;
-
-struct skl_dfw_module {
-	u8 uuid[16];
-
-	u16 module_id;
-	u16 instance_id;
-	u32 max_mcps;
-	u32 mem_pages;
-	u32 obs;
-	u32 ibs;
-	u32 vbus_id;
-
-	u32 max_in_queue:8;
-	u32 max_out_queue:8;
-	u32 time_slot:8;
-	u32 core_id:4;
-	u32 rsvd1:4;
-
-	u32 module_type:8;
-	u32 conn_type:4;
-	u32 dev_type:4;
-	u32 hw_conn_type:4;
-	u32 rsvd2:12;
-
-	u32 params_fixup:8;
-	u32 converter:8;
-	u32 input_pin_type:1;
-	u32 output_pin_type:1;
-	u32 is_dynamic_in_pin:1;
-	u32 is_dynamic_out_pin:1;
-	u32 is_loadable:1;
-	u32 proc_domain:1;
-	u32 rsvd3:10;
-
-	struct skl_dfw_pipe pipe;
-	struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
-	struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
-	struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
-	struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
-	struct skl_dfw_module_caps caps;
-} __packed;
-
 struct skl_dfw_algo_data {
 	u32 set_params:2;
 	u32 rsvd:30;
-- 
1.9.1
