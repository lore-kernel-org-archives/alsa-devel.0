From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/10] ASoC: Intel: Add check_dsp_lp_on
	callback on IPC
Date: Mon, 26 Sep 2016 11:05:28 +0530
Message-ID: <1474868137-29712-2-git-send-email-vinod.koul@intel.com>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF92266726
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

Some controllers support power modes which can't communicate using IPC.

So add a callback to check and wake DSP before sending IPC and then put
to sleep if it is in these power modes.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-ipc.c | 19 ++++++++++++++++++-
 sound/soc/intel/common/sst-ipc.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index a12c7bb08d3b..6ac9a8484635 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -190,8 +190,25 @@ static void ipc_tx_msgs(struct kthread_work *work)
 int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
 	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
 {
-	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
+	int ret;
+
+	/*
+	 * DSP maybe in lower power active state, so
+	 * check if the DSP supports DSP lp On method
+	 * if so invoke that before sending IPC
+	 */
+	if (ipc->ops.check_dsp_lp_on)
+		if (ipc->ops.check_dsp_lp_on(ipc->dsp, true))
+			return -EIO;
+
+	ret = ipc_tx_message(ipc, header, tx_data, tx_bytes,
 		rx_data, rx_bytes, 1);
+
+	if (ipc->ops.check_dsp_lp_on)
+		if (ipc->ops.check_dsp_lp_on(ipc->dsp, false))
+			return -EIO;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sst_ipc_tx_message_wait);
 
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index ceb7e468a3fa..46871a5dff1d 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -52,6 +52,7 @@ struct sst_plat_ipc_ops {
 	void (*tx_data_copy)(struct ipc_message *, char *, size_t);
 	u64  (*reply_msg_match)(u64 header, u64 *mask);
 	bool (*is_dsp_busy)(struct sst_dsp *dsp);
+	int (*check_dsp_lp_on)(struct sst_dsp *dsp, bool state);
 };
 
 /* SST generic IPC data */
-- 
1.9.1
