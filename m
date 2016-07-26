From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 12/12] ASoC: Intel: Skylake: Add module
	processing domain support
Date: Tue, 26 Jul 2016 18:06:50 +0530
Message-ID: <1469536610-27606-13-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 12BA52669DC
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:30:27 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

A module can be scheduled in deferent processing domains in DSP. Topology
specifies the module domain.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c       | 1 +
 sound/soc/intel/skylake/skl-sst-ipc.c        | 6 ++++++
 sound/soc/intel/skylake/skl-sst-ipc.h        | 1 +
 sound/soc/intel/skylake/skl-topology.c       | 1 +
 sound/soc/intel/skylake/skl-tplg-interface.h | 3 ++-
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 2199a91d90d6..8a750b67273f 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -870,6 +870,7 @@ int skl_init_module(struct skl_sst *ctx,
 	msg.ppl_instance_id = mconfig->pipe->ppl_id;
 	msg.param_data_size = module_config_size;
 	msg.core_id = mconfig->core_id;
+	msg.domain = mconfig->domain;
 
 	ret = skl_ipc_init_instance(&ctx->ipc, &msg, param_data);
 	if (ret < 0) {
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 04c1b123aadf..b8baa9aaf6c4 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -114,6 +114,11 @@
 #define IPC_CORE_ID(x)			(((x) & IPC_CORE_ID_MASK) \
 					<< IPC_CORE_ID_SHIFT)
 
+#define IPC_DOMAIN_SHIFT                28
+#define IPC_DOMAIN_MASK                 0x1
+#define IPC_DOMAIN(x)                   (((x) & IPC_DOMAIN_MASK) \
+					<< IPC_DOMAIN_SHIFT)
+
 /* Bind/Unbind message extension register */
 #define IPC_DST_MOD_ID_SHIFT		0
 #define IPC_DST_MOD_ID(x)		(((x) & IPC_MOD_ID_MASK) \
@@ -705,6 +710,7 @@ int skl_ipc_init_instance(struct sst_generic_ipc *ipc,
 	header.extension = IPC_CORE_ID(msg->core_id);
 	header.extension |= IPC_PPL_INSTANCE_ID(msg->ppl_instance_id);
 	header.extension |= IPC_PARAM_BLOCK_SIZE(param_block_size);
+	header.extension |= IPC_DOMAIN(msg->domain);
 
 	dev_dbg(ipc->dev, "In %s primary =%x ext=%x\n", __func__,
 			 header.primary, header.extension);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index aad527d5fc52..0334ed4af031 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -91,6 +91,7 @@ struct skl_ipc_init_instance_msg {
 	u16 param_data_size;
 	u8 ppl_instance_id;
 	u8 core_id;
+	u8 domain;
 };
 
 struct skl_ipc_bind_unbind_msg {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a1d9f84d9674..1ef2c92d1944 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1656,6 +1656,7 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->max_in_queue = dfw_config->max_in_queue;
 	mconfig->max_out_queue = dfw_config->max_out_queue;
 	mconfig->is_loadable = dfw_config->is_loadable;
+	mconfig->domain = dfw_config->proc_domain;
 	skl_tplg_fill_fmt(mconfig->in_fmt, dfw_config->in_fmt,
 						MODULE_MAX_IN_PINS);
 	skl_tplg_fill_fmt(mconfig->out_fmt, dfw_config->out_fmt,
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 1b531c165a91..bd8b4ae43557 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -210,7 +210,8 @@ struct skl_dfw_module {
 	u32 is_dynamic_in_pin:1;
 	u32 is_dynamic_out_pin:1;
 	u32 is_loadable:1;
-	u32 rsvd3:11;
+	u32 proc_domain:1;
+	u32 rsvd3:10;
 
 	struct skl_dfw_pipe pipe;
 	struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
-- 
1.9.1
