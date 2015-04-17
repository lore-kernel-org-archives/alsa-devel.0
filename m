From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 4/9] ASoC: hda: Add DSP init and boot up
	functionality
Date: Fri, 17 Apr 2015 18:46:02 +0530
Message-ID: <1429276567-29007-5-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A1CDB260578
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:23 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-dsp.h       |   28 +++
 sound/soc/hda/intel/soc-hda-sst-dsp.c |  350 +++++++++++++++++++++++++++++++++
 2 files changed, 378 insertions(+)

diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
index 44e8d67aab3a..4a89c3dda5ab 100644
--- a/include/sound/soc-hda-sst-dsp.h
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -101,6 +101,34 @@
 #define ADSPIC_IPC                      1
 #define ADSPIS_IPC			1
 
+/* ADSPCS - Audio DSP Control & Status */
+#define DSP_CORES 1
+#define DSP_CORE0_MASK 1
+#define DSP_CORES_MASK ((1 << DSP_CORES) - 1)
+
+/* Core Reset - asserted high */
+#define ADSPCS_CRST_SHIFT	0
+#define ADSPCS_CRST_MASK	(DSP_CORES_MASK << ADSPCS_CRST_SHIFT)
+#define ADSPCS_CRST(x)		((x << ADSPCS_CRST_SHIFT) & ADSPCS_CRST_MASK)
+
+/* Core run/stall - when set to '1' core is stalled */
+#define ADSPCS_CSTALL_SHIFT	8
+#define ADSPCS_CSTALL_MASK	(DSP_CORES_MASK << ADSPCS_CSTALL_SHIFT)
+#define ADSPCS_CSTALL(x)	((x << ADSPCS_CSTALL_SHIFT) & ADSPCS_CSTALL_MASK)
+
+/* Set Power Active - when set to '1' turn cores on */
+#define ADSPCS_SPA_SHIFT	16
+#define ADSPCS_SPA_MASK		(DSP_CORES_MASK << ADSPCS_SPA_SHIFT)
+#define ADSPCS_SPA(x)		((x << ADSPCS_SPA_SHIFT) & ADSPCS_SPA_MASK)
+
+/* Current Power Active - power status of cores, set by hardware */
+#define ADSPCS_CPA_SHIFT	24
+#define ADSPCS_CPA_MASK		(DSP_CORES_MASK << ADSPCS_CPA_SHIFT)
+#define ADSPCS_CPA(x)		((x << ADSPCS_CPA_SHIFT) & ADSPCS_CPA_MASK)
+
+#define SST_DSP_POWER_D0              0x0  /* full On */
+#define SST_DSP_POWER_D3              0x3  /* Off */
+
 struct ssth_window {
 	void __iomem *w0stat;
 	void __iomem *w0up;
diff --git a/sound/soc/hda/intel/soc-hda-sst-dsp.c b/sound/soc/hda/intel/soc-hda-sst-dsp.c
index 6e85645b3a3e..6285a6772e73 100644
--- a/sound/soc/hda/intel/soc-hda-sst-dsp.c
+++ b/sound/soc/hda/intel/soc-hda-sst-dsp.c
@@ -34,6 +34,11 @@
 #include <sound/soc-hda-sst-dsp.h>
 #include <sound/soc-hda-sst-ipc.h>
 
+#define DSP_CORE_POWER_UP_TIMEOUT		50
+#define DSP_CORE_POWER_DOWN_TIMEOUT		50
+#define DSP_CORE_SET_RESET_STATE_TIMEOUT	50
+#define DSP_CORE_UNSET_RESET_STATE_TIMEOUT	50
+
 u8 ssth_readb_traced(struct ssth_lib *dsp, u32 offset)
 {
 	u8 val;
@@ -135,5 +140,350 @@ void ssth_mailbox_read(struct ssth_lib  *ctx, void *msg, size_t bytes)
 	_ssth_memcpy_fromio_32(msg, ctx->window.w0up, bytes);
 }
 
+int ssth_register_poll(struct ssth_lib  *ctx, u32 offset, u32 mask,
+			 u32 expected_value, u32 timeout, char *operation)
+{
+	int time = 0;
+	int ret = 0;
+	u32 reg;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* check if set state successful */
+	for (time = 0; time < timeout; time++) {
+		if ((ssth_readl_alt(ctx, offset) & mask) == expected_value)
+			break;
+
+		mdelay(1);
+	}
+	reg = ssth_readl_alt(ctx, offset);
+	dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
+			(time < timeout) ? "successful" : "timedout");
+	ret = time < timeout ? 0 : -ETIME;
+
+	return ret;
+}
+
+static int ssth_dsp_core_set_reset_state(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* update bits */
+	ssth_updatel_locked(ctx, ADSPCS, CRST_MASK,
+				ADSPCS_CRST(DSP_CORES_MASK));
+
+	/* poll with timeout to check if operation successful */
+	ret = ssth_register_poll(ctx,
+			HDA_ADSP_REG_ADSPCS,
+			ADSPCS_CRST_MASK,
+			ADSPCS_CRST(DSP_CORES_MASK),
+			DSP_CORE_SET_RESET_STATE_TIMEOUT,
+			"Set reset");
+	if ((ssth_readl(ctx, ADSPCS) & ADSPCS_CRST(DSP_CORES_MASK)) !=
+			ADSPCS_CRST(DSP_CORES_MASK)) {
+		dev_err(ctx->dev, "Set reset state failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int ssth_dsp_core_unset_reset_state(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* update bits */
+	ssth_updatel_locked(ctx, ADSPCS, CRST_MASK, 0);
+
+	/* poll with timeout to check if operation successful */
+	ret = ssth_register_poll(ctx,
+			HDA_ADSP_REG_ADSPCS,
+			ADSPCS_CRST_MASK,
+			0,
+			DSP_CORE_UNSET_RESET_STATE_TIMEOUT,
+			"Unset reset");
+
+	if ((ssth_readl(ctx, ADSPCS) & ADSPCS_CRST(DSP_CORES_MASK)) != 0) {
+		dev_err(ctx->dev, "Unset reset state failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int ssth_dsp_core_power_up(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+	/* update bits */
+	ssth_updatel_locked(ctx,
+			ADSPCS, SPA_MASK, ADSPCS_SPA(DSP_CORES_MASK));
+
+	/* poll with timeout to check if operation successful */
+	ret = ssth_register_poll(ctx,
+			HDA_ADSP_REG_ADSPCS,
+			ADSPCS_CPA_MASK,
+			ADSPCS_CPA(DSP_CORES_MASK),
+			DSP_CORE_POWER_UP_TIMEOUT,
+			"Power up");
+
+	if ((ssth_readl(ctx, ADSPCS) & ADSPCS_CPA(DSP_CORES_MASK)) !=
+			ADSPCS_CPA(DSP_CORES_MASK)) {
+		dev_err(ctx->dev, "DSP core power up failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int ssth_dsp_core_power_down(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* update bits */
+	ssth_updatel_locked(ctx, ADSPCS, SPA_MASK, 0);
+
+	/* poll with timeout to check if operation successful */
+	ret = ssth_register_poll(ctx,
+			HDA_ADSP_REG_ADSPCS,
+			ADSPCS_SPA_MASK,
+			0,
+			DSP_CORE_POWER_DOWN_TIMEOUT,
+			"Power down");
+
+	return ret;
+}
+
+static bool ssth_is_dsp_core_enable(struct ssth_lib  *ctx)
+{
+	int val = 0;
+	bool is_enable;
+
+	val = ssth_readl(ctx, ADSPCS);
+
+	is_enable = ((val & ADSPCS_CPA(DSP_CORES_MASK)) &&
+			(val & ADSPCS_SPA(DSP_CORES_MASK)) &&
+			!(val & ADSPCS_CRST(DSP_CORES_MASK)) &&
+			!(val & ADSPCS_CSTALL(DSP_CORES_MASK)));
+
+	dev_dbg(ctx->dev, "DSP core is enabled=%d\n", is_enable);
+	return is_enable;
+}
+
+
+int ssth_enable_dsp_core(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* power up */
+	ret = ssth_dsp_core_power_up(ctx);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "dsp core power up failed\n");
+		return ret;
+	}
+
+	/* unset reset state */
+	ret = ssth_dsp_core_unset_reset_state(ctx);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "dsp core reset failed\n");
+		return ret;
+	}
+
+	/* run core */
+	dev_dbg(ctx->dev, "run core...\n");
+	ssth_writel(ctx, ADSPCS, ssth_readl(ctx, ADSPCS) &
+			~ADSPCS_CSTALL(DSP_CORES_MASK));
+
+	if (!ssth_is_dsp_core_enable(ctx)) {
+		dev_err(ctx->dev, "DSP core enable failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int ssth_disable_dsp_core(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* stall core */
+	ssth_writel(ctx, ADSPCS, ssth_readl(ctx, ADSPCS) |
+			ADSPCS_CSTALL(DSP_CORES_MASK));
+
+	/* set reset state */
+	ret = ssth_dsp_core_set_reset_state(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core reset failed\n");
+		return ret;
+	}
+
+	/* power down core*/
+	ret = ssth_dsp_core_power_down(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core power down failed\n");
+		return ret;
+	}
+
+	if (ssth_is_dsp_core_enable(ctx)) {
+		dev_err(ctx->dev, "DSP core disable failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int ssth_reset_dsp_core(struct ssth_lib  *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* stall core */
+	ssth_writel(ctx, ADSPCS, ssth_readl(ctx, ADSPCS) &
+			ADSPCS_CSTALL(DSP_CORES_MASK));
+
+	/* set reset state */
+	ret = ssth_dsp_core_set_reset_state(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp reset failed\n");
+		return ret;
+	}
+
+	/* unset reset state */
+	ret = ssth_dsp_core_unset_reset_state(ctx);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "dsp unset reset failes\n");
+		return ret;
+	}
+
+	/* run core */
+	dev_dbg(ctx->dev, "run core...\n");
+	ssth_writel(ctx, ADSPCS, ssth_readl(ctx, ADSPCS) &
+			~ADSPCS_CSTALL(DSP_CORES_MASK));
+
+	if (ssth_is_dsp_core_enable(ctx)) {
+		dev_err(ctx->dev, "DSP core reset failed\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int ssth_boot_dsp(struct ssth_lib *ctx)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	if (ssth_is_dsp_core_enable(ctx)) {
+		/* Dsp core powered up - simply reset core */
+		dev_dbg(ctx->dev, "dsp core is already enabled, so reset the dap core\n");
+		ret = ssth_reset_dsp_core(ctx);
+	} else {
+		/*disable and enable to make sure DSP is invalid state */
+		ret = ssth_disable_dsp_core(ctx);
+
+		if (ret < 0) {
+			dev_err(ctx->dev, "dsp disable core failes\n");
+			return ret;
+		}
+		ret = ssth_enable_dsp_core(ctx);
+	}
+
+	return ret;
+}
+
+/*
+ * interrupt handler
+ */
+static irqreturn_t ssth_interrupt(int irq, void *dev_id)
+{
+	struct ssth_lib *ctx = (struct ssth_lib *) dev_id;
+	u32 val;
+	irqreturn_t result = IRQ_NONE;
+
+	spin_lock(&ctx->reg_lock);
+
+	val = ssth_readl(ctx, ADSPIS);
+
+	if (val & ADSPIS_IPC) {
+		ssth_ipc_int_disable(ctx);
+		queue_work(ctx->intr_wq, &ctx->ipc_process_msg_work);
+		result = IRQ_HANDLED;
+	}
+
+	spin_unlock(&ctx->reg_lock);
+	return result;
+}
+
+static int ssth_acquire_irq(struct ssth_lib *ctx)
+{
+	if (request_threaded_irq(ctx->irq, ssth_interrupt,
+			NULL, IRQF_SHARED, KBUILD_MODNAME, ctx)) {
+		dev_err(ctx->dev, "unable to grab threaded IRQ %d, disabling device\n", ctx->irq);
+		return -1;
+	}
+	return 0;
+}
+
+int ssth_dsp_init(struct ssth_lib *ctx)
+{
+	int ret = 0;
+
+	mutex_init(&ctx->sst_lock);
+	spin_lock_init(&ctx->reg_lock);
+
+	dev_dbg(ctx->dev, "In %s\n", __func__);
+
+	/* initialize IPC */
+	ctx->ipc = ssth_ipc_init(ctx->dev, ctx);
+	if (ctx->ipc == NULL)
+		ret = -ENODEV;
+
+	/* Now let's request the IRQ */
+	ssth_acquire_irq(ctx);
+
+	return ret;
+}
+
+int ssth_dsp_free0(struct ssth_lib *dsp)
+{
+	int ret = 0;
+
+	dev_dbg(dsp->dev, "In %s\n", __func__);
+
+	ssth_ipc_int_disable(dsp);
+
+	free_irq(dsp->irq, dsp);
+	ssth_ipc_free(dsp->ipc);
+	ssth_disable_dsp_core(dsp);
+	kfree(dsp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ssth_dsp_free0);
+
+bool ssth_dsp_is_running(struct ssth_lib *ctx)
+{
+	bool ret = 0;
+
+	mutex_lock(&ctx->sst_lock);
+	ret = (ctx->sst_state == SST_DSP_RUNNING) ? 1 : 0;
+	mutex_unlock(&ctx->sst_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ssth_dsp_is_running);
+
 MODULE_DESCRIPTION("HDA SST/IPC Library");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
