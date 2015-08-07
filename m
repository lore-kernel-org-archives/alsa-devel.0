From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add DSP module init and
	binding routines" to the asoc tree
Date: Fri, 07 Aug 2015 14:26:26 +0100
Message-ID: <E1ZNhfG-0003Kl-FC@finisterre>
References: <1438438244-17974-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3D0626046A
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:26:37 +0200 (CEST)
In-Reply-To: <1438438244-17974-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Add DSP module init and binding routines

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

>From beb73b266a75602084361c5ef0baa5bc14637f4b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 1 Aug 2015 19:40:43 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add DSP module init and binding
 routines

A module needs to be instantiated and then connected with other modules. On
cleanup we need to disconnect the module.
This is achieved by helpers module init, bind and unbind which are added
here

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 183 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |   9 ++
 2 files changed, 192 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 03a80ef..c435a51 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -573,3 +573,186 @@ static void skl_free_queue(struct skl_module_pin *mpin, int q_index)
 		mpin[q_index].id.instance_id = 0;
 	}
 }
+
+/*
+ * A module needs to be instanataited in DSP. A mdoule is present in a
+ * collection of module referred as a PIPE.
+ * We first calculate the module format, based on module type and then
+ * invoke the DSP by sending IPC INIT_INSTANCE using ipc helper
+ */
+int skl_init_module(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig, char *param)
+{
+	u16 module_config_size = 0;
+	void *param_data = NULL;
+	int ret;
+	struct skl_ipc_init_instance_msg msg;
+
+	dev_dbg(ctx->dev, "%s: module_id = %d instance=%d\n", __func__,
+		 mconfig->id.module_id, mconfig->id.instance_id);
+
+	if (mconfig->pipe->state != SKL_PIPE_CREATED) {
+		dev_err(ctx->dev, "Pipe not created state= %d pipe_id= %d\n",
+				 mconfig->pipe->state, mconfig->pipe->ppl_id);
+		return -EIO;
+	}
+
+	ret = skl_set_module_format(ctx, mconfig,
+			&module_config_size, &param_data);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to set module format ret=%d\n", ret);
+		return ret;
+	}
+
+	msg.module_id = mconfig->id.module_id;
+	msg.instance_id = mconfig->id.instance_id;
+	msg.ppl_instance_id = mconfig->pipe->ppl_id;
+	msg.param_data_size = module_config_size;
+	msg.core_id = mconfig->core_id;
+
+	ret = skl_ipc_init_instance(&ctx->ipc, &msg, param_data);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to init instance ret=%d\n", ret);
+		kfree(param_data);
+		return ret;
+	}
+	mconfig->m_state = SKL_MODULE_INIT_DONE;
+
+	return ret;
+}
+
+static void skl_dump_bind_info(struct skl_sst *ctx, struct skl_module_cfg
+	*src_module, struct skl_module_cfg *dst_module)
+{
+	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d\n",
+		__func__, src_module->id.module_id, src_module->id.instance_id);
+	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instacne=%d\n", __func__,
+		 dst_module->id.module_id, dst_module->id.instance_id);
+
+	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
+		src_module->m_state, dst_module->m_state);
+}
+
+/*
+ * On module freeup, we need to unbind the module with modules
+ * it is already bind.
+ * Find the pin allocated and unbind then using bind_unbind IPC
+ */
+int skl_unbind_modules(struct skl_sst *ctx,
+			struct skl_module_cfg *src_mcfg,
+			struct skl_module_cfg *dst_mcfg)
+{
+	int ret;
+	struct skl_ipc_bind_unbind_msg msg;
+	struct skl_module_inst_id src_id = src_mcfg->id;
+	struct skl_module_inst_id dst_id = dst_mcfg->id;
+	int in_max = dst_mcfg->max_in_queue;
+	int out_max = src_mcfg->max_out_queue;
+	int src_index, dst_index;
+
+	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
+
+	if (src_mcfg->m_state != SKL_MODULE_BIND_DONE)
+		return 0;
+
+	/*
+	 * if intra module unbind, check if both modules are BIND,
+	 * then send unbind
+	 */
+	if ((src_mcfg->pipe->ppl_id != dst_mcfg->pipe->ppl_id) &&
+				dst_mcfg->m_state != SKL_MODULE_BIND_DONE)
+		return 0;
+	else if (src_mcfg->m_state < SKL_MODULE_INIT_DONE &&
+				 dst_mcfg->m_state < SKL_MODULE_INIT_DONE)
+		return 0;
+
+	/* get src queue index */
+	src_index = skl_get_queue_index(src_mcfg->m_out_pin, dst_id, out_max);
+	if (src_index < 0)
+		return -EINVAL;
+
+	msg.src_queue = src_mcfg->m_out_pin[src_index].pin_index;
+
+	/* get dst queue index */
+	dst_index  = skl_get_queue_index(dst_mcfg->m_in_pin, src_id, in_max);
+	if (dst_index < 0)
+		return -EINVAL;
+
+	msg.dst_queue = dst_mcfg->m_in_pin[dst_index].pin_index;
+
+	msg.module_id = src_mcfg->id.module_id;
+	msg.instance_id = src_mcfg->id.instance_id;
+	msg.dst_module_id = dst_mcfg->id.module_id;
+	msg.dst_instance_id = dst_mcfg->id.instance_id;
+	msg.bind = false;
+
+	ret = skl_ipc_bind_unbind(&ctx->ipc, &msg);
+	if (!ret) {
+		src_mcfg->m_state = SKL_MODULE_UNINIT;
+		/* free queue only if unbind is success */
+		skl_free_queue(src_mcfg->m_out_pin, src_index);
+		skl_free_queue(dst_mcfg->m_in_pin, dst_index);
+	}
+
+	return ret;
+}
+
+/*
+ * Once a module is instantiated it need to be 'bind' with other modules in
+ * the pipeline. For binding we need to find the module pins which are bind
+ * together
+ * This function finds the pins and then sends bund_unbind IPC message to
+ * DSP using IPC helper
+ */
+int skl_bind_modules(struct skl_sst *ctx,
+			struct skl_module_cfg *src_mcfg,
+			struct skl_module_cfg *dst_mcfg)
+{
+	int ret;
+	struct skl_ipc_bind_unbind_msg msg;
+	struct skl_module_inst_id src_id = src_mcfg->id;
+	struct skl_module_inst_id dst_id = dst_mcfg->id;
+	int in_max = dst_mcfg->max_in_queue;
+	int out_max = src_mcfg->max_out_queue;
+	int src_index, dst_index;
+
+	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
+
+	if (src_mcfg->m_state < SKL_MODULE_INIT_DONE &&
+		dst_mcfg->m_state < SKL_MODULE_INIT_DONE)
+		return 0;
+
+	src_index = skl_alloc_queue(src_mcfg->m_out_pin, dst_id, out_max);
+	if (src_index < 0)
+		return -EINVAL;
+
+	msg.src_queue = src_mcfg->m_out_pin[src_index].pin_index;
+	dst_index = skl_alloc_queue(dst_mcfg->m_in_pin, src_id, in_max);
+	if (dst_index < 0) {
+		skl_free_queue(src_mcfg->m_out_pin, src_index);
+		return -EINVAL;
+	}
+
+	msg.dst_queue = dst_mcfg->m_in_pin[dst_index].pin_index;
+
+	dev_dbg(ctx->dev, "src queue = %d dst queue =%d\n",
+			 msg.src_queue, msg.dst_queue);
+
+	msg.module_id = src_mcfg->id.module_id;
+	msg.instance_id = src_mcfg->id.instance_id;
+	msg.dst_module_id = dst_mcfg->id.module_id;
+	msg.dst_instance_id = dst_mcfg->id.instance_id;
+	msg.bind = true;
+
+	ret = skl_ipc_bind_unbind(&ctx->ipc, &msg);
+
+	if (!ret) {
+		src_mcfg->m_state = SKL_MODULE_BIND_DONE;
+	} else {
+		/* error case , if IPC fails, clear the queue index */
+		skl_free_queue(src_mcfg->m_out_pin, src_index);
+		skl_free_queue(dst_mcfg->m_in_pin, dst_index);
+	}
+
+	return ret;
+}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index e4b2a33..b7e8aa8 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -263,5 +263,14 @@ struct skl_module_cfg {
 	struct skl_specific_cfg formats_config;
 };
 
+int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config,
+	char *param);
+
+int skl_bind_modules(struct skl_sst *ctx, struct skl_module_cfg
+	*src_module, struct skl_module_cfg *dst_module);
+
+int skl_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
+	*src_module, struct skl_module_cfg *dst_module);
+
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
2.5.0
