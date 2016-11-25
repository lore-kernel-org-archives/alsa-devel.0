From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Don't use dma I2S
	config structure in kernel" to the asoc tree
Date: Fri, 25 Nov 2016 13:09:55 +0000
Message-ID: <E1cAGGJ-00053z-Qt@debutante>
References: <1479921387-31248-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E313C2671FF
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 14:10:04 +0100 (CET)
In-Reply-To: <1479921387-31248-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Don't use dma I2S config structure in kernel

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

>From c186fe7401e4234aee6796eda3ad38bd57507899 Mon Sep 17 00:00:00 2001
From: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Date: Wed, 23 Nov 2016 22:46:26 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Don't use dma I2S config structure in
 kernel

I2S blob config structure can change between DSP copier module versions.
We are not modifying these structures anyway and NHLT blobs specify them
properly, so use the blob directly to send the dma_control ipc instead
of using the predefined I2S blob config structure.

Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 4ae021aabc3a..e79cbcf6e462 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -527,16 +527,14 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 {
 	struct skl_dma_control *dma_ctrl;
-	struct skl_i2s_config_blob config_blob;
 	struct skl_ipc_large_config_msg msg = {0};
 	int err = 0;
 
 
 	/*
-	 * if blob size is same as capablity size, then no dma control
-	 * present so return
+	 * if blob size zero, then return
 	 */
-	if (mconfig->formats_config.caps_size == sizeof(config_blob))
+	if (mconfig->formats_config.caps_size == 0)
 		return 0;
 
 	msg.large_param_id = DMA_CONTROL_ID;
@@ -550,7 +548,7 @@ int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 	dma_ctrl->node_id = skl_get_node_id(ctx, mconfig);
 
 	/* size in dwords */
-	dma_ctrl->config_length = sizeof(config_blob) / 4;
+	dma_ctrl->config_length = mconfig->formats_config.caps_size / 4;
 
 	memcpy(dma_ctrl->config_data, mconfig->formats_config.caps,
 				mconfig->formats_config.caps_size);
@@ -558,7 +556,6 @@ int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 	err = skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)dma_ctrl);
 
 	kfree(dma_ctrl);
-
 	return err;
 }
 
-- 
2.10.2
