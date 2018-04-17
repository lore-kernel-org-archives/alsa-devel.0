From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Unify the fw ops for
	SKL and KBL" to the asoc tree
Date: Tue, 17 Apr 2018 12:28:47 +0100
Message-ID: <E1f8On1-0000Lc-GL@debutante>
References: <1522651550-27236-4-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 519CE2675F4
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:28:51 +0200 (CEST)
In-Reply-To: <1522651550-27236-4-git-send-email-sriramx.periyasamy@intel.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Unify the fw ops for SKL and KBL

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

>From 651e4890930d10d009a9a8b829a7177670975ec7 Mon Sep 17 00:00:00 2001
From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Date: Mon, 2 Apr 2018 12:15:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Unify the fw ops for SKL and KBL

SKL and KBL driver used separate set of fw ops for library loading.
However, with the unification of fw binary, use the common set of fw
ops for both

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h  |  3 ---
 sound/soc/intel/skylake/skl-sst.c      | 34 ++------------------------
 3 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 57d4a58522a6..dd590a1c58e2 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -225,7 +225,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.id = 0x9d71,
 		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
-		.init = kbl_sst_dsp_init,
+		.init = skl_sst_dsp_init,
 		.init_fw = skl_sst_init_fw,
 		.cleanup = skl_sst_dsp_cleanup
 	},
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 12fc9a73dc8a..e1d6f6719f7e 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -231,9 +231,6 @@ int skl_dsp_boot(struct sst_dsp *ctx);
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_sst **dsp);
-int kbl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		struct skl_sst **dsp);
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_sst **dsp);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 5a7e41b65ef3..5951bbdf1f1a 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -390,7 +390,7 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 }
 
 static int
-kbl_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
+skl_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 {
 	struct skl_sst *skl = ctx->thread_context;
 	struct firmware stripped_fw;
@@ -508,16 +508,7 @@ static const struct skl_dsp_fw_ops skl_fw_ops = {
 	.set_state_D3 = skl_set_dsp_D3,
 	.load_fw = skl_load_base_firmware,
 	.get_fw_errcode = skl_get_errorcode,
-	.load_mod = skl_load_module,
-	.unload_mod = skl_unload_module,
-};
-
-static const struct skl_dsp_fw_ops kbl_fw_ops = {
-	.set_state_D0 = skl_set_dsp_D0,
-	.set_state_D3 = skl_set_dsp_D3,
-	.load_fw = skl_load_base_firmware,
-	.get_fw_errcode = skl_get_errorcode,
-	.load_library = kbl_load_library,
+	.load_library = skl_load_library,
 	.load_mod = skl_load_module,
 	.unload_mod = skl_unload_module,
 };
@@ -573,27 +564,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
-int kbl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		struct skl_sst **dsp)
-{
-	struct sst_dsp *sst;
-	int ret;
-
-	ret = skl_sst_dsp_init(dev, mmio_base, irq, fw_name, dsp_ops, dsp);
-	if (ret < 0) {
-		dev_err(dev, "%s: Init failed %d\n", __func__, ret);
-		return ret;
-	}
-
-	sst = (*dsp)->dsp;
-	sst->fw_ops = kbl_fw_ops;
-
-	return 0;
-
-}
-EXPORT_SYMBOL_GPL(kbl_sst_dsp_init);
-
 int skl_sst_init_fw(struct device *dev, struct skl_sst *ctx)
 {
 	int ret;
-- 
2.17.0
