From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 2/6] ASoC: tlv320aic32x4: Fix MICPGA input
	configuration
Date: Mon, 27 Jan 2014 13:03:06 +0100
Message-ID: <1390824190-18376-3-git-send-email-mpa@pengutronix.de>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4ABA12625FD
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:03:35 +0100 (CET)
In-Reply-To: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Currently the Negative Terminal Input Routing Configuration is only set
when there is a special routing configuration. If we don't use one of
the inputs IN1 or IN2 as negative terminal input, the PGA and recording
does not work.

This patch adds a route from CM1L/CM1R to the PGA as negative input by
default. With this configuration the PGA can amplify all input signals
and line-in/mic works again.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 10 ++++++----
 sound/soc/codecs/tlv320aic32x4.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 0a8079b..36a9cb9 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -618,12 +618,14 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, AIC32X4_CMMODE, tmp_reg);
 
 	/* Mic PGA routing */
-	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K) {
+	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K)
 		snd_soc_write(codec, AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K);
-	}
-	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K) {
+	else
+		snd_soc_write(codec, AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_CM1L_10K);
+	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K)
 		snd_soc_write(codec, AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_IN1L_10K);
-	}
+	else
+		snd_soc_write(codec, AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_CM1R_10K);
 
 	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 83795af..995f033 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -120,7 +120,9 @@
 #define AIC32X4_MICBIAS_2075V		0x60
 
 #define AIC32X4_LMICPGANIN_IN2R_10K	0x10
+#define AIC32X4_LMICPGANIN_CM1L_10K	0x40
 #define AIC32X4_RMICPGANIN_IN1L_10K	0x10
+#define AIC32X4_RMICPGANIN_CM1R_10K	0x40
 
 #define AIC32X4_LMICPGAVOL_NOGAIN	0x80
 #define AIC32X4_RMICPGAVOL_NOGAIN	0x80
-- 
1.8.5.2
