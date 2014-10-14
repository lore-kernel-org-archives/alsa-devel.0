From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] audio: sgtl5000: Add MicBias resistor support in DT
Date: Tue, 14 Oct 2014 08:32:20 +0200
Message-ID: <1413268341-3743-2-git-send-email-jean-michel.hautbois@vodalys.com>
References: <1413268341-3743-1-git-send-email-jean-michel.hautbois@vodalys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413268341-3743-1-git-send-email-jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Some systems may require a different resistor than the default one (4K).
This adds a property in sgtl5000 codec.
It keeps the default of 4K when nothing is specified so it does not break
existing code.

Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/sound/sgtl5000.txt         |  8 ++++
 sound/soc/codecs/sgtl5000.c                        | 55 ++++++++++++++++++++--
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 955df60..d6ec927 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -7,10 +7,18 @@ Required properties:
 
 - clocks : the clock provider of SYS_MCLK
 
+- micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
+	The resistor can take values of 2k, 4k or 8k.
+	If set to 0 it will be off.
+	If this node is not mentioned or if the value is unknown, then
+	micbias	resistor is set to 4K.
+
+
 Example:
 
 codec: sgtl5000@0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
 	clocks = <&clks 150>;
+	sgtl5000-micbias-resistor = <1>;
 };
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6bb77d7..f0b40a6 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/clk.h>
+#include <linux/log2.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -121,6 +122,13 @@ struct ldo_regulator {
 	bool enabled;
 };
 
+enum sgtl5000_micbias_resistor {
+	SGTL5000_MICBIAS_OFF = 0,
+	SGTL5000_MICBIAS_2K = 2,
+	SGTL5000_MICBIAS_4K = 4,
+	SGTL5000_MICBIAS_8K = 8,
+};
+
 /* sgtl5000 private structure in codec */
 struct sgtl5000_priv {
 	int sysclk;	/* sysclk rate */
@@ -131,6 +139,7 @@ struct sgtl5000_priv {
 	struct regmap *regmap;
 	struct clk *mclk;
 	int revision;
+	u8 micbias_resistor;
 };
 
 /*
@@ -145,12 +154,14 @@ struct sgtl5000_priv {
 static int mic_bias_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(w->codec);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		/* change mic bias resistor to 4Kohm */
+		/* change mic bias resistor */
 		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
-				SGTL5000_BIAS_R_MASK,
-				SGTL5000_BIAS_R_4k << SGTL5000_BIAS_R_SHIFT);
+			SGTL5000_BIAS_R_MASK,
+			sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1326,7 +1337,9 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 			SGTL5000_HP_ZCD_EN |
 			SGTL5000_ADC_ZCD_EN);
 
-	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 2);
+	snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
+			SGTL5000_BIAS_R_MASK,
+			sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
 
 	/*
 	 * disable DAP
@@ -1418,6 +1431,8 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	struct sgtl5000_priv *sgtl5000;
 	int ret, reg, rev;
 	unsigned int mclk;
+	struct device_node *np = client->dev.of_node;
+	u32 value;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
 								GFP_KERNEL);
@@ -1470,6 +1485,38 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
 	sgtl5000->revision = rev;
 
+	if (np) {
+		if (!of_property_read_u32(np,
+			"micbias-resistor-k-ohms", &value)) {
+			switch (value) {
+			case SGTL5000_MICBIAS_OFF:
+				sgtl5000->micbias_resistor = 0;
+				break;
+			case SGTL5000_MICBIAS_2K:
+				sgtl5000->micbias_resistor = 1;
+				break;
+			case SGTL5000_MICBIAS_2K:
+				sgtl5000->micbias_resistor = 2;
+				break;
+			case SGTL5000_MICBIAS_2K:
+				sgtl5000->micbias_resistor = 3;
+				break;
+			default:
+				sgtl5000->micbias_resistor = 2;
+				dev_err(&client->dev,
+					"Unsuitable MicBias resistor\n");
+			}
+		} else {
+			/* default is 4Kohms */
+			sgtl5000->micbias_resistor = 2;
+		}
+				dev_err(&client->dev,
+					"Unsuitable MicBias resistor\n");
+			}
+		} else {
+		}
+	}
+
 	i2c_set_clientdata(client, sgtl5000);
 
 	/* Ensure sgtl5000 will start with sane register values */
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
