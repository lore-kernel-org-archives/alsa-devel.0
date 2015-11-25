From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Poll CLDMA RUN bit when
	set" to the asoc tree
Date: Wed, 25 Nov 2015 17:57:40 +0000
Message-ID: <E1a1eK4-0006Xu-GT@debutante>
References: <1448297789-6524-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21285265053
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 18:57:48 +0100 (CET)
In-Reply-To: <1448297789-6524-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Poll CLDMA RUN bit when set

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

>From 2434caf098588856d1c332d2f60b8a2d8a198450 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 23 Nov 2015 22:26:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Poll CLDMA RUN bit when set

This patch adds polling of CLDMA stream run bit when set
to confirm the HW reports the same value.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 43 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index 947a08e42e86..8c7e8576cba3 100644
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
@@ -167,7 +182,7 @@ cleanup:
 
 static void skl_cldma_stop(struct sst_dsp *ctx)
 {
-	ctx->cl_dev.ops.cl_trigger(ctx, false);
+	skl_cldma_stream_run(ctx, false);
 }
 
 static void skl_cldma_fill_buffer(struct sst_dsp *ctx, unsigned int size,
@@ -309,7 +324,7 @@ int skl_cldma_prepare(struct sst_dsp *ctx)
 	ctx->cl_dev.ops.cl_setup_controller = skl_cldma_setup_controller;
 	ctx->cl_dev.ops.cl_setup_spb = skl_cldma_setup_spb;
 	ctx->cl_dev.ops.cl_cleanup_spb = skl_cldma_cleanup_spb;
-	ctx->cl_dev.ops.cl_trigger = skl_cldma_trigger;
+	ctx->cl_dev.ops.cl_trigger = skl_cldma_stream_run;
 	ctx->cl_dev.ops.cl_cleanup_controller = skl_cldma_cleanup;
 	ctx->cl_dev.ops.cl_copy_to_dmabuf = skl_cldma_copy_to_buf;
 	ctx->cl_dev.ops.cl_stop_dma = skl_cldma_stop;
-- 
2.6.2
