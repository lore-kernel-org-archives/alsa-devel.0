From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 8/8] ASoC: Intel: Allocate for the mailbox
	with max size
Date: Tue, 19 May 2015 15:00:40 +0530
Message-ID: <1432027840-18711-9-git-send-email-vinod.koul@intel.com>
References: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D9E3265171
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:30:03 +0200 (CEST)
In-Reply-To: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-ipc.c | 29 ++++++++++++++++++++++++++++-
 sound/soc/intel/common/sst-ipc.h |  4 ++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index a7699f35a8d2..a12c7bb08d3b 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -129,11 +129,31 @@ static int msg_empty_list_init(struct sst_generic_ipc *ipc)
 		return -ENOMEM;
 
 	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
+		ipc->msg[i].tx_data = kzalloc(ipc->tx_data_max_size, GFP_KERNEL);
+		if (ipc->msg[i].tx_data == NULL)
+			goto free_mem;
+
+		ipc->msg[i].rx_data = kzalloc(ipc->rx_data_max_size, GFP_KERNEL);
+		if (ipc->msg[i].rx_data == NULL) {
+			kfree(ipc->msg[i].tx_data);
+			goto free_mem;
+		}
+
 		init_waitqueue_head(&ipc->msg[i].waitq);
 		list_add(&ipc->msg[i].list, &ipc->empty_list);
 	}
 
 	return 0;
+
+free_mem:
+	while (i > 0) {
+		kfree(ipc->msg[i-1].tx_data);
+		kfree(ipc->msg[i-1].rx_data);
+		--i;
+	}
+	kfree(ipc->msg);
+
+	return -ENOMEM;
 }
 
 static void ipc_tx_msgs(struct kthread_work *work)
@@ -279,11 +299,18 @@ EXPORT_SYMBOL_GPL(sst_ipc_init);
 
 void sst_ipc_fini(struct sst_generic_ipc *ipc)
 {
+	int i;
+
 	if (ipc->tx_thread)
 		kthread_stop(ipc->tx_thread);
 
-	if (ipc->msg)
+	if (ipc->msg) {
+		for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
+			kfree(ipc->msg[i].tx_data);
+			kfree(ipc->msg[i].rx_data);
+		}
 		kfree(ipc->msg);
+	}
 }
 EXPORT_SYMBOL_GPL(sst_ipc_fini);
 
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index 7139afd2547f..ceb7e468a3fa 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -32,9 +32,9 @@ struct ipc_message {
 	u64 header;
 
 	/* direction wrt host CPU */
-	char tx_data[IPC_MAX_MAILBOX_BYTES];
+	char *tx_data;
 	size_t tx_size;
-	char rx_data[IPC_MAX_MAILBOX_BYTES];
+	char *rx_data;
 	size_t rx_size;
 
 	wait_queue_head_t waitq;
-- 
1.9.1
