From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/5] ASoC: q6asm-dai: dt-bindings: Add support to compress dais
Date: Thu, 15 Nov 2018 18:13:22 +0000
Message-ID: <20181115181324.26784-4-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, srini@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds board specific bindings required for dais, In particular
for compressed dais and dai direction.

Board specific setup involves setting up some of dais as compressed dais
and also specify direction of any dai. Some of the dais might only
support capture/playback depending on the board level wiring.

These two new dt properties will allow such flexibilty at board level dts.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index f9c7bd8c1bc0..9f5378c51686 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -27,6 +27,28 @@ used by the apr service device.
 	Value type: <u32>
 	Definition: Must be 1
 
+== ASM DAI is subnode of "dais" and represent a dai, it includes board specific
+configuration of each dai. Must contain the following properties.
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Must be dai id
+
+- direction:
+	Usage: Required for Compress offload dais
+	Value type: <u32>
+	Definition: Specifies the direction of the dai stream
+			0 for both tx and rx
+			1 for only tx (Capture/Encode)
+			2 for only rx (Playback/Decode)
+
+- is-compress-dai:
+	Usage: Required for Compress offload dais
+	Value type: <boolean>
+	Definition: present for Compress offload dais
+
+
 = EXAMPLE
 
 q6asm@7 {
@@ -35,5 +57,10 @@ q6asm@7 {
 	q6asmdai: dais {
 		compatible = "qcom,q6asm-dais";
 		#sound-dai-cells = <1>;
+		mm@0 {
+			reg = <0>;
+			direction = <2>;
+			is-compress-dai;
+		};
 	};
 };
-- 
2.19.1
