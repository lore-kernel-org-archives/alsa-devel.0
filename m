From: =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?=
        <jean-francois.tetu@savoirfairelinux.com>
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: fix micbias level
Date: Fri, 29 Sep 2017 16:19:44 -0400
Message-ID: <1506716384-4700-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?= <jean-francois.tetu@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

The macro used to set the microphone bias level causes the
snd_soc_write() call to overwrite other fields in the CDC_A_MICB_1_VAL
register. The macro also does not return the proper level value
to use. This fixes this by preserving all bits from the register
that are not the level while setting the level.

Signed-off-by: Jean-François Têtu <jean-francois.tetu@savoirfairelinux.com>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index f562f2d..e1534fe 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -104,7 +104,7 @@
 #define CDC_A_MICB_1_VAL		(0xf141)
 #define MICB_MIN_VAL 1600
 #define MICB_STEP_SIZE 50
-#define MICB_VOLTAGE_REGVAL(v)		((v - MICB_MIN_VAL)/MICB_STEP_SIZE)
+#define MICB_VOLTAGE_REGVAL(v)		(((v - MICB_MIN_VAL)/MICB_STEP_SIZE) << 3)
 #define MICB_1_VAL_MICB_OUT_VAL_MASK	GENMASK(7, 3)
 #define MICB_1_VAL_MICB_OUT_VAL_V2P70V	((0x16)  << 3)
 #define MICB_1_VAL_MICB_OUT_VAL_V1P80V	((0x4)  << 3)
@@ -349,8 +349,9 @@ static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
 			    | MICB_1_CTL_EXT_PRECHARG_EN_ENABLE);
 
 	if (wcd->micbias_mv) {
-		snd_soc_write(codec, CDC_A_MICB_1_VAL,
-			      MICB_VOLTAGE_REGVAL(wcd->micbias_mv));
+		snd_soc_update_bits(codec, CDC_A_MICB_1_VAL,
+				    MICB_1_VAL_MICB_OUT_VAL_MASK,
+				    MICB_VOLTAGE_REGVAL(wcd->micbias_mv));
 		/*
 		 * Special headset needs MICBIAS as 2.7V so wait for
 		 * 50 msec for the MICBIAS to reach 2.7 volts.
-- 
2.7.4
