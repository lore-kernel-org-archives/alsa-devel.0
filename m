From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v6 6/8] ARM: AT91: DTS: sam9x5ek: enable SSC
Date: Tue, 30 Jul 2013 12:32:07 +0200
Message-ID: <1375180329-4860-7-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: Bo Shen <voice.shen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, patches@opensource.wolfsonmicro.com, Richard Genoud <richard.genoud@gmail.com>
List-Id: alsa-devel@alsa-project.org

Enable the SSC needed for the WM8731 codec

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index e6fb309..f3e83f7 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -95,6 +95,10 @@
 			watchdog@fffffe40 {
 				status = "okay";
 			};
+
+			ssc0: ssc@f0010000 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci@00600000 {
-- 
1.7.10.4
