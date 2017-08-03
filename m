From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Move platform specific
	init to platform dsp_init()" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:13 +0100
Message-ID: <E1ddJ0n-0002Vw-8l@debutante>
References: <20170802162120.8935-6-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA65826741F
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:22 +0200 (CEST)
In-Reply-To: <20170802162120.8935-6-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Move platform specific init to platform dsp_init()

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

>From 2eed1b024a11b497766604ee8f95e22711859af2 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Wed, 2 Aug 2017 21:51:16 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Move platform specific init to platform
 dsp_init()

Move ipc_init() from helper function to respective platform's dsp_init()
as ipc_init() per platform can be different.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c       | 4 ++++
 sound/soc/intel/skylake/skl-sst-utils.c | 6 +-----
 sound/soc/intel/skylake/skl-sst.c       | 4 ++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index c404a42b670a..71042aceb25f 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -581,6 +581,10 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
 	/* set the D0i3 check */
 	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
 
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 81ee251881b4..369ef7ce981c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -368,7 +368,6 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 {
 	struct skl_sst *skl;
 	struct sst_dsp *sst;
-	int ret;
 
 	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
 	if (skl == NULL)
@@ -388,15 +387,12 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 	sst->dsp_ops = dsp_ops;
 	init_waitqueue_head(&skl->mod_load_wait);
 	INIT_LIST_HEAD(&sst->module_list);
-	ret = skl_ipc_init(dev, skl);
-	if (ret)
-		return ret;
 
 	skl->is_first_boot = true;
 	if (dsp)
 		*dsp = skl;
 
-	return ret;
+	return 0;
 }
 
 int skl_prepare_lib_load(struct skl_sst *skl, struct skl_lib_info *linfo,
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index fd99e74cda03..6cc586d3f03b 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -561,6 +561,10 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
 	sst->fw_ops = skl_fw_ops;
 
 	return 0;
-- 
2.13.2
