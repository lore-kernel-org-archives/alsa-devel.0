From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 06/25] dt-bindings: sound: qcom: Add
	bindings for q6adm
Date: Tue, 13 Feb 2018 16:58:18 +0000
Message-ID: <20180213165837.1620-7-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE49267945
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 18:01:23 +0100 (CET)
Received: by mail-wr0-f194.google.com with SMTP id w77so4814767wrc.6
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 09:01:23 -0800 (PST)
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
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..e493dccfe116
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,31 @@
+Qualcomm Audio Device Manager (Q6ADM) binding
+
+Q6ADM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    example "qcom,adm-v2.0"
+
+- qcom,apr-svc-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 8 for Audio Device Manager Service.
+
+- qcom,apr-svc-name
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must be "ADM"
+
+= EXAMPLE
+
+q6adm: q6adm {
+	compatible = "qcom,q6adm-v2.0";
+	qcom,apr-svc-name = "ADM";
+	qcom,apr-svc-id = <APR_SVC_ADM>;
+};
-- 
2.15.1
