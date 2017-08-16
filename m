From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Set reasonable compress id string" to the asoc tree
Date: Wed, 16 Aug 2017 17:02:06 +0100
Message-ID: <E1di0li-0003O2-WD@debutante>
References: <1502894873-15063-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502894873-15063-1-git-send-email-dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, liam.r.girdwood@linux.intel.com, rf@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Set reasonable compress id string

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

>From aeb6fa0f15c71a18f757d1686822b6c34cf81399 Mon Sep 17 00:00:00 2001
From: Peng Donglin <dolinux.peng@gmail.com>
Date: Wed, 16 Aug 2017 22:47:53 +0800
Subject: [PATCH] ASoC: compress: Set reasonable compress id string

For dynamic compress rtd, the codec_dai may not have any actual
meaning(like snd-soc-dummy-dai), so compress id can just use the
value of dai_link->stream_name. But for others, its codec_dai
has actual meaning, so compress id can include codec_dai name.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 6c867d50e036..2cb8d3b55fbc 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 
 	/* check client and interface hw capabilities */
-	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-			rtd->dai_link->stream_name, codec_dai->name, num);
-
 	if (codec_dai->driver->playback.channels_min)
 		playback = 1;
 	if (codec_dai->driver->capture.channels_min)
@@ -758,7 +755,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		return -EINVAL;
 	}
 
-	if(playback)
+	if (playback)
 		direction = SND_COMPRESS_PLAYBACK;
 	else
 		direction = SND_COMPRESS_CAPTURE;
@@ -794,19 +791,18 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		else if (rtd->dai_link->dpcm_capture)
 			be_pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data = rtd;
 		memcpy(compr->ops, &soc_compr_dyn_ops, sizeof(soc_compr_dyn_ops));
-	} else
+	} else {
+		snprintf(new_name, sizeof(new_name), "%s %s-%d",
+			rtd->dai_link->stream_name, codec_dai->name, num);
+
 		memcpy(compr->ops, &soc_compr_ops, sizeof(soc_compr_ops));
+	}
 
 	/* Add copy callback for not memory mapped DSPs */
 	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
 		compr->ops->copy = soc_compr_copy;
 
 	mutex_init(&compr->lock);
-
-	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-		 rtd->dai_link->stream_name,
-		 rtd->codec_dai->name, num);
-
 	ret = snd_compress_new(rtd->card->snd_card, num, direction,
 				new_name, compr);
 	if (ret < 0) {
-- 
2.13.3
