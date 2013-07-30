From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v6 7/8] ARM: AT91: DTS: sam9x5ek: add sound configuration
Date: Tue, 30 Jul 2013 11:59:51 +0200
Message-ID: <1375178392-26060-8-git-send-email-richard.genoud@gmail.com>
References: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bo Shen <voice.shen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: alsa-devel@alsa-project.org

The sam9x5ek board has 2 jacks:
headphone wired on RHPOUT/LHPOUT of the wm8731
line in wired on LLINEIN/RLINEIN of the wm8731

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index f3e83f7..9afe15b 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -113,4 +113,19 @@
 			status = "okay";
 		};
 	};
+
+	sound {
+		compatible = "atmel,sam9x5-wm8731-audio";
+
+		atmel,model = "wm8731 @ AT91SAM9X5EK";
+
+		atmel,audio-routing =
+			"Headphone Jack", "RHPOUT",
+			"Headphone Jack", "LHPOUT",
+			"LLINEIN", "Line In Jack",
+			"RLINEIN", "Line In Jack";
+
+		atmel,ssc-controller = <&ssc0>;
+		atmel,audio-codec = <&wm8731>;
+	};
 };
-- 
1.7.10.4
