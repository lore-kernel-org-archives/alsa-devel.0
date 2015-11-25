From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reconfigure HDA stream
	register in prepare/resume" to the asoc tree
Date: Wed, 25 Nov 2015 17:57:43 +0000
Message-ID: <E1a1eK7-0006ZK-A0@debutante>
References: <1448297789-6524-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C581265065
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 18:57:49 +0100 (CET)
In-Reply-To: <1448297789-6524-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Reconfigure HDA stream register in prepare/resume

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

>From 7e3a17d311ca89a74cfd39e02e96d29d92849d34 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 23 Nov 2015 22:26:24 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reconfigure HDA stream register in
 prepare/resume

PCM prepare callbacks can be called multiple times. During S3
the stream registers will be reset when Controller is reset.
When stream is resumed, these stream registers needs to reconfigured.

This patch removes the check in prepare callback() if stream already
prepared, which will allow reconfiguring of stream registers and also
decouple stream when stream is resumed to route audio via DSP.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index dae332beea3f..3c891d78ba58 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -181,10 +181,6 @@ static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 	int err;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
-	if (hdac_stream(stream)->prepared) {
-		dev_dbg(dai->dev, "already stream is prepared - returning\n");
-		return 0;
-	}
 
 	format_val = skl_get_format(substream, dai);
 	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d\n",
@@ -342,6 +338,8 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct skl *skl = get_skl_ctx(dai->dev);
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_cfg *mconfig;
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	int ret;
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
@@ -349,15 +347,17 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EIO;
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		skl_pcm_prepare(substream, dai);
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
 		/*
 		 * Start HOST DMA and Start FE Pipe.This is to make sure that
 		 * there are no underrun/overrun in the case when the FE
 		 * pipeline is started but there is a delay in starting the
 		 * DMA channel on the host.
 		 */
+		snd_hdac_ext_stream_decouple(ebus, stream, true);
 		ret = skl_decoupled_trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
@@ -377,6 +377,8 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 
 		ret = skl_decoupled_trigger(substream, cmd);
+		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND)
+			snd_hdac_ext_stream_decouple(ebus, stream, false);
 		break;
 
 	default:
-- 
2.6.2
