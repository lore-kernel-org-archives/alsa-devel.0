From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/10] ASoC: ssm2602: Update supported stream
	formats
Date: Fri, 21 Nov 2008 14:48:27 +0000
Message-ID: <1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1094244E0
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:35 +0100 (CET)
In-Reply-To: <1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Karl Beldan <karl.beldan@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Karl Beldan <karl.beldan@gmail.com>

Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ssm2602.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 0e522e7..56dc1c9 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -514,6 +514,9 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
 		SNDRV_PCM_RATE_96000)
 
+#define SSM2602_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
 struct snd_soc_dai ssm2602_dai = {
 	.name = "SSM2602",
 	.playback = {
@@ -521,13 +524,13 @@ struct snd_soc_dai ssm2602_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SSM2602_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
+		.formats = SSM2602_FORMATS,},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SSM2602_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
+		.formats = SSM2602_FORMATS,},
 	.ops = {
 		.startup = ssm2602_startup,
 		.prepare = ssm2602_pcm_prepare,
-- 
1.5.6.5
