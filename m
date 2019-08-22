From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 11/35] ASoC: Intel: Merge sst_dsp_device into
	sst_pdata
Date: Thu, 22 Aug 2019 21:04:01 +0200
Message-ID: <20190822190425.23001-12-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB4EEF800BF
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:58 +0200 (CEST)
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

With all core ops united, sst_dsp_device is a stub struct. Merge it with
sst_pdata and thus making it dsp-platform info struct. As sst_pdata is
targeted to become a sole initialization struct for DSP drivers, update
its definition to contain fw_name and machine board list too.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 10 +++-------
 sound/soc/intel/common/sst-dsp-priv.h       |  1 -
 sound/soc/intel/common/sst-dsp.h            | 17 ++++-------------
 sound/soc/intel/common/sst-firmware.c       |  8 +++-----
 sound/soc/intel/haswell/sst-haswell-ipc.c   | 10 +++-------
 sound/soc/intel/skylake/bxt-sst.c           |  2 +-
 sound/soc/intel/skylake/cnl-sst-dsp.h       |  2 +-
 sound/soc/intel/skylake/cnl-sst.c           |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c       |  8 ++++----
 sound/soc/intel/skylake/skl-sst-dsp.h       |  6 +++---
 sound/soc/intel/skylake/skl-sst-utils.c     |  6 +++---
 sound/soc/intel/skylake/skl-sst.c           |  2 +-
 12 files changed, 27 insertions(+), 47 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 23d65ad38e19..efa78e33caf2 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -556,10 +556,6 @@ struct sst_dsp *sst_byt_get_dsp(struct sst_byt *byt)
 	return byt->dsp;
 }
 
-static struct sst_dsp_device byt_dev = {
-	.ops = &sst_byt_ops,
-};
-
 int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_byt *byt = pdata->dsp;
@@ -701,10 +697,11 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 	INIT_LIST_HEAD(&byt->stream_list);
 	init_waitqueue_head(&byt->boot_wait);
-	byt_dev.thread_context = byt;
+	pdata->dsp = byt;
+	pdata->ops = &sst_byt_ops;
 
 	/* init SST shim */
-	byt->dsp = sst_dsp_new(dev, &byt_dev, pdata);
+	byt->dsp = sst_dsp_new(dev, pdata);
 	if (byt->dsp == NULL) {
 		err = -ENODEV;
 		goto dsp_new_err;
@@ -741,7 +738,6 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	dev_info(byt->dev, "Build date: %s %s\n",
 		 init.build_info.date, init.build_info.time);
 
-	pdata->dsp = byt;
 	byt->fw = byt_sst_fw;
 
 	return 0;
diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 7ec477108948..8a7009937d59 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -259,7 +259,6 @@ struct sst_dsp {
 	/* Shared for all platforms */
 
 	/* runtime */
-	struct sst_dsp_device *sst_dev;
 	spinlock_t spinlock;	/* IPC locking */
 	struct mutex mutex;	/* DSP FW lock */
 	struct device *dev;
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 05fa1ca72f46..63c29bb45cf1 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -167,17 +167,6 @@
 
 struct sst_dsp;
 
-/*
- * SST Device.
- *
- * This structure is populated by the SST core driver.
- */
-struct sst_dsp_device {
-	/* Mandatory fields */
-	struct sst_ops *ops;
-	void *thread_context;
-};
-
 /*
  * SST Platform Data.
  */
@@ -203,13 +192,15 @@ struct sst_pdata {
 
 	/* DSP */
 	u32 id;
+	const char *fw_name;
+	struct sst_ops *ops;
+	struct snd_soc_acpi_mach *boards;
 	void *dsp;
 };
 
 #if IS_ENABLED(CONFIG_DW_DMAC_CORE)
 /* Initialization */
-struct sst_dsp *sst_dsp_new(struct device *dev,
-	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata);
+struct sst_dsp *sst_dsp_new(struct device *dev, struct sst_pdata *pdata);
 void sst_dsp_free(struct sst_dsp *sst);
 #endif
 
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index c18236ca77f4..6b6af11c32c3 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1200,8 +1200,7 @@ u32 sst_dsp_get_offset(struct sst_dsp *dsp, u32 offset,
 }
 EXPORT_SYMBOL_GPL(sst_dsp_get_offset);
 
-struct sst_dsp *sst_dsp_new(struct device *dev,
-	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata)
+struct sst_dsp *sst_dsp_new(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_dsp *sst;
 	int err;
@@ -1216,11 +1215,10 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 	mutex_init(&sst->mutex);
 	sst->dev = dev;
 	sst->dma_dev = pdata->dma_dev;
-	sst->thread_context = sst_dev->thread_context;
-	sst->sst_dev = sst_dev;
+	sst->thread_context = pdata->dsp;
 	sst->id = pdata->id;
 	sst->irq = pdata->irq;
-	sst->ops = sst_dev->ops;
+	sst->ops = pdata->ops;
 	sst->pdata = pdata;
 	INIT_LIST_HEAD(&sst->used_block_list);
 	INIT_LIST_HEAD(&sst->free_block_list);
diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index e25358d19aae..61c4d674940e 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2045,10 +2045,6 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 	return ret;
 }
 
-static struct sst_dsp_device hsw_dev = {
-	.ops = &haswell_ops,
-};
-
 static void hsw_tx_msg(struct sst_generic_ipc *ipc, struct ipc_message *msg)
 {
 	/* send the message */
@@ -2126,10 +2122,11 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 	INIT_LIST_HEAD(&hsw->stream_list);
 	init_waitqueue_head(&hsw->boot_wait);
-	hsw_dev.thread_context = hsw;
+	pdata->dsp = hsw;
+	pdata->ops = &haswell_ops;
 
 	/* init SST shim */
-	hsw->dsp = sst_dsp_new(dev, &hsw_dev, pdata);
+	hsw->dsp = sst_dsp_new(dev, pdata);
 	if (hsw->dsp == NULL) {
 		ret = -ENODEV;
 		goto dsp_new_err;
@@ -2189,7 +2186,6 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 		goto boot_err;
 	}
 
-	pdata->dsp = hsw;
 	return 0;
 
 boot_err:
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 8faffec4e943..e3614acff34d 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -543,7 +543,7 @@ static struct sst_ops skl_ops = {
 	.free = skl_dsp_free,
 };
 
-static struct sst_dsp_device skl_dev = {
+static struct sst_pdata skl_dev = {
 	.ops = &skl_ops,
 };
 
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
index f3d320b05eb5..30b586acc858 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.h
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -9,7 +9,7 @@
 #define __CNL_SST_DSP_H__
 
 struct sst_dsp;
-struct sst_dsp_device;
+struct sst_pdata;
 struct sst_generic_ipc;
 
 /* Intel HD Audio General DSP Registers */
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 02d8e72d2d5a..84dc6b82831d 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -419,7 +419,7 @@ static struct sst_ops cnl_ops = {
 	.free = cnl_dsp_free,
 };
 
-static struct sst_dsp_device cnl_dev = {
+static struct sst_pdata cnl_dev = {
 	.ops = &cnl_ops,
 };
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 8d98089e3177..348e69226e46 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -419,7 +419,7 @@ int skl_dsp_sleep(struct sst_dsp *ctx)
 EXPORT_SYMBOL_GPL(skl_dsp_sleep);
 
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
-		struct sst_dsp_device *sst_dev, int irq)
+		struct sst_pdata *pdata, int irq)
 {
 	int ret;
 	struct sst_dsp *sst;
@@ -431,10 +431,10 @@ struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 	spin_lock_init(&sst->spinlock);
 	mutex_init(&sst->mutex);
 	sst->dev = dev;
-	sst->sst_dev = sst_dev;
+	sst->pdata = pdata;
 	sst->irq = irq;
-	sst->ops = sst_dev->ops;
-	sst->thread_context = sst_dev->thread_context;
+	sst->ops = pdata->ops;
+	sst->thread_context = pdata->dsp;
 
 	/* Initialise SST Audio DSP */
 	if (sst->ops->init) {
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 21d376692503..ba37433e4efa 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -15,7 +15,7 @@
 #include "skl-sst-cldma.h"
 
 struct sst_dsp;
-struct sst_dsp_device;
+struct sst_pdata;
 struct skl_lib_info;
 struct skl_dev;
 
@@ -197,7 +197,7 @@ int skl_cldma_wait_interruptible(struct sst_dsp *ctx);
 
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
-		struct sst_dsp_device *sst_dev, int irq);
+		struct sst_pdata *pdata, int irq);
 int skl_dsp_acquire_irq(struct sst_dsp *sst);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
 
@@ -243,7 +243,7 @@ void skl_dsp_set_astate_cfg(struct skl_dev *skl, u32 cnt, void *data);
 
 int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 		struct skl_dsp_loader_ops dsp_ops, struct skl_dev **dsp,
-		struct sst_dsp_device *skl_dev);
+		struct sst_pdata *pdata);
 int skl_prepare_lib_load(struct skl_dev *skl, struct skl_lib_info *linfo,
 			struct firmware *stripped_fw,
 			unsigned int hdr_offset, int index);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index d43cbf4a71ef..9061a9b17ea0 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -355,15 +355,15 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw)
 
 int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 	struct skl_dsp_loader_ops dsp_ops, struct skl_dev **dsp,
-	struct sst_dsp_device *skl_dev)
+	struct sst_pdata *pdata)
 {
 	struct skl_dev *skl = *dsp;
 	struct sst_dsp *sst;
 
 	skl->dev = dev;
-	skl_dev->thread_context = skl;
+	pdata->dsp = skl;
 	INIT_LIST_HEAD(&skl->uuid_list);
-	skl->dsp = skl_dsp_ctx_init(dev, skl_dev, irq);
+	skl->dsp = skl_dsp_ctx_init(dev, pdata, irq);
 	if (!skl->dsp) {
 		dev_err(skl->dev, "%s: no device\n", __func__);
 		return -ENODEV;
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 9fd3cf30e87c..72ee3d8a1d7d 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -512,7 +512,7 @@ static struct sst_ops skl_ops = {
 	.free = skl_dsp_free,
 };
 
-static struct sst_dsp_device skl_dev = {
+static struct sst_pdata skl_dev = {
 	.ops = &skl_ops,
 };
 
-- 
2.17.1
