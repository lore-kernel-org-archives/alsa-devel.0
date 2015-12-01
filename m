From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update DMIC DAIs and
	capabilities" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:41 +0000
Message-ID: <E1a3ttd-0006Ex-6j@debutante>
References: <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27652261AD8
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:47 +0100 (CET)
In-Reply-To: <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, "Dharageswari.R" <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update DMIC DAIs and capabilities

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

>From 8f35bf3f71f7b367511e0912eb7b70834b39ef77 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 28 Nov 2015 15:01:46 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update DMIC DAIs and capabilities

On Skylake we can support upton 4DMICs on the PDM port, so update
the PCM capabilities accordingly

Also add a new DAI for DMIC pin which can be used for getting raw
DMIC data

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.2
