From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: pcm: remove runtime PM calls
	during pcm open/close" to the asoc tree
Date: Mon, 13 May 2019 13:30:28 +0100 (BST)
Message-ID: <20190513123028.CFE011129236@debutante.sirena.org.uk>
References: <20190509201027.3906-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D188CF89707
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <20190509201027.3906-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: pcm: remove runtime PM calls during pcm open/close

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 14a2212dd4bcb55a03eddaf66d62068c9cece585 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 9 May 2019 15:10:24 -0500
Subject: [PATCH] ASoC: SOF: pcm: remove runtime PM calls during pcm open/close

pm_runtime_get_sync()/pm_runtime_put_autosuspend() calls are
already invoked by the ASoC core in soc_pcm_open() and
soc_pcm_close(). So the SOF component driver does not need
to call them again.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
