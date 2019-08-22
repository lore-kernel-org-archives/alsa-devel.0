From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 13/35] ASoC: Intel: Skylake: Reuse sst_dsp_new
Date: Thu, 22 Aug 2019 21:04:03 +0200
Message-ID: <20190822190425.23001-14-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F422F805FA
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:01 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

skl_dsp_ctx_init is dumplication of sst_dsp_new and usage of such
bypasses natural DSP framework's flow. Remove it and reuse sst_dsp_new
constructor which invokes sst specific init internally so nothing is
missed.

Skylake does not even define any sst_ops::init so portion of existing
skl_dsp_ctx_init can be regarded as DEADCODE.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c       |  2 +-
 sound/soc/intel/skylake/cnl-sst.c       |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c   | 28 -------------------------
 sound/soc/intel/skylake/skl-sst-dsp.h   |  2 --
 sound/soc/intel/skylake/skl-sst-utils.c |  6 +++++-
 sound/soc/intel/skylake/skl-sst.c       |  2 +-
 6 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index e3614acff34d..a8a2783f9b37 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -588,7 +588,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	INIT_DELAYED_WORK(&skl->d0i3.work, bxt_set_dsp_D0i3);
 	skl->d0i3.state = SKL_DSP_D0I3_NONE;
 
-	return skl_dsp_acquire_irq(sst);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
 
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 84dc6b82831d..0b0337f6ebff 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -460,7 +460,7 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	cnl->boot_complete = false;
 	init_waitqueue_head(&cnl->boot_wait);
 
-	return skl_dsp_acquire_irq(sst);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cnl_sst_dsp_init);
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 1c4ecbcd7db7..9d8eb1af4798 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -418,34 +418,6 @@ int skl_dsp_sleep(struct sst_dsp *ctx)
 }
 EXPORT_SYMBOL_GPL(skl_dsp_sleep);
 
-struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
-		struct sst_pdata *pdata, int irq)
-{
-	int ret;
-	struct sst_dsp *sst;
-
-	sst = devm_kzalloc(dev, sizeof(*sst), GFP_KERNEL);
-	if (sst == NULL)
-		return NULL;
-
-	spin_lock_init(&sst->spinlock);
-	mutex_init(&sst->mutex);
-	sst->dev = dev;
-	sst->pdata = pdata;
-	sst->irq = irq;
-	sst->ops = pdata->ops;
-	sst->thread_context = pdata->dsp;
-
-	/* Initialise SST Audio DSP */
-	if (sst->ops->init) {
-		ret = sst->ops->init(sst, NULL);
-		if (ret < 0)
-			return NULL;
-	}
-
-	return sst;
-}
-
 int skl_dsp_acquire_irq(struct sst_dsp *sst)
 {
 	int ret;
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index ba37433e4efa..1d579d59de60 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -196,8 +196,6 @@ int skl_cldma_prepare(struct sst_dsp *ctx);
 int skl_cldma_wait_interruptible(struct sst_dsp *ctx);
 
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
-struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
-		struct sst_pdata *pdata, int irq);
 int skl_dsp_acquire_irq(struct sst_dsp *sst);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
 
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 9061a9b17ea0..8e03a10855c4 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
 #include "../common/sst-dsp.h"
@@ -360,10 +361,13 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 	struct skl_dev *skl = *dsp;
 	struct sst_dsp *sst;
 
+	pdata->id = skl->pci->device;
+	pdata->irq = irq;
+	pdata->resindex_dma_base = -1;
 	skl->dev = dev;
 	pdata->dsp = skl;
 	INIT_LIST_HEAD(&skl->uuid_list);
-	skl->dsp = skl_dsp_ctx_init(dev, pdata, irq);
+	skl->dsp = sst_dsp_new(dev, pdata);
 	if (!skl->dsp) {
 		dev_err(skl->dev, "%s: no device\n", __func__);
 		return -ENODEV;
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index e55523826346..6bb003add9e2 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -550,7 +550,7 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	sst->fw_ops = skl_fw_ops;
 
-	return skl_dsp_acquire_irq(sst);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 
-- 
2.17.1
