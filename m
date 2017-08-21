From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Skylake: Add driver
	structures to be filled from topology manifest
Date: Mon, 21 Aug 2017 14:16:43 +0530
Message-ID: <20170821084646.6525-5-guneshwor.o.singh@intel.com>
References: <20170821084646.6525-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id F19B6267453
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 10:47:02 +0200 (CEST)
In-Reply-To: <20170821084646.6525-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

The topology manifest would include module common data including resource
and interface table. The resource table consists of resources required by
the dsp module such as buffer size, cycles per second, number of
input/output pins. And, the interface table consists of pcm parameters per
module which can be referenced later.

So define the structures accordingly to represent topology manifest data in
the driver.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.h | 53 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h          |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index f30e381ff1c8..9324f5eec69f 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -44,6 +44,13 @@
 #define SKL_DEFAULT_MIC_SEL_GAIN	0x3FF
 #define SKL_MIC_SEL_SWITCH	0x3
 
+#define SKL_OUTPUT_PIN		0
+#define SKL_INPUT_PIN		1
+#define SKL_MAX_PATH_CONFIGS	8
+#define SKL_MAX_MODULES_IN_PIPE	8
+#define SKL_MAX_MODULE_FORMATS		32
+#define SKL_MAX_MODULE_RESOURCES	32
+
 enum skl_channel_index {
 	SKL_CHANNEL_LEFT = 0,
 	SKL_CHANNEL_RIGHT = 1,
@@ -293,6 +300,52 @@ enum d0i3_capability {
 	SKL_D0I3_NON_STREAMING = 2,
 };
 
+struct skl_module_pin_fmt {
+	u8 id;
+	struct skl_module_fmt fmt;
+};
+
+struct skl_module_iface {
+	u8 fmt_idx;
+	u8 nr_in_fmt;
+	u8 nr_out_fmt;
+	struct skl_module_pin_fmt inputs[MAX_IN_QUEUE];
+	struct skl_module_pin_fmt outputs[MAX_OUT_QUEUE];
+};
+
+struct skl_module_pin_resources {
+	u8 pin_index;
+	u32 buf_size;
+};
+
+struct skl_module_res {
+	u8 id;
+	u32 is_pages;
+	u32 cps;
+	u32 ibs;
+	u32 obs;
+	u32 dma_buffer_size;
+	u32 cpc;
+	u8 nr_input_pins;
+	u8 nr_output_pins;
+	struct skl_module_pin_resources input[MAX_IN_QUEUE];
+	struct skl_module_pin_resources output[MAX_OUT_QUEUE];
+};
+
+struct skl_module {
+	uuid_le uuid;
+	u8 loadable;
+	u8 input_pin_type;
+	u8 output_pin_type;
+	u8 max_input_pins;
+	u8 max_output_pins;
+	u8 max_instance_count;
+	u8 nr_resources;
+	u8 nr_interfaces;
+	struct skl_module_res resources[SKL_MAX_MODULE_RESOURCES];
+	struct skl_module_iface formats[SKL_MAX_MODULE_FORMATS];
+};
+
 struct skl_module_cfg {
 	u8 guid[16];
 	struct skl_module_inst_id id;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 20017ee4685c..8d9d6899f761 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -71,6 +71,8 @@ struct skl {
 	struct work_struct probe_work;
 
 	struct skl_debug *debugfs;
+	u8 nr_modules;
+	struct skl_module **modules;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.14.1
