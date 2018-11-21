From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 6/7] arm64: dts: allwinner: a64: enable
	sound on Pine64 and SoPine
Date: Tue, 20 Nov 2018 21:17:51 -0800
Message-ID: <20181121051752.18387-7-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BAFA267947
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:19:17 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id t13so3699976ply.13
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:19:17 -0800 (PST)
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This commit enables I2S, digital and analog parts of audiocodec on
Pine64 and SoPine boards.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 35 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 35 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c077b6c1f458..30d0743d0d79 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -73,6 +73,24 @@
 			};
 		};
 	};
+
+	headphone_amp: headphone_amp {
+		compatible = "simple-audio-amplifier";
+		VCC-supply = <&reg_eldo1>;
+		sound-name-prefix = "HP";
+	};
+};
+
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
 };
 
 &de {
@@ -259,6 +277,23 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>, <&headphone_amp>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"HP INL", "HP",
+			"HP INR", "HP",
+			"Headphone Jack", "HP OUTL",
+			"Headphone Jack", "HP OUTR",
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
index 53fcc9098df3..81d85ad127a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -72,6 +72,12 @@
 		};
 	};
 
+	headphone_amp: headphone_amp {
+		compatible = "simple-audio-amplifier";
+		VCC-supply = <&reg_eldo1>;
+		sound-name-prefix = "HP";
+	};
+
 	reg_vcc1v8: vcc1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8";
@@ -80,6 +86,18 @@
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
@@ -164,6 +182,23 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>, <&headphone_amp>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"HP INL", "HP",
+			"HP INR", "HP",
+			"Headphone Jack", "HP OUTL",
+			"Headphone Jack", "HP OUTR",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"MIC2", "Microphone Jack";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.19.1
