From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add HDMI FE and BE cpu
	dais" to the asoc tree
Date: Sun, 21 Feb 2016 02:15:28 +0900
Message-ID: <E1aXB7w-0008Ke-Tp@finisterre>
References: <1455725047-7303-10-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0973265182
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:38 +0100 (CET)
In-Reply-To: <1455725047-7303-10-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add HDMI FE and BE cpu dais

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

>From 8cca87c073ac38c7866fb86205fc9ff312a3a575 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 17 Feb 2016 21:34:07 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add HDMI FE and BE cpu dais

This patch enables HDMI support in passthrough mode in skylake.
Skylake supports 3 pin widgets in HDMI codec, so add 3 FE and 3
BE dais

Add required hw info, formats, rates to support HDMI.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 78 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index bbb6c28..dab0900 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -676,6 +676,51 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+{
+	.name = "HDMI1 Pin",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "HDMI1 Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "HDMI2 Pin",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "HDMI2 Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "HDMI3 Pin",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "HDMI3 Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
 
 /* BE CPU  Dais */
 {
@@ -715,14 +760,41 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
-	.name = "iDisp Pin",
+	.name = "iDisp1 Pin",
 	.ops = &skl_link_dai_ops,
 	.playback = {
-		.stream_name = "iDisp Tx",
+		.stream_name = "iDisp1 Tx",
 		.channels_min = HDA_STEREO,
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "iDisp2 Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "iDisp2 Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
+			SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "iDisp3 Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "iDisp3 Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
+			SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
 {
-- 
2.7.0
