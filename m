From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2 4/4] dts: atmel: at91sam9g20: switch ssc compatible string
Date: Wed, 11 Jun 2014 18:14:42 +0800
Message-ID: <1402481682-9811-5-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

As the SSC integrate in at91sam9g20 support frame sync length
extension, so switch compatible string to support this feature.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - New

 arch/arm/boot/dts/at91sam9g20.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index b8e7946..dcd39fe 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -22,6 +22,10 @@
 				compatible = "atmel,at91sam9g20-i2c";
 			};
 
+			ssc0: ssc@fffbc000 {
+				compatible = "atmel,at91sam9rl-ssc";
+			};
+
 			adc0: adc@fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
-- 
1.8.5.2

