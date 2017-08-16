From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH] ASoC: compress: Set reasonable compress id
	string
Date: Wed, 16 Aug 2017 22:47:53 +0800
Message-ID: <1502894873-15063-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 24A7F266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 16:48:00 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id t83so1555900pfj.3
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 07:48:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@linux.intel.com, rf@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

For dynamic compress rtd, the codec_dai may not have any actual
meaning(like snd-soc-dummy-dai), so compress id can just use the
value of dai_link->stream_name. But for others, its codec_dai
has actual meaning, so compress id can include codec_dai name.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/soc-compress.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 206f36b..b6a0714 100644
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
@@ -797,19 +794,18 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
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
1.9.1
