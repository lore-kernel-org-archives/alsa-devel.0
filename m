From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 10/10] arm64: dts: allwinner: a64: enable sound
	on Pinebook
Date: Fri, 12 Oct 2018 20:32:30 -0700
Message-ID: <20181013033230.6506-11-anarsoul@gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E659E2679C0
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 05:32:55 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so6774075plr.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 20:32:55 -0700 (PDT)
In-Reply-To: <20181013033230.6506-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This commit enables I2S, digital and analog parts of audiocodec on
Pinebook

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index e2e426334cfe..3145459722c7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -76,6 +76,19 @@
 	};
 };
 
+&codec {
+	allwinner,pa-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>;
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
 &ehci0 {
 	phys = <&usbphy 0>;
 	phy-names = "usb";
@@ -278,6 +291,26 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Speaker", "LINEOUT",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Mic", "MBIAS",
+			"MIC1", "Mic",
+			"Headset Mic", "Microphone Jack",
+			"Microphone Jack", "HBIAS",
+			"MIC2", "Headset Mic";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.19.0
