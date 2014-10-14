From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] audio: sgtl5000: Add MicBias voltage support
Date: Tue, 14 Oct 2014 08:32:21 +0200
Message-ID: <1413268341-3743-3-git-send-email-jean-michel.hautbois@vodalys.com>
References: <1413268341-3743-1-git-send-email-jean-michel.hautbois@vodalys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413268341-3743-1-git-send-email-jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Some systems may require to specify a bias different than default (1.25V).
This adds a property in sgtl5000 codec.
The property is specified in milli-volts so that it is coherent with datasheet.

Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt |  7 ++++++-
 sound/soc/codecs/sgtl5000.c                          | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index d6ec927..1aab403 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -13,6 +13,10 @@ Required properties:
 	If this node is not mentioned or if the value is unknown, then
 	micbias	resistor is set to 4K.
 
+- micbias-voltage-m-volts : the bias voltage to be used in mVolts
+	The voltage can take values from 1.25V to 3V by 250mV steps
+	If this node is not mentionned or the value is unknown, then
+	the value is set to 1.25V.
 
 Example:
 
@@ -20,5 +24,6 @@ codec: sgtl5000@0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
 	clocks = <&clks 150>;
-	sgtl5000-micbias-resistor = <1>;
+	micbias-resistor-k-ohms = <2>;
+	micbias-voltage-m-volts = <2250>;
 };
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index f0b40a6..cb77231 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -140,6 +140,7 @@ struct sgtl5000_priv {
 	struct clk *mclk;
 	int revision;
 	u8 micbias_resistor;
+	u8 micbias_voltage;
 };
 
 /*
@@ -1341,6 +1342,9 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 			SGTL5000_BIAS_R_MASK,
 			sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
 
+	snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
+			SGTL5000_BIAS_R_MASK,
+			sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
 	/*
 	 * disable DAP
 	 * TODO:
@@ -1510,10 +1514,19 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 			/* default is 4Kohms */
 			sgtl5000->micbias_resistor = 2;
 		}
+		if (!of_property_read_u32(np,
+			"micbias-voltage-m-volts", &value)) {
+			/* 1250mV => 0 */
+			/* steps of 250mV */
+			if ((value >= 1250) && (value <= 3000))
+				sgtl5000->micbias_voltage = (value / 250) - 5;
+			else {
+				sgtl5000->micbias_voltage = 0;
 				dev_err(&client->dev,
 					"Unsuitable MicBias resistor\n");
 			}
 		} else {
+			sgtl5000->micbias_voltage = 0;
 		}
 	}
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
