From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/10] ASoC: Intel: Add sst_ipc_tx_message_nopm
Date: Mon, 26 Sep 2016 11:05:29 +0530
Message-ID: <1474868137-29712-3-git-send-email-vinod.koul@intel.com>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 080E826672C
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 07:27:19 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

Add a IPC API to send IPC without waking up DSP.

This is helpful when the DSP is already in woken up state(not in any low
power mode) and an IPC is to be sent.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-ipc.c | 8 ++++++++
 sound/soc/intel/common/sst-ipc.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index 6ac9a8484635..1c9919d8b70a 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -220,6 +220,14 @@ int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
 }
 EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nowait);
 
+int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
+{
+	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
+		rx_data, rx_bytes, 1);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nopm);
+
 struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
 	u64 header)
 {
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index 46871a5dff1d..f4aab1b3789a 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -82,6 +82,9 @@ int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
 int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
 	void *tx_data, size_t tx_bytes);
 
+int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes);
+
 struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
 	u64 header);
 
-- 
1.9.1
