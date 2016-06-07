From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Copy the pipe parameter
	by pipe type" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:32 +0100
Message-ID: <E1bAH2a-0001dg-QH@debutante>
References: <1464958783-19344-10-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8FF02606D6
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:39 +0200 (CEST)
In-Reply-To: <1464958783-19344-10-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Copy the pipe parameter by pipe type

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

>From 8871dcb9f0840c642507754b309aa506dc245985 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 3 Jun 2016 18:29:42 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Copy the pipe parameter by pipe type

For pass through pipe, Host and Link DMA id's are valid,
instead of overwriting the params set the host and link
based on pipe type.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 39 ++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2f1991dc9f55..b284b3cf5f94 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1111,6 +1111,39 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 }
 
 /*
+ * Fill the dma id for host and link. In case of passthrough
+ * pipeline, this will both host and link in the same
+ * pipeline, so need to copy the link and host based on dev_type
+ */
+static void skl_tplg_fill_dma_id(struct skl_module_cfg *mcfg,
+				struct skl_pipe_params *params)
+{
+	struct skl_pipe *pipe = mcfg->pipe;
+
+	if (pipe->passthru) {
+		switch (mcfg->dev_type) {
+		case SKL_DEVICE_HDALINK:
+			pipe->p_params->link_dma_id = params->link_dma_id;
+			break;
+
+		case SKL_DEVICE_HDAHOST:
+			pipe->p_params->host_dma_id = params->host_dma_id;
+			break;
+
+		default:
+			break;
+		}
+		pipe->p_params->s_fmt = params->s_fmt;
+		pipe->p_params->ch = params->ch;
+		pipe->p_params->s_freq = params->s_freq;
+		pipe->p_params->stream = params->stream;
+
+	} else {
+		memcpy(pipe->p_params, params, sizeof(*params));
+	}
+}
+
+/*
  * The FE params are passed by hw_params of the DAI.
  * On hw_params, the params are stored in Gateway module of the FE and we
  * need to calculate the format in DSP module configuration, that
@@ -1120,10 +1153,9 @@ int skl_tplg_update_pipe_params(struct device *dev,
 			struct skl_module_cfg *mconfig,
 			struct skl_pipe_params *params)
 {
-	struct skl_pipe *pipe = mconfig->pipe;
 	struct skl_module_fmt *format = NULL;
 
-	memcpy(pipe->p_params, params, sizeof(*params));
+	skl_tplg_fill_dma_id(mconfig, params);
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		format = &mconfig->in_fmt[0];
@@ -1310,12 +1342,11 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 				struct skl_module_cfg *mconfig,
 				struct skl_pipe_params *params)
 {
-	struct skl_pipe *pipe = mconfig->pipe;
 	struct nhlt_specific_cfg *cfg;
 	struct skl *skl = get_skl_ctx(dai->dev);
 	int link_type = skl_tplg_be_link_type(mconfig->dev_type);
 
-	memcpy(pipe->p_params, params, sizeof(*params));
+	skl_tplg_fill_dma_id(mconfig, params);
 
 	if (link_type == NHLT_LINK_HDA)
 		return 0;
-- 
2.8.1
