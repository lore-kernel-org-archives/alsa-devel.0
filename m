From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 13/17] ASoC: Intel: Skylake: Update the
	topology interface structure
Date: Tue, 27 Oct 2015 09:22:56 +0900
Message-ID: <1445905380-18167-14-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E29526533B
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:56 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Hardik T Shah <hardik.t.shah@intel.com>

This patch updates the topology interface structure alignment and
also updates the Sample interleaving defines

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.h       |  7 +--
 sound/soc/intel/skylake/skl-tplg-interface.h | 69 +++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 3b63450c6d5e..4b0a59898676 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -58,12 +58,6 @@ enum skl_bitdepth {
 	SKL_DEPTH_INVALID
 };
 
-enum skl_interleaving {
-	/* [s1_ch1...s1_chN,...,sM_ch1...sM_chN] */
-	SKL_INTERLEAVING_PER_CHANNEL = 0,
-	/* [s1_ch1...sM_ch1,...,s1_chN...sM_chN] */
-	SKL_INTERLEAVING_PER_SAMPLE = 1,
-};
 
 enum skl_s_freq {
 	SKL_FS_8000 = 8000,
@@ -253,6 +247,7 @@ enum skl_module_state {
 
 struct skl_module_cfg {
 	struct skl_module_inst_id id;
+	u8 domain;
 	bool homogenous_inputs;
 	bool homogenous_outputs;
 	struct skl_module_fmt in_fmt[MODULE_MAX_IN_PINS];
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 7bd9af7ee15c..aeb8f251675a 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -72,6 +72,7 @@ enum skl_ch_cfg {
 	SKL_CH_CFG_DUAL_MONO = 9,
 	SKL_CH_CFG_I2S_DUAL_STEREO_0 = 10,
 	SKL_CH_CFG_I2S_DUAL_STEREO_1 = 11,
+	SKL_CH_CFG_4_CHANNEL = 12,
 	SKL_CH_CFG_INVALID
 };
 
@@ -110,6 +111,25 @@ enum skl_dev_type {
 	SKL_DEVICE_NONE
 };
 
+/**
+ * enum skl_interleaving - interleaving style
+ *
+ * @SKL_INTERLEAVING_PER_CHANNEL: [s1_ch1...s1_chN,...,sM_ch1...sM_chN]
+ * @SKL_INTERLEAVING_PER_SAMPLE: [s1_ch1...sM_ch1,...,s1_chN...sM_chN]
+ */
+enum skl_interleaving {
+	SKL_INTERLEAVING_PER_CHANNEL = 0,
+	SKL_INTERLEAVING_PER_SAMPLE = 1,
+};
+
+enum skl_sample_type {
+	SKL_SAMPLE_TYPE_INT_MSB = 0,
+	SKL_SAMPLE_TYPE_INT_LSB = 1,
+	SKL_SAMPLE_TYPE_INT_SIGNED = 2,
+	SKL_SAMPLE_TYPE_INT_UNSIGNED = 3,
+	SKL_SAMPLE_TYPE_FLOAT = 4
+};
+
 enum module_pin_type {
 	/* All pins of the module takes same PCM inputs or outputs
 	* e.g. mixout
@@ -138,6 +158,9 @@ struct skl_dfw_module_fmt {
 } __packed;
 
 struct skl_dfw_module_caps {
+	u32 set_params:1;
+	u32 rsvd:31;
+	u32 param_id;
 	u32 caps_size;
 	u32 caps[HDA_SST_CFG_MAX];
 };
@@ -145,30 +168,41 @@ struct skl_dfw_module_caps {
 struct skl_dfw_pipe {
 	u8 pipe_id;
 	u8 pipe_priority;
-	u16 conn_type;
-	u32 memory_pages;
+	u16 conn_type:4;
+	u16 rsvd:4;
+	u16 memory_pages:8;
 } __packed;
 
 struct skl_dfw_module {
 	u16 module_id;
 	u16 instance_id;
 	u32 max_mcps;
-	u8 core_id;
-	u8 max_in_queue;
-	u8 max_out_queue;
-	u8 is_loadable;
-	u8 conn_type;
-	u8 dev_type;
-	u8 hw_conn_type;
-	u8 time_slot;
+	u32 mem_pages;
 	u32 obs;
 	u32 ibs;
-	u32 params_fixup;
-	u32 converter;
-	u32 module_type;
 	u32 vbus_id;
-	u8 is_dynamic_in_pin;
-	u8 is_dynamic_out_pin;
+
+	u32 max_in_queue:8;
+	u32 max_out_queue:8;
+	u32 time_slot:8;
+	u32 core_id:4;
+	u32 rsvd1:4;
+
+	u32 module_type:8;
+	u32 conn_type:4;
+	u32 dev_type:4;
+	u32 hw_conn_type:4;
+	u32 rsvd2:12;
+
+	u32 params_fixup:8;
+	u32 converter:8;
+	u32 input_pin_type:1;
+	u32 output_pin_type:1;
+	u32 is_dynamic_in_pin:1;
+	u32 is_dynamic_out_pin:1;
+	u32 is_loadable:1;
+	u32 rsvd3:11;
+
 	struct skl_dfw_pipe pipe;
 	struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
 	struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
@@ -178,8 +212,11 @@ struct skl_dfw_module {
 } __packed;
 
 struct skl_dfw_algo_data {
+	u32 set_params:1;
+	u32 rsvd:31;
+	u32 param_id;
 	u32 max;
-	char *params;
+	char params[0];
 } __packed;
 
 #endif
-- 
2.4.3
