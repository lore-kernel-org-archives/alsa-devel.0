From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Request IRQ late only
	after all context are initialized" to the asoc tree
Date: Wed, 20 Dec 2017 10:50:23 +0000
Message-ID: <E1eRbx9-0007Ki-45@debutante>
References: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, GuruprasadX <guruprasadx.pawse@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Pawse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Request IRQ late only after all context are initialized

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

>From 8e9d8e19b3d0c36d45161233eee3f2d368efe3ac Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 18 Dec 2017 10:46:49 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Request IRQ late only after all context
 are initialized

Sometimes during boot, panic is observed at sst_dsp_shim_read_unlocked().
This happens when interrupt occurs before the context is initialized. So
move the irq initialization only after the context is initialized
completely.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Pawse, GuruprasadX <guruprasadx.pawse@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     |  2 +-
 sound/soc/intel/skylake/cnl-sst.c     |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c | 14 ++++++++++----
 sound/soc/intel/skylake/skl-sst-dsp.h |  1 +
 sound/soc/intel/skylake/skl-sst.c     |  2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 4524211960e4..440bca7afbf1 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -595,7 +595,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	INIT_DELAYED_WORK(&skl->d0i3.work, bxt_set_dsp_D0i3);
 	skl->d0i3.state = SKL_DSP_D0I3_NONE;
 
-	return 0;
+	return skl_dsp_acquire_irq(sst);
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
 
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 387de388ce29..245df1067ba8 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -458,7 +458,7 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	cnl->boot_complete = false;
 	init_waitqueue_head(&cnl->boot_wait);
 
-	return 0;
+	return skl_dsp_acquire_irq(sst);
 }
 EXPORT_SYMBOL_GPL(cnl_sst_dsp_init);
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 19ee1d4f3bdf..71e31ad0bb3f 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -435,16 +435,22 @@ struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 			return NULL;
 	}
 
+	return sst;
+}
+
+int skl_dsp_acquire_irq(struct sst_dsp *sst)
+{
+	struct sst_dsp_device *sst_dev = sst->sst_dev;
+	int ret;
+
 	/* Register the ISR */
 	ret = request_threaded_irq(sst->irq, sst->ops->irq_handler,
 		sst_dev->thread, IRQF_SHARED, "AudioDSP", sst);
-	if (ret) {
+	if (ret)
 		dev_err(sst->dev, "unable to grab threaded IRQ %d, disabling device\n",
 			       sst->irq);
-		return NULL;
-	}
 
-	return sst;
+	return ret;
 }
 
 void skl_dsp_free(struct sst_dsp *dsp)
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index b8e799ed65ef..12fc9a73dc8a 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -206,6 +206,7 @@ int skl_cldma_wait_interruptible(struct sst_dsp *ctx);
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 		struct sst_dsp_device *sst_dev, int irq);
+int skl_dsp_acquire_irq(struct sst_dsp *sst);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
 
 unsigned int skl_dsp_get_enabled_cores(struct sst_dsp *ctx);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index a436abf2fe3f..5a7e41b65ef3 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -569,7 +569,7 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	sst->fw_ops = skl_fw_ops;
 
-	return 0;
+	return skl_dsp_acquire_irq(sst);
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
-- 
2.15.1
