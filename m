From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 1/2] ASoC: qcom: document apq8016 sbc machine driver bindings
Date: Tue,  9 Jun 2015 13:59:29 +0100
Message-ID: <1433854769-23807-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433854702-23654-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for apq8016 sbc machine driver.
APQ8016 has 4 MI2S which can be configured to different sinks like
internal codec/external codec, this connection and various parameters
are controlled via 2 iomux registers.

Acked-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
new file mode 100644
index 0000000..01d62be
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
@@ -0,0 +1,61 @@
+* Qualcomm Technologies APQ8016 SBC ASoC machine driver
+
+This node models the Qualcomm Technologies APQ8016 SBC ASoC machine driver
+
+Required properties:
+
+- compatible		: "qcom,apq8016-sbc-sndcard"
+
+- pinctrl-N		: One property must exist for each entry in
+			  pinctrl-names.  See ../pinctrl/pinctrl-bindings.txt
+			  for details of the property values.
+- pinctrl-names		: Must contain a "default" entry.
+- reg			: Must contain an address for each entry in reg-names.
+- reg-names		: A list which must include the following entries:
+				* "mic-iomux"
+				* "spkr-iomux"
+- qcom,model		: Name of the sound card.
+
+Dai-link subnode properties and subnodes:
+
+Required dai-link subnodes:
+
+- cpu					: CPU   sub-node
+- codec					: CODEC sub-node
+
+Required CPU/CODEC subnodes properties:
+
+-sound-dai		: phandle and port of CPU/CODEC
+-capture-dai		: phandle and port of CPU/CODEC
+
+Optional CPU/CODEC subnodes properties:
+- external	: flag to indicate if the I2S is connected to external codec
+Example:
+
+sound: sound {
+	compatible = "qcom,apq8016-sbc-sndcard";
+	reg = <0x07702000 0x4>, <0x07702004 0x4>;
+	reg-names = "mic-iomux", "spkr-iomux";
+	qcom,model = "DB410c";
+
+	/* I2S - Internal codec */
+	internal-dai-link@0 {
+		cpu { /* PRIMARY */
+			sound-dai = <&lpass MI2S_PRIMARY>;
+		};
+		codec {
+			sound-dai = <&wcd_codec 0>;
+		};
+	};
+
+	/* External Primary or External Secondary -ADV7533 HDMI */
+	external-dai-link@0 {
+		external;
+		cpu { /* QUAT */
+			sound-dai = <&lpass MI2S_QUATERNARY>;
+		};
+		codec {
+			sound-dai = <&adv_bridge 0>;
+		};
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
