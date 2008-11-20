From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 2/2] ALSA: ASoC: ssm2602: Update supported
	stream formats
Date: Thu, 20 Nov 2008 15:39:31 +0100
Message-ID: <492576A3.7050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C3E1243BF
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:39:21 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so200143eyc.56
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 06:39:20 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Karl Beldan <karl.beldan@gmail.com>
---
 sound/soc/codecs/ssm2602.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index abc804e..714187a 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -516,6 +516,9 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
 		SNDRV_PCM_RATE_96000)
 
+#define SSM2602_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
 struct snd_soc_dai ssm2602_dai = {
 	.name = "SSM2602",
 	.playback = {
@@ -523,13 +526,13 @@ struct snd_soc_dai ssm2602_dai = {
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
1.6.0.3.523.g304d0
