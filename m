From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: add dt bindings for
	wcd9335 audio codec" to the asoc tree
Date: Wed,  1 Aug 2018 12:20:20 +0100 (BST)
Message-ID: <20180801112020.93C4A1124241@debutante.sirena.org.uk>
References: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A0026782B
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 13:20:21 +0200 (CEST)
In-Reply-To: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: add dt bindings for wcd9335 audio codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1877c9fda1b7ba2ee2d9b108b9c9298e69b5b488 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 27 Jul 2018 13:17:57 +0100
Subject: [PATCH] ASoC: dt-bindings: add dt bindings for wcd9335 audio codec

This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
and I2S/I2C interface.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/qcom,wcd9335.txt           | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
new file mode 100644
index 000000000000..1d8d49e30af7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -0,0 +1,123 @@
+QCOM WCD9335 Codec
+
+Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
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
+#sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+codec@1{
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
+	#sound-dai-cells = <1>;
+}
-- 
2.18.0
