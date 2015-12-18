From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/19] ASoC: Intel: boards: add DEEP_BUFFER
	support for BYT/CHT/BSW
Date: Thu, 17 Dec 2015 20:35:45 -0600
Message-ID: <1450406156-22246-9-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A4FF42616B9
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:16 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

Add dai links to enable additional playback stream with deeper
buffer for lower power consumption.
The normal and DEEP_buffer streams are not mutually exclusive,
content will be mixed by the DSP.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c        | 13 +++++++++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 ++++++++++++
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 12 ++++++++++++
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 12 ++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 944283f..a81389d 100644
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
index e36dad3..90588d6 100644
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
index 1d2525a..2d3afdd 100644
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
index 77fb3c4..2e5347f 100644
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
1.9.1
