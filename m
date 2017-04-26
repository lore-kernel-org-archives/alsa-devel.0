From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Move sst common
	initialization to a helper function" to the asoc tree
Date: Wed, 26 Apr 2017 15:49:29 +0100
Message-ID: <E1d3OG1-0000U0-E2@finisterre>
References: <1492786693-24167-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2F36267478
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:49:45 +0200 (CEST)
In-Reply-To: <1492786693-24167-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: G Kranthi <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Move sst common initialization to a helper function

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

>From 9fe9c71192832a1c63fb94120cb6c2541aca694f Mon Sep 17 00:00:00 2001
From: G Kranthi <gudishax.kranthikumar@intel.com>
Date: Tue, 25 Apr 2017 12:18:19 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Move sst common initialization to a
 helper function

Some skl sst context are not dependent of platform and initializing them
independently for each platform can lead to errors. So optimize by
moving them to a helper function and platform specific init code can
call this.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c       | 28 +++++--------------------
 sound/soc/intel/skylake/skl-sst-dsp.h   |  3 +++
 sound/soc/intel/skylake/skl-sst-utils.c | 37 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst.c       | 32 ++++++----------------------
 4 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 268bdaec8042..2bf6ebe29f50 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -590,23 +590,14 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	struct sst_dsp *sst;
 	int ret;
 
-	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
-	if (skl == NULL)
-		return -ENOMEM;
-
-	skl->dev = dev;
-	skl_dev.thread_context = skl;
-	INIT_LIST_HEAD(&skl->uuid_list);
-
-	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
-	if (!skl->dsp) {
-		dev_err(skl->dev, "skl_dsp_ctx_init failed\n");
-		return -ENODEV;
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
+	if (ret < 0) {
+		dev_err(skl->dev, "%s: no device\n", __func__);
+		return ret;
 	}
 
+	skl = *dsp;
 	sst = skl->dsp;
-	sst->fw_name = fw_name;
-	sst->dsp_ops = dsp_ops;
 	sst->fw_ops = bxt_fw_ops;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
@@ -614,24 +605,15 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
-	INIT_LIST_HEAD(&sst->module_list);
-	ret = skl_ipc_init(dev, skl);
-	if (ret)
-		return ret;
-
 	/* set the D0i3 check */
 	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
 
 	skl->cores.count = 2;
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
-	skl->is_first_boot = true;
 	INIT_DELAYED_WORK(&skl->d0i3.work, bxt_set_dsp_D0i3);
 	skl->d0i3.state = SKL_DSP_D0I3_NONE;
 
-	if (dsp)
-		*dsp = skl;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 7229a12b4c94..c1f95e23933d 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -247,5 +247,8 @@ void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
 void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable);
+int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
+		struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp,
+		struct sst_dsp_device *skl_dev);
 
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 6d5bff04bf65..a72152123c3c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -361,3 +361,40 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw)
 
 	return 0;
 }
+
+int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
+	struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp,
+	struct sst_dsp_device *skl_dev)
+{
+	struct skl_sst *skl;
+	struct sst_dsp *sst;
+	int ret;
+
+	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
+	if (skl == NULL)
+		return -ENOMEM;
+
+	skl->dev = dev;
+	skl_dev->thread_context = skl;
+	INIT_LIST_HEAD(&skl->uuid_list);
+	skl->dsp = skl_dsp_ctx_init(dev, skl_dev, irq);
+	if (!skl->dsp) {
+		dev_err(skl->dev, "%s: no device\n", __func__);
+		return -ENODEV;
+	}
+
+	sst = skl->dsp;
+	sst->fw_name = fw_name;
+	sst->dsp_ops = dsp_ops;
+	init_waitqueue_head(&skl->mod_load_wait);
+	INIT_LIST_HEAD(&sst->module_list);
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
+	skl->is_first_boot = true;
+	if (dsp)
+		*dsp = skl;
+
+	return ret;
+}
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 539529729e3f..4fdd503a837c 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -330,7 +330,6 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 	int ret, bytes_left, curr_pos;
 	struct skl_sst *skl = ctx->thread_context;
 	skl->mod_load_complete = false;
-	init_waitqueue_head(&skl->mod_load_wait);
 
 	bytes_left = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, data, size, false);
 	if (bytes_left < 0)
@@ -489,43 +488,24 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	struct sst_dsp *sst;
 	int ret;
 
-	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
-	if (skl == NULL)
-		return -ENOMEM;
-
-	skl->dev = dev;
-	skl_dev.thread_context = skl;
-	INIT_LIST_HEAD(&skl->uuid_list);
-
-	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
-	if (!skl->dsp) {
-		dev_err(skl->dev, "%s: no device\n", __func__);
-		return -ENODEV;
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
+	if (ret < 0) {
+		dev_err(dev, "%s: no device\n", __func__);
+		return ret;
 	}
 
+	skl = *dsp;
 	sst = skl->dsp;
-
-	sst->fw_name = fw_name;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
-	INIT_LIST_HEAD(&sst->module_list);
-	sst->dsp_ops = dsp_ops;
 	sst->fw_ops = skl_fw_ops;
 
-	ret = skl_ipc_init(dev, skl);
-	if (ret)
-		return ret;
-
 	skl->cores.count = 2;
-	skl->is_first_boot = true;
-
-	if (dsp)
-		*dsp = skl;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
-- 
2.11.0
