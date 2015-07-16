From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Process code loader DMA
	interrupt" to the asoc tree
Date: Thu, 16 Jul 2015 22:01:15 +0100
Message-ID: <E1ZFqHL-0001fM-Ex@finisterre>
References: <1436546926-17263-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5DDA2605D7
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:21 +0200 (CEST)
In-Reply-To: <1436546926-17263-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Process code loader DMA interrupt

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

>From 6cb0033380ec6297589e68bfcf19aeda7ba95e99 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 10 Jul 2015 22:18:43 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Process code loader DMA interrupt

The code loader DMA interrupt is received by main interrupt handler which
dispatches it to cldma routines

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 5 +++++
 sound/soc/intel/skylake/skl-sst-ipc.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 313ca7c..94875b0 100644
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
index 94be6cb..bd5ac41 100644
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
2.1.4
