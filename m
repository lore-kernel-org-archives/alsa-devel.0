From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v5 9/9] arm64: dts: allwinner: a64: enable
	sound on Pinebook
Date: Wed, 17 Oct 2018 00:38:13 -0700
Message-ID: <20181017073813.14127-10-anarsoul@gmail.com>
References: <20181017073813.14127-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB192675C0
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 09:38:33 +0200 (CEST)
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so12110694pgq.5
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 00:38:33 -0700 (PDT)
In-Reply-To: <20181017073813.14127-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This commit enables I2S, digital and analog parts of audiocodec on
Pinebook

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index e2e426334cfe..b426a6e2b485 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -74,6 +74,23 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
+
+	speaker_amp: speaker_amp {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>;
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
 
 &ehci0 {
@@ -278,6 +295,31 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
+				    "Microphone", "Internal Microphone Right",
+				    "Headphone", "Headphone Jack",
+				    "Speaker", "Internal Speaker";
+	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"INL", "LINEOUT",
+			"INR", "LINEOUT",
+			"Internal Speaker", "OUTL",
+			"Internal Speaker", "OUTR",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Internal Microphone Left", "MBIAS",
+			"MIC1", "Internal Microphone Left",
+			"Internal Microphone Right", "HBIAS",
+			"MIC2", "Internal Microphone Right";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.19.0
