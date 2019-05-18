From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/12] ASoC: SOF: pcm: remove runtime PM calls
	during pcm open/close
Date: Sat, 18 May 2019 15:26:56 -0500
Message-ID: <20190518202704.7772-5-pierre-louis.bossart@linux.intel.com>
References: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C01FDF896B9
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 22:27:26 +0200 (CEST)
In-Reply-To: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

pm_runtime_get_sync()/pm_runtime_put_autosuspend() calls are
already invoked by the ASoC core in soc_pcm_open() and
soc_pcm_close(). So the SOF component driver does not need
to call them again.

Fixes: 868bd00f495 ("ASoC: SOF: Add PCM operations support")
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 649968841dad..4f536c0de0a5 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -416,7 +416,6 @@ static int sof_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_sof_pcm *spcm;
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;
-	int err;
 
 	/* nothing to do for BE */
 	if (rtd->dai_link->no_pcm)
@@ -434,14 +433,6 @@ static int sof_pcm_open(struct snd_pcm_substream *substream)
 
 	caps = &spcm->pcm.caps[substream->stream];
 
-	ret = pm_runtime_get_sync(sdev->dev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: pcm open failed to resume %d\n",
-			ret);
-		pm_runtime_put_noidle(sdev->dev);
-		return ret;
-	}
-
 	/* set any runtime constraints based on topology */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
@@ -485,17 +476,8 @@ static int sof_pcm_open(struct snd_pcm_substream *substream)
 	spcm->stream[substream->stream].substream = substream;
 
 	ret = snd_sof_pcm_platform_open(sdev, substream);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: pcm open failed %d\n",
-			ret);
-
-		pm_runtime_mark_last_busy(sdev->dev);
-
-		err = pm_runtime_put_autosuspend(sdev->dev);
-		if (err < 0)
-			dev_err(sdev->dev, "error: pcm close failed to idle %d\n",
-				err);
-	}
+	if (ret < 0)
+		dev_err(sdev->dev, "error: pcm open failed %d\n", ret);
 
 	return ret;
 }
@@ -530,13 +512,6 @@ static int sof_pcm_close(struct snd_pcm_substream *substream)
 		 */
 	}
 
-	pm_runtime_mark_last_busy(sdev->dev);
-
-	err = pm_runtime_put_autosuspend(sdev->dev);
-	if (err < 0)
-		dev_err(sdev->dev, "error: pcm close failed to idle %d\n",
-			err);
-
 	return 0;
 }
 
-- 
2.20.1
