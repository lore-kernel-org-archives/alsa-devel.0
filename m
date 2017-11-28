From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Skylake: Parse vendor tokens
	to build A-State table
Date: Tue, 28 Nov 2017 16:40:20 +0530
Message-ID: <20171128111021.11830-4-guneshwor.o.singh@intel.com>
References: <20171128111021.11830-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 81B95267745
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 12:11:00 +0100 (CET)
In-Reply-To: <20171128111021.11830-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Pradeep Tewani <pradeep.d.tewani@intel.com>, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pradeep Tewani <pradeep.d.tewani@intel.com>

A-State table is a power management table which allows the driver to
configure the DSP clock source corresponding to various load thresholds.
The table contains upto 3 A-State entries. The patch adds and parses the
corresponding A-State tokens to build the table.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 include/uapi/sound/snd_sst_tokens.h    | 17 ++++++++++++-
 sound/soc/intel/skylake/skl-topology.c | 44 +++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.h          | 17 +++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index 326054a72bc7..8ba0112e5336 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -222,6 +222,17 @@
  * %SKL_TKN_MM_U32_NUM_IN_FMT:  Number of input formats
  * %SKL_TKN_MM_U32_NUM_OUT_FMT: Number of output formats
  *
+ * %SKL_TKN_U32_ASTATE_IDX:     Table Index for the A-State entry to be filled
+ *                              with kcps and clock source
+ *
+ * %SKL_TKN_U32_ASTATE_COUNT:   Number of valid entries in A-State table
+ *
+ * %SKL_TKN_U32_ASTATE_KCPS:    Specifies the core load threshold (in kilo
+ *                              cycles per second) below which DSP is clocked
+ *                              from source specified by clock source.
+ *
+ * %SKL_TKN_U32_ASTATE_CLK_SRC: Clock source for A-State entry
+ *
  * module_id and loadable flags dont have tokens as these values will be
  * read from the DSP FW manifest
  *
@@ -309,7 +320,11 @@ enum SKL_TKNS {
 	SKL_TKN_MM_U32_NUM_IN_FMT,
 	SKL_TKN_MM_U32_NUM_OUT_FMT,
 
-	SKL_TKN_MAX = SKL_TKN_MM_U32_NUM_OUT_FMT,
+	SKL_TKN_U32_ASTATE_IDX,
+	SKL_TKN_U32_ASTATE_COUNT,
+	SKL_TKN_U32_ASTATE_KCPS,
+	SKL_TKN_U32_ASTATE_CLK_SRC,
+	SKL_TKN_MAX = SKL_TKN_U32_ASTATE_CLK_SRC,
 };
 
 #endif
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a072bcf209d2..6a5f8462c380 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3056,11 +3056,13 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
 		struct skl *skl)
 {
-	int tkn_count = 0, ret;
+	int tkn_count = 0, ret, size;
 	static int mod_idx, res_val_idx, intf_val_idx, dir, pin_idx;
 	struct skl_module_res *res = NULL;
 	struct skl_module_iface *fmt = NULL;
 	struct skl_module *mod = NULL;
+	static struct skl_astate_param *astate_table;
+	static int astate_cfg_idx, count;
 	int i;
 
 	if (skl->modules) {
@@ -3093,6 +3095,46 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 		mod_idx = tkn_elem->value;
 		break;
 
+	case SKL_TKN_U32_ASTATE_COUNT:
+		if (astate_table != NULL) {
+			dev_err(dev, "More than one entry for A-State count");
+			return -EINVAL;
+		}
+
+		if (tkn_elem->value > SKL_MAX_ASTATE_CFG) {
+			dev_err(dev, "Invalid A-State count %d\n",
+				tkn_elem->value);
+			return -EINVAL;
+		}
+
+		size = tkn_elem->value * sizeof(struct skl_astate_param) +
+				sizeof(count);
+		skl->cfg.astate_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
+		if (!skl->cfg.astate_cfg)
+			return -ENOMEM;
+
+		astate_table = skl->cfg.astate_cfg->astate_table;
+		count = skl->cfg.astate_cfg->count = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_ASTATE_IDX:
+		if (tkn_elem->value >= count) {
+			dev_err(dev, "Invalid A-State index %d\n",
+				tkn_elem->value);
+			return -EINVAL;
+		}
+
+		astate_cfg_idx = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_ASTATE_KCPS:
+		astate_table[astate_cfg_idx].kcps = tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_ASTATE_CLK_SRC:
+		astate_table[astate_cfg_idx].clk_src = tkn_elem->value;
+		break;
+
 	case SKL_TKN_U8_IN_PIN_TYPE:
 	case SKL_TKN_U8_OUT_PIN_TYPE:
 	case SKL_TKN_U8_IN_QUEUE_COUNT:
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index e00cde8200dd..fa46a5782929 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -28,6 +28,8 @@
 
 #define SKL_SUSPEND_DELAY 2000
 
+#define SKL_MAX_ASTATE_CFG		3
+
 #define AZX_PCIREG_PGCTL		0x44
 #define AZX_PGCTL_LSRMD_MASK		(1 << 4)
 #define AZX_PCIREG_CGCTL		0x48
@@ -45,6 +47,20 @@ struct skl_dsp_resource {
 
 struct skl_debug;
 
+struct skl_astate_param {
+	u32 kcps;
+	u32 clk_src;
+};
+
+struct skl_astate_config {
+	u32 count;
+	struct skl_astate_param astate_table[0];
+};
+
+struct skl_fw_config {
+	struct skl_astate_config *astate_cfg;
+};
+
 struct skl {
 	struct hdac_ext_bus ebus;
 	struct pci_dev *pci;
@@ -75,6 +91,7 @@ struct skl {
 	u8 nr_modules;
 	struct skl_module **modules;
 	bool use_tplg_pcm;
+	struct skl_fw_config cfg;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.15.0
