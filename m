From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/2] ASoC: msm8916: Add codec Device Tree bindings.
Date: Fri, 10 Jun 2016 19:18:44 +0100
Message-ID: <1465582725-30183-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings required for msm8916 codec which is
integrated in msm8916 and apq8016 SOCs.

Codec IP is divided into two parts, first analog which is integrated
in pmic pm8916 and secondly digital part which is integrated into
application processor. Codec register controls are also split across
pmic an lpass. Analog part is controlled via spmi bus to pmic, registers
on the Application processor are memory mapped.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,msm8916-wcd.txt | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
new file mode 100644
index 0000000..0559c1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
@@ -0,0 +1,103 @@
+msm8916 audio CODEC audio CODEC
+
+Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
+and secondly digital part which is integrated into application processor. Codec register
+controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.
+
+## Bindings for codec core on pmic:
+
+Required properties
+ - compatible = "qcom,msm8916-pmic-wcd-codec";
+ - reg: represents the slave base address provided to the peripheral.
+ - interrupt-parent : The parent interrupt controller.
+ - interrupts: List of interrupts in given SPMI peripheral.
+ - interrupt-names: Names specified to above list of interrupts in same
+		    order. List of supported interrupt names are:
+  "spk_cnp_int" - Speaker click and pop interrupt
+  "spk_clip_int" - Speaker clip interrupt
+  "spk_ocp_int" - Speaker over current protect interrupt.
+  "ins_rem_det1" - jack insert removal detect interrupt 1.
+  "but_rel_det" - button release interrupt
+  "but_press_det" - button press event
+  "ins_rem_det" - jack insert removal detect interrup
+  "mbhc_int"	- multi button headset interrupt.
+  "ear_ocp_int" - Earphone over current protect interrupt.
+  "hphr_ocp_int" - Headphone R over current protect interrupt.
+  "hphl_ocp_det" - Headphone L over current protect interrupt
+  "ear_cnp_int" - earphone cnp interrupt.
+  "hphr_cnp_int" - hphr click and pop interrupt.
+  "hphl_cnp_int" - hphl click and pop interrupt
+
+ - clocks: Handle to mclk.
+ - clock-names: should be "mclk".
+ - vddio-supply: phandle to VDD_CDC_IO regulator device tree node.
+ - vdd-tx-rx-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.
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
+ - compatible: should be "qcom,msm8916-lpass-codec" followed by "syscon".
+ - reg: represents the lpass codec core register map.
+
+Example:
+
+spmi_bus {
+	...
+	msm8916_wcd_codec@f000{
+		compatible = "qcom,msm8916-pmic-wcd-codec";
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
+		vddio-supply = <&pm8916_l5>;
+		vdd-tx-rx-supply = <&pm8916_l5>;
+		vdd-micbias-supply = <&pm8916_l13>;
+		qcom,lpass-codec-core = <&lpass_codec_core>;
+		#sound-dai-cells = <1>;
+	};
+};
+
+soc {
+	...
+	lpass_codec_core: lpass-codec{
+		compatible = "qcom,msm8916-lpass-codec", "syscon";
+		reg = <0x0771c000 0x400>;
+	};
+
+};
-- 
2.8.3
