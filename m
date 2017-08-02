From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 4/9] ASoC: Intel: cnl: Add cnl dsp functions
	and registers
Date: Wed,  2 Aug 2017 21:51:15 +0530
Message-ID: <20170802162120.8935-5-guneshwor.o.singh@intel.com>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0475C267356
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 18:25:34 +0200 (CEST)
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds Cannonlake specific registers and support for CNL dsp related
library functions for programming the registers to power up/down dsp cores,
set/unset reset states for each core, enable/disable ipc interrupts and few
wrappers to be called from elsewhere.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/cnl-sst-dsp.c | 274 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/cnl-sst-dsp.h | 106 +++++++++++++
 2 files changed, 380 insertions(+)
 create mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.c
 create mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.h

diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.c b/sound/soc/intel/skylake/cnl-sst-dsp.c
new file mode 100644
index 000000000000..2f8326707c21
--- /dev/null
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.c
@@ -0,0 +1,274 @@
+/*
+ * cnl-sst-dsp.c - CNL SST library generic function
+ *
+ * Copyright (C) 2016-17, Intel Corporation.
+ * Author: Guneshwor Singh <guneshwor.o.singh@intel.com>
+ *
+ * Modified from:
+ *	SKL SST library generic function
+ *	Copyright (C) 2014-15, Intel Corporation.
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/device.h>
+#include "../common/sst-dsp.h"
+#include "../common/sst-ipc.h"
+#include "../common/sst-dsp-priv.h"
+#include "cnl-sst-dsp.h"
+
+/* various timeout values */
+#define CNL_DSP_PU_TO		50
+#define CNL_DSP_PD_TO		50
+#define CNL_DSP_RESET_TO	50
+
+static int
+cnl_dsp_core_set_reset_state(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx,
+			CNL_ADSP_REG_ADSPCS, CNL_ADSPCS_CRST(core_mask),
+			CNL_ADSPCS_CRST(core_mask));
+
+	/* poll with timeout to check if operation successful */
+	return sst_dsp_register_poll(ctx,
+			CNL_ADSP_REG_ADSPCS,
+			CNL_ADSPCS_CRST(core_mask),
+			CNL_ADSPCS_CRST(core_mask),
+			CNL_DSP_RESET_TO,
+			"Set reset");
+}
+
+static int
+cnl_dsp_core_unset_reset_state(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx, CNL_ADSP_REG_ADSPCS,
+					CNL_ADSPCS_CRST(core_mask), 0);
+
+	/* poll with timeout to check if operation successful */
+	return sst_dsp_register_poll(ctx,
+			CNL_ADSP_REG_ADSPCS,
+			CNL_ADSPCS_CRST(core_mask),
+			0,
+			CNL_DSP_RESET_TO,
+			"Unset reset");
+}
+
+static bool is_cnl_dsp_core_enable(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	int val;
+	bool is_enable;
+
+	val = sst_dsp_shim_read_unlocked(ctx, CNL_ADSP_REG_ADSPCS);
+
+	is_enable = (val & CNL_ADSPCS_CPA(core_mask)) &&
+			(val & CNL_ADSPCS_SPA(core_mask)) &&
+			!(val & CNL_ADSPCS_CRST(core_mask)) &&
+			!(val & CNL_ADSPCS_CSTALL(core_mask));
+
+	dev_dbg(ctx->dev, "DSP core(s) enabled? %d: core_mask %#x\n",
+		is_enable, core_mask);
+
+	return is_enable;
+}
+
+static int cnl_dsp_reset_core(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	/* stall core */
+	sst_dsp_shim_update_bits_unlocked(ctx, CNL_ADSP_REG_ADSPCS,
+			CNL_ADSPCS_CSTALL(core_mask),
+			CNL_ADSPCS_CSTALL(core_mask));
+
+	/* set reset state */
+	return cnl_dsp_core_set_reset_state(ctx, core_mask);
+}
+
+static int cnl_dsp_start_core(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	int ret;
+
+	/* unset reset state */
+	ret = cnl_dsp_core_unset_reset_state(ctx, core_mask);
+	if (ret < 0)
+		return ret;
+
+	/* run core */
+	sst_dsp_shim_update_bits_unlocked(ctx, CNL_ADSP_REG_ADSPCS,
+				CNL_ADSPCS_CSTALL(core_mask), 0);
+
+	if (!is_cnl_dsp_core_enable(ctx, core_mask)) {
+		cnl_dsp_reset_core(ctx, core_mask);
+		dev_err(ctx->dev, "DSP core mask %#x enable failed\n",
+			core_mask);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int cnl_dsp_core_power_up(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx, CNL_ADSP_REG_ADSPCS,
+					  CNL_ADSPCS_SPA(core_mask),
+					  CNL_ADSPCS_SPA(core_mask));
+
+	/* poll with timeout to check if operation successful */
+	return sst_dsp_register_poll(ctx, CNL_ADSP_REG_ADSPCS,
+				    CNL_ADSPCS_CPA(core_mask),
+				    CNL_ADSPCS_CPA(core_mask),
+				    CNL_DSP_PU_TO,
+				    "Power up");
+}
+
+static int cnl_dsp_core_power_down(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	/* update bits */
+	sst_dsp_shim_update_bits_unlocked(ctx, CNL_ADSP_REG_ADSPCS,
+					CNL_ADSPCS_SPA(core_mask), 0);
+
+	/* poll with timeout to check if operation successful */
+	return sst_dsp_register_poll(ctx,
+			CNL_ADSP_REG_ADSPCS,
+			CNL_ADSPCS_CPA(core_mask),
+			0,
+			CNL_DSP_PD_TO,
+			"Power down");
+}
+
+int cnl_dsp_enable_core(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	int ret;
+
+	/* power up */
+	ret = cnl_dsp_core_power_up(ctx, core_mask);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "DSP core mask %#x power up failed",
+			core_mask);
+		return ret;
+	}
+
+	return cnl_dsp_start_core(ctx, core_mask);
+}
+
+int cnl_dsp_disable_core(struct sst_dsp *ctx, unsigned int core_mask)
+{
+	int ret;
+
+	ret = cnl_dsp_reset_core(ctx, core_mask);
+	if (ret < 0) {
+		dev_err(ctx->dev, "DSP core mask %#x reset failed\n",
+			core_mask);
+		return ret;
+	}
+
+	/* power down core*/
+	ret = cnl_dsp_core_power_down(ctx, core_mask);
+	if (ret < 0) {
+		dev_err(ctx->dev, "DSP core mask %#x power down failed\n",
+			core_mask);
+		return ret;
+	}
+
+	if (is_cnl_dsp_core_enable(ctx, core_mask)) {
+		dev_err(ctx->dev, "DSP core mask %#x disable failed\n",
+			core_mask);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+irqreturn_t cnl_dsp_sst_interrupt(int irq, void *dev_id)
+{
+	struct sst_dsp *ctx = dev_id;
+	u32 val;
+	irqreturn_t ret = IRQ_NONE;
+
+	spin_lock(&ctx->spinlock);
+
+	val = sst_dsp_shim_read_unlocked(ctx, CNL_ADSP_REG_ADSPIS);
+	ctx->intr_status = val;
+
+	if (val == 0xffffffff) {
+		spin_unlock(&ctx->spinlock);
+		return IRQ_NONE;
+	}
+
+	if (val & CNL_ADSPIS_IPC) {
+		cnl_ipc_int_disable(ctx);
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	spin_unlock(&ctx->spinlock);
+
+	return ret;
+}
+
+void cnl_dsp_free(struct sst_dsp *dsp)
+{
+	cnl_ipc_int_disable(dsp);
+
+	free_irq(dsp->irq, dsp);
+	cnl_ipc_op_int_disable(dsp);
+	cnl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
+}
+EXPORT_SYMBOL_GPL(cnl_dsp_free);
+
+void cnl_ipc_int_enable(struct sst_dsp *ctx)
+{
+	sst_dsp_shim_update_bits(ctx, CNL_ADSP_REG_ADSPIC,
+				 CNL_ADSPIC_IPC, CNL_ADSPIC_IPC);
+}
+
+void cnl_ipc_int_disable(struct sst_dsp *ctx)
+{
+	sst_dsp_shim_update_bits_unlocked(ctx, CNL_ADSP_REG_ADSPIC,
+					  CNL_ADSPIC_IPC, 0);
+}
+
+void cnl_ipc_op_int_enable(struct sst_dsp *ctx)
+{
+	/* enable IPC DONE interrupt */
+	sst_dsp_shim_update_bits(ctx, CNL_ADSP_REG_HIPCCTL,
+				 CNL_ADSP_REG_HIPCCTL_DONE,
+				 CNL_ADSP_REG_HIPCCTL_DONE);
+
+	/* enable IPC BUSY interrupt */
+	sst_dsp_shim_update_bits(ctx, CNL_ADSP_REG_HIPCCTL,
+				 CNL_ADSP_REG_HIPCCTL_BUSY,
+				 CNL_ADSP_REG_HIPCCTL_BUSY);
+}
+
+void cnl_ipc_op_int_disable(struct sst_dsp *ctx)
+{
+	/* disable IPC DONE interrupt */
+	sst_dsp_shim_update_bits(ctx, CNL_ADSP_REG_HIPCCTL,
+				 CNL_ADSP_REG_HIPCCTL_DONE, 0);
+
+	/* disable IPC BUSY interrupt */
+	sst_dsp_shim_update_bits(ctx, CNL_ADSP_REG_HIPCCTL,
+				 CNL_ADSP_REG_HIPCCTL_BUSY, 0);
+}
+
+bool cnl_ipc_int_status(struct sst_dsp *ctx)
+{
+	return sst_dsp_shim_read_unlocked(ctx, CNL_ADSP_REG_ADSPIS) &
+							CNL_ADSPIS_IPC;
+}
+
+void cnl_ipc_free(struct sst_generic_ipc *ipc)
+{
+	cnl_ipc_op_int_disable(ipc->dsp);
+	sst_ipc_fini(ipc);
+}
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
new file mode 100644
index 000000000000..2fe41b137a2c
--- /dev/null
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -0,0 +1,106 @@
+/*
+ * Cannonlake SST DSP Support
+ *
+ * Copyright (C) 2016-17, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef __CNL_SST_DSP_H__
+#define __CNL_SST_DSP_H__
+
+struct sst_dsp;
+struct skl_sst;
+struct sst_dsp_device;
+struct sst_generic_ipc;
+
+/* Intel HD Audio General DSP Registers */
+#define CNL_ADSP_GEN_BASE		0x0
+#define CNL_ADSP_REG_ADSPCS		(CNL_ADSP_GEN_BASE + 0x04)
+#define CNL_ADSP_REG_ADSPIC		(CNL_ADSP_GEN_BASE + 0x08)
+#define CNL_ADSP_REG_ADSPIS		(CNL_ADSP_GEN_BASE + 0x0c)
+
+/* Intel HD Audio Inter-Processor Communication Registers */
+#define CNL_ADSP_IPC_BASE               0xc0
+#define CNL_ADSP_REG_HIPCTDR            (CNL_ADSP_IPC_BASE + 0x00)
+#define CNL_ADSP_REG_HIPCTDA            (CNL_ADSP_IPC_BASE + 0x04)
+#define CNL_ADSP_REG_HIPCTDD            (CNL_ADSP_IPC_BASE + 0x08)
+#define CNL_ADSP_REG_HIPCIDR            (CNL_ADSP_IPC_BASE + 0x10)
+#define CNL_ADSP_REG_HIPCIDA            (CNL_ADSP_IPC_BASE + 0x14)
+#define CNL_ADSP_REG_HIPCIDD            (CNL_ADSP_IPC_BASE + 0x18)
+#define CNL_ADSP_REG_HIPCCTL            (CNL_ADSP_IPC_BASE + 0x28)
+
+/* HIPCTDR */
+#define CNL_ADSP_REG_HIPCTDR_BUSY	BIT(31)
+
+/* HIPCTDA */
+#define CNL_ADSP_REG_HIPCTDA_DONE	BIT(31)
+
+/* HIPCIDR */
+#define CNL_ADSP_REG_HIPCIDR_BUSY	BIT(31)
+
+/* HIPCIDA */
+#define CNL_ADSP_REG_HIPCIDA_DONE	BIT(31)
+
+/* CNL HIPCCTL */
+#define CNL_ADSP_REG_HIPCCTL_DONE	BIT(1)
+#define CNL_ADSP_REG_HIPCCTL_BUSY	BIT(0)
+
+/* CNL HIPCT */
+#define CNL_ADSP_REG_HIPCT_BUSY		BIT(31)
+
+/* Intel HD Audio SRAM Window 1 */
+#define CNL_ADSP_SRAM1_BASE		0xa0000
+
+#define CNL_ADSP_MMIO_LEN		0x10000
+
+#define CNL_ADSP_W0_STAT_SZ		0x1000
+
+#define CNL_ADSP_W0_UP_SZ		0x1000
+
+#define CNL_ADSP_W1_SZ			0x1000
+
+#define CNL_FW_STS_MASK			0xf
+
+#define CNL_ADSPIC_IPC			0x1
+#define CNL_ADSPIS_IPC			0x1
+
+#define CNL_DSP_CORES		4
+#define CNL_DSP_CORES_MASK	((1 << CNL_DSP_CORES) - 1)
+
+/* core reset - asserted high */
+#define CNL_ADSPCS_CRST_SHIFT	0
+#define CNL_ADSPCS_CRST(x)	(x << CNL_ADSPCS_CRST_SHIFT)
+
+/* core run/stall - when set to 1 core is stalled */
+#define CNL_ADSPCS_CSTALL_SHIFT	8
+#define CNL_ADSPCS_CSTALL(x)	(x << CNL_ADSPCS_CSTALL_SHIFT)
+
+/* set power active - when set to 1 turn core on */
+#define CNL_ADSPCS_SPA_SHIFT	16
+#define CNL_ADSPCS_SPA(x)	(x << CNL_ADSPCS_SPA_SHIFT)
+
+/* current power active - power status of cores, set by hardware */
+#define CNL_ADSPCS_CPA_SHIFT	24
+#define CNL_ADSPCS_CPA(x)	(x << CNL_ADSPCS_CPA_SHIFT)
+
+int cnl_dsp_enable_core(struct sst_dsp *ctx, unsigned int core);
+int cnl_dsp_disable_core(struct sst_dsp *ctx, unsigned int core);
+irqreturn_t cnl_dsp_sst_interrupt(int irq, void *dev_id);
+void cnl_dsp_free(struct sst_dsp *dsp);
+
+void cnl_ipc_int_enable(struct sst_dsp *ctx);
+void cnl_ipc_int_disable(struct sst_dsp *ctx);
+void cnl_ipc_op_int_enable(struct sst_dsp *ctx);
+void cnl_ipc_op_int_disable(struct sst_dsp *ctx);
+bool cnl_ipc_int_status(struct sst_dsp *ctx);
+void cnl_ipc_free(struct sst_generic_ipc *ipc);
+
+#endif /*__CNL_SST_DSP_H__*/
-- 
2.13.0
