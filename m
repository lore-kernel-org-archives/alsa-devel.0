From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v9 7/8] arm64: dts: allwinner: a64: enable sound
 on Pine64 and SoPine
Date: Thu, 22 Nov 2018 18:23:24 +0800
Message-ID: <20181122102325.29495-8-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBOEH3LPQKGQE7NJLXPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20181122102325.29495-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This commit enables I2S, digital and analog parts of audiocodec on
Pine64 and SoPine boards.

Signed-off-by: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
[wens-jdAy2FN1RRM@public.gmane.org: Dropped headphone_amp; added headphone amp regulator supply]
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 27 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 26 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  4 +++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c077b6c1f458..216f2f5db5ef 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -75,6 +75,19 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	hpvcc-supply = <&reg_eldo1>;
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -259,6 +272,20 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"MIC2", "Microphone Jack";
+	status = "okay";
+};
+
 /* On Euler connector */
 &spdif {
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 53fcc9098df3..2052319b9030 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -80,6 +80,18 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -164,6 +176,20 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"MIC2", "Microphone Jack";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 6723b8695e0b..d2651f284aa0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -47,6 +47,10 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+&codec_analog {
+	hpvcc-supply = <&reg_eldo1>;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.19.1
