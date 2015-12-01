From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add helper routine to
	handle Algo parameter" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:39 +0000
Message-ID: <E1a3ttb-00067p-3q@debutante>
References: <1448703121-5831-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23426266332
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:45 +0100 (CET)
In-Reply-To: <1448703121-5831-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Divya Prakash <divya1.prakash@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add helper routine to handle Algo parameter

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

>From 399b210bef097ce01d9e7b03ce5d4435f0624111 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 28 Nov 2015 15:01:48 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add helper routine to handle Algo
 parameter

Some DSP modules has user configurable parameters, which are
required by some modules at module initialization.

To configure the module algorithm parameter during initialization
we add helpers here

Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.2
