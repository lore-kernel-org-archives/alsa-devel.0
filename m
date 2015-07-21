From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Skylake: Add DSP module init
	and binding routines
Date: Tue, 21 Jul 2015 23:53:59 +0530
Message-ID: <1437503040-7392-6-git-send-email-vinod.koul@intel.com>
References: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BCB126512D
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 20:22:24 +0200 (CEST)
In-Reply-To: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The modules init and binding helper function creates module init and bind
IPC message based on module parameter and calls IPC interface to send the
IPC to DSP FW.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 165 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |   4 +
 2 files changed, 169 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index faa0e71d4ae5..72af582183ae 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -547,3 +547,168 @@ static int skl_free_queue(struct skl_module_pin *mpin,
 
 	return m_pin.pin_index;
 }
+
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
+static int skl_unbind_modules(struct skl_sst *ctx,
+			struct skl_module_cfg *src_mcfg,
+			struct skl_module_cfg *dst_mcfg)
+{
+	int ret;
+	struct skl_ipc_bind_unbind_msg msg;
+	struct skl_module_inst_id src_id = src_mcfg->id;
+	struct skl_module_inst_id dst_id = dst_mcfg->id;
+	int in_max = dst_mcfg->max_in_queue;
+	int out_max = src_mcfg->max_out_queue;
+	struct skl_module_pin m_pin;
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
+	/* get src pin index */
+	m_pin = skl_get_queue(src_mcfg->m_out_pin, src_id, out_max);
+	if (m_pin.pin_index < 0)
+		return -EINVAL;
+
+	msg.src_queue = m_pin.pin_index;
+
+	/* get dst pin index */
+	m_pin  = skl_get_queue(dst_mcfg->m_in_pin, dst_id, in_max);
+	if (m_pin.pin_index < 0) {
+		skl_free_queue(src_mcfg->m_out_pin, src_id, out_max);
+		return -EINVAL;
+	}
+
+	msg.dst_queue = m_pin.pin_index;
+
+	msg.module_id = src_mcfg->id.module_id;
+	msg.instance_id = src_mcfg->id.instance_id;
+	msg.dst_module_id = dst_mcfg->id.module_id;
+	msg.dst_instance_id = dst_mcfg->id.instance_id;
+	msg.bind = false;
+
+	ret = skl_ipc_bind_unbind(&ctx->ipc, &msg);
+	if (!ret)
+		src_mcfg->m_state = SKL_MODULE_UNINIT;
+
+	skl_free_queue(src_mcfg->m_out_pin, src_id, out_max);
+	skl_free_queue(dst_mcfg->m_in_pin, dst_id, in_max);
+
+	return ret;
+}
+
+static int skl_bind_modules(struct skl_sst *ctx,
+			struct skl_module_cfg *src_mcfg,
+			struct skl_module_cfg *dst_mcfg)
+{
+	int pin_index, ret;
+	struct skl_ipc_bind_unbind_msg msg;
+	struct skl_module_inst_id src_id = src_mcfg->id;
+	struct skl_module_inst_id dst_id = dst_mcfg->id;
+	int in_max = dst_mcfg->max_in_queue;
+	int out_max = src_mcfg->max_out_queue;
+
+	if (src_mcfg->m_state < SKL_MODULE_INIT_DONE &&
+		dst_mcfg->m_state < SKL_MODULE_INIT_DONE)
+		return 0;
+
+	pin_index = skl_alloc_queue(src_mcfg->m_out_pin, src_id, out_max);
+	if (pin_index < 0)
+		return -EINVAL;
+
+	msg.src_queue = pin_index;
+	pin_index = skl_alloc_queue(dst_mcfg->m_in_pin, dst_id, in_max);
+	if (pin_index < 0) {
+		skl_free_queue(src_mcfg->m_out_pin, src_id, out_max);
+		return -EINVAL;
+	}
+
+	msg.dst_queue = pin_index;
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
+		skl_free_queue(src_mcfg->m_out_pin, src_id, out_max);
+		skl_free_queue(dst_mcfg->m_in_pin, dst_id, in_max);
+	}
+
+	return ret;
+}
+
+int skl_bind_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
+	*src_module, struct skl_module_cfg *dst_module, bool bind)
+{
+	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d\n",
+		__func__, src_module->id.module_id, src_module->id.instance_id);
+	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instacne=%d\n", __func__,
+		 dst_module->id.module_id, dst_module->id.instance_id);
+
+	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
+		src_module->m_state, dst_module->m_state);
+
+	if (bind)
+		return skl_bind_modules(ctx, src_module, dst_module);
+	else
+		return skl_unbind_modules(ctx, src_module, dst_module);
+}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index e4b2a339b2f4..c944ec024e62 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -263,5 +263,9 @@ struct skl_module_cfg {
 	struct skl_specific_cfg formats_config;
 };
 
+int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config,
+	char *param);
+int skl_bind_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
+	*src_module, struct skl_module_cfg *dst_module, bool bind);
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
1.9.1
