From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Parse vendor tokens to
	build A-State table" to the asoc tree
Date: Wed, 06 Dec 2017 17:49:41 +0000
Message-ID: <E1eMdpF-0004nE-Nt@debutante>
References: <20171128111021.11830-4-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AECEA2679FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:44 +0100 (CET)
In-Reply-To: <20171128111021.11830-4-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Parse vendor tokens to build A-State table

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 437623554e89f388648a31c35e1e5e4c7cb09004 Mon Sep 17 00:00:00 2001
From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Date: Wed, 6 Dec 2017 16:34:02 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Parse vendor tokens to build A-State
 table

A-State table is a power management table which allows the driver to
configure the DSP clock source corresponding to various load thresholds.
The table contains upto 3 A-State entries. The patch adds and parses the
corresponding A-State tokens to build the table.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/snd_sst_tokens.h    | 17 ++++++++++++-
 sound/soc/intel/skylake/skl-topology.c | 44 +++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.h          | 17 +++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index f691e421f5e8..9e38fea11b2b 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -221,6 +221,17 @@
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
@@ -308,7 +319,11 @@ enum SKL_TKNS {
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
index 1200b7c6af56..d8d110b3be01 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3037,11 +3037,13 @@ static int skl_tplg_get_int_tkn(struct device *dev,
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
@@ -3074,6 +3076,46 @@ static int skl_tplg_get_int_tkn(struct device *dev,
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
index 554ad6b5a823..46dda88ba139 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -29,6 +29,8 @@
 
 #define SKL_SUSPEND_DELAY 2000
 
+#define SKL_MAX_ASTATE_CFG		3
+
 #define AZX_PCIREG_PGCTL		0x44
 #define AZX_PGCTL_LSRMD_MASK		(1 << 4)
 #define AZX_PCIREG_CGCTL		0x48
@@ -46,6 +48,20 @@ struct skl_dsp_resource {
 
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
@@ -77,6 +93,7 @@ struct skl {
 	u8 nr_modules;
 	struct skl_module **modules;
 	bool use_tplg_pcm;
+	struct skl_fw_config cfg;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.15.0
