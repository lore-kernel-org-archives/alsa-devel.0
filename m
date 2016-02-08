From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add MCLK configuration"
	to the asoc tree
Date: Mon, 08 Feb 2016 18:01:34 +0000
Message-ID: <E1aSq7y-0002ky-3N@debutante>
References: <1454654950-23091-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68F382612BD
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 19:01:42 +0100 (CET)
In-Reply-To: <1454654950-23091-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add MCLK configuration

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

>From c115fa5ec06a647c5aeff95d73e56d488145ec2e Mon Sep 17 00:00:00 2001
From: "Dharageswari.R" <dharageswari.r@intel.com>
Date: Fri, 5 Feb 2016 12:19:07 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add MCLK configuration

The SoC has MCLK output which is typically required by codecs.
The MCLK is controlled by DSP FW, so driver can configure that by
sending DMA_CONTROL IPC. The configuration for MCLK is present
in the endpoint blob.

So if block has this configuration, send IPC to DSP for MCLK
configuration. This is done by new function skl_dsp_set_dma_control()
which is invoked by BE prepare.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 40 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c      | 18 +++++++++++++++
 sound/soc/intel/skylake/skl-topology.h | 25 +++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 60f9fe389887..737934cc620d 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -317,6 +317,46 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 	skl_copy_copier_caps(mconfig, cpr_mconfig);
 }
 
+#define DMA_CONTROL_ID 5
+
+int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+{
+	struct skl_dma_control *dma_ctrl;
+	struct skl_i2s_config_blob config_blob;
+	struct skl_ipc_large_config_msg msg = {0};
+	int err = 0;
+
+
+	/*
+	 * if blob size is same as capablity size, then no dma control
+	 * present so return
+	 */
+	if (mconfig->formats_config.caps_size == sizeof(config_blob))
+		return 0;
+
+	msg.large_param_id = DMA_CONTROL_ID;
+	msg.param_data_size = sizeof(struct skl_dma_control) +
+				mconfig->formats_config.caps_size;
+
+	dma_ctrl = kzalloc(msg.param_data_size, GFP_KERNEL);
+	if (dma_ctrl == NULL)
+		return -ENOMEM;
+
+	dma_ctrl->node_id = skl_get_node_id(ctx, mconfig);
+
+	/* size in dwords */
+	dma_ctrl->config_length = sizeof(config_blob) / 4;
+
+	memcpy(dma_ctrl->config_data, mconfig->formats_config.caps,
+				mconfig->formats_config.caps_size);
+
+	err = skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)dma_ctrl);
+
+	kfree(dma_ctrl);
+
+	return err;
+}
+
 static void skl_setup_out_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_audio_data_format *out_fmt)
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index cc9a5599ab9d..092450ac1c78 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -206,6 +206,23 @@ static int skl_get_format(struct snd_pcm_substream *substream,
 	return format_val;
 }
 
+static int skl_be_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_module_cfg *mconfig;
+
+	if ((dai->playback_active > 1) || (dai->capture_active > 1))
+		return 0;
+
+	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
+	if (mconfig == NULL)
+		return -EINVAL;
+
+	return skl_dsp_set_dma_control(ctx, mconfig);
+}
+
 static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -588,6 +605,7 @@ static struct snd_soc_dai_ops skl_dmic_dai_ops = {
 
 static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
 	.hw_params = skl_be_hw_params,
+	.prepare = skl_be_prepare,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 5f0707cf1f54..de3c401284d9 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -113,6 +113,29 @@ struct skl_cpr_gtw_cfg {
 	u32 config_data[1];
 } __packed;
 
+struct skl_i2s_config_blob {
+	u32 gateway_attrib;
+	u32 tdm_ts_group[8];
+	u32 ssc0;
+	u32 ssc1;
+	u32 sscto;
+	u32 sspsp;
+	u32 sstsa;
+	u32 ssrsa;
+	u32 ssc2;
+	u32 sspsp2;
+	u32 ssc3;
+	u32 ssioc;
+	u32 mdivc;
+	u32 mdivr;
+} __packed;
+
+struct skl_dma_control {
+	u32 node_id;
+	u32 config_length;
+	u32 config_data[1];
+} __packed;
+
 struct skl_cpr_cfg {
 	struct skl_base_cfg base_cfg;
 	struct skl_audio_data_format out_fmt;
@@ -313,6 +336,8 @@ static inline struct skl *get_skl_ctx(struct device *dev)
 
 int skl_tplg_be_update_params(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params);
+int skl_dsp_set_dma_control(struct skl_sst *ctx,
+		struct skl_module_cfg *mconfig);
 void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params, int stream);
 int skl_tplg_init(struct snd_soc_platform *platform,
-- 
2.7.0.rc3
