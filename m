From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH] ASoC: tlv320aic32x4:  Add 96k sample rate
Date: Tue, 19 Apr 2016 09:59:04 -0700
Message-ID: <1461085144-28104-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C3426262A
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 18:59:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The TLV320AIC32x4 series supports 96ksps rates in hardware.  This patch
adds the necessary PLL divider values and clock settings to the table to
make 96ksps work.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index c6b6d55..2f8480c 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -159,7 +159,10 @@ static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 48k rate */
 	{AIC32X4_FREQ_12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4},
 	{AIC32X4_FREQ_24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4},
-	{AIC32X4_FREQ_25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4}
+	{AIC32X4_FREQ_25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4},
+
+	/* 96k rate */
+	{AIC32X4_FREQ_25000000, 96000, 2, 7, 8643, 64, 4, 4, 64, 4, 4, 1},
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -564,7 +567,7 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_48000
+#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC32X4_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
 			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-- 
2.5.0
