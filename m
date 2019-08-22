From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 10/35] ASoC: Intel: Relocate irq thread header
	to sst_ops
Date: Thu, 22 Aug 2019 21:04:00 +0200
Message-ID: <20190822190425.23001-11-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D075F8036D
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:57 +0200 (CEST)
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

thread_fn is the only DSP core op which is located outside of sst_ops.
Add it to the rest. Change enables further cleanups by following
patches, mainly removal of sst_dsp_device struct.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-dsp.c |  1 +
 sound/soc/intel/baytrail/sst-baytrail-ipc.c |  3 +--
 sound/soc/intel/baytrail/sst-baytrail-ipc.h |  2 ++
 sound/soc/intel/common/sst-dsp-priv.h       |  1 +
 sound/soc/intel/common/sst-dsp.h            |  1 -
 sound/soc/intel/common/sst-firmware.c       |  2 +-
 sound/soc/intel/haswell/sst-haswell-dsp.c   |  1 +
 sound/soc/intel/haswell/sst-haswell-ipc.c   |  3 +--
 sound/soc/intel/haswell/sst-haswell-ipc.h   |  2 ++
 sound/soc/intel/skylake/bxt-sst.c           |  2 +-
 sound/soc/intel/skylake/cnl-sst.c           | 28 ++++++++++-----------
 sound/soc/intel/skylake/skl-sst-dsp.c       |  3 +--
 sound/soc/intel/skylake/skl-sst.c           |  1 -
 13 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-dsp.c b/sound/soc/intel/baytrail/sst-baytrail-dsp.c
index 4116ba66a4c2..4869e18116eb 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-dsp.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-dsp.c
@@ -352,6 +352,7 @@ struct sst_ops sst_byt_ops = {
 	.ram_read = sst_memcpy_fromio_32,
 	.ram_write = sst_memcpy_toio_32,
 	.irq_handler = sst_byt_irq,
+	.thread_fn = sst_byt_irq_thread,
 	.init = sst_byt_init,
 	.free = sst_byt_free,
 	.parse_fw = sst_byt_parse_fw_image,
diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 74274bd38f7a..23d65ad38e19 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -293,7 +293,7 @@ static int sst_byt_process_notification(struct sst_byt *byt,
 	return 1;
 }
 
-static irqreturn_t sst_byt_irq_thread(int irq, void *context)
+irqreturn_t sst_byt_irq_thread(int irq, void *context)
 {
 	struct sst_dsp *sst = (struct sst_dsp *) context;
 	struct sst_byt *byt = sst_dsp_get_thread_context(sst);
@@ -557,7 +557,6 @@ struct sst_dsp *sst_byt_get_dsp(struct sst_byt *byt)
 }
 
 static struct sst_dsp_device byt_dev = {
-	.thread = sst_byt_irq_thread,
 	.ops = &sst_byt_ops,
 };
 
diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.h b/sound/soc/intel/baytrail/sst-baytrail-ipc.h
index 755098509327..9aba6b83ee5f 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.h
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.h
@@ -7,6 +7,7 @@
 #ifndef __SST_BYT_IPC_H
 #define __SST_BYT_IPC_H
 
+#include <linux/irqreturn.h>
 #include <linux/types.h>
 
 struct sst_byt;
@@ -61,5 +62,6 @@ struct sst_dsp *sst_byt_get_dsp(struct sst_byt *byt);
 int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata);
 int sst_byt_dsp_boot(struct device *dev, struct sst_pdata *pdata);
 int sst_byt_dsp_wait_for_ready(struct device *dev, struct sst_pdata *pdata);
+irqreturn_t sst_byt_irq_thread(int irq, void *context);
 
 #endif
diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 3d8765ce3e0d..7ec477108948 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -49,6 +49,7 @@ struct sst_ops {
 
 	/* IRQ handlers */
 	irqreturn_t (*irq_handler)(int irq, void *context);
+	irqreturn_t (*thread_fn)(int irq, void *context);
 
 	/* SST init and free */
 	int (*init)(struct sst_dsp *sst, struct sst_pdata *pdata);
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 604a80c5859b..05fa1ca72f46 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -175,7 +175,6 @@ struct sst_dsp;
 struct sst_dsp_device {
 	/* Mandatory fields */
 	struct sst_ops *ops;
-	irqreturn_t (*thread)(int irq, void *context);
 	void *thread_context;
 };
 
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index d27947aeb079..c18236ca77f4 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1237,7 +1237,7 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 
 	/* Register the ISR */
 	err = request_threaded_irq(sst->irq, sst->ops->irq_handler,
-		sst_dev->thread, IRQF_SHARED, "AudioDSP", sst);
+		sst->ops->thread_fn, IRQF_SHARED, "AudioDSP", sst);
 	if (err)
 		goto irq_err;
 
diff --git a/sound/soc/intel/haswell/sst-haswell-dsp.c b/sound/soc/intel/haswell/sst-haswell-dsp.c
index 88c3f63bded9..c099dec7d61f 100644
--- a/sound/soc/intel/haswell/sst-haswell-dsp.c
+++ b/sound/soc/intel/haswell/sst-haswell-dsp.c
@@ -699,6 +699,7 @@ struct sst_ops haswell_ops = {
 	.ram_read = sst_memcpy_fromio_32,
 	.ram_write = sst_memcpy_toio_32,
 	.irq_handler = hsw_irq,
+	.thread_fn = hsw_irq_thread,
 	.init = hsw_init,
 	.free = hsw_free,
 	.parse_fw = hsw_parse_fw_image,
diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 5c73b11375e3..e25358d19aae 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -757,7 +757,7 @@ static int hsw_process_notification(struct sst_hsw *hsw)
 	return handled;
 }
 
-static irqreturn_t hsw_irq_thread(int irq, void *context)
+irqreturn_t hsw_irq_thread(int irq, void *context)
 {
 	struct sst_dsp *sst = (struct sst_dsp *) context;
 	struct sst_hsw *hsw = sst_dsp_get_thread_context(sst);
@@ -2046,7 +2046,6 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 }
 
 static struct sst_dsp_device hsw_dev = {
-	.thread = hsw_irq_thread,
 	.ops = &haswell_ops,
 };
 
diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.h b/sound/soc/intel/haswell/sst-haswell-ipc.h
index fdc70c77e688..d4a936a75f7d 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.h
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.h
@@ -8,6 +8,7 @@
 #ifndef __SST_HASWELL_IPC_H
 #define __SST_HASWELL_IPC_H
 
+#include <linux/irqreturn.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -396,6 +397,7 @@ struct sst_hsw_ipc_fw_version;
 struct sst_hsw *sst_hsw_new(struct device *dev, const u8 *fw, size_t fw_length,
 	u32 fw_offset);
 void sst_hsw_free(struct sst_hsw *hsw);
+irqreturn_t hsw_irq_thread(int irq, void *context);
 int sst_hsw_fw_get_version(struct sst_hsw *hsw,
 	struct sst_hsw_ipc_fw_version *version);
 u32 create_channel_map(enum sst_hsw_channel_config config);
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 4e5fb7684415..8faffec4e943 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -535,6 +535,7 @@ static const struct skl_dsp_fw_ops bxt_fw_ops = {
 
 static struct sst_ops skl_ops = {
 	.irq_handler = skl_dsp_sst_interrupt,
+	.thread_fn = skl_dsp_irq_thread_handler,
 	.write = sst_shim32_write,
 	.read = sst_shim32_read,
 	.ram_read = sst_memcpy_fromio_32,
@@ -543,7 +544,6 @@ static struct sst_ops skl_ops = {
 };
 
 static struct sst_dsp_device skl_dev = {
-	.thread = skl_dsp_irq_thread_handler,
 	.ops = &skl_ops,
 };
 
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 5143200579aa..02d8e72d2d5a 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -286,15 +286,6 @@ static const struct skl_dsp_fw_ops cnl_fw_ops = {
 	.load_library = bxt_load_library,
 };
 
-static struct sst_ops cnl_ops = {
-	.irq_handler = cnl_dsp_sst_interrupt,
-	.write = sst_shim32_write,
-	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
-	.free = cnl_dsp_free,
-};
-
 #define CNL_IPC_GLB_NOTIFY_RSP_SHIFT	29
 #define CNL_IPC_GLB_NOTIFY_RSP_MASK	0x1
 #define CNL_IPC_GLB_NOTIFY_RSP_TYPE(x)	(((x) >> CNL_IPC_GLB_NOTIFY_RSP_SHIFT) \
@@ -370,11 +361,6 @@ static irqreturn_t cnl_dsp_irq_thread_handler(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
-static struct sst_dsp_device cnl_dev = {
-	.thread = cnl_dsp_irq_thread_handler,
-	.ops = &cnl_ops,
-};
-
 static void cnl_ipc_tx_msg(struct sst_generic_ipc *ipc, struct ipc_message *msg)
 {
 	struct skl_ipc_header *header = (struct skl_ipc_header *)(&msg->tx.header);
@@ -423,6 +409,20 @@ static int cnl_ipc_init(struct device *dev, struct skl_dev *cnl)
 	return 0;
 }
 
+static struct sst_ops cnl_ops = {
+	.irq_handler = cnl_dsp_sst_interrupt,
+	.thread_fn = cnl_dsp_irq_thread_handler,
+	.write = sst_shim32_write,
+	.read = sst_shim32_read,
+	.ram_read = sst_memcpy_fromio_32,
+	.ram_write = sst_memcpy_toio_32,
+	.free = cnl_dsp_free,
+};
+
+static struct sst_dsp_device cnl_dev = {
+	.ops = &cnl_ops,
+};
+
 int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		     const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		     struct skl_dev **dsp)
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index e0807db225f4..8d98089e3177 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -448,12 +448,11 @@ struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 
 int skl_dsp_acquire_irq(struct sst_dsp *sst)
 {
-	struct sst_dsp_device *sst_dev = sst->sst_dev;
 	int ret;
 
 	/* Register the ISR */
 	ret = request_threaded_irq(sst->irq, sst->ops->irq_handler,
-		sst_dev->thread, IRQF_SHARED, "AudioDSP", sst);
+		sst->ops->thread_fn, IRQF_SHARED, "AudioDSP", sst);
 	if (ret)
 		dev_err(sst->dev, "unable to grab threaded IRQ %d, disabling device\n",
 			       sst->irq);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index a7a285ea24e1..9fd3cf30e87c 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -513,7 +513,6 @@ static struct sst_ops skl_ops = {
 };
 
 static struct sst_dsp_device skl_dev = {
-	.thread = skl_dsp_irq_thread_handler,
 	.ops = &skl_ops,
 };
 
-- 
2.17.1
