From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 01/14] ASoC: dt-bindings: update wcd9335 bindings.
Date: Sun, 16 Sep 2018 17:57:14 -0700
Message-ID: <20180917005727.32728-2-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch updates wcd9335 bindings with recommended properties.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 1d8d49e..5d6ea66 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -34,12 +34,12 @@ Required properties with SLIMbus Interface:
 	Definition: Interrupt names of WCD INTR1 and INTR2
 	Should be: "intr1", "intr2"
 
-- reset-gpio:
+- reset-gpios:
 	Usage: required
 	Value type: <String Array>
 	Definition: Reset gpio line
 
-- qcom,ifd:
+- slim-ifc-dev:
 	Usage: required
 	Value type: <phandle>
 	Definition: SLIM interface device
@@ -104,13 +104,13 @@ Required properties with SLIMbus Interface:
 	Value type: <u32>
 	Definition: Must be 1
 
-codec@1{
+audio-codec@1{
 	compatible = "slim217,1a0";
 	reg  = <1 0>;
 	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "intr2"
-	reset-gpio = <&msmgpio 64 0>;
-	qcom,ifd  = <&wc9335_ifd>;
+	reset-gpios = <&msmgpio 64 0>;
+	slim-ifc-dev  = <&wc9335_ifd>;
 	clock-names = "mclk", "native";
 	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
 		 <&rpmcc RPM_SMD_BB_CLK1>;
-- 
2.9.3
