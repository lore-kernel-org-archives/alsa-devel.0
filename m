From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: support more than 2 channels" to the asoc tree
Date: Mon, 13 Feb 2017 18:53:57 +0000
Message-ID: <E1cdLl7-00012W-Ec@debutante>
References: <20170210184243.15901-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210184243.15901-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.orgNicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: support more than 2 channels

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

>From 4957b556f5e7ef9855d698b7ae2f0d4245c7ff50 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Fri, 10 Feb 2017 19:42:43 +0100
Subject: [PATCH] ASoC: fsl_sai: support more than 2 channels

The FSL SAI can support up to 32 channels using TDM. Report that value so
they can actually be used.

Tested using 8 channels.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9fadf7e31c5f..18e5ce81527d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -668,7 +668,7 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rate_min = 8000,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
@@ -677,7 +677,7 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rate_min = 8000,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
-- 
2.11.0
