From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add helpers for SRC and
	converter modules" to the asoc tree
Date: Fri, 07 Aug 2015 14:26:27 +0100
Message-ID: <E1ZNhfH-0003LE-Uu@finisterre>
References: <1438438244-17974-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC3AD2604CA
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:26:39 +0200 (CEST)
In-Reply-To: <1438438244-17974-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hardik T Shah <hardik.t.shah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add helpers for SRC and converter modules

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a0ffe48bb5d45fcef444e8a03c75fb7b73a5af29 Mon Sep 17 00:00:00 2001
From: Hardik T Shah <hardik.t.shah@intel.com>
Date: Sat, 1 Aug 2015 19:40:42 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add helpers for SRC and converter
 modules

SRC and converter modules are required to do frequency and channel
conversion in DSP. Both take base module configuration and additional SRC
and converter parameters. The helpers here are added to calculate the values
for these modules

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 64 +++++++++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-topology.h | 16 +++++++++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 0ba13f1..03a80ef 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -381,6 +381,47 @@ static void skl_setup_out_format(struct skl_sst *ctx,
 }
 
 /*
+ * DSP needs SRC module for frequency conversion, SRC takes base module
+ * configuration and the target frequency as extra parameter passed as src
+ * config
+ */
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
+/*
+ * DSP needs updown module to do channel conversion. updown module take base
+ * module configuration and channel configuration
+ * It also take coefficients and now we have defaults applied here
+ */
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
+/*
  * 'copier' is DSP internal module which copies data from Host DMA (HDA host
  * dma) or link (hda link, SSP, PDM)
  * Here we calculate the copier module parameters, like PCM format, output
@@ -411,6 +452,12 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
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
@@ -423,11 +470,12 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
 }
 
 /*
- * DSP firmware supports various modules like copier etc. These modules
- * required various parameters to be calculated and sent for the module
- * initialization to DSP. By default a generic module needs only base module
- * format configuration
+ * DSP firmware supports various modules like copier, SRC, updown etc.
+ * These modules required various parameters to be calculated and sent for
+ * the module initialization to DSP. By default a generic module needs only
+ * base module format configuration
  */
+
 static int skl_set_module_format(struct skl_sst *ctx,
 			struct skl_module_cfg *module_config,
 			u16 *module_config_size,
@@ -448,6 +496,14 @@ static int skl_set_module_format(struct skl_sst *ctx,
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
 		break;
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 6ba137a..e4b2a33 100644
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
2.5.0
