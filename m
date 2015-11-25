From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: using params_width function to
	simplify code" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:05 +0000
Message-ID: <E1a1Zg5-0002qy-Th@debutante>
References: <61c4bd3dd82c40b59d1d2570a400321027ae6abc.1448350220.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66DFD261AA0
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:14 +0100 (CET)
In-Reply-To: <61c4bd3dd82c40b59d1d2570a400321027ae6abc.1448350220.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: using params_width function to simplify code

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

>From 4ca730436a676afebbe6b77d65b5b4c4d7d38b9c Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Tue, 24 Nov 2015 15:32:09 +0800
Subject: [PATCH] ASoC: fsl: using params_width function to simplify code

using params_width function to simplify code.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 sound/soc/fsl/fsl_esai.c | 2 +-
 sound/soc/fsl/fsl_sai.c  | 2 +-
 sound/soc/fsl/fsl_ssi.c  | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 9f087d4f73ed..6d0636605ed2 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -447,7 +447,7 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
-	int width = snd_pcm_format_width(params_format(params));
+	int width = params_width(params);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
 	unsigned int channels = params_channels(params);
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 504e7318f225..45d4319b2079 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -510,7 +510,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	u32 width = snd_pcm_format_width(params_format(params));
+	u32 width = params_width(params);
 	u32 channels = params_channels(params);
 	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
 	u32 slot_width = width;
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index dc0cc65406f5..3da278313591 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -404,7 +404,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int channels = params_channels(params);
-	u32 word_width = snd_pcm_format_width(params_format(params));
+	u32 word_width = params_width(params);
 	u32 val_cr4 = 0, val_cr5 = 0;
 	u32 slots = (channels == 1) ? 2 : channels;
 	u32 slot_width = word_width;
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 674abf778715..e3abad5f980a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -767,8 +767,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi_private->regs;
 	unsigned int channels = params_channels(hw_params);
-	unsigned int sample_size =
-		snd_pcm_format_width(params_format(hw_params));
+	unsigned int sample_size = params_width(hw_params);
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
 	int ret;
 	u32 scr_val;
-- 
2.6.2
