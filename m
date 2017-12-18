From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: Request IRQ late
	only after all context are initialized
Date: Mon, 18 Dec 2017 10:46:49 +0530
Message-ID: <20171218051650.7027-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 389E6266AE1
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 06:16:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, GuruprasadX <guruprasadx.pawse@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Pawse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Sometimes during boot, panic is observed at sst_dsp_shim_read_unlocked().
This happens when interrupt occurs before the context is initialized. So
move the irq initialization only after the context is initialized
completely.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Pawse, GuruprasadX <guruprasadx.pawse@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     |  2 +-
 sound/soc/intel/skylake/cnl-sst.c     |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c | 14 ++++++++++----
 sound/soc/intel/skylake/skl-sst-dsp.h |  1 +
 sound/soc/intel/skylake/skl-sst.c     |  2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 1c78b853a7cc..13b1749fbcd5 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -582,7 +582,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
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
