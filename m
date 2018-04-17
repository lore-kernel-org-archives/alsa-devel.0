From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reset DSP Pipelines in
	prepare" to the asoc tree
Date: Tue, 17 Apr 2018 12:28:43 +0100
Message-ID: <E1f8Omx-0000KS-Rn@debutante>
References: <1522651550-27236-2-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BDD9267605
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:28:48 +0200 (CEST)
In-Reply-To: <1522651550-27236-2-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Divya Prakash <divya1.prakash@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Reset DSP Pipelines in prepare

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 74e651926ee038237c48493d0a0853868d622b01 Mon Sep 17 00:00:00 2001
From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Date: Mon, 2 Apr 2018 12:15:48 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reset DSP Pipelines in prepare

An application can choose to call .prepare function
any number of times. In such scenarios, there is a
need to reset the DSP pipeline.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index fe25515debec..afa86b9e4dcf 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -268,15 +268,31 @@ static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 {
 	struct skl *skl = get_skl_ctx(dai->dev);
 	struct skl_module_cfg *mconfig;
+	int ret;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
 
-	/* In case of XRUN recovery, reset the FW pipe to clean state */
-	if (mconfig && (substream->runtime->status->state ==
-					SNDRV_PCM_STATE_XRUN))
-		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
+	/*
+	 * In case of XRUN recovery or in the case when the application
+	 * calls prepare another time, reset the FW pipe to clean state
+	 */
+	if (mconfig &&
+		(substream->runtime->status->state == SNDRV_PCM_STATE_XRUN ||
+		 mconfig->pipe->state == SKL_PIPE_CREATED ||
+		 mconfig->pipe->state == SKL_PIPE_PAUSED)) {
+
+		ret = skl_reset_pipe(skl->skl_sst, mconfig->pipe);
+
+		if (ret < 0)
+			return ret;
+
+		ret = skl_pcm_host_dma_prepare(dai->dev,
+					mconfig->pipe->p_params);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.17.0
