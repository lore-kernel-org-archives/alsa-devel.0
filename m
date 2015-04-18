From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 3/7] ASoC: hda: add FW module init/bind IPC
Date: Sun, 19 Apr 2015 02:27:29 +0530
Message-ID: <1429390653-8194-4-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 77673265133
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:48 +0200 (CEST)
In-Reply-To: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This helper function creates module init and bind IPC message based on
module parameter and calls IPC interface to send the IPC to FW.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/hda_soc_dsp.c |  133 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/sound/soc/hda/hda_soc_dsp.c b/sound/soc/hda/hda_soc_dsp.c
index fea47645368e..5a9927b82852 100644
--- a/sound/soc/hda/hda_soc_dsp.c
+++ b/sound/soc/hda/hda_soc_dsp.c
@@ -455,3 +455,136 @@ static int ssth_free_queue(u8 *queue_mask, u8 queue_index)
 	else
 		return queue_index;
 }
+
+int ssth_init_module(struct ssth_lib *ctx,
+			struct ssth_module_config *mconfig,
+			struct hda_sst_algo_data *ac)
+{
+	u16 module_config_size = 0;
+	void *param_data = NULL;
+	int ret = 0;
+	struct ssth_init_instance_msg msg;
+	struct ssth_dxstate_info dx;
+
+	dev_dbg(ctx->dev, "%s: module_id = %d instance=%d\n", __func__,
+		 mconfig->id.module_id, mconfig->id.instance_id);
+
+	ret = ssth_set_module_format(ctx, mconfig,
+			&module_config_size, &param_data);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to set module format ret=%d\n", ret);
+		goto exit;
+	}
+
+	if (mconfig->core_id != SSTH_AFFINITY_CORE_0) {
+		dx.core_mask = mconfig->core_id;
+		dx.dx_mask = mconfig->core_id;
+		/*SET core to D0 */
+		ret = ssth_ipc_set_dx(ctx->ipc, 0, 0, &dx);
+		if (ret < 0)
+			return ret;
+
+	}
+	msg.module_id = mconfig->id.module_id;
+	msg.instance_id = mconfig->id.instance_id;
+	msg.ppl_instance_id = mconfig->pipe->ppl_id;
+	msg.param_data_size = module_config_size;
+	msg.core_id = mconfig->core_id;
+
+	if (mconfig->pipe->state != SSTH_PIPE_STATE_CREATED) {
+		dev_err(ctx->dev, "Pipe not created for Module state= %d pipe_id= %d\n",
+				 mconfig->pipe->state, mconfig->pipe->ppl_id);
+		return -EIO;
+	}
+
+	ret = ssth_ipc_init_instance(ctx->ipc, &msg, param_data);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to init instance ret=%d\n", ret);
+		goto exit;
+	}
+	mconfig->m_state = SSTH_MODULE_STATE_INIT_DONE;
+
+exit:
+	if (param_data != NULL)
+		kfree(param_data);
+
+	return ret;
+}
+
+int ssth_bind_unbind_modules(struct ssth_lib *ctx, struct ssth_module_config
+	*src_module, struct ssth_module_config *dst_module, bool bind)
+{
+	int ret = 0;
+	struct ssth_bind_unbind_msg msg;
+	struct ssth_sink_module *sink_module, *__sink_module;
+
+	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d dst_module=%d \
+		dst_instacne=%d\n", __func__, src_module->id.module_id,
+		src_module->id.instance_id, dst_module->id.module_id,
+		dst_module->id.instance_id);
+
+	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
+		src_module->m_state, dst_module->m_state);
+	/*if module is not bind, then don't send unbind */
+	if (!bind) {
+		if (src_module->m_state != SSTH_MODULE_STATE_BIND_DONE)
+			return ret;
+		/* if intra module unbind, check if both modules are BIND,
+		then send unbind
+		*/
+		if ((src_module->pipe->ppl_id != dst_module->pipe->ppl_id) &&
+			dst_module->m_state != SSTH_MODULE_STATE_BIND_DONE)
+			return ret;
+	} else if (src_module->m_state != SSTH_MODULE_STATE_INIT_DONE &&
+			 dst_module->m_state != SSTH_MODULE_STATE_INIT_DONE)
+		return ret;
+
+	msg.module_id = src_module->id.module_id;
+	msg.instance_id = src_module->id.instance_id;
+	msg.dst_module_id = dst_module->id.module_id;
+	msg.dst_instance_id = dst_module->id.instance_id;
+	if (bind) {
+		src_module->out_queue = ssth_alloc_queue(&src_module->out_queue_mask,
+				 src_module->max_out_queue, src_module->out_queue);
+		dst_module->in_queue = ssth_alloc_queue(&dst_module->in_queue_mask,
+				 dst_module->max_in_queue, dst_module->in_queue);
+		sink_module = devm_kzalloc(ctx->dev, sizeof(struct ssth_sink_module), GFP_KERNEL);
+		if (!sink_module) {
+			dev_err(ctx->dev, "Unable to allocate mem\n");
+			return -ENOMEM;
+		}
+		sink_module->id.instance_id = dst_module->id.instance_id;
+		sink_module->id.module_id = dst_module->id.module_id;
+		sink_module->in_queue = dst_module->in_queue;
+		list_add_tail(&sink_module->node, &src_module->sink_list);
+	} else {
+		src_module->out_queue = ssth_free_queue(&src_module->out_queue_mask,
+				 src_module->out_queue);
+		list_for_each_entry_safe(sink_module, __sink_module, &src_module->sink_list, node) {
+			if ((sink_module->id.module_id == dst_module->id.module_id) &&
+				((sink_module->id.instance_id == dst_module->id.instance_id))) {
+				list_del(&sink_module->node);
+				dst_module->in_queue = sink_module->in_queue;
+				devm_kfree(ctx->dev, sink_module);
+				break;
+			}
+		}
+		dst_module->in_queue = ssth_free_queue(&dst_module->in_queue_mask,
+				dst_module->in_queue);
+	}
+	dev_dbg(ctx->dev, "in queque = %d out_queue =%d\n",
+		 src_module->out_queue, dst_module->in_queue);
+	msg.src_queue = src_module->out_queue;
+	msg.dst_queue = dst_module->in_queue;
+	msg.bind = bind;
+
+	ret = ssth_ipc_bind_unbind(ctx->ipc, &msg);
+
+	if (!ret) {
+		if (bind)
+			src_module->m_state = SSTH_MODULE_STATE_BIND_DONE;
+		else
+			src_module->m_state = SSTH_MODULE_STATE_UNINIT;
+	}
+	return ret;
+}
-- 
1.7.9.5
