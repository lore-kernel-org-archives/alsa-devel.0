From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 4/8] ASoC: Intel: Remove the direct register
	reference from common ipc
Date: Tue, 19 May 2015 15:00:36 +0530
Message-ID: <1432027840-18711-5-git-send-email-vinod.koul@intel.com>
References: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA4F265128
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:29:53 +0200 (CEST)
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
 sound/soc/intel/common/sst-ipc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index 4b62a553823c..a7699f35a8d2 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -142,7 +142,6 @@ static void ipc_tx_msgs(struct kthread_work *work)
 		container_of(work, struct sst_generic_ipc, kwork);
 	struct ipc_message *msg;
 	unsigned long flags;
-	u64 ipcx;
 
 	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
 
@@ -153,8 +152,8 @@ static void ipc_tx_msgs(struct kthread_work *work)
 
 	/* if the DSP is busy, we will TX messages after IRQ.
 	 * also postpone if we are in the middle of procesing completion irq*/
-	ipcx = sst_dsp_shim_read_unlocked(ipc->dsp, SST_IPCX);
-	if (ipcx & (SST_IPCX_BUSY | SST_IPCX_DONE)) {
+	if (ipc->ops.is_dsp_busy && ipc->ops.is_dsp_busy(ipc->dsp)) {
+		dev_dbg(ipc->dev, "ipc_tx_msgs dsp busy\n");
 		spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
 		return;
 	}
-- 
1.9.1
