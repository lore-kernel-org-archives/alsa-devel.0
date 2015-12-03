From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 06/12] ASoC: Intel: Skylake: add
	LARGE_CONFIG_GET IPC support
Date: Thu,  3 Dec 2015 23:29:55 +0530
Message-ID: <1449165601-11226-7-git-send-email-vinod.koul@intel.com>
References: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A38926055E
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:20 +0100 (CET)
In-Reply-To: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Mousami Jana <mousami.janax@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mousami Jana <mousami.janax@intel.com>

For messages which have larger payload than mailbox data, we need
to split the payload using set of messages containing mailbox
size as payload.

For sending such payload we already support LARGE_CONFIG_SET
IPCs and now to query such payload add LARGE_CONFIG_GET IPC

Signed-off-by: Mousami Jana <mousami.janax@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 53 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h |  3 ++
 2 files changed, 56 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 33860d2311c4..62e665a3b8f7 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -349,6 +349,8 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 	switch (reply) {
 	case IPC_GLB_REPLY_SUCCESS:
 		dev_info(ipc->dev, "ipc FW reply %x: success\n", header.primary);
+		/* copy the rx data from the mailbox */
+		sst_dsp_inbox_read(ipc->dsp, msg->rx_data, msg->rx_size);
 		break;
 
 	case IPC_GLB_REPLY_OUT_OF_MEMORY:
@@ -834,3 +836,54 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_ipc_set_large_config);
+
+int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
+		struct skl_ipc_large_config_msg *msg, u32 *param)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret = 0;
+	size_t sz_remaining, rx_size, data_offset;
+
+	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_MOD_LARGE_CONFIG_GET);
+	header.primary |= IPC_MOD_INSTANCE_ID(msg->instance_id);
+	header.primary |= IPC_MOD_ID(msg->module_id);
+
+	header.extension = IPC_DATA_OFFSET_SZ(msg->param_data_size);
+	header.extension |= IPC_LARGE_PARAM_ID(msg->large_param_id);
+	header.extension |= IPC_FINAL_BLOCK(1);
+	header.extension |= IPC_INITIAL_BLOCK(1);
+
+	sz_remaining = msg->param_data_size;
+	data_offset = 0;
+
+	while (sz_remaining != 0) {
+		rx_size = sz_remaining > SKL_ADSP_W1_SZ
+				? SKL_ADSP_W1_SZ : sz_remaining;
+		if (rx_size == sz_remaining)
+			header.extension |= IPC_FINAL_BLOCK(1);
+
+		ret = sst_ipc_tx_message_wait(ipc, *ipc_header, NULL, 0,
+					      ((char *)param) + data_offset,
+					      msg->param_data_size);
+		if (ret < 0) {
+			dev_err(ipc->dev,
+				"ipc: get large config fail, err: %d\n", ret);
+			return ret;
+		}
+		sz_remaining -= rx_size;
+		data_offset = msg->param_data_size - sz_remaining;
+
+		/* clear the fields */
+		header.extension &= IPC_INITIAL_BLOCK_CLEAR;
+		header.extension &= IPC_DATA_OFFSET_SZ_CLEAR;
+		/* fill the fields */
+		header.extension |= IPC_INITIAL_BLOCK(1);
+		header.extension |= IPC_DATA_OFFSET_SZ(data_offset);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_ipc_get_large_config);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index e17012778560..1bbcdb471cf2 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -120,6 +120,9 @@ int skl_ipc_set_dx(struct sst_generic_ipc *ipc,
 int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param);
 
+int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
+		struct skl_ipc_large_config_msg *msg, u32 *param);
+
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
 void skl_ipc_op_int_disable(struct sst_dsp *ctx);
-- 
1.9.1
