From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Skylake: Process code loader
	DMA interrupt
Date: Fri, 10 Jul 2015 22:18:43 +0530
Message-ID: <1436546926-17263-6-git-send-email-vinod.koul@intel.com>
References: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AE9F726664F
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 18:47:11 +0200 (CEST)
In-Reply-To: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

The code loader DMA interrupt is received by main interrupt handler which
dispatches it to cldma routines

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 5 +++++
 sound/soc/intel/skylake/skl-sst-ipc.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 313ca7c6ca7f..94875b008b0b 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -267,6 +267,11 @@ irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id)
 		result = IRQ_WAKE_THREAD;
 	}
 
+	if (val & SKL_ADSPIS_CL_DMA) {
+		skl_cldma_int_disable(ctx);
+		result = IRQ_WAKE_THREAD;
+	}
+
 	spin_unlock(&ctx->spinlock);
 
 	return result;
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 94be6cbf2698..bd5ac4165151 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -375,6 +375,9 @@ irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
 	u32 hipcie, hipct, hipcte;
 	int ipc_irq = 0;
 
+	if (dsp->intr_status & SKL_ADSPIS_CL_DMA)
+		skl_cldma_process_intr(dsp);
+
 	/* Here we handle IPC interrupts only */
 	if (!(dsp->intr_status & SKL_ADSPIS_IPC))
 		return IRQ_NONE;
-- 
1.9.1
