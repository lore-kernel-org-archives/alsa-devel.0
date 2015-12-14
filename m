From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: sst: fix the IRQ locked issue
Date: Mon, 14 Dec 2015 20:06:13 +0800
Message-ID: <1450094773-15281-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 23D29260417
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 12:59:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, yang.jie@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

If driver received a message that it can't handle, it won't
clear the corresponding bit and unmask interrupt, this may
lock the IRQ and DSP can't send message anymore.

To fix the issue, we should Always update IMRX after IPC.

Here we always clear the DONE/BUSY bit and unmask the IRQ
source, even when IPC failures have occurred previously.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Modified-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index b27f25f..ac60f13 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -778,7 +778,6 @@ static irqreturn_t hsw_irq_thread(int irq, void *context)
 	struct sst_hsw *hsw = sst_dsp_get_thread_context(sst);
 	struct sst_generic_ipc *ipc = &hsw->ipc;
 	u32 ipcx, ipcd;
-	int handled;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sst->spinlock, flags);
@@ -790,34 +789,30 @@ static irqreturn_t hsw_irq_thread(int irq, void *context)
 	if (ipcx & SST_IPCX_DONE) {
 
 		/* Handle Immediate reply from DSP Core */
-		handled = hsw_process_reply(hsw, ipcx);
+		hsw_process_reply(hsw, ipcx);
 
-		if (handled > 0) {
-			/* clear DONE bit - tell DSP we have completed */
-			sst_dsp_shim_update_bits_unlocked(sst, SST_IPCX,
-				SST_IPCX_DONE, 0);
+		/* clear DONE bit - tell DSP we have completed */
+		sst_dsp_shim_update_bits_unlocked(sst, SST_IPCX,
+			SST_IPCX_DONE, 0);
 
-			/* unmask Done interrupt */
-			sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
-				SST_IMRX_DONE, 0);
-		}
+		/* unmask Done interrupt */
+		sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
+			SST_IMRX_DONE, 0);
 	}
 
 	/* new message from DSP */
 	if (ipcd & SST_IPCD_BUSY) {
 
 		/* Handle Notification and Delayed reply from DSP Core */
-		handled = hsw_process_notification(hsw);
+		hsw_process_notification(hsw);
 
 		/* clear BUSY bit and set DONE bit - accept new messages */
-		if (handled > 0) {
-			sst_dsp_shim_update_bits_unlocked(sst, SST_IPCD,
-				SST_IPCD_BUSY | SST_IPCD_DONE, SST_IPCD_DONE);
+		sst_dsp_shim_update_bits_unlocked(sst, SST_IPCD,
+			SST_IPCD_BUSY | SST_IPCD_DONE, SST_IPCD_DONE);
 
-			/* unmask busy interrupt */
-			sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
-				SST_IMRX_BUSY, 0);
-		}
+		/* unmask busy interrupt */
+		sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
+			SST_IMRX_BUSY, 0);
 	}
 
 	spin_unlock_irqrestore(&sst->spinlock, flags);
-- 
2.5.0
