From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v8 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Wed,  9 May 2018 13:56:16 +0100
Message-ID: <20180509125635.5653-6-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..cb709e5dbc44
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,33 @@
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
+	Definition: must be "qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6adm" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6adm-v2.0"
+
+
+= ADM routing
+"routing" subnode of the ADM node represents adm routing specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 0
+
+= EXAMPLE
+q6adm@8 {
+	compatible = "qcom,q6adm";
+	reg = <APR_SVC_ADM>;
+	q6routing: routing {
+		#sound-dai-cells = <0>;
+	};
+};
-- 
2.16.2
