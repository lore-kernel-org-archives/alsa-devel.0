From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v7 4/7] ASoC: Intel: Skylake: add HDA BE DAIs
Date: Fri, 17 Aug 2018 15:37:20 -0500
Message-ID: <20180817203723.32305-5-pierre-louis.bossart@linux.intel.com>
References: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 71B962677E2
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 22:37:31 +0200 (CEST)
In-Reply-To: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

Add support for HDA BE DAIs in SKL platform driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 70 +++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 823e39103edd..00b7a91b18c9 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -32,6 +32,7 @@
 #define HDA_MONO 1
 #define HDA_STEREO 2
 #define HDA_QUAD 4
+#define HDA_MAX 8
 
 static const struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
@@ -569,7 +570,10 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	stream_tag = hdac_stream(link_dev)->stream_tag;
 
 	/* set the stream tag in the codec dai dma params  */
-	snd_soc_dai_set_tdm_slot(codec_dai, stream_tag, 0, 0, 0);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_dai_set_tdm_slot(codec_dai, stream_tag, 0, 0, 0);
+	else
+		snd_soc_dai_set_tdm_slot(codec_dai, 0, stream_tag, 0, 0);
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
@@ -995,21 +999,63 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
-	.name = "HD-Codec Pin",
+	.name = "Analog CPU DAI",
 	.ops = &skl_link_dai_ops,
 	.playback = {
-		.stream_name = "HD-Codec Tx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.stream_name = "Analog CPU Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_MAX,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
 	},
 	.capture = {
-		.stream_name = "HD-Codec Rx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.stream_name = "Analog CPU Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_MAX,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "Alt Analog CPU DAI",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "Alt Analog CPU Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_MAX,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "Alt Analog CPU Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_MAX,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "Digital CPU DAI",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "Digital CPU Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_MAX,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "Digital CPU Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_MAX,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
 	},
 },
 };
-- 
2.17.1
