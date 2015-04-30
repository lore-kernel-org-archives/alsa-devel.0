From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 14/14] ASoC: qcom: document apq8016 machine driver bindings
Date: Thu, 30 Apr 2015 18:18:26 +0100
Message-ID: <1430414306-11469-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for apq8016 machine driver.
On APQ8016 4 MI2S can be configured to different sinks like internal
codec/external codec, this connection is controlled via 2 iomux
registers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,apq8016-machine.txt        | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-machine.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-machine.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-machine.txt
new file mode 100644
index 0000000..de697b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-machine.txt
@@ -0,0 +1,61 @@
+* Qualcomm Technologies APQ8016 ASoC machine driver
+
+This node models the Qualcomm Technologies APQ8016 ASoC machine driver
+
+Required properties:
+
+- compatible		: "qcom,apq8016-sndcard"
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
+	compatible = "qcom,apq8016-sndcard";
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
