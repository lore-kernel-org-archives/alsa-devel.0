From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 2/2] ASoC: Intel: Skylake: large_config_get
	overhaul
Date: Tue, 23 Jul 2019 16:43:41 +0200
Message-ID: <20190723144341.21339-3-cezary.rojewski@intel.com>
References: <20190723144341.21339-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F243F8045F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 16:44:20 +0200 (CEST)
In-Reply-To: <20190723144341.21339-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

LARGE_CONFIG_GET is among the most crucial IPCs. Host is expected to
send single request first to obtain total payload size from received
header's data_off_size. From then on, it loops for each frame exceeding
inbox size until entire payload is read. If entire payload is contained
within the very first frame, no looping is performed.

LARGE_CONFIG_GET is a flexible IPC, it not only receives payload but may
carry one with them to provide list of params DSP module should return
info for. This behavior is usually reserved for vendors and IPC handler
should not touch that content. To achieve that, simply pass provided
payload and bytes to sst_ipc_tx_message_wait as a part of request.

In current state, LARGE_CONFIG_GET message handler does nothing of that,
in consequence making it dysfunctional. Overhaul said handler allowing
rightful king of IPCs to return back on his throne - kingdom he shares
with his twin brother: LARGE_CONFIG_SET.

The looping has not been added in this update as payloads of such size
do not exist in practice. Will need to create custom module specifically
for that very case and test against it before that feature can be added.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c |  3 +-
 sound/soc/intel/skylake/skl-sst-ipc.c  | 54 +++++++++++---------------
 sound/soc/intel/skylake/skl-sst-ipc.h  |  3 +-
 3 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index febc070839e0..90c19c529b01 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1404,11 +1404,12 @@ int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
 			  u32 param_id, struct skl_module_cfg *mcfg)
 {
 	struct skl_ipc_large_config_msg msg;
+	size_t bytes = size;
 
 	msg.module_id = mcfg->id.module_id;
 	msg.instance_id = mcfg->id.pvt_id;
 	msg.param_data_size = size;
 	msg.large_param_id = param_id;
 
-	return skl_ipc_get_large_config(&ctx->ipc, &msg, params);
+	return skl_ipc_get_large_config(&ctx->ipc, &msg, &params, &bytes);
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index c040158ae282..ce19654a6e49 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -969,12 +969,17 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 EXPORT_SYMBOL_GPL(skl_ipc_set_large_config);
 
 int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
-		struct skl_ipc_large_config_msg *msg, u32 *param)
+		struct skl_ipc_large_config_msg *msg,
+		unsigned int **payload, size_t *bytes)
 {
 	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0}, reply = {0};
-	int ret = 0;
-	size_t sz_remaining, rx_size, data_offset;
+	struct sst_ipc_message request, reply = {0};
+	unsigned int *buf;
+	int ret;
+
+	reply.data = kzalloc(SKL_ADSP_W1_SZ, GFP_KERNEL);
+	if (!reply.data)
+		return -ENOMEM;
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
 	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
@@ -987,34 +992,21 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 	header.extension |= IPC_FINAL_BLOCK(1);
 	header.extension |= IPC_INITIAL_BLOCK(1);
 
-	sz_remaining = msg->param_data_size;
-	data_offset = 0;
-
-	while (sz_remaining != 0) {
-		rx_size = sz_remaining > SKL_ADSP_W1_SZ
-				? SKL_ADSP_W1_SZ : sz_remaining;
-		if (rx_size == sz_remaining)
-			header.extension |= IPC_FINAL_BLOCK(1);
-
-		request.header = *(u64 *)(&header);
-		reply.data = ((char *)param) + data_offset;
-		reply.size = msg->param_data_size;
-		ret = sst_ipc_tx_message_wait(ipc, request, &reply);
-		if (ret < 0) {
-			dev_err(ipc->dev,
-				"ipc: get large config fail, err: %d\n", ret);
-			return ret;
-		}
-		sz_remaining -= rx_size;
-		data_offset = msg->param_data_size - sz_remaining;
+	request.header = *(u64 *)&header;
+	request.data = *payload;
+	request.size = *bytes;
+	reply.size = SKL_ADSP_W1_SZ;
 
-		/* clear the fields */
-		header.extension &= IPC_INITIAL_BLOCK_CLEAR;
-		header.extension &= IPC_DATA_OFFSET_SZ_CLEAR;
-		/* fill the fields */
-		header.extension |= IPC_INITIAL_BLOCK(1);
-		header.extension |= IPC_DATA_OFFSET_SZ(data_offset);
-	}
+	ret = sst_ipc_tx_message_wait(ipc, request, &reply);
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: get large config fail: %d\n", ret);
+
+	reply.size = (reply.header >> 32) & IPC_DATA_OFFSET_SZ_MASK;
+	buf = krealloc(reply.data, reply.size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	*payload = buf;
+	*bytes = reply.size;
 
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 9c31a48e99dd..3134774ea93d 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -187,7 +187,8 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param);
 
 int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
-		struct skl_ipc_large_config_msg *msg, u32 *param);
+		struct skl_ipc_large_config_msg *msg,
+		unsigned int **payload, size_t *bytes);
 
 int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 			u8 dma_id, u8 table_id, bool wait);
-- 
2.17.1
