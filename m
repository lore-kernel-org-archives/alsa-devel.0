From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] ASoC: dt-bindings: add dt bindings for
	WCD9340/WCD9341 audio codec
Date: Tue,  2 Jul 2019 09:09:15 +0100
Message-ID: <20190702080920.22623-2-srinivas.kandagatla@linaro.org>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADB3CF800C7
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 10:10:32 +0200 (CEST)
Received: by mail-wm1-x344.google.com with SMTP id s15so2184855wmj.3
 for <alsa-devel@alsa-project.org>; Tue, 02 Jul 2019 01:10:32 -0700 (PDT)
In-Reply-To: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for wcd9340/wcd9341 audio codec which can
support both SLIMbus and I2S/I2C interface.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wcd934x.txt           | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.txt b/Documentation/devicetree/bindings/sound/qcom,wcd934x.txt
new file mode 100644
index 000000000000..2b48c98b5b7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.txt
@@ -0,0 +1,188 @@
+QCOM WCD9340/9341 Codec Bindings
+
+Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC, supports
+Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
+the MSM8996, MSM8976, and MSM8956 chipsets. It has in-built
+Soundwire controller, interrupt mux. It supports both I2S/I2C and
+SLIMbus audio interfaces.
+
+Required properties with SLIMbus Interface:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: For SLIMbus interface it should be "slimMID,PID",
+		    textual representation of Manufacturer ID, Product Code,
+		    shall be in lower case hexadecimal with leading zeroes
+		    suppressed.  Refer to slimbus/bus.txt for details.
+		    Should be:
+		    "slim217,250" for SDM845/SDA845 SoCs with SLIMbus.
+
+- reg
+	Usage: required
+	Value type: <u32 u32>
+	Definition: Should be ('Device index', 'Instance ID')
+
+- interrupts
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Interrupts via WCD INTR1 and INTR2 pins
+
+- interrupt-names:
+	Usage: required
+	Value type: <String array>
+	Definition: Interrupt names of WCD INTR1 and INTR2
+	Should be: "intr1", "intr2"
+
+- reset-gpios:
+	Usage: required
+	Value type: <String Array>
+	Definition: Reset gpio line
+
+- slim-ifc-dev:
+	Usage: required
+	Value type: <phandle>
+	Definition: SLIM interface device
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: See clock-bindings.txt section "consumers". List of
+                three clock specifiers for mclk, mclk2 and slimbus clock.
+
+- clock-names:
+	Usage: required
+	Value type: <string>
+	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
+
+- vdd-buck-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V buck supply
+
+- vdd-buck-sido-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V SIDO buck supply
+
+- vdd-rx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V rx supply
+
+- vdd-tx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V tx supply
+
+- vdd-vbat-supply:
+	Usage: Optional
+	Value type: <phandle>
+	Definition: Should contain a reference to the vbat supply
+
+- vdd-micbias-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the micbias supply
+
+- vdd-io-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V io supply
+
+- qcom,micbias1-lvl:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be voltage in milli Volts for micbias1 output
+	Supported values are in inbetween 1800mV-2850mV
+
+- qcom,micbias2-lvl:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be voltage in milli Volts for micbias2 output
+	Supported values are in inbetween 1800mV-2850mV
+
+- qcom,micbias3-lvl:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be voltage in milli Volts for micbias3 output
+	Supported values are in inbetween 1800mV-2850mV
+
+- qcom,micbias4-lvl:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be voltage in milli Volts for micbias4 output
+	Supported values are in inbetween 1800mV-2850mV
+
+- clock-output-names:
+	Usage: required
+	Value type: <string>
+	Definition: Should be the "mclk", corresponding to name
+			of the clk output.
+
+- clock-frequency:
+	Usage: required
+	Definition: Indicating the frequency of mclk output.
+
+- interrupt-controller:
+	Usage: required
+	Definition: Indicating that this is a interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 1
+
+- #clock-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 0, as there is only one clock out supported.
+
+#sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+Example:
+
+wcd9340: audio-codec@1{
+	compatible = "slim217,250";
+	reg  = <1 0>;
+	reset-gpios = <&tlmm 64 0>;
+	slim-ifc-dev  = <&wcd9340_ifd>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+	qcom,micbias1-lvl = <1800>;
+	qcom,micbias2-lvl = <1800>;
+	qcom,micbias3-lvl = <1800>;
+	qcom,micbias4-lvl = <1800>;
+
+	interrupt-parent = <&tlmm>;
+	interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names  = "intr1";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	#clock-cells = <0>;
+	clock-frequency = <9600000>;
+	clock-output-names = "mclk";
+	#sound-dai-cells = <1>;
+
+	pinctrl@42 {
+		compatible = "qcom,wcd9340-pinctrl";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&wcdpinctrl 0 0 5>;
+		reg = <0x42 0x2>;
+		...
+	};
+
+	soundwire@c85{
+		compatible = "qcom,soundwire-v1.3.0";
+		reg = <0xc85 0x40>;
+		...
+	};
+};
-- 
2.21.0
