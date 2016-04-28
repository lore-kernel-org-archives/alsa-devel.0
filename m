From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add multichannel
	support for HDMI" to the asoc tree
Date: Thu, 28 Apr 2016 18:55:11 +0100
Message-ID: <E1avq9f-0002wu-Ui@debutante>
References: <1460437293-8509-11-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37B1B265141
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:55:18 +0200 (CEST)
In-Reply-To: <1460437293-8509-11-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add multichannel support for HDMI

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

>From 7e12dc87ac59963cf1765fb8272412db19004987 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 14 Apr 2016 10:07:35 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add multichannel support for HDMI

Channel max is changed to 8 from stereo to support multichannel
capability for HDMI devices.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index dab0900eef26..8de921272f71 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -51,7 +51,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 	.rate_min =		8000,
 	.rate_max =		48000,
 	.channels_min =		1,
-	.channels_max =		HDA_QUAD,
+	.channels_max =		8,
 	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
 	.period_bytes_min =	128,
 	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
@@ -682,7 +682,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "HDMI1 Playback",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
@@ -697,7 +697,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "HDMI2 Playback",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
@@ -712,7 +712,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "HDMI3 Playback",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
@@ -765,7 +765,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "iDisp1 Tx",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
 			SNDRV_PCM_FMTBIT_S24_LE,
@@ -777,7 +777,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "iDisp2 Tx",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
 			SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
@@ -790,7 +790,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "iDisp3 Tx",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
 			SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
-- 
2.8.0.rc3
