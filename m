From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 08/25] dt-bindings: sound: qcom: Add
	bindings for q6asm
Date: Tue, 13 Feb 2018 16:58:20 +0000
Message-ID: <20180213165837.1620-9-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AE1C726795E
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 18:01:25 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id j21so14097575wmh.1
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 09:01:25 -0800 (PST)
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt       | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
new file mode 100644
index 000000000000..5d6a90681796
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,38 @@
+Qualcomm Audio Stream Manager (Q6ASM) binding
+
+Q6ASM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    example "qcom,asm-v2.0"
+
+- qcom,apr-svc-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 7 for Audio Stream Manager Service.
+
+- qcom,apr-svc-name
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must be "ASM"
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 1
+
+
+= EXAMPLE
+
+q6asm: q6asm {
+	compatible = "qcom,q6asm";
+	qcom,apr-svc-name = "ASM";
+	qcom,apr-svc-id = <APR_SVC_ASM>;
+	#sound-dai-cells = <1>;
+};
-- 
2.15.1
