From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Date: Sat, 10 Mar 2018 02:24:36 +0000
Message-ID: <20180310022456.26739-5-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for AFE (Audio Frontend) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       | 107 +++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
new file mode 100644
index 000000000000..1e4b82e7747a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -0,0 +1,107 @@
+Qualcomm Audio Front End (Q6AFE) binding
+
+AFE is one of the APR audio service on Q6DSP
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by all apr services.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
+		  Or "qcom,afe" where the version number can be queried
+		  from DSP.
+		  example "qcom,afe-v2.0"
+
+= AFE DAIs (Digial Audio Interface)
+"dais" subnode of the AFE node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 1
+
+- reg
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be dai id
+
+- interface-type
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must be one of following
+	"mi2s"
+	"hdmi"
+	"pcm"
+	"slim"
+
+- qcom,sd-lines
+	Usage: required for mi2s interface
+	Value type: <prop-encoded-array>
+	Definition: Must be list of serial data lines used by this dai.
+	should be one or more of the 1-4 sd lines.
+
+= EXAMPLE
+
+q6afe {
+	compatible = "qcom,q6afe";
+	qcom,apr-svc-name = "AFE";
+	qcom,apr-svc-id = <APR_SVC_AFE>;
+
+	q6asmdai: dais {
+		#sound-dai-cells = <1>;
+		hdmi@1 {
+			reg = <1>;
+			interface-type = "hdmi";
+		};
+
+		prim-mi2s-rx@16 {
+			reg = <16>;
+			qcom,sd-lines = <1 3>;
+			interface-type = "mi2s";
+		};
+
+		prim-mi2s-tx@17 {
+			reg = <17>;
+			qcom,sd-lines = <2>;
+			interface-type = "mi2s";
+		};
+
+		sec-mi2s-rx@18 {
+			reg = <18>;
+			qcom,sd-lines = <1 4>;
+			interface-type = "mi2s";
+		};
+
+		sec-mi2s-tx@19 {
+			reg = <19>;
+			qcom,sd-lines = <2>;
+			interface-type = "mi2s";
+		};
+
+		tert-mi2s-rx@20 {
+			reg = <20>;
+			qcom,sd-lines = <2 4>;
+			interface-type = "mi2s";
+		};
+
+		tert-mi2s-tx@21 {
+			reg = <21>;
+			qcom,sd-lines = <1>;
+			interface-type = "mi2s";
+		};
+
+		quat-mi2s-rx@22 {
+			reg = <22>;
+			qcom,sd-lines = <1>;
+			interface-type = "mi2s";
+		};
+
+		quat-mi2s-tx@23 {
+			reg = <23>;
+			qcom,sd-lines = <2>;
+			interface-type = "mi2s";
+		};
+	};
+};
diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
new file mode 100644
index 000000000000..3c7868394889
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __DT_BINDINGS_Q6_AFE_H__
+#define __DT_BINDINGS_Q6_AFE_H__
+
+/* Audio Front End (AFE) virtual ports IDs */
+#define HDMI_RX		1
+#define SLIMBUS_0_RX    2
+#define SLIMBUS_0_TX    3
+#define SLIMBUS_1_RX    4
+#define SLIMBUS_1_TX    5
+#define SLIMBUS_2_RX    6
+#define SLIMBUS_2_TX    7
+#define SLIMBUS_3_RX    8
+#define SLIMBUS_3_TX    9
+#define SLIMBUS_4_RX    10
+#define SLIMBUS_4_TX    11
+#define SLIMBUS_5_RX    12
+#define SLIMBUS_5_TX    13
+#define SLIMBUS_6_RX    14
+#define SLIMBUS_6_TX    15
+#define PRIMARY_MI2S_RX		16
+#define PRIMARY_MI2S_TX		17
+#define SECONDARY_MI2S_RX	18
+#define SECONDARY_MI2S_TX	19
+#define TERTIARY_MI2S_RX	20
+#define TERTIARY_MI2S_TX	21
+#define QUATERNARY_MI2S_RX	22
+#define QUATERNARY_MI2S_TX	23
+
+#endif /* __DT_BINDINGS_Q6_AFE_H__ */
+
-- 
2.15.1
