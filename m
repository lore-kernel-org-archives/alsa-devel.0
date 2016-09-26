From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/10] ASoC: Intel: Skylake: Add D0iX IPCs
Date: Mon, 26 Sep 2016 11:05:30 +0530
Message-ID: <1474868137-29712-4-git-send-email-vinod.koul@intel.com>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B20B2266C6B
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 07:27:20 +0200 (CEST)
In-Reply-To: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

To set D0iX, driver needs to tell the DSP to go into D0iX mode by
sending "Set D0iX IPC". Add support for that IPC.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 43 ++++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-sst-ipc.h | 10 ++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 0bd01e62622c..95120771a4f6 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -172,6 +172,17 @@
 					<< IPC_INITIAL_BLOCK_SHIFT)
 #define IPC_INITIAL_BLOCK_CLEAR		~(IPC_INITIAL_BLOCK_MASK \
 					  << IPC_INITIAL_BLOCK_SHIFT)
+/* Set D0ix IPC extension register */
+#define IPC_D0IX_WAKE_SHIFT		0
+#define IPC_D0IX_WAKE_MASK		0x1
+#define IPC_D0IX_WAKE(x)		(((x) & IPC_D0IX_WAKE_MASK) \
+					<< IPC_D0IX_WAKE_SHIFT)
+
+#define IPC_D0IX_STREAMING_SHIFT	1
+#define IPC_D0IX_STREAMING_MASK		0x1
+#define IPC_D0IX_STREAMING(x)		(((x) & IPC_D0IX_STREAMING_MASK) \
+					<< IPC_D0IX_STREAMING_SHIFT)
+
 
 enum skl_ipc_msg_target {
 	IPC_FW_GEN_MSG = 0,
@@ -258,7 +269,8 @@ enum skl_ipc_module_msg {
 	IPC_MOD_LARGE_CONFIG_SET = 4,
 	IPC_MOD_BIND = 5,
 	IPC_MOD_UNBIND = 6,
-	IPC_MOD_SET_DX = 7
+	IPC_MOD_SET_DX = 7,
+	IPC_MOD_SET_D0IX = 8
 };
 
 static void skl_ipc_tx_data_copy(struct ipc_message *msg, char *tx_data,
@@ -931,3 +943,32 @@ int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_sst_ipc_load_library);
+
+int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc, struct skl_ipc_d0ix_msg *msg)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret;
+
+	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_MOD_SET_D0IX);
+	header.primary |= IPC_MOD_INSTANCE_ID(msg->instance_id);
+	header.primary |= IPC_MOD_ID(msg->module_id);
+
+	header.extension = IPC_D0IX_WAKE(msg->wake);
+	header.extension |= IPC_D0IX_STREAMING(msg->streaming);
+
+	dev_dbg(ipc->dev, "In %s primary=%x ext=%x\n", __func__,
+			header.primary,	header.extension);
+
+	/*
+	 * Use the nopm IPC here as we dont want it checking for D0iX
+	 */
+	ret = sst_ipc_tx_message_nopm(ipc, *ipc_header, NULL, 0, NULL, 0);
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: set d0ix failed, err %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_ipc_set_d0ix);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 0334ed4af031..1ae265d8ee08 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -111,6 +111,13 @@ struct skl_ipc_large_config_msg {
 	u32 param_data_size;
 };
 
+struct skl_ipc_d0ix_msg {
+	u32 module_id;
+	u32 instance_id;
+	u8 streaming;
+	u8 wake;
+};
+
 #define SKL_IPC_BOOT_MSECS		3000
 
 #define SKL_IPC_D3_MASK	0
@@ -155,6 +162,9 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 			u8 dma_id, u8 table_id);
 
+int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc,
+		struct skl_ipc_d0ix_msg *msg);
+
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
 void skl_ipc_op_int_disable(struct sst_dsp *ctx);
-- 
1.9.1
