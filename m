From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: fix the IRQ locked issue"
	to the asoc tree
Date: Tue, 15 Dec 2015 22:41:17 +0000
Message-ID: <E1a8yHV-0008Bq-Jt@debutante>
References: <1450094773-15281-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51C63261294
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 23:41:27 +0100 (CET)
In-Reply-To: <1450094773-15281-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: fix the IRQ locked issue

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From af1086ba051aa33c559350a5fdb533acfe98a80c Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 14 Dec 2015 20:06:13 +0800
Subject: [PATCH] ASoC: Intel: sst: fix the IRQ locked issue

If driver received a message that it can't handle, it won't
clear the corresponding bit and unmask interrupt, this may
lock the IRQ and DSP can't send message anymore.

To fix the issue, we should Always update IMRX after IPC.

Here we always clear the DONE/BUSY bit and unmask the IRQ
source, even when IPC failures have occurred previously.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Modified-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index b27f25f70730..ac60f1301e21 100644
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
2.6.2
