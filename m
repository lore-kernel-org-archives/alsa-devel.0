From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/12] ASoC: q6afe: dt-bindings: add compatible string to
 dais
Date: Tue, 26 Jun 2018 10:20:07 +0100
Message-ID: <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com, perex@perex.cz, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add compatible string to dais so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index bdbf87df8c0b..a8179409c194 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
 subnode of "dais" representing board specific dai setup.
 "dais" node should have following properties followed by dai children.
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-dais"
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -100,6 +105,7 @@ q6afe@4 {
 	reg = <APR_SVC_AFE>;
 
 	dais {
+		compatible = "qcom,q6afe-dais";
 		#sound-dai-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.16.2
