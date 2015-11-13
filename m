From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/9] ASoC: Intel: Skylake: Reset the DSP
	when set D3 fails
Date: Fri, 13 Nov 2015 19:22:09 +0530
Message-ID: <1447422733-2484-6-git-send-email-vinod.koul@intel.com>
References: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C8E265AD3
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 14:48:56 +0100 (CET)
In-Reply-To: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Sometimes firmware D3 IPC fails causing firmware to be in invalid
state. To recover we need to reset the DSP and then shut it down,
so don't return on error and continue resetting to recover.

On D0, firmware will be redownloaded and DSP will be back in
clean state

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
