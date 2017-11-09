From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 16/17] NOT FOR MERGING: Add TLV320DAC3101 to BBB for testing
Date: Wed, 8 Nov 2017 18:27:40 -0600
Message-ID: <20171109002741.10897-17-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171109002741.10897-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

---
 arch/arm/boot/dts/am335x-boneblack.dts | 106 +++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index d154d3133c16..e52553d144ab 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -11,9 +11,115 @@
 #include "am335x-bone-common.dtsi"
 #include "am335x-boneblack-common.dtsi"
 
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/sound/tlv320aic31xx-micbias.h>
+
 / {
 	model = "TI AM335x BeagleBone Black";
 	compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
+
+	sound {
+		status = "disabled"; /* Disable default HDMI sound card */
+	};
+
+	sound0: sound0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "BeagleBone-Black-TLV320DAC3101";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker External";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Speaker External", "SPL",
+			"Speaker External", "SPR";
+		simple-audio-card,format = "i2s"; /* Change this to try out different DAI formats */
+		simple-audio-card,bitclock-master = <&sound0_codec>; /* Change these to switch clock masters */
+		simple-audio-card,frame-master = <&sound0_codec>;
+
+		sound0_cpu: simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+			clocks = <&clk_mcasp0>;
+		};
+
+		sound0_codec: simple-audio-card,codec {
+			sound-dai = <&tlv320dac3101>;
+			clocks = <&clkout2_ck>;
+		};
+	};
+};
+
+&tda19988 {
+	status = "disabled";
+};
+
+&am33xx_pinmux {
+	mcasp0_pins: mcasp0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x9ac, PIN_INPUT | MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(0x990, PIN_INPUT | MUX_MODE0 ) /* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(0x994, PIN_INPUT | MUX_MODE0 ) /* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(0x998, PIN_INPUT | MUX_MODE0 ) /* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(0x9a4, PIN_INPUT | MUX_MODE2 ) /* mcasp0_fsr.mcasp0_axr3 */
+			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a11.gpio1_27 */
+		>;
+	};
+
+	tlv320dac3101_default: tlv320dac3101_default {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x844, PIN_OUTPUT_PULLUP | MUX_MODE7 ) /* gpmc_a1.gpio1_17 */
+			AM33XX_IOPAD(0x878, PIN_INPUT | MUX_MODE7 ) /* gpmc_ben1.gpio1_28 */
+		>;
+	};
+};
+
+&sysclkout_pre_ck {
+	/*
+	 * Switch to a higher-speed clock as a base for clkout2_div_ck other than
+	 * the 32.768Hz default clock that is unusable for a CODEC. Possible
+	 * options are clk_32768_ck, l3_gclk, dpll_ddr_m2_ck, dpll_per_m2_ck, and
+	 * lcd_gclk. See am33xx-clocks.dtsi for more info.
+	 */
+	assigned-clocks = <&sysclkout_pre_ck>;
+	assigned-clock-parents = <&lcd_gclk>;
+};
+
+&clkout2_div_ck {
+	assigned-clocks = <&clkout2_div_ck>;
+	assigned-clock-rates = <12000000>;  /* Change this to try different CODEC MCLK speeds */
+};
+
+&mcasp0	{
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins>;
+
+	status = "okay";
+
+	op-mode = <0>; /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = < 1 0 0 0 >; /* 0: INACTIVE, 1: TX, 2: RX */
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
+&i2c2 {
+	tlv320dac3101: tlv320dac3101@18 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320dac3101";
+		reg = <0x18>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tlv320dac3101_default>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+
+		reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
+		ai31xx-micbias-vg = <MICBIAS_2_0V>;
+	};
 };
 
 &cpu0_opp_table {
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
