From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: Reset DSP Pipelines
	in prepare
Date: Mon,  2 Apr 2018 12:15:48 +0530
Message-ID: <1522651550-27236-2-git-send-email-sriramx.periyasamy@intel.com>
References: <1522651550-27236-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id E0CDF2670D5
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 08:54:41 +0200 (CEST)
In-Reply-To: <1522651550-27236-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Divya Prakash <divya1.prakash@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

An application can choose to call .prepare function
any number of times. In such scenarios, there is a
need to reset the DSP pipeline.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 15cb8ac3e374..5ac0a12007c2 100644
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
2.7.4
