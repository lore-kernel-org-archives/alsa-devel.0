From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Freeup properly on
	skl_dsp_free" to the asoc tree
Date: Wed, 16 Mar 2016 10:09:20 +0000
Message-ID: <E1ag8OG-00062J-Lk@debutante>
References: <1458035836-1843-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 986F7266009
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:09:28 +0100 (CET)
In-Reply-To: <1458035836-1843-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Freeup properly on skl_dsp_free

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

>From 3f7f8489e25b180cf8de8a3ae3896b3f18fc4aa5 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Mar 2016 16:39:25 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Freeup properly on skl_dsp_free

We are supposed to freeup the Code loader DMA allocation and
ensure all interrupts are disabled before we disable dsp cores.
So invoke these to ensure DSP shuts down properly.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index a5267e8a96e0..2962ef22fc84 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -336,6 +336,11 @@ void skl_dsp_free(struct sst_dsp *dsp)
 	skl_ipc_int_disable(dsp);
 
 	free_irq(dsp->irq, dsp);
+	dsp->cl_dev.ops.cl_cleanup_controller(dsp);
+	skl_cldma_int_disable(dsp);
+	skl_ipc_op_int_disable(dsp);
+	skl_ipc_int_disable(dsp);
+
 	skl_dsp_disable_core(dsp);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_free);
-- 
2.7.0
