From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v6 5/5] arm64: dts: apq8016-sbc: add analog audio support with multicodec
Date: Thu, 20 Oct 2016 15:20:49 +0100
Message-ID: <1476973249-14547-6-git-send-email-srinivas.kandagatla@linaro.org>
References: <1476973249-14547-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476973249-14547-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch add support to Analog audio both Playback and Capture via
msm8916 WCD muti codec.
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 61 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi     |  9 +++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi      | 45 ++++++++++++++++++++++-
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index bb062b5..4b6cd04 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -15,6 +15,7 @@
 #include "pm8916.dtsi"
 #include "apq8016-sbc-soc-pins.dtsi"
 #include "apq8016-sbc-pmic-pins.dtsi"
+#include <dt-bindings/sound/apq8016-lpass.h>
 
 / {
 	aliases {
@@ -251,6 +252,60 @@
 				vddio-supply = <&pm8916_l6>;
 			};
 		};
+
+		lpass_codec: codec{
+			status = "okay";
+		};
+
+		/*
+		Internal Codec
+			playback - Primary MI2S
+			capture - Ter MI2S
+
+		External Primary:
+			playback - secondary MI2S
+			capture - Quat MI2S
+
+		External Secondary:
+			playback - Quat MI2S
+			capture - Quat MI2S
+
+		*/
+
+                sound: sound {
+                        compatible = "qcom,apq8016-sbc-sndcard";
+                        reg = <0x07702000 0x4>, <0x07702004 0x4>;
+                        reg-names = "mic-iomux", "spkr-iomux";
+
+                        status = "okay";
+                        pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
+                        pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
+                        pinctrl-names = "default", "sleep";
+                        qcom,model = "DB410c";
+                        qcom,audio-routing =
+                                "AMIC2", "MIC BIAS Internal2",
+                                "AMIC3", "MIC BIAS External1";
+
+                        internal-codec-playback-dai-link@0 {            /* I2S - Internal codec */
+                                link-name = "WCD";
+                                cpu { /* PRIMARY */
+                                        sound-dai = <&lpass MI2S_PRIMARY>;
+                                };
+                                codec {
+                                        sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+                                };
+                        };
+
+                        internal-codec-capture-dai-link@0 {             /* I2S - Internal codec */
+                                link-name = "WCD-Capture";
+                                cpu { /* PRIMARY */
+                                        sound-dai = <&lpass MI2S_TERTIARY>;
+                                };
+                                codec {
+                                        sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+                                };
+                        };
+                };
 	};
 
 	usb2513 {
@@ -278,6 +333,12 @@
 	};
 };
 
+&wcd_codec {
+        status = "okay";
+        clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+        clock-names = "mclk";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l5-supply = <&pm8916_s3>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 466ca57..1575694d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -504,6 +504,15 @@
 			reg-names = "lpass-lpaif";
 		};
 
+                lpass_codec: codec{
+			compatible = "qcom,msm8916-wcd-digital-codec";
+			reg = <0x0771c000 0x400>;
+			clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
+				 <&gcc GCC_CODEC_DIGCODEC_CLK>;
+			clock-names = "ahbix-clk", "mclk";
+			#sound-dai-cells = <1>;
+                };
+
 		sdhc_1: sdhci@07824000 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f71679b..53deebf 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -91,9 +91,52 @@
 	};
 
 	pm8916_1: pm8916@1 {
-		compatible = "qcom,spmi-pmic";
+		compatible = "qcom,pm8916", "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+                wcd_codec: codec@f000 {
+                       compatible = "qcom,pm8916-wcd-analog-codec";
+	               reg = <0xf000 0x200>;
+	               reg-names = "pmic-codec-core";
+	               clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+	               clock-names = "mclk";
+	               interrupt-parent = <&spmi_bus>;
+	               interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+	                            <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+	                            <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+	                            <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+	                            <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+	                            <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+	                            <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+	                            <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+	               interrupt-names = "cdc_spk_cnp_int",
+	                                 "cdc_spk_clip_int",
+	                                 "cdc_spk_ocp_int",
+	                                 "mbhc_ins_rem_det1",
+	                                 "mbhc_but_rel_det",
+	                                 "mbhc_but_press_det",
+	                                 "mbhc_ins_rem_det",
+	                                 "mbhc_switch_int",
+	                                 "cdc_ear_ocp_int",
+	                                 "cdc_hphr_ocp_int",
+	                                 "cdc_hphl_ocp_det",
+	                                 "cdc_ear_cnp_int",
+	                                 "cdc_hphr_cnp_int",
+	                                 "cdc_hphl_cnp_int";
+	               vdd-cdc-io-supply = <&pm8916_l5>;
+	               vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	               vdd-micbias-supply = <&pm8916_l13>;
+	               #sound-dai-cells = <1>;
+
+                };
+
 	};
 };
-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
