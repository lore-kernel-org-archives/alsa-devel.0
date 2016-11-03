From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add D0iX callbacks" to
	the asoc tree
Date: Thu, 03 Nov 2016 11:26:55 -0600
Message-ID: <E1c2Lmx-0002eL-GM@finisterre>
References: <1474868137-29712-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FDE62667E0
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 18:27:09 +0100 (CET)
In-Reply-To: <1474868137-29712-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add D0iX callbacks

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

>From 5bb4cd46ace5f220fbc34370e7fe9ba515ead9f8 Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Thu, 3 Nov 2016 17:07:17 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add D0iX callbacks

The driver needs two DSP callback, one to set D0i0 (active) and D0i3
(low-power) states.

Add these callbacks in dsp ops and implement them for broxton platforms.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     | 140 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h |  12 +++
 sound/soc/intel/skylake/skl-sst-ipc.h |  19 +++++
 3 files changed, 171 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 1d251d59bcb9..fed818fe2e69 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -43,6 +43,9 @@
 
 #define BXT_ADSP_FW_BIN_HDR_OFFSET 0x2000
 
+/* Delay before scheduling D0i3 entry */
+#define BXT_D0I3_DELAY 5000
+
 static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 {
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
@@ -288,6 +291,141 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	return ret;
 }
 
+/*
+ * Decide the D0i3 state that can be targeted based on the usecase
+ * ref counts and DSP state
+ *
+ * Decision Matrix:  (X= dont care; state = target state)
+ *
+ * DSP state != SKL_DSP_RUNNING ; state = no d0i3
+ *
+ * DSP state == SKL_DSP_RUNNING , the following matrix applies
+ * non_d0i3 >0; streaming =X; non_streaming =X; state = no d0i3
+ * non_d0i3 =X; streaming =0; non_streaming =0; state = no d0i3
+ * non_d0i3 =0; streaming >0; non_streaming =X; state = streaming d0i3
+ * non_d0i3 =0; streaming =0; non_streaming =X; state = non-streaming d0i3
+ */
+static int bxt_d0i3_target_state(struct sst_dsp *ctx)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	struct skl_d0i3_data *d0i3 = &skl->d0i3;
+
+	if (skl->cores.state[SKL_DSP_CORE0_ID] != SKL_DSP_RUNNING)
+		return SKL_DSP_D0I3_NONE;
+
+	if (d0i3->non_d0i3)
+		return SKL_DSP_D0I3_NONE;
+	else if (d0i3->streaming)
+		return SKL_DSP_D0I3_STREAMING;
+	else if (d0i3->non_streaming)
+		return SKL_DSP_D0I3_NON_STREAMING;
+	else
+		return SKL_DSP_D0I3_NONE;
+}
+
+static void bxt_set_dsp_D0i3(struct work_struct *work)
+{
+	int ret;
+	struct skl_ipc_d0ix_msg msg;
+	struct skl_sst *skl = container_of(work,
+			struct skl_sst, d0i3.work.work);
+	struct sst_dsp *ctx = skl->dsp;
+	struct skl_d0i3_data *d0i3 = &skl->d0i3;
+	int target_state;
+
+	dev_dbg(ctx->dev, "In %s:\n", __func__);
+
+	/* D0i3 entry allowed only if core 0 alone is running */
+	if (skl_dsp_get_enabled_cores(ctx) !=  SKL_DSP_CORE0_MASK) {
+		dev_warn(ctx->dev,
+				"D0i3 allowed when only core0 running:Exit\n");
+		return;
+	}
+
+	target_state = bxt_d0i3_target_state(ctx);
+	if (target_state == SKL_DSP_D0I3_NONE)
+		return;
+
+	msg.instance_id = 0;
+	msg.module_id = 0;
+	msg.wake = 1;
+	msg.streaming = 0;
+	if (target_state == SKL_DSP_D0I3_STREAMING)
+		msg.streaming = 1;
+
+	ret =  skl_ipc_set_d0ix(&skl->ipc, &msg);
+
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to set DSP to D0i3 state\n");
+		return;
+	}
+
+	/* Set Vendor specific register D0I3C.I3 to enable D0i3*/
+	if (skl->update_d0i3c)
+		skl->update_d0i3c(skl->dev, true);
+
+	d0i3->state = target_state;
+	skl->cores.state[SKL_DSP_CORE0_ID] = SKL_DSP_RUNNING_D0I3;
+}
+
+static int bxt_schedule_dsp_D0i3(struct sst_dsp *ctx)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	struct skl_d0i3_data *d0i3 = &skl->d0i3;
+
+	/* Schedule D0i3 only if the usecase ref counts are appropriate */
+	if (bxt_d0i3_target_state(ctx) != SKL_DSP_D0I3_NONE) {
+
+		dev_dbg(ctx->dev, "%s: Schedule D0i3\n", __func__);
+
+		schedule_delayed_work(&d0i3->work,
+				msecs_to_jiffies(BXT_D0I3_DELAY));
+	}
+
+	return 0;
+}
+
+static int bxt_set_dsp_D0i0(struct sst_dsp *ctx)
+{
+	int ret;
+	struct skl_ipc_d0ix_msg msg;
+	struct skl_sst *skl = ctx->thread_context;
+
+	dev_dbg(ctx->dev, "In %s:\n", __func__);
+
+	/* First Cancel any pending attempt to put DSP to D0i3 */
+	cancel_delayed_work_sync(&skl->d0i3.work);
+
+	/* If DSP is currently in D0i3, bring it to D0i0 */
+	if (skl->cores.state[SKL_DSP_CORE0_ID] != SKL_DSP_RUNNING_D0I3)
+		return 0;
+
+	dev_dbg(ctx->dev, "Set DSP to D0i0\n");
+
+	msg.instance_id = 0;
+	msg.module_id = 0;
+	msg.streaming = 0;
+	msg.wake = 0;
+
+	if (skl->d0i3.state == SKL_DSP_D0I3_STREAMING)
+		msg.streaming = 1;
+
+	/* Clear Vendor specific register D0I3C.I3 to disable D0i3*/
+	if (skl->update_d0i3c)
+		skl->update_d0i3c(skl->dev, false);
+
+	ret =  skl_ipc_set_d0ix(&skl->ipc, &msg);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to set DSP to D0i0\n");
+		return ret;
+	}
+
+	skl->cores.state[SKL_DSP_CORE0_ID] = SKL_DSP_RUNNING;
+	skl->d0i3.state = SKL_DSP_D0I3_NONE;
+
+	return 0;
+}
+
 static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 {
 	struct skl_sst *skl = ctx->thread_context;
@@ -414,6 +552,8 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 static struct skl_dsp_fw_ops bxt_fw_ops = {
 	.set_state_D0 = bxt_set_dsp_D0,
 	.set_state_D3 = bxt_set_dsp_D3,
+	.set_state_D0i3 = bxt_schedule_dsp_D0i3,
+	.set_state_D0i0 = bxt_set_dsp_D0i0,
 	.load_fw = bxt_load_base_firmware,
 	.get_fw_errcode = bxt_get_errorcode,
 	.load_library = bxt_load_library,
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index b9e71d051fb1..7c272ba0f4b5 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -126,11 +126,21 @@ struct sst_dsp_device;
 #define SKL_ADSPCS_CPA_SHIFT		24
 #define SKL_ADSPCS_CPA_MASK(cm)		((cm) << SKL_ADSPCS_CPA_SHIFT)
 
+/* DSP Core state */
 enum skl_dsp_states {
 	SKL_DSP_RUNNING = 1,
+	/* Running in D0i3 state; can be in streaming or non-streaming D0i3 */
+	SKL_DSP_RUNNING_D0I3, /* Running in D0i3 state*/
 	SKL_DSP_RESET,
 };
 
+/* D0i3 substates */
+enum skl_dsp_d0i3_states {
+	SKL_DSP_D0I3_NONE = -1, /* No D0i3 */
+	SKL_DSP_D0I3_NON_STREAMING = 0,
+	SKL_DSP_D0I3_STREAMING = 1,
+};
+
 struct skl_dsp_fw_ops {
 	int (*load_fw)(struct sst_dsp  *ctx);
 	/* FW module parser/loader */
@@ -139,6 +149,8 @@ struct skl_dsp_fw_ops {
 	int (*parse_fw)(struct sst_dsp *ctx);
 	int (*set_state_D0)(struct sst_dsp *ctx, unsigned int core_id);
 	int (*set_state_D3)(struct sst_dsp *ctx, unsigned int core_id);
+	int (*set_state_D0i3)(struct sst_dsp *ctx);
+	int (*set_state_D0i0)(struct sst_dsp *ctx);
 	unsigned int (*get_fw_errcode)(struct sst_dsp *ctx);
 	int (*load_mod)(struct sst_dsp *ctx, u16 mod_id, u8 *mod_name);
 	int (*unload_mod)(struct sst_dsp *ctx, u16 mod_id);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index ef2182d21934..a45c42046b64 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -53,6 +53,23 @@ struct skl_dsp_cores {
 	int usage_count[SKL_DSP_CORES_MAX];
 };
 
+/**
+ * skl_d0i3_data: skl D0i3 counters data struct
+ *
+ * @streaming: Count of usecases that can attempt streaming D0i3
+ * @non_streaming: Count of usecases that can attempt non-streaming D0i3
+ * @non_d0i3: Count of usecases that cannot attempt D0i3
+ * @state: current state
+ * @work: D0i3 worker thread
+ */
+struct skl_d0i3_data {
+	int streaming;
+	int non_streaming;
+	int non_d0i3;
+	enum skl_dsp_d0i3_states state;
+	struct delayed_work work;
+};
+
 struct skl_sst {
 	struct device *dev;
 	struct sst_dsp *dsp;
@@ -86,6 +103,8 @@ struct skl_sst {
 
 	/* Callback to update D0i3C register */
 	void (*update_d0i3c)(struct device *dev, bool enable);
+
+	struct skl_d0i3_data d0i3;
 };
 
 struct skl_ipc_init_instance_msg {
-- 
2.10.1
