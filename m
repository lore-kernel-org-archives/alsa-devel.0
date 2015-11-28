From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/16] ASoC: Intel: Skylake: Add support for
	Load/Unload IPCs
Date: Sat, 28 Nov 2015 15:01:51 +0530
Message-ID: <1448703121-5831-7-git-send-email-vinod.koul@intel.com>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E6D266838
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:32:49 +0100 (CET)
In-Reply-To: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

Some firmware modules can be loaded and unloaded to/from DSP.
This can be done by invoking IPCs Load module and unload module
respectively. So this patch starts this by adding support for
these IPCs

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 47 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h |  6 +++++
 2 files changed, 53 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 95679c02c6ee..d99ec9a2f397 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -130,6 +130,11 @@
 #define IPC_SRC_QUEUE_MASK		0x7
 #define IPC_SRC_QUEUE(x)		(((x) & IPC_SRC_QUEUE_MASK) \
 					<< IPC_SRC_QUEUE_SHIFT)
+/* Load Module count */
+#define IPC_LOAD_MODULE_SHIFT		0
+#define IPC_LOAD_MODULE_MASK		0xFF
+#define IPC_LOAD_MODULE_CNT(x)		(((x) & IPC_LOAD_MODULE_MASK) \
+					<< IPC_LOAD_MODULE_SHIFT)
 
 /* Save pipeline messgae extension register */
 #define IPC_DMA_ID_SHIFT		0
@@ -728,6 +733,48 @@ int skl_ipc_bind_unbind(struct sst_generic_ipc *ipc,
 }
 EXPORT_SYMBOL_GPL(skl_ipc_bind_unbind);
 
+int skl_ipc_load_modules(struct sst_generic_ipc *ipc,
+				u8 module_cnt, void *data)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret;
+
+	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_GLB_LOAD_MULTIPLE_MODS);
+	header.primary |= IPC_LOAD_MODULE_CNT(module_cnt);
+
+	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, data,
+				(sizeof(u16) * module_cnt), NULL, 0);
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: load modules failed :%d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_ipc_load_modules);
+
+int skl_ipc_unload_modules(struct sst_generic_ipc *ipc, u8 module_cnt,
+							void *data)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret;
+
+	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_GLB_UNLOAD_MULTIPLE_MODS);
+	header.primary |= IPC_LOAD_MODULE_CNT(module_cnt);
+
+	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, data,
+				(sizeof(u16) * module_cnt), NULL, 0);
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: unload modules failed :%d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_ipc_unload_modules);
+
 int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param)
 {
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index f1a154e45dc3..e17012778560 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -108,6 +108,12 @@ int skl_ipc_init_instance(struct sst_generic_ipc *sst_ipc,
 int skl_ipc_bind_unbind(struct sst_generic_ipc *sst_ipc,
 		struct skl_ipc_bind_unbind_msg *msg);
 
+int skl_ipc_load_modules(struct sst_generic_ipc *ipc,
+				u8 module_cnt, void *data);
+
+int skl_ipc_unload_modules(struct sst_generic_ipc *ipc,
+				u8 module_cnt, void *data);
+
 int skl_ipc_set_dx(struct sst_generic_ipc *ipc,
 		u8 instance_id, u16 module_id, struct skl_ipc_dxstate_info *dx);
 
-- 
2.4.3
