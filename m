From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH v4 6/8] ARM: dts: sun8i: Add audio codec, dai and card for A33
Date: Thu,  2 Feb 2017 10:24:20 +0100
Message-ID: <20170202092422.5588-7-mylene.josserand@free-electrons.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, mylene.josserand@free-electrons.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

Add the audio codec, dai and a simple card to be able to use the
audio stream of the builtin codec on sun8i SoC.

This commit adds also an audio-routing for the sound card node to link
the analog DAPM widgets (Right/Left DAC) and the digital one's as they
are created in different drivers.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index fd1e1cddd4a8..4e34ec6613a0 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -69,6 +69,28 @@
 		reg = <0x40000000 0x80000000>;
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun8i-a33-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&link_codec>;
+		simple-audio-card,bitclock-master = <&link_codec>;
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,aux-devs = <&codec_analog>;
+		simple-audio-card,routing =
+			"Left DAC", "Digital Left DAC",
+			"Right DAC", "Digital Right DAC";
+		status = "disabled";
+
+		simple-audio-card,cpu {
+			sound-dai = <&dai>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+
 	soc@01c00000 {
 		tcon0: lcd-controller@01c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
@@ -116,6 +138,29 @@
 			reset-names = "ahb";
 		};
 
+		dai: dai@01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun6i-a31-i2s";
+			reg = <0x01c22c00 0x200>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		codec: codec@01c22e00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a33-codec";
+			reg = <0x01c22e00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "bus", "mod";
+			status = "disabled";
+		};
+
 		fe0: display-frontend@01e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
-- 
2.11.0
