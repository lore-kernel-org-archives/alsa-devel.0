From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 13/15] dt-bindings: sound: qcom: Add devicetree bindings for apq8096
Date: Tue,  5 Dec 2017 22:18:10 +0000
Message-ID: <20171205221812.25641-14-srinivas.kandagatla@linaro.org>
References: <20171205221812.25641-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171205221812.25641-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, bgoswami@codeaurora.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, plai@codeaurora.org, kwestfie@codeaurora.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 000000000000..27b511dab533
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,22 @@
+* Qualcomm Technologies APQ8096 ASoC sound card driver
+
+This binding describes the APQ8096 sound card, which uses qdsp for audio.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apq8096-sndcard"
+
+- qcom,audio-routing:
+	Usage: Optional
+	Value type: <stringlist>
+	Definition:  A list of the connections between audio components.
+		  Each entry is a pair of strings, the first being the
+		  connection's sink, the second being the connection's
+		  source. Valid names could be power supplies, MicBias
+		  of codec and the jacks on the board:
+Example:
+	sound {
+		compatible	= "qcom,snd-apq8096";
+		qcom,model = "DB820c";
+	};
-- 
2.15.0
