From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add 4 channel support to DSP.
Date: Thu, 16 Oct 2014 15:29:16 +0100
Message-ID: <1413469757-6200-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413469757-6200-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E93AD2605E7
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 16:29:37 +0200 (CEST)
In-Reply-To: <1413469757-6200-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

DSP can now support 4 channels in certain use cases.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 4 ----
 sound/soc/intel/sst-haswell-pcm.c | 8 +-------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 92d625a..4799768 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1256,10 +1256,6 @@ int sst_hsw_stream_set_channels(struct sst_hsw *hsw,
 		return -EINVAL;
 	}
 
-	/* stereo is only supported atm */
-	if (channels != 2)
-		return -EINVAL;
-
 	stream->request.format.ch_num = channels;
 	return 0;
 }
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 4df867c..9a51987 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -421,13 +421,7 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* we only support stereo atm */
 	channels = params_channels(params);
-	if (channels != 2) {
-		dev_err(rtd->dev, "error: invalid channels %d\n", channels);
-		return -EINVAL;
-	}
-
 	map = create_channel_map(SST_HSW_CHANNEL_CONFIG_STEREO);
 	sst_hsw_stream_set_map_config(hsw, pcm_data->stream,
 			map, SST_HSW_CHANNEL_CONFIG_STEREO);
@@ -741,7 +735,7 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 		.capture = {
 			.stream_name = "Analog Capture",
 			.channels_min = 2,
-			.channels_max = 2,
+			.channels_max = 4,
 			.rates = SNDRV_PCM_RATE_48000,
 			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
 		},
-- 
1.9.1
