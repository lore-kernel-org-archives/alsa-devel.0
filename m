From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reset the DSP when set
	D3 fails" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:11 +0000
Message-ID: <E1Zz7l9-0001N2-C9@debutante>
References: <1447267609-27816-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7576265A2E
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:16 +0100 (CET)
In-Reply-To: <1447267609-27816-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Reset the DSP when set D3 fails

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

>From 53afce2c5764ebf5e933efe9a2dd58cbc316c854 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 13 Nov 2015 19:22:09 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reset the DSP when set D3 fails

Sometimes firmware D3 IPC fails causing firmware to be in invalid
state. To recover we need to reset the DSP and then shut it down,
so don't return on error and continue resetting to recover.

On D0, firmware will be redownloaded and DSP will be back in
clean state

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 51f07f0e4735..e1d34d5c3f9a 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 #include "../common/sst-ipc.h"
@@ -176,10 +177,15 @@ static int skl_set_dsp_D3(struct sst_dsp *ctx)
 	dx.core_mask = SKL_DSP_CORE0_MASK;
 	dx.dx_mask = SKL_IPC_D3_MASK;
 	ret = skl_ipc_set_dx(&skl->ipc, SKL_INSTANCE_ID, SKL_BASE_FW_MODULE_ID, &dx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to set DSP to D3 state\n");
-		return ret;
-	}
+	if (ret < 0)
+		dev_err(ctx->dev,
+			"D3 request to FW failed, continuing reset: %d", ret);
+
+	/* disable Interrupt */
+	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
+	skl_cldma_int_disable(ctx);
+	skl_ipc_op_int_disable(ctx);
+	skl_ipc_int_disable(ctx);
 
 	ret = skl_dsp_disable_core(ctx);
 	if (ret < 0) {
@@ -188,12 +194,6 @@ static int skl_set_dsp_D3(struct sst_dsp *ctx)
 	}
 	skl_dsp_set_state_locked(ctx, SKL_DSP_RESET);
 
-	/* disable Interrupt */
-	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
-	skl_cldma_int_disable(ctx);
-	skl_ipc_op_int_disable(ctx);
-	skl_ipc_int_disable(ctx);
-
 	return ret;
 }
 
-- 
2.6.2
