From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 1/9] ASoC: msm8x176: Add Device Tree bindings.
Date: Tue, 16 Feb 2016 17:32:30 +0000
Message-ID: <1455643950-1657-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings required for msm8x16 codec which is
integrated in msm8916 and apq8016 SOCs.

Codec IP is divided into two parts, first analog which is integrated
in pmic pm8916 and secondly digital part which is integrated into
application processor. Codec register controls are also split across
pmic an lpass. Analog part is controlled via spmi bus to pmic, registers
on the Application processor are memory mapped.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,msm8x16-wcd.txt | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt b/Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt
new file mode 100644
index 0000000..42d3f66
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt
@@ -0,0 +1,91 @@
+msm8x16 audio CODEC aka Tombak audio CODEC
+
+Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
+and secondly digital part which is integrated into application processor. Codec register
+controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.
+
+## Bindings for codec core on pmic:
+
+Required properties
+ - compatible = "qcom,msm8x16-wcd-codec";
+ - reg: represents the slave base address provided to the peripheral.
+ - interrupt-parent : The parent interrupt controller.
+ - interrupts: List of interrupts in given SPMI peripheral.
+ - interrupt-names: Names specified to above list of interrupts in same
+		    order
+ - vddio-supply: phandle to VDD_CDC_IO regulator device tree node.
+ - vdd-tx-rx-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.
+ - vdda-cp-supply: phandle of VDD_CP charge pump supply's regulator device tree node.
+ - vdda-hph-supply: phandle of VDD_HPH supply's regulator device tree node.
+ - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator device tree
+			    node.
+- qcom,lpass-codec-core: phandle to syscon node of lpass code core.
+
+Optional Properties:
+- qcom,micbias1-ext-cap: present if micbias1 has external capacitor connected.
+- qcom,micbias2-ext-cap: present if micbias2 has external capacitor connected.
+
+## Bindings codec core on lpass:
+
+Required properties
+ - compatible: should be "syscon" follwed by "qcom,msm8x16-lpass-codec"
+ - reg: represents the lpass codec core register map.
+
+Example:
+
+spmi_bus {
+	...
+	msm8x16_wcd_codec@f000{
+		compatible = "qcom,msm8x16-wcd-codec";
+		reg = <0xf000 0x200>;
+		reg-names = "pmic-codec-core";
+		clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+		clock-names = "mclk";
+		interrupt-parent = <&spmi_bus>;
+		interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+			     <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+			     <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+			     <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+			     <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+			     <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+			     <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+			     <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+		interrupt-names = "spk_cnp_int",
+				  "spk_clip_int",
+				  "spk_ocp_int",
+				  "ins_rem_det1",
+				  "but_rel_det",
+				  "but_press_det",
+				  "ins_rem_det",
+				  "mbhc_int",
+				  "ear_ocp_int",
+				  "hphr_ocp_int",
+				  "hphl_ocp_det",
+				  "ear_cnp_int",
+				  "hphr_cnp_int",
+				  "hphl_cnp_int";
+
+		vddio-supply = <&pm8916_l5>;
+		vdd-cp-supply = <&pm8916_s4>;
+		vdd-hph-supply = <&pm8916_s4>;
+		vdd-tx-rx-supply = <&pm8916_l5>
+		vdd-micbias-supply = <&pm8916_l13>;
+		qcom,lpass-codec-core = <&lpass_codec>;
+		#sound-dai-cells = <1>;
+	};
+};
+
+soc {
+	...
+	lpass_codec_core: lpass-codec{
+		compatible = "syscon", "qcom,msm8x16-lpass-codec";
+		reg = <0x0771c000 0x400>;
+	};
+
+};
-- 
1.9.1
