From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Skylake: Poll CLDMA RUN bit
	when set
Date: Mon, 23 Nov 2015 22:26:27 +0530
Message-ID: <1448297789-6524-6-git-send-email-vinod.koul@intel.com>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D32FC265826
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:53:00 +0100 (CET)
In-Reply-To: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
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

This patch adds polling of CLDMA stream run bit when set
to confirm the HW reports the same value.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 43 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index b03d9db0acad..faaa852ed015 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/mm.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 
@@ -33,6 +34,32 @@ void skl_cldma_int_disable(struct sst_dsp *ctx)
 			SKL_ADSP_REG_ADSPIC, SKL_ADSPIC_CL_DMA, 0);
 }
 
+static void skl_cldma_stream_run(struct sst_dsp  *ctx, bool enable)
+{
+	unsigned char val;
+	int timeout;
+
+	sst_dsp_shim_update_bits_unlocked(ctx,
+			SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_RUN_MASK, CL_SD_CTL_RUN(enable));
+
+	udelay(3);
+	timeout = 300;
+	do {
+		/* waiting for hardware to report that the stream Run bit set */
+		val = sst_dsp_shim_read(ctx, SKL_ADSP_REG_CL_SD_CTL) &
+			CL_SD_CTL_RUN_MASK;
+		if (enable && val)
+			break;
+		else if (!enable && !val)
+			break;
+		udelay(3);
+	} while (--timeout);
+
+	if (timeout == 0)
+		dev_err(ctx->dev, "Failed to set Run bit=%d enable=%d\n", val, enable);
+}
+
 /* Code loader helper APIs */
 static void skl_cldma_setup_bdle(struct sst_dsp *ctx,
 		struct snd_dma_buffer *dmab_data,
@@ -107,18 +134,6 @@ static void skl_cldma_cleanup_spb(struct sst_dsp  *ctx)
 	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_CL_SPBFIFO_SPIB, 0);
 }
 
-static void skl_cldma_trigger(struct sst_dsp  *ctx, bool enable)
-{
-	if (enable)
-		sst_dsp_shim_update_bits_unlocked(ctx,
-			SKL_ADSP_REG_CL_SD_CTL,
-			CL_SD_CTL_RUN_MASK, CL_SD_CTL_RUN(1));
-	else
-		sst_dsp_shim_update_bits_unlocked(ctx,
-			SKL_ADSP_REG_CL_SD_CTL,
-			CL_SD_CTL_RUN_MASK, CL_SD_CTL_RUN(0));
-}
-
 static void skl_cldma_cleanup(struct sst_dsp  *ctx)
 {
 	skl_cldma_cleanup_spb(ctx);
@@ -169,7 +184,7 @@ cleanup:
 
 static void skl_cldma_stop(struct sst_dsp *ctx)
 {
-	ctx->cl_dev.ops.cl_trigger(ctx, false);
+	skl_cldma_stream_run(ctx, false);
 }
 
 static void skl_cldma_fill_buffer(struct sst_dsp *ctx, unsigned int size,
@@ -311,7 +326,7 @@ int skl_cldma_prepare(struct sst_dsp *ctx)
 	ctx->cl_dev.ops.cl_setup_controller = skl_cldma_setup_controller;
 	ctx->cl_dev.ops.cl_setup_spb = skl_cldma_setup_spb;
 	ctx->cl_dev.ops.cl_cleanup_spb = skl_cldma_cleanup_spb;
-	ctx->cl_dev.ops.cl_trigger = skl_cldma_trigger;
+	ctx->cl_dev.ops.cl_trigger = skl_cldma_stream_run;
 	ctx->cl_dev.ops.cl_cleanup_controller = skl_cldma_cleanup;
 	ctx->cl_dev.ops.cl_copy_to_dmabuf = skl_cldma_copy_to_buf;
 	ctx->cl_dev.ops.cl_stop_dma = skl_cldma_stop;
-- 
1.9.1
