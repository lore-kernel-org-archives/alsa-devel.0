From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 1/2] ASoC: qcom: document apq8016 sbc machine driver bindings
Date: Wed, 10 Jun 2015 13:15:44 +0100
Message-ID: <1433938544-18076-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1433938505-18006-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1433938505-18006-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for apq8016 sbc machine driver.
APQ8016 has 4 MI2S which can be configured to different sinks like
internal codec/external codec, this connection and various parameters
are controlled via 2 iomux registers.

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
new file mode 100644
index 0000000..4812936
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
@@ -0,0 +1,60 @@
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
+-link-name		: Name of the dai link.
+-sound-dai		: phandle and port of CPU/CODEC
+-capture-dai		: phandle and port of CPU/CODEC
+
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
+		link-name = "ADV7533";
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
