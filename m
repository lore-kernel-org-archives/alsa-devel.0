From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v8 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Date: Wed,  9 May 2018 13:56:17 +0100
Message-ID: <20180509125635.5653-7-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch add DT bindings for ASM (Audio Stream Manager) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
new file mode 100644
index 000000000000..2178eb91146f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,33 @@
+Qualcomm Audio Stream Manager (Q6ASM) binding
+
+Q6ASM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    Or "qcom,q6asm" where the version number can be queried
+		    from DSP.
+		    example "qcom,q6asm-v2.0"
+
+= ASM DAIs (Digial Audio Interface)
+"dais" subnode of the ASM node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+= EXAMPLE
+
+q6asm@7 {
+	compatible = "qcom,q6asm";
+	reg = <APR_SVC_ASM>;
+	q6asmdai: dais {
+		#sound-dai-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
new file mode 100644
index 000000000000..1eb77d87c2e8
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_ASM_H__
+#define __DT_BINDINGS_Q6_ASM_H__
+
+#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
+#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
+#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
+#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
+#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
+#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
+#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
+#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
+
+#endif /* __DT_BINDINGS_Q6_ASM_H__ */
-- 
2.16.2
