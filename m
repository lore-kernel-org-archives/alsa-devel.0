From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix support for
	multiple pins in a module" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:28 +0900
Message-ID: <E1ZqwCO-0004va-O4@finisterre>
References: <1445905380-18167-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 011F526588F
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:39 +0100 (CET)
In-Reply-To: <1445905380-18167-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix support for multiple pins in a module

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

>From 2e01daa7aba46c55faad9d5f0d262d45f80ddfce Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:49 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix support for multiple pins in a
 module

For supporting multiple dynamic pins, module state check is
incorrect. In case of unbind, module state need to be changed to
uninit if all pins in the module is is unbind state.
To handle module state correctly add pin state and use pin
state check to set module state correctly.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 83 ++++++++++++++++++++++------------
 sound/soc/intel/skylake/skl-topology.c |  1 +
 sound/soc/intel/skylake/skl-topology.h | 10 +++-
 3 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 50a1095..ee05958 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -571,10 +571,10 @@ static int skl_get_queue_index(struct skl_module_pin *mpin,
  * In static, the pin_index is fixed based on module_id and instance id
  */
 static int skl_alloc_queue(struct skl_module_pin *mpin,
-			struct skl_module_inst_id id, int max)
+			struct skl_module_cfg *tgt_cfg, int max)
 {
 	int i;
-
+	struct skl_module_inst_id id = tgt_cfg->id;
 	/*
 	 * if pin in dynamic, find first free pin
 	 * otherwise find match module and instance id pin as topology will
@@ -583,16 +583,23 @@ static int skl_alloc_queue(struct skl_module_pin *mpin,
 	 */
 	for (i = 0; i < max; i++)  {
 		if (mpin[i].is_dynamic) {
-			if (!mpin[i].in_use) {
+			if (!mpin[i].in_use &&
+				mpin[i].pin_state == SKL_PIN_UNBIND) {
+
 				mpin[i].in_use = true;
 				mpin[i].id.module_id = id.module_id;
 				mpin[i].id.instance_id = id.instance_id;
+				mpin[i].tgt_mcfg = tgt_cfg;
 				return i;
 			}
 		} else {
 			if (mpin[i].id.module_id == id.module_id &&
-				mpin[i].id.instance_id == id.instance_id)
+				mpin[i].id.instance_id == id.instance_id &&
+				mpin[i].pin_state == SKL_PIN_UNBIND) {
+
+				mpin[i].tgt_mcfg = tgt_cfg;
 				return i;
+			}
 		}
 	}
 
@@ -606,6 +613,28 @@ static void skl_free_queue(struct skl_module_pin *mpin, int q_index)
 		mpin[q_index].id.module_id = 0;
 		mpin[q_index].id.instance_id = 0;
 	}
+	mpin[q_index].pin_state = SKL_PIN_UNBIND;
+	mpin[q_index].tgt_mcfg = NULL;
+}
+
+/* Module state will be set to unint, if all the out pin state is UNBIND */
+
+static void skl_clear_module_state(struct skl_module_pin *mpin, int max,
+						struct skl_module_cfg *mcfg)
+{
+	int i;
+	bool found = false;
+
+	for (i = 0; i < max; i++)  {
+		if (mpin[i].pin_state == SKL_PIN_UNBIND)
+			continue;
+		found = true;
+		break;
+	}
+
+	if (!found)
+		mcfg->m_state = SKL_MODULE_UNINIT;
+	return;
 }
 
 /*
@@ -682,37 +711,30 @@ int skl_unbind_modules(struct skl_sst *ctx,
 	struct skl_module_inst_id dst_id = dst_mcfg->id;
 	int in_max = dst_mcfg->max_in_queue;
 	int out_max = src_mcfg->max_out_queue;
-	int src_index, dst_index;
+	int src_index, dst_index, src_pin_state, dst_pin_state;
 
 	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
 
-	if (src_mcfg->m_state != SKL_MODULE_BIND_DONE)
-		return 0;
-
-	/*
-	 * if intra module unbind, check if both modules are BIND,
-	 * then send unbind
-	 */
-	if ((src_mcfg->pipe->ppl_id != dst_mcfg->pipe->ppl_id) &&
-				dst_mcfg->m_state != SKL_MODULE_BIND_DONE)
-		return 0;
-	else if (src_mcfg->m_state < SKL_MODULE_INIT_DONE &&
-				 dst_mcfg->m_state < SKL_MODULE_INIT_DONE)
-		return 0;
-
 	/* get src queue index */
 	src_index = skl_get_queue_index(src_mcfg->m_out_pin, dst_id, out_max);
 	if (src_index < 0)
 		return -EINVAL;
 
-	msg.src_queue = src_mcfg->m_out_pin[src_index].pin_index;
+	msg.src_queue = src_index;
 
 	/* get dst queue index */
 	dst_index  = skl_get_queue_index(dst_mcfg->m_in_pin, src_id, in_max);
 	if (dst_index < 0)
 		return -EINVAL;
 
-	msg.dst_queue = dst_mcfg->m_in_pin[dst_index].pin_index;
+	msg.dst_queue = dst_index;
+
+	src_pin_state = src_mcfg->m_out_pin[src_index].pin_state;
+	dst_pin_state = dst_mcfg->m_in_pin[dst_index].pin_state;
+
+	if (src_pin_state != SKL_PIN_BIND_DONE ||
+		dst_pin_state != SKL_PIN_BIND_DONE)
+		return 0;
 
 	msg.module_id = src_mcfg->id.module_id;
 	msg.instance_id = src_mcfg->id.instance_id;
@@ -722,10 +744,15 @@ int skl_unbind_modules(struct skl_sst *ctx,
 
 	ret = skl_ipc_bind_unbind(&ctx->ipc, &msg);
 	if (!ret) {
-		src_mcfg->m_state = SKL_MODULE_UNINIT;
 		/* free queue only if unbind is success */
 		skl_free_queue(src_mcfg->m_out_pin, src_index);
 		skl_free_queue(dst_mcfg->m_in_pin, dst_index);
+
+		/*
+		 * check only if src module bind state, bind is
+		 * always from src -> sink
+		 */
+		skl_clear_module_state(src_mcfg->m_out_pin, out_max, src_mcfg);
 	}
 
 	return ret;
@@ -744,8 +771,6 @@ int skl_bind_modules(struct skl_sst *ctx,
 {
 	int ret;
 	struct skl_ipc_bind_unbind_msg msg;
-	struct skl_module_inst_id src_id = src_mcfg->id;
-	struct skl_module_inst_id dst_id = dst_mcfg->id;
 	int in_max = dst_mcfg->max_in_queue;
 	int out_max = src_mcfg->max_out_queue;
 	int src_index, dst_index;
@@ -756,18 +781,18 @@ int skl_bind_modules(struct skl_sst *ctx,
 		dst_mcfg->m_state < SKL_MODULE_INIT_DONE)
 		return 0;
 
-	src_index = skl_alloc_queue(src_mcfg->m_out_pin, dst_id, out_max);
+	src_index = skl_alloc_queue(src_mcfg->m_out_pin, dst_mcfg, out_max);
 	if (src_index < 0)
 		return -EINVAL;
 
-	msg.src_queue = src_mcfg->m_out_pin[src_index].pin_index;
-	dst_index = skl_alloc_queue(dst_mcfg->m_in_pin, src_id, in_max);
+	msg.src_queue = src_index;
+	dst_index = skl_alloc_queue(dst_mcfg->m_in_pin, src_mcfg, in_max);
 	if (dst_index < 0) {
 		skl_free_queue(src_mcfg->m_out_pin, src_index);
 		return -EINVAL;
 	}
 
-	msg.dst_queue = dst_mcfg->m_in_pin[dst_index].pin_index;
+	msg.dst_queue = dst_index;
 
 	dev_dbg(ctx->dev, "src queue = %d dst queue =%d\n",
 			 msg.src_queue, msg.dst_queue);
@@ -782,6 +807,8 @@ int skl_bind_modules(struct skl_sst *ctx,
 
 	if (!ret) {
 		src_mcfg->m_state = SKL_MODULE_BIND_DONE;
+		src_mcfg->m_out_pin[src_index].pin_state = SKL_PIN_BIND_DONE;
+		dst_mcfg->m_in_pin[dst_index].pin_state = SKL_PIN_BIND_DONE;
 	} else {
 		/* error case , if IPC fails, clear the queue index */
 		skl_free_queue(src_mcfg->m_out_pin, src_index);
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e11a9e4..e8258d4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1049,6 +1049,7 @@ static void skl_fill_module_pin_info(struct skl_dfw_module_pin *dfw_pin,
 		m_pin[i].id.instance_id = dfw_pin[i].instance_id;
 		m_pin[i].in_use = false;
 		m_pin[i].is_dynamic = is_dynamic;
+		m_pin[i].pin_state = SKL_PIN_UNBIND;
 	}
 }
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 76053a8..cd87683 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -180,16 +180,24 @@ struct skl_module_fmt {
 	u32 ch_cfg;
 };
 
+struct skl_module_cfg;
+
 struct skl_module_inst_id {
 	u32 module_id;
 	u32 instance_id;
 };
 
+enum skl_module_pin_state {
+	SKL_PIN_UNBIND = 0,
+	SKL_PIN_BIND_DONE = 1,
+};
+
 struct skl_module_pin {
 	struct skl_module_inst_id id;
-	u8 pin_index;
 	bool is_dynamic;
 	bool in_use;
+	enum skl_module_pin_state pin_state;
+	struct skl_module_cfg *tgt_mcfg;
 };
 
 struct skl_specific_cfg {
-- 
2.6.1
