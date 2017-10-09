From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Modify
	skl_dsp_set_dma_control API arguments" to the asoc tree
Date: Mon, 09 Oct 2017 11:44:26 +0100
Message-ID: <E1e1VXu-0001gE-KI@debutante>
References: <1504794565-19168-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1AEC266B38
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 12:44:41 +0200 (CEST)
In-Reply-To: <1504794565-19168-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API arguments

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

>From 5514830dffb2332c034c20db3b264ba1f94de1d8 Mon Sep 17 00:00:00 2001
From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Date: Mon, 18 Sep 2017 10:26:44 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API
 arguments

Set dma control ipc can be used to set the M/N divider, enable the clks. It
takes different payload for different configuration. So modify the
skl_dsp_set_dma_control API to take the size and node_id as argument.

Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 23 ++++++++++++++---------
 sound/soc/intel/skylake/skl-topology.h |  4 ++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 89f70133c8e4..f637829833e6 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -613,8 +613,10 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 }
 
 #define DMA_CONTROL_ID 5
+#define DMA_I2S_BLOB_SIZE 21
 
-int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
+				u32 caps_size, u32 node_id)
 {
 	struct skl_dma_control *dma_ctrl;
 	struct skl_ipc_large_config_msg msg = {0};
@@ -624,24 +626,27 @@ int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 	/*
 	 * if blob size zero, then return
 	 */
-	if (mconfig->formats_config.caps_size == 0)
+	if (caps_size == 0)
 		return 0;
 
 	msg.large_param_id = DMA_CONTROL_ID;
-	msg.param_data_size = sizeof(struct skl_dma_control) +
-				mconfig->formats_config.caps_size;
+	msg.param_data_size = sizeof(struct skl_dma_control) + caps_size;
 
 	dma_ctrl = kzalloc(msg.param_data_size, GFP_KERNEL);
 	if (dma_ctrl == NULL)
 		return -ENOMEM;
 
-	dma_ctrl->node_id = skl_get_node_id(ctx, mconfig);
+	dma_ctrl->node_id = node_id;
 
-	/* size in dwords */
-	dma_ctrl->config_length = mconfig->formats_config.caps_size / 4;
+	/*
+	 * NHLT blob may contain additional configs along with i2s blob.
+	 * firmware expects only the i2s blob size as the config_length.
+	 * So fix to i2s blob size.
+	 * size in dwords.
+	 */
+	dma_ctrl->config_length = DMA_I2S_BLOB_SIZE;
 
-	memcpy(dma_ctrl->config_data, mconfig->formats_config.caps,
-				mconfig->formats_config.caps_size);
+	memcpy(dma_ctrl->config_data, caps, caps_size);
 
 	err = skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)dma_ctrl);
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 2717db92036b..e11cc1fc0e43 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -455,8 +455,8 @@ static inline struct skl *get_skl_ctx(struct device *dev)
 
 int skl_tplg_be_update_params(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params);
-int skl_dsp_set_dma_control(struct skl_sst *ctx,
-		struct skl_module_cfg *mconfig);
+int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
+			u32 caps_size, u32 node_id);
 void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params, int stream);
 int skl_tplg_init(struct snd_soc_platform *platform,
-- 
2.14.1
