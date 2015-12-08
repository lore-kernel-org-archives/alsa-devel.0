From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support for Mic
	Select module" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:27 +0000
Message-ID: <E1a6Nfb-00044T-OF@debutante>
References: <1448703121-5831-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66AAA2604D1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:34 +0100 (CET)
In-Reply-To: <1448703121-5831-10-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support for Mic Select module

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

>From fd18110f1480d51f416cea6d5f63b83f85b14043 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Thu, 3 Dec 2015 23:29:52 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support for Mic Select module

Mic select is a DSP module which is used to select one or many
inputs to form an output. This is useful to select data
selectively from PDM input and hence the name. This module is of
generic module type.

This patch adds support to add and configure Mic select module in
firmware topology.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.2
