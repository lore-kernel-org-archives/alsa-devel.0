From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add HDA BE DAIs" to the
	asoc tree
Date: Tue, 28 Aug 2018 21:32:44 +0100 (BST)
Message-ID: <20180828203244.2EDCF440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FC4426779D
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:32:49 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add HDA BE DAIs

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

>From 3d17871349d5cec0a37ce9407ba72fdbf8572cfd Mon Sep 17 00:00:00 2001
From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Date: Wed, 22 Aug 2018 15:25:01 -0500
Subject: [PATCH] ASoC: Intel: Skylake: add HDA BE DAIs

Add support for HDA BE DAIs in SKL platform driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0
