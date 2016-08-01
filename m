From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: split fw and dsp
	initialization" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:22 +0100
Message-ID: <E1bUGgU-0006Py-7V@debutante>
References: <1469536610-27606-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB4B32660C4
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:28 +0200 (CEST)
In-Reply-To: <1469536610-27606-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: split fw and dsp initialization

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

>From b2f51fd9e11429124cab41fb2b94d1d2ee6ec9fc Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 26 Jul 2016 18:06:42 +0530
Subject: [PATCH] ASoC: Intel: Skylake: split fw and dsp initialization

The DSP instance creation also loads the firmware on DSPs. For library load
the firmware names come from topology so can't be loaded at object creation.

So split the firmware load and object creation. FW load is now called after
topology init in platform probe.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c      | 19 +++++++++++++++----
 sound/soc/intel/skylake/skl-messages.c |  8 +++++++-
 sound/soc/intel/skylake/skl-pcm.c      | 20 ++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h  |  2 ++
 sound/soc/intel/skylake/skl-sst-ipc.h  |  3 +++
 sound/soc/intel/skylake/skl-sst.c      | 27 +++++++++++++++++----------
 sound/soc/intel/skylake/skl.h          |  1 +
 7 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 2663781278aa..eb68258b653d 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -397,6 +397,19 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	skl->cores.count = 2;
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
+	skl->is_first_boot = true;
+
+	if (dsp)
+		*dsp = skl;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
+
+int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx)
+{
+	int ret;
+	struct sst_dsp *sst = ctx->dsp;
 
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
@@ -406,13 +419,11 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	skl_dsp_init_core_state(sst);
 
-	if (dsp)
-		*dsp = skl;
+	ctx->is_first_boot = false;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
-
+EXPORT_SYMBOL_GPL(bxt_sst_init_fw);
 
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 25d057679f2c..2199a91d90d6 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -203,18 +203,21 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.id = 0x9d70,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
+		.init_fw = skl_sst_init_fw,
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
 		.id = 0x9d71,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
+		.init_fw = skl_sst_init_fw,
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
 		.id = 0x5a98,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
+		.init_fw = bxt_sst_init_fw,
 		.cleanup = bxt_sst_dsp_cleanup
 	},
 };
@@ -264,7 +267,6 @@ int skl_init_dsp(struct skl *skl)
 	if (ret < 0)
 		return ret;
 
-	skl_dsp_enable_notification(skl->skl_sst, false);
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
 	return ret;
@@ -325,6 +327,10 @@ int skl_resume_dsp(struct skl *skl)
 	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, true);
 	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, true);
 
+	/* check if DSP 1st boot is done */
+	if (skl->skl_sst->is_first_boot == true)
+		return 0;
+
 	ret = skl_dsp_wake(ctx->dsp);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 6e05bf8622f7..22d4f0703a33 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1142,8 +1142,10 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(platform->dev);
 	struct skl *skl = ebus_to_skl(ebus);
+	const struct skl_dsp_ops *ops;
 	int ret;
 
+	pm_runtime_get_sync(platform->dev);
 	if (ebus->ppcap) {
 		ret = skl_tplg_init(platform, ebus);
 		if (ret < 0) {
@@ -1151,7 +1153,25 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 			return ret;
 		}
 		skl->platform = platform;
+
+		/* load the firmwares, since all is set */
+		ops = skl_get_dsp_ops(skl->pci->device);
+		if (!ops)
+			return -EIO;
+
+		if (skl->skl_sst->is_first_boot == false) {
+			dev_err(platform->dev, "DSP reports first boot done!!!\n");
+			return -EIO;
+		}
+
+		ret = ops->init_fw(platform->dev, skl->skl_sst);
+		if (ret < 0) {
+			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
+			return ret;
+		}
 	}
+	pm_runtime_mark_last_busy(platform->dev);
+	pm_runtime_put_autosuspend(platform->dev);
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 0f8629ef79ac..7e994688d8a0 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -203,6 +203,8 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_sst **dsp);
+int skl_sst_init_fw(struct device *dev, struct skl_sst *ctx);
+int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 2e3d4e80ef97..0a0d09cde99d 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -75,6 +75,9 @@ struct skl_sst {
 	/* Is firmware loaded */
 	bool fw_loaded;
 
+	/* first boot ? */
+	bool is_first_boot;
+
 	/* multi-core */
 	struct skl_dsp_cores cores;
 };
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 588f899ceb65..6de4c027a65b 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -484,25 +484,32 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		return ret;
 
 	skl->cores.count = 2;
+	skl->is_first_boot = true;
+
+	if (dsp)
+		*dsp = skl;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
+
+int skl_sst_init_fw(struct device *dev, struct skl_sst *ctx)
+{
+	int ret;
+	struct sst_dsp *sst = ctx->dsp;
 
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
 		dev_err(dev, "Load base fw failed : %d", ret);
-		goto cleanup;
+		return ret;
 	}
 
 	skl_dsp_init_core_state(sst);
+	ctx->is_first_boot = false;
 
-	if (dsp)
-		*dsp = skl;
-
-	return ret;
-
-cleanup:
-	skl_sst_dsp_cleanup(dev, skl);
-	return ret;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
+EXPORT_SYMBOL_GPL(skl_sst_init_fw);
 
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index c3538f8b17d9..5d4fbb094c48 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -105,6 +105,7 @@ struct skl_dsp_ops {
 			int irq, const char *fw_name,
 			struct skl_dsp_loader_ops loader_ops,
 			struct skl_sst **skl_sst);
+	int (*init_fw)(struct device *dev, struct skl_sst *ctx);
 	void (*cleanup)(struct device *dev, struct skl_sst *ctx);
 };
 
-- 
2.8.1
