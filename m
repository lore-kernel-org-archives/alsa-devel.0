From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v5 1/2] ASoC: Intel: Skylake: Limit
	large_config_get to single frame
Date: Thu,  8 Aug 2019 20:15:48 +0200
Message-ID: <20190808181549.12521-2-cezary.rojewski@intel.com>
References: <20190808181549.12521-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74102F800E4
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 20:16:18 +0200 (CEST)
In-Reply-To: <20190808181549.12521-1-cezary.rojewski@intel.com>
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

Reply for the very first LARGE_CONFIG_GET request contains total size of
payload to be retrieved by host.
>From then on, each subsequent reply carries buffer offset instead. As
looping is not covered by any real-life example, remove it and cleanup
the function for followup overhaul.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 37 +++++----------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index a2b69a02aab2..196c80dadb1f 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -973,8 +973,7 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 {
 	struct skl_ipc_header header = {0};
 	struct sst_ipc_message request = {0}, reply = {0};
-	int ret = 0;
-	size_t sz_remaining, rx_size, data_offset;
+	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
 	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
@@ -987,34 +986,12 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
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
-
-		/* clear the fields */
-		header.extension &= IPC_INITIAL_BLOCK_CLEAR;
-		header.extension &= IPC_DATA_OFFSET_SZ_CLEAR;
-		/* fill the fields */
-		header.extension |= IPC_INITIAL_BLOCK(1);
-		header.extension |= IPC_DATA_OFFSET_SZ(data_offset);
-	}
+	request.header = *(u64 *)(&header);
+	reply.data = param;
+	reply.size = msg->param_data_size;
+	ret = sst_ipc_tx_message_wait(ipc, request, &reply);
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: get large config fail, err: %d\n", ret);
 
 	return ret;
 }
-- 
2.17.1
