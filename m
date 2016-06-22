From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add DSP muti-core
	infrastructure" to the asoc tree
Date: Wed, 22 Jun 2016 16:28:18 +0100
Message-ID: <E1bFk4g-0002Cm-Bu@debutante>
References: <1466484463-9129-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A7C266CFB
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:28:25 +0200 (CEST)
In-Reply-To: <1466484463-9129-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Add DSP muti-core infrastructure

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

>From 052f103c89aa8ff6a72a4cadc0a5471cc8bc4c93 Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Tue, 21 Jun 2016 10:17:41 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add DSP muti-core infrastructure

The DSP can have more than one cores. In that case the secondary
core has to be managed by the driver. This patch adds the changes
to driver infrastructure to support multiple core.

A new object skl_dsp_cores is introduced to support multiple
core. Helpers skl_dsp_get_core() skl_dsp_put_core() help to
managed the cores.

Many of the power_up/down and DSP APIs take additional argument
of core_id. The primary core, 0 is always powered up first and
then on demand second core.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     |  22 +--
 sound/soc/intel/skylake/skl-sst-dsp.c | 253 ++++++++++++++++++++++++----------
 sound/soc/intel/skylake/skl-sst-dsp.h |  96 ++++++++-----
 sound/soc/intel/skylake/skl-sst-ipc.h |  11 ++
 sound/soc/intel/skylake/skl-sst.c     |  16 ++-
 5 files changed, 278 insertions(+), 120 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 622da5d3e3b3..c6cc1cfd04c8 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -58,7 +58,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
-	ret = skl_dsp_core_power_up(ctx);
+	ret = skl_dsp_core_power_up(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Boot dsp core failed ret: %d\n", ret);
 		goto base_fw_load_failed;
@@ -68,7 +68,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_HIPCI, SKL_ADSP_REG_HIPCI_BUSY |
 				(BXT_IPC_PURGE_FW | ((stream_tag - 1) << 9)));
 
-	ret = skl_dsp_start_core(ctx);
+	ret = skl_dsp_start_core(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Start dsp core failed ret: %d\n", ret);
 		ret = -EIO;
@@ -118,7 +118,8 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 
 base_fw_load_failed:
 	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
-	skl_dsp_disable_core(ctx);
+	skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
+	skl_dsp_disable_core(ctx, SKL_DSP_CORE_MASK(1));
 	return ret;
 }
 
@@ -183,14 +184,14 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 			sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
 			sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
 
-		skl_dsp_disable_core(ctx);
+		skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 	} else {
 		dev_dbg(ctx->dev, "Firmware download successful\n");
 		ret = wait_event_timeout(skl->boot_wait, skl->boot_complete,
 					msecs_to_jiffies(SKL_IPC_BOOT_MSECS));
 		if (ret == 0) {
 			dev_err(ctx->dev, "DSP boot fail, FW Ready timeout\n");
-			skl_dsp_disable_core(ctx);
+			skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 			ret = -EIO;
 		} else {
 			skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
@@ -204,7 +205,7 @@ sst_load_base_firmware_failed:
 	return ret;
 }
 
-static int bxt_set_dsp_D0(struct sst_dsp *ctx)
+static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 {
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
@@ -219,7 +220,7 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx)
 		return ret;
 	}
 
-	ret = skl_dsp_enable_core(ctx);
+	ret = skl_dsp_enable_core(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
 		dev_err(ctx->dev, "enable dsp core failed ret: %d\n", ret);
 		return ret;
@@ -243,7 +244,7 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx)
 	return 0;
 }
 
-static int bxt_set_dsp_D3(struct sst_dsp *ctx)
+static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 {
 	struct skl_ipc_dxstate_info dx;
 	struct skl_sst *skl = ctx->thread_context;
@@ -262,7 +263,7 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx)
 		return ret;
 	}
 
-	ret = skl_dsp_disable_core(ctx);
+	ret = skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
 		dev_err(ctx->dev, "disbale dsp core failed: %d\n", ret);
 		ret = -EIO;
@@ -329,6 +330,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	if (ret)
 		return ret;
 
+	skl->cores.count = 2;
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
 
@@ -338,6 +340,8 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		return ret;
 	}
 
+	skl_dsp_init_core_state(sst);
+
 	if (dsp)
 		*dsp = skl;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 33c45aa53532..c3deefab65d6 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -34,33 +34,84 @@ void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state)
 	mutex_unlock(&ctx->mutex);
 }
 
-static int skl_dsp_core_set_reset_state(struct sst_dsp *ctx)
+/*
+ * Initialize core power state and usage count. To be called after
+ * successful first boot. Hence core 0 will be running and other cores
+ * will be reset
+ */
+void skl_dsp_init_core_state(struct sst_dsp *ctx)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	int i;
+
+	skl->cores.state[SKL_DSP_CORE0_ID] = SKL_DSP_RUNNING;
+	skl->cores.usage_count[SKL_DSP_CORE0_ID] = 1;
+
+	for (i = SKL_DSP_CORE0_ID + 1; i < SKL_DSP_CORES_MAX; i++) {
+		skl->cores.state[i] = SKL_DSP_RESET;
+		skl->cores.usage_count[i] = 0;
+	}
+}
+
+/* Get the mask for all enabled cores */
+unsigned int skl_dsp_get_enabled_cores(struct sst_dsp *ctx)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	unsigned int core_mask, en_cores_mask;
+	u32 val;
+
+	core_mask = SKL_DSP_CORES_MASK(skl->cores.count);
+
+	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS);
+
+	/* Cores having CPA bit set */
+	en_cores_mask = (val & SKL_ADSPCS_CPA_MASK(core_mask)) >>
+			SKL_ADSPCS_CPA_SHIFT;
+
+	/* And cores having CRST bit cleared */
+	en_cores_mask &= (~val & SKL_ADSPCS_CRST_MASK(core_mask)) >>
+			SKL_ADSPCS_CRST_SHIFT;
+
+	/* And cores having CSTALL bit cleared */
+	en_cores_mask &= (~val & SKL_ADSPCS_CSTALL_MASK(core_mask)) >>
+			SKL_ADSPCS_CSTALL_SHIFT;
+	en_cores_mask &= core_mask;
+
+	dev_dbg(ctx->dev, "DSP enabled cores mask = %x\n", en_cores_mask);
+
+	return en_cores_mask;
+}
+
+static int
+skl_dsp_core_set_reset_state(struct sst_dsp *ctx, unsigned int core_mask)
 {
 	int ret;
 
 	/* update bits */
 	sst_dsp_shim_update_bits_unlocked(ctx,
-			SKL_ADSP_REG_ADSPCS, SKL_ADSPCS_CRST_MASK,
-			SKL_ADSPCS_CRST(SKL_DSP_CORES_MASK));
+			SKL_ADSP_REG_ADSPCS, SKL_ADSPCS_CRST_MASK(core_mask),
+			SKL_ADSPCS_CRST_MASK(core_mask));
 
 	/* poll with timeout to check if operation successful */
 	ret = sst_dsp_register_poll(ctx,
 			SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_CRST_MASK,
-			SKL_ADSPCS_CRST(SKL_DSP_CORES_MASK),
+			SKL_ADSPCS_CRST_MASK(core_mask),
+			SKL_ADSPCS_CRST_MASK(core_mask),
 			SKL_DSP_RESET_TO,
 			"Set reset");
 	if ((sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
-				SKL_ADSPCS_CRST(SKL_DSP_CORES_MASK)) !=
-				SKL_ADSPCS_CRST(SKL_DSP_CORES_MASK)) {
-		dev_err(ctx->dev, "Set reset state failed\n");
+				SKL_ADSPCS_CRST_MASK(core_mask)) !=
+				SKL_ADSPCS_CRST_MASK(core_mask)) {
+		dev_err(ctx->dev, "Set reset state failed: core_mask %x\n",
+							core_mask);
 		ret = -EIO;
 	}
 
 	return ret;
 }
 
-static int skl_dsp_core_unset_reset_state(struct sst_dsp *ctx)
+int skl_dsp_core_unset_reset_state(
+		struct sst_dsp *ctx, unsigned int core_mask)
 {
 	int ret;
 
@@ -68,151 +119,160 @@ static int skl_dsp_core_unset_reset_state(struct sst_dsp *ctx)
 
 	/* update bits */
 	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-					SKL_ADSPCS_CRST_MASK, 0);
+				SKL_ADSPCS_CRST_MASK(core_mask), 0);
 
 	/* poll with timeout to check if operation successful */
 	ret = sst_dsp_register_poll(ctx,
 			SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_CRST_MASK,
+			SKL_ADSPCS_CRST_MASK(core_mask),
 			0,
 			SKL_DSP_RESET_TO,
 			"Unset reset");
 
 	if ((sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
-				 SKL_ADSPCS_CRST(SKL_DSP_CORES_MASK)) != 0) {
-		dev_err(ctx->dev, "Unset reset state failed\n");
+				SKL_ADSPCS_CRST_MASK(core_mask)) != 0) {
+		dev_err(ctx->dev, "Unset reset state failed: core_mask %x\n",
+				core_mask);
 		ret = -EIO;
 	}
 
 	return ret;
 }
 
-static bool is_skl_dsp_core_enable(struct sst_dsp *ctx)
+static bool
+is_skl_dsp_core_enable(struct sst_dsp *ctx, unsigned int core_mask)
 {
 	int val;
 	bool is_enable;
 
 	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS);
 
-	is_enable = ((val & SKL_ADSPCS_CPA(SKL_DSP_CORES_MASK)) &&
-			(val & SKL_ADSPCS_SPA(SKL_DSP_CORES_MASK)) &&
-			!(val & SKL_ADSPCS_CRST(SKL_DSP_CORES_MASK)) &&
-			!(val & SKL_ADSPCS_CSTALL(SKL_DSP_CORES_MASK)));
+	is_enable = ((val & SKL_ADSPCS_CPA_MASK(core_mask)) &&
+			(val & SKL_ADSPCS_SPA_MASK(core_mask)) &&
+			!(val & SKL_ADSPCS_CRST_MASK(core_mask)) &&
+			!(val & SKL_ADSPCS_CSTALL_MASK(core_mask)));
+
+	dev_dbg(ctx->dev, "DSP core(s) enabled? %d : core_mask %x\n",
+						is_enable, core_mask);
 
-	dev_dbg(ctx->dev, "DSP core is enabled=%d\n", is_enable);
 	return is_enable;
 }
 
-static int skl_dsp_reset_core(struct sst_dsp *ctx)
+static int skl_dsp_reset_core(struct sst_dsp *ctx, unsigned int core_mask)
 {
 	/* stall core */
 	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_CSTALL_MASK,
-			SKL_ADSPCS_CSTALL(SKL_DSP_CORES_MASK));
+			SKL_ADSPCS_CSTALL_MASK(core_mask),
+			SKL_ADSPCS_CSTALL_MASK(core_mask));
 
 	/* set reset state */
-	return skl_dsp_core_set_reset_state(ctx);
+	return skl_dsp_core_set_reset_state(ctx, core_mask);
 }
 
-int skl_dsp_start_core(struct sst_dsp *ctx)
+int skl_dsp_start_core(struct sst_dsp *ctx, unsigned int core_mask)
 {
 	int ret;
 
 	/* unset reset state */
-	ret = skl_dsp_core_unset_reset_state(ctx);
-	if (ret < 0) {
-		dev_dbg(ctx->dev, "dsp unset reset fails\n");
+	ret = skl_dsp_core_unset_reset_state(ctx, core_mask);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* run core */
-	dev_dbg(ctx->dev, "run core...\n");
+	dev_dbg(ctx->dev, "unstall/run core: core_mask = %x\n", core_mask);
 	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_CSTALL_MASK, 0);
+			SKL_ADSPCS_CSTALL_MASK(core_mask), 0);
 
-	if (!is_skl_dsp_core_enable(ctx)) {
-		skl_dsp_reset_core(ctx);
-		dev_err(ctx->dev, "DSP core enable failed\n");
+	if (!is_skl_dsp_core_enable(ctx, core_mask)) {
+		skl_dsp_reset_core(ctx, core_mask);
+		dev_err(ctx->dev, "DSP start core failed: core_mask %x\n",
+							core_mask);
 		ret = -EIO;
 	}
 
 	return ret;
 }
 
-int skl_dsp_core_power_up(struct sst_dsp *ctx)
+int skl_dsp_core_power_up(struct sst_dsp *ctx, unsigned int core_mask)
 {
 	int ret;
 
 	/* update bits */
 	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_SPA_MASK, SKL_ADSPCS_SPA(SKL_DSP_CORES_MASK));
+			SKL_ADSPCS_SPA_MASK(core_mask),
+			SKL_ADSPCS_SPA_MASK(core_mask));
 
 	/* poll with timeout to check if operation successful */
 	ret = sst_dsp_register_poll(ctx,
 			SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_CPA_MASK,
-			SKL_ADSPCS_CPA(SKL_DSP_CORES_MASK),
+			SKL_ADSPCS_CPA_MASK(core_mask),
+			SKL_ADSPCS_CPA_MASK(core_mask),
 			SKL_DSP_PU_TO,
 			"Power up");
 
 	if ((sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
-			SKL_ADSPCS_CPA(SKL_DSP_CORES_MASK)) !=
-			SKL_ADSPCS_CPA(SKL_DSP_CORES_MASK)) {
-		dev_err(ctx->dev, "DSP core power up failed\n");
+			SKL_ADSPCS_CPA_MASK(core_mask)) !=
+			SKL_ADSPCS_CPA_MASK(core_mask)) {
+		dev_err(ctx->dev, "DSP core power up failed: core_mask %x\n",
+				core_mask);
 		ret = -EIO;
 	}
 
 	return ret;
 }
 
-static int skl_dsp_core_power_down(struct sst_dsp *ctx)
+int skl_dsp_core_power_down(struct sst_dsp  *ctx, unsigned int core_mask)
 {
 	/* update bits */
 	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-					SKL_ADSPCS_SPA_MASK, 0);
+				SKL_ADSPCS_SPA_MASK(core_mask), 0);
 
 	/* poll with timeout to check if operation successful */
 	return sst_dsp_register_poll(ctx,
 			SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_CPA_MASK,
+			SKL_ADSPCS_CPA_MASK(core_mask),
 			0,
 			SKL_DSP_PD_TO,
 			"Power down");
 }
 
-int skl_dsp_enable_core(struct sst_dsp *ctx)
+int skl_dsp_enable_core(struct sst_dsp  *ctx, unsigned int core_mask)
 {
 	int ret;
 
 	/* power up */
-	ret = skl_dsp_core_power_up(ctx);
+	ret = skl_dsp_core_power_up(ctx, core_mask);
 	if (ret < 0) {
-		dev_dbg(ctx->dev, "dsp core power up failed\n");
+		dev_err(ctx->dev, "dsp core power up failed: core_mask %x\n",
+							core_mask);
 		return ret;
 	}
 
-	return skl_dsp_start_core(ctx);
+	return skl_dsp_start_core(ctx, core_mask);
 }
 
-int skl_dsp_disable_core(struct sst_dsp *ctx)
+int skl_dsp_disable_core(struct sst_dsp *ctx, unsigned int core_mask)
 {
 	int ret;
 
-	ret = skl_dsp_reset_core(ctx);
+	ret = skl_dsp_reset_core(ctx, core_mask);
 	if (ret < 0) {
-		dev_err(ctx->dev, "dsp core reset failed\n");
+		dev_err(ctx->dev, "dsp core reset failed: core_mask %x\n",
+							core_mask);
 		return ret;
 	}
 
 	/* power down core*/
-	ret = skl_dsp_core_power_down(ctx);
+	ret = skl_dsp_core_power_down(ctx, core_mask);
 	if (ret < 0) {
-		dev_err(ctx->dev, "dsp core power down failed\n");
+		dev_err(ctx->dev, "dsp core power down fail mask %x: %d\n",
+							core_mask, ret);
 		return ret;
 	}
 
-	if (is_skl_dsp_core_enable(ctx)) {
-		dev_err(ctx->dev, "DSP core disable failed\n");
+	if (is_skl_dsp_core_enable(ctx, core_mask)) {
+		dev_err(ctx->dev, "dsp core disable fail mask %x: %d\n",
+							core_mask, ret);
 		ret = -EIO;
 	}
 
@@ -223,28 +283,25 @@ int skl_dsp_boot(struct sst_dsp *ctx)
 {
 	int ret;
 
-	if (is_skl_dsp_core_enable(ctx)) {
-		dev_dbg(ctx->dev, "dsp core is already enabled, so reset the dap core\n");
-		ret = skl_dsp_reset_core(ctx);
+	if (is_skl_dsp_core_enable(ctx, SKL_DSP_CORE0_MASK)) {
+		ret = skl_dsp_reset_core(ctx, SKL_DSP_CORE0_MASK);
 		if (ret < 0) {
-			dev_err(ctx->dev, "dsp reset failed\n");
+			dev_err(ctx->dev, "dsp core0 reset fail: %d\n", ret);
 			return ret;
 		}
 
-		ret = skl_dsp_start_core(ctx);
+		ret = skl_dsp_start_core(ctx, SKL_DSP_CORE0_MASK);
 		if (ret < 0) {
-			dev_err(ctx->dev, "dsp start failed\n");
+			dev_err(ctx->dev, "dsp core0 start fail: %d\n", ret);
 			return ret;
 		}
 	} else {
-		dev_dbg(ctx->dev, "disable and enable to make sure DSP is invalid state\n");
-		ret = skl_dsp_disable_core(ctx);
-
+		ret = skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 		if (ret < 0) {
-			dev_err(ctx->dev, "dsp disable core failes\n");
+			dev_err(ctx->dev, "dsp core0 disable fail: %d\n", ret);
 			return ret;
 		}
-		ret = skl_dsp_enable_core(ctx);
+		ret = skl_dsp_enable_core(ctx, SKL_DSP_CORE0_MASK);
 	}
 
 	return ret;
@@ -280,16 +337,74 @@ irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id)
 
 	return result;
 }
+/*
+ * skl_dsp_get_core/skl_dsp_put_core will be called inside DAPM context
+ * within the dapm mutex. Hence no separate lock is used.
+ */
+int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	int ret = 0;
+
+	if (core_id >= skl->cores.count) {
+		dev_err(ctx->dev, "invalid core id: %d\n", core_id);
+		return -EINVAL;
+	}
+
+	if (skl->cores.state[core_id] == SKL_DSP_RESET) {
+		ret = ctx->fw_ops.set_state_D0(ctx, core_id);
+		if (ret < 0) {
+			dev_err(ctx->dev, "unable to get core%d\n", core_id);
+			return ret;
+		}
+	}
+
+	skl->cores.usage_count[core_id]++;
+
+	dev_dbg(ctx->dev, "core id %d state %d usage_count %d\n",
+			core_id, skl->cores.state[core_id],
+			skl->cores.usage_count[core_id]);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_dsp_get_core);
+
+int skl_dsp_put_core(struct sst_dsp *ctx, unsigned int core_id)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	int ret = 0;
+
+	if (core_id >= skl->cores.count) {
+		dev_err(ctx->dev, "invalid core id: %d\n", core_id);
+		return -EINVAL;
+	}
+
+	if (--skl->cores.usage_count[core_id] == 0) {
+		ret = ctx->fw_ops.set_state_D3(ctx, core_id);
+		if (ret < 0) {
+			dev_err(ctx->dev, "unable to put core %d: %d\n",
+					core_id, ret);
+			skl->cores.usage_count[core_id]++;
+		}
+	}
+
+	dev_dbg(ctx->dev, "core id %d state %d usage_count %d\n",
+			core_id, skl->cores.state[core_id],
+			skl->cores.usage_count[core_id]);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_dsp_put_core);
 
 int skl_dsp_wake(struct sst_dsp *ctx)
 {
-	return ctx->fw_ops.set_state_D0(ctx);
+	return skl_dsp_get_core(ctx, SKL_DSP_CORE0_ID);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_wake);
 
 int skl_dsp_sleep(struct sst_dsp *ctx)
 {
-	return ctx->fw_ops.set_state_D3(ctx);
+	return skl_dsp_put_core(ctx, SKL_DSP_CORE0_ID);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_sleep);
 
@@ -336,9 +451,7 @@ void skl_dsp_free(struct sst_dsp *dsp)
 
 	free_irq(dsp->irq, dsp);
 	skl_ipc_op_int_disable(dsp);
-	skl_ipc_int_disable(dsp);
-
-	skl_dsp_disable_core(dsp);
+	skl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_free);
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 22fbe1075cb5..0f8629ef79ac 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -77,35 +77,53 @@ struct sst_dsp_device;
 #define SKL_ADSPIC_IPC			1
 #define SKL_ADSPIS_IPC			1
 
+/* Core ID of core0 */
+#define SKL_DSP_CORE0_ID		0
+
+/* Mask for a given core index, c = 0.. number of supported cores - 1 */
+#define SKL_DSP_CORE_MASK(c)		BIT(c)
+
+/*
+ * Core 0 mask = SKL_DSP_CORE_MASK(0); Defined separately
+ * since Core0 is primary core and it is used often
+ */
+#define SKL_DSP_CORE0_MASK		BIT(0)
+
+/*
+ * Mask for a given number of cores
+ * nc = number of supported cores
+ */
+#define SKL_DSP_CORES_MASK(nc)	GENMASK((nc - 1), 0)
+
 /* ADSPCS - Audio DSP Control & Status */
-#define SKL_DSP_CORES		1
-#define SKL_DSP_CORE0_MASK	1
-#define SKL_DSP_CORES_MASK	((1 << SKL_DSP_CORES) - 1)
-
-/* Core Reset - asserted high */
-#define SKL_ADSPCS_CRST_SHIFT	0
-#define SKL_ADSPCS_CRST_MASK	(SKL_DSP_CORES_MASK << SKL_ADSPCS_CRST_SHIFT)
-#define SKL_ADSPCS_CRST(x)	((x << SKL_ADSPCS_CRST_SHIFT) & SKL_ADSPCS_CRST_MASK)
-
-/* Core run/stall - when set to '1' core is stalled */
-#define SKL_ADSPCS_CSTALL_SHIFT	8
-#define SKL_ADSPCS_CSTALL_MASK	(SKL_DSP_CORES_MASK <<	\
-					SKL_ADSPCS_CSTALL_SHIFT)
-#define SKL_ADSPCS_CSTALL(x)	((x << SKL_ADSPCS_CSTALL_SHIFT) &	\
-				SKL_ADSPCS_CSTALL_MASK)
-
-/* Set Power Active - when set to '1' turn cores on */
-#define SKL_ADSPCS_SPA_SHIFT	16
-#define SKL_ADSPCS_SPA_MASK	(SKL_DSP_CORES_MASK << SKL_ADSPCS_SPA_SHIFT)
-#define SKL_ADSPCS_SPA(x)	((x << SKL_ADSPCS_SPA_SHIFT) & SKL_ADSPCS_SPA_MASK)
-
-/* Current Power Active - power status of cores, set by hardware */
-#define SKL_ADSPCS_CPA_SHIFT	24
-#define SKL_ADSPCS_CPA_MASK	(SKL_DSP_CORES_MASK << SKL_ADSPCS_CPA_SHIFT)
-#define SKL_ADSPCS_CPA(x)	((x << SKL_ADSPCS_CPA_SHIFT) & SKL_ADSPCS_CPA_MASK)
-
-#define SST_DSP_POWER_D0	0x0  /* full On */
-#define SST_DSP_POWER_D3	0x3  /* Off */
+
+/*
+ * Core Reset - asserted high
+ * CRST Mask for a given core mask pattern, cm
+ */
+#define SKL_ADSPCS_CRST_SHIFT		0
+#define SKL_ADSPCS_CRST_MASK(cm)	((cm) << SKL_ADSPCS_CRST_SHIFT)
+
+/*
+ * Core run/stall - when set to '1' core is stalled
+ * CSTALL Mask for a given core mask pattern, cm
+ */
+#define SKL_ADSPCS_CSTALL_SHIFT		8
+#define SKL_ADSPCS_CSTALL_MASK(cm)	((cm) << SKL_ADSPCS_CSTALL_SHIFT)
+
+/*
+ * Set Power Active - when set to '1' turn cores on
+ * SPA Mask for a given core mask pattern, cm
+ */
+#define SKL_ADSPCS_SPA_SHIFT		16
+#define SKL_ADSPCS_SPA_MASK(cm)		((cm) << SKL_ADSPCS_SPA_SHIFT)
+
+/*
+ * Current Power Active - power status of cores, set by hardware
+ * CPA Mask for a given core mask pattern, cm
+ */
+#define SKL_ADSPCS_CPA_SHIFT		24
+#define SKL_ADSPCS_CPA_MASK(cm)		((cm) << SKL_ADSPCS_CPA_SHIFT)
 
 enum skl_dsp_states {
 	SKL_DSP_RUNNING = 1,
@@ -116,8 +134,8 @@ struct skl_dsp_fw_ops {
 	int (*load_fw)(struct sst_dsp  *ctx);
 	/* FW module parser/loader */
 	int (*parse_fw)(struct sst_dsp *ctx);
-	int (*set_state_D0)(struct sst_dsp *ctx);
-	int (*set_state_D3)(struct sst_dsp *ctx);
+	int (*set_state_D0)(struct sst_dsp *ctx, unsigned int core_id);
+	int (*set_state_D3)(struct sst_dsp *ctx, unsigned int core_id);
 	unsigned int (*get_fw_errcode)(struct sst_dsp *ctx);
 	int (*load_mod)(struct sst_dsp *ctx, u16 mod_id, u8 *mod_name);
 	int (*unload_mod)(struct sst_dsp *ctx, u16 mod_id);
@@ -158,14 +176,26 @@ int skl_cldma_prepare(struct sst_dsp *ctx);
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 		struct sst_dsp_device *sst_dev, int irq);
-int skl_dsp_enable_core(struct sst_dsp *ctx);
-int skl_dsp_disable_core(struct sst_dsp *ctx);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
+
+unsigned int skl_dsp_get_enabled_cores(struct sst_dsp *ctx);
+void skl_dsp_init_core_state(struct sst_dsp *ctx);
+int skl_dsp_enable_core(struct sst_dsp *ctx, unsigned int core_mask);
+int skl_dsp_disable_core(struct sst_dsp *ctx, unsigned int core_mask);
+int skl_dsp_core_power_up(struct sst_dsp *ctx, unsigned int core_mask);
+int skl_dsp_core_power_down(struct sst_dsp *ctx, unsigned int core_mask);
+int skl_dsp_core_unset_reset_state(struct sst_dsp *ctx,
+					unsigned int core_mask);
+int skl_dsp_start_core(struct sst_dsp *ctx, unsigned int core_mask);
+
 irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id);
 int skl_dsp_wake(struct sst_dsp *ctx);
 int skl_dsp_sleep(struct sst_dsp *ctx);
 void skl_dsp_free(struct sst_dsp *dsp);
 
+int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id);
+int skl_dsp_put_core(struct sst_dsp *ctx, unsigned int core_id);
+
 int skl_dsp_boot(struct sst_dsp *ctx);
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
@@ -182,7 +212,5 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
-int skl_dsp_start_core(struct sst_dsp *ctx);
-int skl_dsp_core_power_up(struct sst_dsp *ctx);
 
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 5102c7b415fe..2e3d4e80ef97 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -45,6 +45,14 @@ struct skl_ipc_header {
 	u32 extension;
 };
 
+#define SKL_DSP_CORES_MAX  2
+
+struct skl_dsp_cores {
+	unsigned int count;
+	enum skl_dsp_states state[SKL_DSP_CORES_MAX];
+	int usage_count[SKL_DSP_CORES_MAX];
+};
+
 struct skl_sst {
 	struct device *dev;
 	struct sst_dsp *dsp;
@@ -66,6 +74,9 @@ struct skl_sst {
 
 	/* Is firmware loaded */
 	bool fw_loaded;
+
+	/* multi-core */
+	struct skl_dsp_cores cores;
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index eaf0c9d19782..ecaca94d2a96 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -84,10 +84,8 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Request firmware failed %d\n", ret);
-			skl_dsp_disable_core(ctx);
 			return -EIO;
 		}
-
 	}
 
 	ret = snd_skl_parse_uuids(ctx, SKL_ADSP_FW_BIN_HDR_OFFSET);
@@ -95,7 +93,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		dev_err(ctx->dev,
 				"UUID parsing err: %d\n", ret);
 		release_firmware(ctx->fw);
-		skl_dsp_disable_core(ctx);
+		skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 		return ret;
 	}
 
@@ -159,13 +157,13 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 transfer_firmware_failed:
 	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
 skl_load_base_firmware_failed:
-	skl_dsp_disable_core(ctx);
+	skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 	release_firmware(ctx->fw);
 	ctx->fw = NULL;
 	return ret;
 }
 
-static int skl_set_dsp_D0(struct sst_dsp *ctx)
+static int skl_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 {
 	int ret;
 
@@ -180,7 +178,7 @@ static int skl_set_dsp_D0(struct sst_dsp *ctx)
 	return ret;
 }
 
-static int skl_set_dsp_D3(struct sst_dsp *ctx)
+static int skl_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 {
 	int ret;
 	struct skl_ipc_dxstate_info dx;
@@ -207,7 +205,7 @@ static int skl_set_dsp_D3(struct sst_dsp *ctx)
 	skl_ipc_op_int_disable(ctx);
 	skl_ipc_int_disable(ctx);
 
-	ret = skl_dsp_disable_core(ctx);
+	ret = skl_dsp_disable_core(ctx, core_id);
 	if (ret < 0) {
 		dev_err(ctx->dev, "disable dsp core failed ret: %d\n", ret);
 		ret = -EIO;
@@ -466,12 +464,16 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	if (ret)
 		return ret;
 
+	skl->cores.count = 2;
+
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
 		dev_err(dev, "Load base fw failed : %d", ret);
 		goto cleanup;
 	}
 
+	skl_dsp_init_core_state(sst);
+
 	if (dsp)
 		*dsp = skl;
 
-- 
2.8.1
