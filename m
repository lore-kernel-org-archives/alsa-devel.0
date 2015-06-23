From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/6] ASoC: Intel: Add DSP init and boot up
	functionality for SKL
Date: Tue, 23 Jun 2015 16:16:56 +0530
Message-ID: <1435056416-24653-7-git-send-email-vinod.koul@intel.com>
References: <1435056416-24653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 89859265749
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 12:45:34 +0200 (CEST)
In-Reply-To: <1435056416-24653-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This patch adds code to enable, disable and boot DSP core.
Also provide some helpers to reset and power up/down the core.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h |   4 +
 sound/soc/intel/skylake/Makefile      |   2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c | 338 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h |  61 ++++++
 4 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.c

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index cd6c7ecf6288..c1e5cbf7c580 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -22,6 +22,8 @@
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
 
+#include "../skylake/skl-sst-dsp.h"
+
 struct sst_mem_block;
 struct sst_module;
 struct sst_fw;
@@ -306,6 +308,8 @@ struct sst_dsp {
 
 	/* SKL data */
 
+	struct skl_fw_ops fw_ops;
+	int sst_state;
 	u32 intr_status;
 };
 
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index 18fbe647abca..10c1319f7ed5 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -3,6 +3,6 @@ snd-soc-skl-objs := skl.o skl-pcm.o
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
 
 # Skylake IPC Support
-snd-soc-skl-ipc-objs := skl-sst-ipc.o
+snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl-ipc.o
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
new file mode 100644
index 000000000000..e75ba2a9c3df
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -0,0 +1,338 @@
+/*
+ *  skl-sst-dsp.c - SKL SST library generic function
+ *
+ *  Copyright (C) 2014-15 Intel Corp
+ *  Author:Rafal Redzimski <rafal.f.redzimski@intel.com>
+ *		Jeeja KP <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <sound/pcm.h>
+
+#include "../common/sst-dsp.h"
+#include "../common/sst-ipc.h"
+#include "../common/sst-dsp-priv.h"
+#include "skl-sst-ipc.h"
+
+/* various timeout values */
+#define SKL_DSP_PU_TO		50
+#define SKL_DSP_PD_TO		50
+#define SKL_DSP_RESET_TO	50
+
+void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state)
+{
+	mutex_lock(&ctx->mutex);
+	ctx->sst_state = state;
+	mutex_unlock(&ctx->mutex);
+}
+
+static int skl_dsp_core_set_reset_state(struct sst_dsp  *ctx)
+{
+	int ret;
+
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx,  SKL_ADSP_REG_ADSPCS,
+			ADSPCS_CRST_MASK, ADSPCS_CRST(SKL_DSP_CORES_MASK));
+
+	/* poll with timeout to check if operation successful */
+	ret = sst_dsp_register_poll(ctx,
+			SKL_ADSP_REG_ADSPCS,
+			ADSPCS_CRST_MASK,
+			ADSPCS_CRST(SKL_DSP_CORES_MASK),
+			SKL_DSP_RESET_TO,
+			"Set reset");
+	if ((sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
+				ADSPCS_CRST(SKL_DSP_CORES_MASK)) !=
+				ADSPCS_CRST(SKL_DSP_CORES_MASK)) {
+		dev_err(ctx->dev, "Set reset state failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int skl_dsp_core_unset_reset_state(struct sst_dsp  *ctx)
+{
+	int ret;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+					ADSPCS_CRST_MASK, 0);
+
+	/* poll with timeout to check if operation successful */
+	ret = sst_dsp_register_poll(ctx,
+			SKL_ADSP_REG_ADSPCS,
+			ADSPCS_CRST_MASK,
+			0,
+			SKL_DSP_RESET_TO,
+			"Unset reset");
+
+	if ((sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
+				 ADSPCS_CRST(SKL_DSP_CORES_MASK)) != 0) {
+		dev_err(ctx->dev, "Unset reset state failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static bool skl_is_dsp_core_enable(struct sst_dsp  *ctx)
+{
+	int val;
+	bool is_enable;
+
+	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS);
+
+	is_enable = ((val & ADSPCS_CPA(SKL_DSP_CORES_MASK)) &&
+			(val & ADSPCS_SPA(SKL_DSP_CORES_MASK)) &&
+			!(val & ADSPCS_CRST(SKL_DSP_CORES_MASK)) &&
+			!(val & ADSPCS_CSTALL(SKL_DSP_CORES_MASK)));
+
+	dev_dbg(ctx->dev, "DSP core is enabled=%d\n", is_enable);
+	return is_enable;
+}
+
+static int skl_reset_dsp_core(struct sst_dsp *ctx)
+{
+	/* stall core */
+	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+			 sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
+				ADSPCS_CSTALL(SKL_DSP_CORES_MASK));
+
+	/* set reset state */
+	return skl_dsp_core_set_reset_state(ctx);
+}
+
+static int skl_start_dsp_core(struct sst_dsp *ctx)
+{
+	int ret;
+
+	/* unset reset state */
+	ret = skl_dsp_core_unset_reset_state(ctx);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "dsp unset reset fails\n");
+		return ret;
+	}
+
+	/* run core */
+	dev_dbg(ctx->dev, "run core...\n");
+	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+			 sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
+				~ADSPCS_CSTALL(SKL_DSP_CORES_MASK));
+
+	if (!skl_is_dsp_core_enable(ctx)) {
+		skl_reset_dsp_core(ctx);
+		dev_err(ctx->dev, "DSP core enable failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int skl_dsp_core_power_up(struct sst_dsp  *ctx)
+{
+	int ret;
+
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+			ADSPCS_SPA_MASK, ADSPCS_SPA(SKL_DSP_CORES_MASK));
+
+	/* poll with timeout to check if operation successful */
+	ret = sst_dsp_register_poll(ctx,
+			SKL_ADSP_REG_ADSPCS,
+			ADSPCS_CPA_MASK,
+			ADSPCS_CPA(SKL_DSP_CORES_MASK),
+			SKL_DSP_PU_TO,
+			"Power up");
+
+	if ((sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
+			ADSPCS_CPA(SKL_DSP_CORES_MASK)) !=
+			ADSPCS_CPA(SKL_DSP_CORES_MASK)) {
+		dev_err(ctx->dev, "DSP core power up failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int skl_dsp_core_power_down(struct sst_dsp  *ctx)
+{
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+					ADSPCS_SPA_MASK, 0);
+
+	/* poll with timeout to check if operation successful */
+	return sst_dsp_register_poll(ctx,
+			SKL_ADSP_REG_ADSPCS,
+			ADSPCS_SPA_MASK,
+			0,
+			SKL_DSP_PD_TO,
+			"Power down");
+}
+
+static int skl_enable_dsp_core(struct sst_dsp  *ctx)
+{
+	int ret;
+
+	/* power up */
+	ret = skl_dsp_core_power_up(ctx);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "dsp core power up failed\n");
+		return ret;
+	}
+
+	return skl_start_dsp_core(ctx);
+}
+
+int skl_disable_dsp_core(struct sst_dsp  *ctx)
+{
+	int ret;
+
+	ret = skl_reset_dsp_core(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core reset failed\n");
+		return ret;
+	}
+
+	/* power down core*/
+	ret = skl_dsp_core_power_down(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core power down failed\n");
+		return ret;
+	}
+
+	if (skl_is_dsp_core_enable(ctx)) {
+		dev_err(ctx->dev, "DSP core disable failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int skl_boot_dsp(struct sst_dsp *ctx)
+{
+	int ret;
+
+	if (skl_is_dsp_core_enable(ctx)) {
+		dev_dbg(ctx->dev, "dsp core is already enabled, so reset the dap core\n");
+		ret = skl_reset_dsp_core(ctx);
+		if (ret < 0) {
+			dev_err(ctx->dev, "dsp reset failed\n");
+			return ret;
+		}
+
+		ret = skl_start_dsp_core(ctx);
+		if (ret < 0) {
+			dev_err(ctx->dev, "dsp start failed\n");
+			return ret;
+		}
+	} else {
+		dev_dbg(ctx->dev, "disable and enable to make sure DSP is invalid state\n");
+		ret = skl_disable_dsp_core(ctx);
+
+		if (ret < 0) {
+			dev_err(ctx->dev, "dsp disable core failes\n");
+			return ret;
+		}
+		ret = skl_enable_dsp_core(ctx);
+	}
+
+	return ret;
+}
+
+irqreturn_t skl_sst_interrupt(int irq, void *dev_id)
+{
+	struct sst_dsp *ctx = (struct sst_dsp *) dev_id;
+	u32 val;
+	irqreturn_t result = IRQ_NONE;
+
+	spin_lock(&ctx->spinlock);
+
+	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPIS);
+	ctx->intr_status = val;
+
+	if (val & SKL_ADSPIS_IPC) {
+		skl_ipc_int_disable(ctx);
+		result = IRQ_WAKE_THREAD;
+	}
+
+	spin_unlock(&ctx->spinlock);
+
+	return result;
+}
+
+int skl_dsp_wake(struct sst_dsp *ctx)
+{
+	return ctx->fw_ops.set_state_D0(ctx);
+}
+
+void skl_dsp_sleep(struct sst_dsp *ctx)
+{
+	ctx->fw_ops.set_state_D3(ctx);
+}
+
+struct sst_dsp *skl_dsp_init(struct device *dev,
+		struct sst_dsp_device *sst_dev, int irq)
+{
+	int ret;
+	struct sst_dsp *sst;
+
+	sst = devm_kzalloc(dev, sizeof(*sst), GFP_KERNEL);
+	if (sst == NULL)
+		return NULL;
+
+	spin_lock_init(&sst->spinlock);
+	mutex_init(&sst->mutex);
+	sst->dev = dev;
+	sst->sst_dev = sst_dev;
+	sst->irq = irq;
+	sst->ops = sst_dev->ops;
+	sst->thread_context = sst_dev->thread_context;
+
+	/* Initialise SST Audio DSP */
+	if (sst->ops->init) {
+		ret = sst->ops->init(sst, NULL);
+		if (ret < 0)
+			return NULL;
+	}
+
+	/* Register the ISR */
+	ret = request_threaded_irq(sst->irq, sst->ops->irq_handler,
+		sst_dev->thread, IRQF_SHARED, "AudioDSP", sst);
+	if (ret) {
+		dev_err(sst->dev, "unable to grab threaded IRQ %d, disabling device\n",
+			       sst->irq);
+		return NULL;
+	}
+
+	return sst;
+}
+
+void skl_dsp_free(struct sst_dsp *dsp)
+{
+	skl_ipc_int_disable(dsp);
+
+	free_irq(dsp->irq, dsp);
+	skl_disable_dsp_core(dsp);
+}
+EXPORT_SYMBOL_GPL(skl_dsp_free);
+
+bool skl_dsp_is_running(struct sst_dsp *ctx)
+{
+	return (ctx->sst_state == SST_DSP_RUNNING);
+}
+EXPORT_SYMBOL_GPL(skl_dsp_is_running);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 1eceddef4a98..e96968b1b8ba 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -17,6 +17,10 @@
 #ifndef __SKL_SST_DSP_H__
 #define __SKL_SST_DSP_H__
 
+struct sst_skl;
+struct sst_dsp_device;
+struct skl_dsp_loader_ops;
+
 /* Intel HD Audio General DSP Registers */
 #define SKL_ADSP_GEN_BASE		0x0
 #define SKL_ADSP_REG_ADSPCS		(SKL_ADSP_GEN_BASE + 0x04)
@@ -60,4 +64,61 @@
 #define SKL_ADSPIC_IPC			1
 #define SKL_ADSPIS_IPC			1
 
+/* ADSPCS - Audio DSP Control & Status */
+#define SKL_DSP_CORES		0
+#define SKL_DSP_CORE0_MASK		1
+#define SKL_DSP_CORES_MASK		((1 << SKL_DSP_CORES) - 1)
+
+/* Core Reset - asserted high */
+#define ADSPCS_CRST_SHIFT	0
+#define ADSPCS_CRST_MASK	(SKL_DSP_CORES_MASK << ADSPCS_CRST_SHIFT)
+#define ADSPCS_CRST(x)		((x << ADSPCS_CRST_SHIFT) & ADSPCS_CRST_MASK)
+
+/* Core run/stall - when set to '1' core is stalled */
+#define ADSPCS_CSTALL_SHIFT	8
+#define ADSPCS_CSTALL_MASK	(SKL_DSP_CORES_MASK << ADSPCS_CSTALL_SHIFT)
+#define ADSPCS_CSTALL(x)	((x << ADSPCS_CSTALL_SHIFT) & ADSPCS_CSTALL_MASK)
+
+/* Set Power Active - when set to '1' turn cores on */
+#define ADSPCS_SPA_SHIFT	16
+#define ADSPCS_SPA_MASK		(SKL_DSP_CORES_MASK << ADSPCS_SPA_SHIFT)
+#define ADSPCS_SPA(x)		((x << ADSPCS_SPA_SHIFT) & ADSPCS_SPA_MASK)
+
+/* Current Power Active - power status of cores, set by hardware */
+#define ADSPCS_CPA_SHIFT	24
+#define ADSPCS_CPA_MASK		(SKL_DSP_CORES_MASK << ADSPCS_CPA_SHIFT)
+#define ADSPCS_CPA(x)		((x << ADSPCS_CPA_SHIFT) & ADSPCS_CPA_MASK)
+
+#define SST_DSP_POWER_D0	0x0  /* full On */
+#define SST_DSP_POWER_D3	0x3  /* Off */
+
+enum skl_states {
+	SST_DSP_RUNNING = 1,
+	SST_DSP_RESET,
+};
+
+struct skl_fw_ops {
+	int (*load_fw)(struct sst_dsp  *ctx);
+	/* FW module parser/loader */
+	int (*parse_fw)(struct sst_dsp *ctx);
+	int (*set_state_D0)(struct sst_dsp *ctx);
+	int (*set_state_D3)(struct sst_dsp *ctx);
+};
+
+void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
+struct sst_dsp *skl_dsp_init(struct device *dev,
+		struct sst_dsp_device *sst_dev, int irq);
+int skl_disable_dsp_core(struct sst_dsp  *ctx);
+bool skl_dsp_is_running(struct sst_dsp *ctx);
+irqreturn_t skl_sst_interrupt(int irq, void *dev_id);
+int skl_dsp_wake(struct sst_dsp *ctx);
+void skl_dsp_sleep(struct sst_dsp *ctx);
+int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
+		struct skl_dsp_loader_ops dsp_ops, struct sst_skl **dsp);
+void skl_dsp_free(struct sst_dsp *dsp);
+void skl_cleanup(struct device *dev, struct sst_skl *ctx);
+
+int skl_boot_dsp(struct sst_dsp *ctx);
+
+
 #endif /*__SKL_SST_DSP_H__*/
-- 
1.9.1
