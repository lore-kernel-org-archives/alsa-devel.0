From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: add DEEP_BUFFER support
	for BYT/CHT/BSW" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:30 +0000
Message-ID: <E1aAG2s-0004e1-2x@debutante>
References: <1450406156-22246-9-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 210752606B2
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:36 +0100 (CET)
In-Reply-To: <1450406156-22246-9-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: add DEEP_BUFFER support for BYT/CHT/BSW

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

>From d35eb96a95dc82befe2d9d1533728506b0847f14 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:45 -0600
Subject: [PATCH] ASoC: Intel: boards: add DEEP_BUFFER support for BYT/CHT/BSW

Add dai links to enable additional playback stream with deeper
buffer for lower power consumption.
The normal and DEEP_buffer streams are not mutually exclusive,
content will be mixed by the DSP.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c        | 13 +++++++++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 ++++++++++++
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 12 ++++++++++++
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 12 ++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 944283f569c6..a81389d10e17 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -267,6 +267,19 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &byt_rt5640_aif1_ops,
 	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &byt_rt5640_aif1_ops,
+	},
 	[MERR_DPCM_COMPR] = {
 		.name = "Baytrail Compressed Port",
 		.stream_name = "Baytrail Compress",
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index e36dad302bed..90588d6e64fc 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -232,6 +232,18 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_capture = 1,
 		.ops = &cht_aif1_ops,
 	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &cht_aif1_ops,
+	},
 	[MERR_DPCM_COMPR] = {
 		.name = "Compressed Port",
 		.stream_name = "Compress",
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 1d2525a53bff..2d3afddb0a2e 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -260,6 +260,18 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_capture = 1,
 		.ops = &cht_aif1_ops,
 	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &cht_aif1_ops,
+	},
 	[MERR_DPCM_COMPR] = {
 		.name = "Compressed Port",
 		.stream_name = "Compress",
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 77fb3c419ca4..2e5347f8f96c 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -248,6 +248,18 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_capture = 1,
 		.ops = &cht_aif1_ops,
 	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &cht_aif1_ops,
+	},
 	[MERR_DPCM_COMPR] = {
 		.name = "Compressed Port",
 		.stream_name = "Compress",
-- 
2.6.2
