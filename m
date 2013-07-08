From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v2 3/5] ARM: AT91: DTS: sam9x5ek: add WM8731 codec
Date: Mon,  8 Jul 2013 15:29:51 +0200
Message-ID: <1373290193-25300-4-git-send-email-richard.genoud@gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: alsa-devel@alsa-project.org

The WM8731 codec on sam9x5ek board is on i2c, address 1A

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index d107241..e6fb309 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -59,6 +59,11 @@
 
 			i2c0: i2c@f8010000 {
 				status = "okay";
+
+				wm8731: wm8731@1a {
+					compatible = "wm8731";
+					reg = <0x1a>;
+				};
 			};
 
 			pinctrl@fffff400 {
-- 
1.7.10.4
