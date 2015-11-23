From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Skylake: Clear stream
	registers before setting up stream
Date: Mon, 23 Nov 2015 22:26:28 +0530
Message-ID: <1448297789-6524-7-git-send-email-vinod.koul@intel.com>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6783C265473
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:53:03 +0100 (CET)
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

This patch adds clean up routine to clear the stream registers and
calls this routine before setting up stream registers.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index faaa852ed015..b845c3acd3eb 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -60,6 +60,28 @@ static void skl_cldma_stream_run(struct sst_dsp  *ctx, bool enable)
 		dev_err(ctx->dev, "Failed to set Run bit=%d enable=%d\n", val, enable);
 }
 
+static void skl_cldma_stream_clear(struct sst_dsp  *ctx)
+{
+	/* make sure Run bit is cleared before setting stream register */
+	skl_cldma_stream_run(ctx, 0);
+
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_IOCE_MASK, CL_SD_CTL_IOCE(0));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_FEIE_MASK, CL_SD_CTL_FEIE(0));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_DEIE_MASK, CL_SD_CTL_DEIE(0));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_STRM_MASK, CL_SD_CTL_STRM(0));
+
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPL, CL_SD_BDLPLBA(0));
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPU, 0);
+
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_CBL, 0);
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_LVI, 0);
+}
+
+
 /* Code loader helper APIs */
 static void skl_cldma_setup_bdle(struct sst_dsp *ctx,
 		struct snd_dma_buffer *dmab_data,
@@ -95,6 +117,7 @@ static void skl_cldma_setup_controller(struct sst_dsp  *ctx,
 		struct snd_dma_buffer *dmab_bdl, unsigned int max_size,
 		u32 count)
 {
+	skl_cldma_stream_clear(ctx);
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPL,
 			CL_SD_BDLPLBA(dmab_bdl->addr));
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPU,
@@ -137,21 +160,7 @@ static void skl_cldma_cleanup_spb(struct sst_dsp  *ctx)
 static void skl_cldma_cleanup(struct sst_dsp  *ctx)
 {
 	skl_cldma_cleanup_spb(ctx);
-
-	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
-				CL_SD_CTL_IOCE_MASK, CL_SD_CTL_IOCE(0));
-	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
-				CL_SD_CTL_FEIE_MASK, CL_SD_CTL_FEIE(0));
-	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
-				CL_SD_CTL_DEIE_MASK, CL_SD_CTL_DEIE(0));
-	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
-				CL_SD_CTL_STRM_MASK, CL_SD_CTL_STRM(0));
-
-	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPL, CL_SD_BDLPLBA(0));
-	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPU, 0);
-
-	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_CBL, 0);
-	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_LVI, 0);
+	skl_cldma_stream_clear(ctx);
 
 	if (&ctx->cl_dev.dmab_data)
 		ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
-- 
1.9.1
