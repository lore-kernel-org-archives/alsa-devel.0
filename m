From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Replace kthread with work" to
	the asoc tree
Date: Wed, 30 Nov 2016 18:07:34 +0000
Message-ID: <E1cC9I6-0008Eh-EK@debutante>
References: <20161128153219.31289-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DB5266B93
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 19:07:45 +0100 (CET)
In-Reply-To: <20161128153219.31289-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Replace kthread with work

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

>From 786e1c37194e8e822eb72a0aed5fa850e07071a0 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 28 Nov 2016 16:32:19 +0100
Subject: [PATCH] ASoC: intel: Replace kthread with work

The usage pattern of kthread worker in Intel SST drivers can be
replaced gracefully with the normal workqueue, which is more light-
weight and easier to manage in general.  Let's do it.

While in the replacement, move the schedule_work() call inside the
spinlock for excluding the race, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c |  3 +-
 sound/soc/intel/common/sst-ipc.c            | 58 ++++++++++-------------------
 sound/soc/intel/common/sst-ipc.h            |  4 +-
 sound/soc/intel/haswell/sst-haswell-ipc.c   |  3 +-
 sound/soc/intel/skylake/skl-sst-cldma.c     |  1 -
 sound/soc/intel/skylake/skl-sst-ipc.c       |  2 +-
 sound/soc/intel/skylake/skl-sst-ipc.h       |  1 -
 7 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 7ab14ce65a73..260447da32b8 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/kthread.h>
 #include <linux/firmware.h>
 #include <linux/io.h>
 #include <asm/div64.h>
@@ -338,7 +337,7 @@ static irqreturn_t sst_byt_irq_thread(int irq, void *context)
 	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	/* continue to send any remaining messages... */
-	kthread_queue_work(&ipc->kworker, &ipc->kwork);
+	schedule_work(&ipc->kwork);
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index 2c1b3159ac1a..62f3a8e0ec87 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -26,7 +26,6 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/kthread.h>
 #include <sound/asound.h>
 
 #include "sst-dsp.h"
@@ -109,10 +108,9 @@ static int ipc_tx_message(struct sst_generic_ipc *ipc, u64 header,
 		ipc->ops.tx_data_copy(msg, tx_data, tx_bytes);
 
 	list_add_tail(&msg->list, &ipc->tx_list);
+	schedule_work(&ipc->kwork);
 	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
 
-	kthread_queue_work(&ipc->kworker, &ipc->kwork);
-
 	if (wait)
 		return tx_wait_done(ipc, msg, rx_data);
 	else
@@ -156,35 +154,32 @@ static int msg_empty_list_init(struct sst_generic_ipc *ipc)
 	return -ENOMEM;
 }
 
-static void ipc_tx_msgs(struct kthread_work *work)
+static void ipc_tx_msgs(struct work_struct *work)
 {
 	struct sst_generic_ipc *ipc =
 		container_of(work, struct sst_generic_ipc, kwork);
 	struct ipc_message *msg;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
+	spin_lock_irq(&ipc->dsp->spinlock);
 
-	if (list_empty(&ipc->tx_list) || ipc->pending) {
-		spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
-		return;
-	}
-
-	/* if the DSP is busy, we will TX messages after IRQ.
-	 * also postpone if we are in the middle of procesing completion irq*/
-	if (ipc->ops.is_dsp_busy && ipc->ops.is_dsp_busy(ipc->dsp)) {
-		dev_dbg(ipc->dev, "ipc_tx_msgs dsp busy\n");
-		spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
-		return;
-	}
+	while (!list_empty(&ipc->tx_list) && !ipc->pending) {
+		/* if the DSP is busy, we will TX messages after IRQ.
+		 * also postpone if we are in the middle of processing
+		 * completion irq
+		 */
+		if (ipc->ops.is_dsp_busy && ipc->ops.is_dsp_busy(ipc->dsp)) {
+			dev_dbg(ipc->dev, "ipc_tx_msgs dsp busy\n");
+			break;
+		}
 
-	msg = list_first_entry(&ipc->tx_list, struct ipc_message, list);
-	list_move(&msg->list, &ipc->rx_list);
+		msg = list_first_entry(&ipc->tx_list, struct ipc_message, list);
+		list_move(&msg->list, &ipc->rx_list);
 
-	if (ipc->ops.tx_msg != NULL)
-		ipc->ops.tx_msg(ipc, msg);
+		if (ipc->ops.tx_msg != NULL)
+			ipc->ops.tx_msg(ipc, msg);
+	}
 
-	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+	spin_unlock_irq(&ipc->dsp->spinlock);
 }
 
 int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
@@ -305,19 +300,7 @@ int sst_ipc_init(struct sst_generic_ipc *ipc)
 	if (ret < 0)
 		return -ENOMEM;
 
-	/* start the IPC message thread */
-	kthread_init_worker(&ipc->kworker);
-	ipc->tx_thread = kthread_run(kthread_worker_fn,
-					&ipc->kworker, "%s",
-					dev_name(ipc->dev));
-	if (IS_ERR(ipc->tx_thread)) {
-		dev_err(ipc->dev, "error: failed to create message TX task\n");
-		ret = PTR_ERR(ipc->tx_thread);
-		kfree(ipc->msg);
-		return ret;
-	}
-
-	kthread_init_work(&ipc->kwork, ipc_tx_msgs);
+	INIT_WORK(&ipc->kwork, ipc_tx_msgs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sst_ipc_init);
@@ -326,8 +309,7 @@ void sst_ipc_fini(struct sst_generic_ipc *ipc)
 {
 	int i;
 
-	if (ipc->tx_thread)
-		kthread_stop(ipc->tx_thread);
+	cancel_work_sync(&ipc->kwork);
 
 	if (ipc->msg) {
 		for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index f4aab1b3789a..7ed42a640ad6 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -23,7 +23,6 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/sched.h>
-#include <linux/kthread.h>
 
 #define IPC_MAX_MAILBOX_BYTES	256
 
@@ -66,8 +65,7 @@ struct sst_generic_ipc {
 	struct list_head empty_list;
 	wait_queue_head_t wait_txq;
 	struct task_struct *tx_thread;
-	struct kthread_worker kworker;
-	struct kthread_work kwork;
+	struct work_struct kwork;
 	bool pending;
 	struct ipc_message *msg;
 	int tx_data_max_size;
diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index e432a31fd9f2..a3459d1682a6 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -26,7 +26,6 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/platform_device.h>
-#include <linux/kthread.h>
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
@@ -818,7 +817,7 @@ static irqreturn_t hsw_irq_thread(int irq, void *context)
 	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	/* continue to send any remaining messages... */
-	kthread_queue_work(&ipc->kworker, &ipc->kwork);
+	schedule_work(&ipc->kwork);
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index efa2532114ba..c9f6d87381db 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -17,7 +17,6 @@
 
 #include <linux/device.h>
 #include <linux/mm.h>
-#include <linux/kthread.h>
 #include <linux/delay.h>
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 594623a4b4cd..e1391dfbc9e9 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -498,7 +498,7 @@ irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
 	skl_ipc_int_enable(dsp);
 
 	/* continue to send any remaining messages... */
-	kthread_queue_work(&ipc->kworker, &ipc->kwork);
+	schedule_work(&ipc->kwork);
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 0568f2e8fc57..cc40341233fa 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -16,7 +16,6 @@
 #ifndef __SKL_IPC_H
 #define __SKL_IPC_H
 
-#include <linux/kthread.h>
 #include <linux/irqreturn.h>
 #include "../common/sst-ipc.h"
 
-- 
2.10.2
