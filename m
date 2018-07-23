From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/12] mfd: dt-bindings: Add wcd9335 mfd
	bindings
Date: Mon, 23 Jul 2018 16:53:59 +0100
Message-ID: <20180723155410.9494-2-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6497226739D
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 17:58:17 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so1766221wmc.0
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 08:58:17 -0700 (PDT)
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

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
the MSM8996, MSM8976, and MSM8956 chipsets. It has in-build
Soundwire controller, interrupt mux. It supports both I2S/I2C and
SLIMbus audio interfaces.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/mfd/qcom,wcd9335.txt       | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt

diff --git a/Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt b/Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt
new file mode 100644
index 000000000000..1f8c9e8d4e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt
@@ -0,0 +1,130 @@
+QCOM WCD9335 Codec
+
+Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
+Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
+the MSM8996, MSM8976, and MSM8956 chipsets. It has in-build
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
+		    "slim217,1a0" for MSM8996 and APQ8096 SoCs with SLIMbus.
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
+- reset-gpio:
+	Usage: required
+	Value type: <String Array>
+	Definition: Reset gpio line
+
+- qcom,ifd:
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
+- interrupt-controller:
+	Usage: required
+	Definition: Indicating that this is a interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 1
+
+= WCD9335 Child devices
+Each subnode of WCD9335 represents a functional blocks like
+"audio codec", "soundwire Controller" of WCD. The name of the
+nodes are not important. The properties of these nodes are
+defined by the individual bindings for the specific device.
+
+Example:
+
+wcd9335@1 {
+	compatible = "slim217,1a0";
+	reg  = <1 0>;
+	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr2"
+	reset-gpio = <&msmgpio 64 0>;
+	qcom,ifd  = <&wc9335_ifd>;
+	clock-names = "mclk", "native";
+	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
+		 <&rpmcc RPM_SMD_BB_CLK1>;
+	vdd-buck-supply = <&pm8994_s4>;
+	vdd-rx-supply = <&pm8994_s4>;
+	vdd-buck-sido-supply = <&pm8994_s4>;
+	vdd-tx-supply = <&pm8994_s4>;
+	vdd-io-supply = <&pm8994_s4>;
+
+	codec {
+		compatible = "qcom,wcd9335-codec";
+		#sound-dai-cells = <1>;
+	};
+}
-- 
2.16.2
