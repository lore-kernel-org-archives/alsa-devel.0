From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix fw reload failure
Date: Thu, 14 Jul 2016 09:05:25 +0530
Message-ID: <1468467325-10118-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FA68260851
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 05:28:15 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

FW reload had two issues:
 - We need to disable the core 0 on when fw fails
 - Before loading firmware mark boot flag as false

This patch fixes these two

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 9c3750f49c21..16e2ed97d71a 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -139,7 +139,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 base_fw_load_failed:
 	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
 	skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
-	skl_dsp_disable_core(ctx, SKL_DSP_CORE_MASK(1));
+	skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 	return ret;
 }
 
@@ -232,6 +232,7 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
 
 	if (skl->fw_loaded == false) {
+		skl->boot_complete = false;
 		ret = bxt_load_base_firmware(ctx);
 		if (ret < 0)
 			dev_err(ctx->dev, "reload fw failed: %d\n", ret);
-- 
1.9.1
