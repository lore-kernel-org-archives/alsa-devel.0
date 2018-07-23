From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/12] ASoC: dt-bindings: add dt bindings for
	wcd9335 audio codec
Date: Mon, 23 Jul 2018 16:54:02 +0100
Message-ID: <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 695742676D4
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 17:58:20 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so1727271wmc.2
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 08:58:20 -0700 (PDT)
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
and I2S/I2C interface.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
new file mode 100644
index 000000000000..55fcf7504fe1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -0,0 +1,21 @@
+QCOM WCD9335 Audio Codec
+
+Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
+It supports both I2S/I2C and SLIMbus audio interfaces.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: "qcom,wcd9335-codec"
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+= EXAMPLE
+
+codec {
+	compatible = "qcom,wcd9335-codec";
+	#sound-dai-cells = <1>;
+};
-- 
2.16.2
