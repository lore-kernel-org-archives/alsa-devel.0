From: srinivas.kandagatla@linaro.org
Subject: [PATCH v10 10/13] dt-bindings: Add qcom slimbus
	controller bindings
Date: Mon, 11 Dec 2017 23:43:04 +0000
Message-ID: <20171211234307.14465-11-srinivas.kandagatla@linaro.org>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 429AD2676DA
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 00:45:27 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id k61so19308123wrc.4
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 15:45:27 -0800 (PST)
In-Reply-To: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

This patch add device tree bindings for Qualcomm slimbus controller.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
new file mode 100644
index 000000000000..922dcb8ff24a
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
@@ -0,0 +1,39 @@
+Qualcomm SLIMbus controller
+This controller is used if applications processor driver controls SLIMbus
+master component.
+
+Required properties:
+
+ - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
+ - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
+
+ - reg : Offset and length of the register region(s) for the device
+ - reg-names : Register region name(s) referenced in reg above
+	 Required register resource entries are:
+	 "ctrl": Physical address of controller register blocks
+ 	 "slew": required for "qcom,apq8064-slim" SOC.
+ - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible
+ 		followed by "qcom,slim" for fallback.
+ - interrupts : Interrupt number used by this controller
+ - clocks : Interface and core clocks used by this SLIMbus controller
+ - clock-names : Required clock-name entries are:
+	"iface" : Interface clock for this controller
+	"core" : Interrupt for controller core's BAM
+
+Example:
+
+	slim@28080000 {
+		compatible = "qcom,apq8064-slim", "qcom,slim";
+		reg = <0x28080000 0x2000>, <0x80207C 4>;
+		reg-names = "ctrl", "slew";
+		interrupts = <0 33 0>;
+		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+		clock-names = "iface", "core";
+		#address-cells = <2>;
+		#size-cell = <0>;
+
+		wcd9310: audio-codec@1,0{
+			compatible = "slim217,60";
+			reg = <1 0>;
+		};
+	};
-- 
2.15.0
