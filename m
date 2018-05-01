From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 03/24] ASoC: qdsp6: dt-bindings: Add q6core
	dt bindings
Date: Tue,  1 May 2018 13:07:59 +0100
Message-ID: <20180501120820.11016-4-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2791D26769C
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 14:10:29 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id f6so17483399wmc.4
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 05:10:29 -0700 (PDT)
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
new file mode 100644
index 000000000000..bd14e9a93490
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
@@ -0,0 +1,21 @@
+Qualcomm ADSP Core service binding
+
+Q6CORE is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6core-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6core" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6core-v2.0"
+
+= EXAMPLE
+q6core@3 {
+	compatible = "qcom,q6core";
+	reg = <APR_SVC_ADSP_CORE>;
+};
-- 
2.16.2
