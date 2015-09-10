From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/2] ASoC: Intel: remove unused function
Date: Thu, 10 Sep 2015 18:01:45 +0530
Message-ID: <1441888305-19957-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1441888305-19957-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441888305-19957-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

The function get_current_pipe_id() was not being used.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 683e501..5e9c316 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -368,23 +368,6 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	kfree(stream);
 }
 
-static inline unsigned int get_current_pipe_id(struct snd_soc_dai *dai,
-					       struct snd_pcm_substream *substream)
-{
-	struct sst_data *sst = snd_soc_dai_get_drvdata(dai);
-	struct sst_dev_stream_map *map = sst->pdata->pdev_strm_map;
-	struct sst_runtime_stream *stream =
-			substream->runtime->private_data;
-	u32 str_id = stream->stream_info.str_id;
-	unsigned int pipe_id;
-
-	pipe_id = map[str_id].device_id;
-
-	dev_dbg(dai->dev, "got pipe_id = %#x for str_id = %d\n",
-			pipe_id, str_id);
-	return pipe_id;
-}
-
 static int sst_media_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-- 
1.9.1
