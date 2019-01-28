From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 1/8] ASoC: dt-bindings: update wcd9335
	bindings.
Date: Mon, 28 Jan 2019 14:27:46 +0000
Message-ID: <20190128142753.22396-2-srinivas.kandagatla@linaro.org>
References: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 47657267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 15:28:32 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id z5so18238633wrt.11
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 06:28:32 -0800 (PST)
In-Reply-To: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch updates wcd9335 bindings with recommended properties.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 1d8d49e30af7..5d6ea66a863f 100644
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
2.20.1
