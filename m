From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/16] ASoC: Intel: Skylake: Update DMIC DAIs
	and capabilities
Date: Sat, 28 Nov 2015 15:01:46 +0530
Message-ID: <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0245C2651EB
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:32:14 +0100 (CET)
In-Reply-To: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

On Skylake we can support upton 4DMICs on the PDM port, so update
the PCM capabilities accordingly

Also add a new DAI for DMIC pin which can be used for getting raw
DMIC data

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index c79bbff00cb7..6570e5753e49 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -28,6 +28,7 @@
 
 #define HDA_MONO 1
 #define HDA_STEREO 2
+#define HDA_QUAD 4
 
 static struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
@@ -46,8 +47,8 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				SNDRV_PCM_RATE_8000,
 	.rate_min =		8000,
 	.rate_max =		48000,
-	.channels_min =		2,
-	.channels_max =		2,
+	.channels_min =		1,
+	.channels_max =		HDA_QUAD,
 	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
 	.period_bytes_min =	128,
 	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
@@ -560,7 +561,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.capture = {
 		.stream_name = "Reference Capture",
 		.channels_min = HDA_MONO,
-		.channels_max = HDA_STEREO,
+		.channels_max = HDA_QUAD,
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
@@ -587,6 +588,18 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+{
+	.name = "DMIC Pin",
+	.ops = &skl_pcm_dai_ops,
+	.capture = {
+		.stream_name = "DMIC Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_QUAD,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+
 /* BE CPU  Dais */
 {
 	.name = "SSP0 Pin",
@@ -640,8 +653,8 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.ops = &skl_dmic_dai_ops,
 	.capture = {
 		.stream_name = "DMIC01 Rx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_QUAD,
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
-- 
2.4.3
