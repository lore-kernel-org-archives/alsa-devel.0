From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 1/6] ASoC: tlv320aic32x4: Fix mono playback
Date: Mon, 27 Jan 2014 13:03:05 +0100
Message-ID: <1390824190-18376-2-git-send-email-mpa@pengutronix.de>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 3BC61264FF0
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:03:43 +0100 (CET)
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

Playback of a mono stream should output the same stream on both
channels. At the moment only the left analog signal is valid, the right
one is just noise.

This patch maps the left digital channel onto both DACs when receiving a
mono stream.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 18 +++++++++++-------
 sound/soc/codecs/tlv320aic32x4.h |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 7639601..0a8079b 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -450,6 +450,17 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	}
 	snd_soc_write(codec, AIC32X4_IFACE1, data);
 
+	if (params_channels(params) == 1) {
+		data = AIC32X4_RDAC2LCHN | AIC32X4_LDAC2LCHN;
+	} else {
+		if (aic32x4->swapdacs)
+			data = AIC32X4_RDAC2LCHN | AIC32X4_LDAC2RCHN;
+		else
+			data = AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN;
+	}
+	snd_soc_update_bits(codec, AIC32X4_DACSETUP, AIC32X4_DAC_CHAN_MASK,
+			data);
+
 	return 0;
 }
 
@@ -606,13 +617,6 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	}
 	snd_soc_write(codec, AIC32X4_CMMODE, tmp_reg);
 
-	/* Do DACs need to be swapped? */
-	if (aic32x4->swapdacs) {
-		snd_soc_write(codec, AIC32X4_DACSETUP, AIC32X4_LDAC2RCHN | AIC32X4_RDAC2LCHN);
-	} else {
-		snd_soc_write(codec, AIC32X4_DACSETUP, AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN);
-	}
-
 	/* Mic PGA routing */
 	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K) {
 		snd_soc_write(codec, AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K);
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 3577422..83795af 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -138,6 +138,7 @@
 #define AIC32X4_LDAC2RCHN		(0x02 << 4)
 #define AIC32X4_LDAC2LCHN		(0x01 << 4)
 #define AIC32X4_RDAC2RCHN		(0x01 << 2)
+#define AIC32X4_DAC_CHAN_MASK		0x3c
 
 #define AIC32X4_SSTEP2WCLK		0x01
 #define AIC32X4_MUTEON			0x0C
-- 
1.8.5.2
