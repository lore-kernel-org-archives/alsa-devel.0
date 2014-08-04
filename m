From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v4 02/12] ASoC: Intel: mrfld: set private data for
	cpu-dai
Date: Mon,  4 Aug 2014 15:15:53 +0530
Message-ID: <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 61BB42608CF
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 12:07:28 +0200 (CEST)
In-Reply-To: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We set the driver private data for media dai so that we can use in media
operations

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 364034024cee..821c9970548c 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -223,7 +223,7 @@ int sst_fill_stream_params(void *substream,
 }
 
 static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
-		struct snd_soc_platform *platform)
+		struct snd_soc_dai *dai)
 {
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
@@ -231,7 +231,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 	struct snd_sst_params str_params = {0};
 	struct snd_sst_alloc_params_ext alloc_params = {0};
 	int ret_val = 0;
-	struct sst_data *ctx = snd_soc_platform_get_drvdata(platform);
+	struct sst_data *ctx = snd_soc_dai_get_drvdata(dai);
 
 	/* set codec params and inform SST driver the same */
 	sst_fill_pcm_params(substream, &param);
@@ -347,10 +347,10 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	kfree(stream);
 }
 
-static inline unsigned int get_current_pipe_id(struct snd_soc_platform *platform,
+static inline unsigned int get_current_pipe_id(struct snd_soc_dai *dai,
 					       struct snd_pcm_substream *substream)
 {
-	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct sst_data *sst = snd_soc_dai_get_drvdata(dai);
 	struct sst_dev_stream_map *map = sst->pdata->pdev_strm_map;
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
@@ -376,7 +376,7 @@ static int sst_media_prepare(struct snd_pcm_substream *substream,
 		return ret_val;
 	}
 
-	ret_val = sst_platform_alloc_stream(substream, dai->platform);
+	ret_val = sst_platform_alloc_stream(substream, dai);
 	if (ret_val <= 0)
 		return ret_val;
 	snprintf(substream->pcm->id, sizeof(substream->pcm->id),
@@ -412,8 +412,16 @@ static struct snd_soc_dai_ops sst_media_dai_ops = {
 	.hw_free = sst_media_hw_free,
 };
 
+static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
+{
+	struct sst_data *sst = dev_get_drvdata(cpu_dai->dev);
+
+	snd_soc_dai_set_drvdata(cpu_dai, sst);
+	return 0;
+}
 static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
+	.probe = sst_media_dai_probe,
 	.name = "media-cpu-dai",
 	.ops = &sst_media_dai_ops,
 	.playback = {
-- 
1.9.0
