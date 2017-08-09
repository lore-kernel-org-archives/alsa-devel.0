From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 2/5] ASoC: codecs: msm8916-wcd-analog: get
	micbias voltage from dt
Date: Wed,  9 Aug 2017 18:49:24 +0200
Message-ID: <20170809164927.19663-3-srinivas.kandagatla@linaro.org>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id BB932267409
 for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2017 18:49:38 +0200 (CEST)
Received: by mail-it0-f53.google.com with SMTP id 76so733552ith.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Aug 2017 09:49:38 -0700 (PDT)
In-Reply-To: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds bindings in DT to provide required micbias voltage which
could be specific to board. With this new binding, now the mic bias
voltage is left at hardware default value if the device tree does not
specify any mic bias voltage value. Correct micbias value is required
for mbhc buttons to work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,msm8916-wcd-analog.txt       |  1 +
 sound/soc/codecs/msm8916-wcd-analog.c                | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index ccb401c..05b67a1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -33,6 +33,7 @@ Required properties
  - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator DT node.
 
 Optional Properties:
+- qcom,micbias-lvl:  Voltage (mV) for Mic Bias
 - qcom,micbias1-ext-cap: boolean, present if micbias1 has external capacitor
 			 connected.
 - qcom,micbias2-ext-cap: boolean, present if micbias2 has external capacitor
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 6606954..dec4978 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -93,8 +93,12 @@
 #define MICB_1_EN_TX3_GND_SEL_TX_GND	0
 
 #define CDC_A_MICB_1_VAL		(0xf141)
+#define MICB_MIN_VAL 1600
+#define MICB_STEP_SIZE 50
+#define MICB_VOLTAGE_REGVAL(v)		((v - MICB_MIN_VAL)/MICB_STEP_SIZE)
 #define MICB_1_VAL_MICB_OUT_VAL_MASK	GENMASK(7, 3)
 #define MICB_1_VAL_MICB_OUT_VAL_V2P70V	((0x16)  << 3)
+#define MICB_1_VAL_MICB_OUT_VAL_V1P80V	((0x4)  << 3)
 #define CDC_A_MICB_1_CTL		(0xf142)
 
 #define MICB_1_CTL_CFILT_REF_SEL_MASK		BIT(1)
@@ -225,6 +229,7 @@ struct pm8916_wcd_analog_priv {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 	unsigned int micbias1_cap_mode;
 	unsigned int micbias2_cap_mode;
+	unsigned int micbias_mv;
 };
 
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
@@ -265,18 +270,18 @@ static const struct snd_kcontrol_new pm8916_wcd_analog_snd_controls[] = {
 
 static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
 {
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+
 	snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
 			    MICB_1_CTL_EXT_PRECHARG_EN_MASK |
 			    MICB_1_CTL_INT_PRECHARG_BYP_MASK,
 			    MICB_1_CTL_INT_PRECHARG_BYP_EXT_PRECHRG_SEL
 			    | MICB_1_CTL_EXT_PRECHARG_EN_ENABLE);
 
-	snd_soc_write(codec, CDC_A_MICB_1_VAL, MICB_1_VAL_MICB_OUT_VAL_V2P70V);
-	/*
-	 * Special headset needs MICBIAS as 2.7V so wait for
-	 * 50 msec for the MICBIAS to reach 2.7 volts.
-	 */
-	msleep(50);
+	if (wcd->micbias_mv)
+		snd_soc_write(codec, CDC_A_MICB_1_VAL,
+			      MICB_VOLTAGE_REGVAL(wcd->micbias_mv));
+
 	snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
 			    MICB_1_CTL_EXT_PRECHARG_EN_MASK |
 			    MICB_1_CTL_INT_PRECHARG_BYP_MASK, 0);
@@ -795,6 +800,9 @@ static int pm8916_wcd_analog_parse_dt(struct device *dev,
 	else
 		priv->micbias2_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;
 
+	of_property_read_u32(dev->of_node, "qcom,micbias-lvl",
+			     &priv->micbias_mv);
+
 	return 0;
 }
 
-- 
2.9.3
