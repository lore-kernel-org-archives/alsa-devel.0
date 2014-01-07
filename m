From: Andreas Pretzsch <apr@cn-eng.de>
Subject: [PATCH] ASoC: ssm2602: add 16kHz sampling rate support
Date: Tue,  7 Jan 2014 22:34:41 +0100
Message-ID: <1389130481-25364-1-git-send-email-apr@cn-eng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mars-solutions.de (mail.mars-solutions.de
 [213.239.212.107])
 by alsa0.perex.cz (Postfix) with ESMTP id A599D2616F6
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 22:34:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

SSM260x also supports 16kHz with external master clocks of 12.000MHz,
12.288MHz and 18.432MHz.
Add matching coefficients, update constraints and announced rates.

Signed-off-by: Andreas Pretzsch <apr@cn-eng.de>
---
patch against topic/ssm2602 of kernel.org/.../broonie/sound.git
Values taken from SSM2603 datasheet (2602/2603/2604 identical here).
Tested on real hardware with 12.288MHz master clock.
Useful e.g. for wideband codecs like G.722.

 sound/soc/codecs/ssm2602.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index c6dd485..af76bbd 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -194,7 +194,7 @@ static const struct snd_soc_dapm_route ssm2604_routes[] = {
 };
 
 static const unsigned int ssm2602_rates_12288000[] = {
-	8000, 32000, 48000, 96000,
+	8000, 16000, 32000, 48000, 96000,
 };
 
 static struct snd_pcm_hw_constraint_list ssm2602_constraints_12288000 = {
@@ -231,6 +231,11 @@ static const struct ssm2602_coeff ssm2602_coeff_table[] = {
 	{18432000, 32000, SSM2602_COEFF_SRATE(0x6, 0x1, 0x0)},
 	{12000000, 32000, SSM2602_COEFF_SRATE(0x6, 0x0, 0x1)},
 
+	/* 16k */
+	{12288000, 16000, SSM2602_COEFF_SRATE(0x5, 0x0, 0x0)},
+	{18432000, 16000, SSM2602_COEFF_SRATE(0x5, 0x1, 0x0)},
+	{12000000, 16000, SSM2602_COEFF_SRATE(0xa, 0x0, 0x1)},
+
 	/* 8k */
 	{12288000, 8000, SSM2602_COEFF_SRATE(0x3, 0x0, 0x0)},
 	{18432000, 8000, SSM2602_COEFF_SRATE(0x3, 0x1, 0x0)},
@@ -473,9 +478,10 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#define SSM2602_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_32000 |\
-		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
-		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+#define SSM2602_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+		SNDRV_PCM_RATE_96000)
 
 #define SSM2602_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-- 
1.7.10.4
