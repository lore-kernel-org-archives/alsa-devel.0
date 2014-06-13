From: Shahina Shaik <shahina.s@samsung.com>
Subject: [PATCH 2/2] SOUND: TLV320AIC32x4: Fixed Coding Style Issues
Date: Fri, 13 Jun 2014 11:18:48 +0530
Message-ID: <1402638528-5787-2-git-send-email-shahina.s@samsung.com>
References: <1402638528-5787-1-git-send-email-shahina.s@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1402638528-5787-1-git-send-email-shahina.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: sharab.shaik@gmail.com, shahina.s@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Shahina Shaik <sharab.shaik@gmail.com>

Fixed Coding style issues of lines over 80 characters.

Signed-off-by: Shahina Shaik <sharab.shaik@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 1e50f15..89e41d2 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -642,13 +642,17 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 
 	/* Mic PGA routing */
 	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K)
-		snd_soc_write(codec, AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K);
+		snd_soc_write(codec, AIC32X4_LMICPGANIN,
+				AIC32X4_LMICPGANIN_IN2R_10K);
 	else
-		snd_soc_write(codec, AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_CM1L_10K);
+		snd_soc_write(codec, AIC32X4_LMICPGANIN,
+				AIC32X4_LMICPGANIN_CM1L_10K);
 	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K)
-		snd_soc_write(codec, AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_IN1L_10K);
+		snd_soc_write(codec, AIC32X4_RMICPGANIN,
+				AIC32X4_RMICPGANIN_IN1L_10K);
 	else
-		snd_soc_write(codec, AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_CM1R_10K);
+		snd_soc_write(codec, AIC32X4_RMICPGANIN,
+				AIC32X4_RMICPGANIN_CM1R_10K);
 
 	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.7.9.5
