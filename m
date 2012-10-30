From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH 1/2] sound: soc: tlv320aic32x4: Fix problem
	with first capture.
Date: Tue, 30 Oct 2012 16:29:33 +0100
Message-ID: <1351610974-18395-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 657DF260202
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 16:29:44 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so222944eek.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 08:29:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lrg@ti.com, lars@metafoo.de, w.sang@pengutronix.de, Javier Martin <javier.martin@vista-silicon.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

In its previous status, the first capture didn't work properly;
nothing was actually recorded from the microphone. This
behaviour was observed using a Visstrim M10 board.

In order to solve this BUG a workaround has been added that,
during the initialization process of the codec, powers on and
off the ADC.

The issue seems related to a HW BUG or some behavior that
is not documented in the datasheet.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/codecs/tlv320aic32x4.c |   10 ++++++++++
 sound/soc/codecs/tlv320aic32x4.h |    3 +++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index b0a73d3..aad92f9 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -675,6 +675,16 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(aic32x4_snd_controls));
 	aic32x4_add_widgets(codec);
 
+	/*
+	 * Workaround: for an unknown reason, the ADC needs to be powered up
+	 * and down for the first capture to work properly. It seems related to
+	 * a HW BUG or some kind of behavior not documented in the datasheet.
+	 */
+	tmp_reg = snd_soc_read(codec, AIC32X4_ADCSETUP);
+	snd_soc_write(codec, AIC32X4_ADCSETUP, tmp_reg |
+				AIC32X4_LADC_EN | AIC32X4_RADC_EN);
+	snd_soc_write(codec, AIC32X4_ADCSETUP, tmp_reg);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index aae2b24..3577422 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -94,6 +94,9 @@
 #define AIC32X4_WORD_LEN_24BITS		0x02
 #define AIC32X4_WORD_LEN_32BITS		0x03
 
+#define AIC32X4_LADC_EN			(1 << 7)
+#define AIC32X4_RADC_EN			(1 << 6)
+
 #define AIC32X4_I2S_MODE		0x00
 #define AIC32X4_DSP_MODE		0x01
 #define AIC32X4_RIGHT_JUSTIFIED_MODE	0x02
-- 
1.7.9.5
