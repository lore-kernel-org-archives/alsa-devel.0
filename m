From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 4/5] ARM: dts: rockchip: Add shared file for audio related nodes for veyron boards
Date: Mon,  9 May 2016 12:46:34 +0200
Message-ID: <1462790795-25345-5-git-send-email-enric.balletbo@collabora.com>
References: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Set i2s block to "okay", add sound node for max98090 with gpios for
HP and Mic detect and pinctrl, and add a max98090 device and ts3a227e to
the correct i2c bus.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - None

 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi

diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
new file mode 100644
index 0000000..f045e1a
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
@@ -0,0 +1,102 @@
+/*
+ * Google Veyron (and derivatives) fragment for the  max98090 audio
+ * codec and analog headphone jack.
+ *
+ * Copyright 2016 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+
+	sound {
+		compatible = "rockchip,rockchip-audio-max98090";
+		rockchip,model = "ROCKCHIP-I2S";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&max98090>;
+		rockchip,hp-det-gpios = <&gpio6 5 GPIO_ACTIVE_HIGH>;
+		rockchip,mic-det-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		rockchip,headset-codec = <&headsetcodec>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mic_det>, <&hp_det>;
+	};
+
+	io-domains {
+		audio-supply = <&vcc18_codec>;
+	};
+};
+
+&rk808 {
+	vcc10-supply = <&vcc33_sys>;
+
+	regulators {
+		vcc18_codec: LDO_REG6 {
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-name = "vcc18_codec";
+			regulator-suspend-mem-disabled;
+		};
+	};
+};
+
+&i2c2 {
+	max98090: max98090@10 {
+		compatible = "maxim,max98090";
+		reg = <0x10>;
+		clock-names = "mclk";
+		clocks = <&cru SCLK_I2S0_OUT>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&int_codec>;
+	};
+};
+
+&i2c4 {
+	headsetcodec: ts3a227e@3b {
+		compatible = "ti,ts3a227e";
+		reg = <0x3b>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts3a227e_int_l>;
+		ti,micbias = <7>;		/* MICBIAS = 2.8V */
+	};
+};
+
+&i2s {
+	status = "okay";
+	clock-names = "i2s_hclk", "i2s_clk";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+};
+
+&pinctrl {
+	codec {
+		hp_det: hp-det {
+			rockchip,pins = <6 5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		/*
+		 * HACK: We're going to _pull down_ this _active low_ interrupt
+		 * so that it never fires.  We don't need this interrupt because
+		 * we've got a ts3a227e chip but the driver requires it.
+		 */
+		int_codec: int-codec {
+			rockchip,pins = <6 7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		mic_det: mic-det {
+			rockchip,pins = <6 11 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	headset {
+		ts3a227e_int_l: ts3a227e-int-l {
+			rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
-- 
2.1.0
