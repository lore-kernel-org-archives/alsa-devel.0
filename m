From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2 3/4] dts: atmel: at91sam9rl: switch ssc compatible string
Date: Wed, 11 Jun 2014 18:14:41 +0800
Message-ID: <1402481682-9811-4-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

As the SSC integrate in at91sam9rl support frame sync length
extension, so switch compatible string to support this feature.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - New

 arch/arm/boot/dts/at91sam9rl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 1da1831..fa32de9 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -203,7 +203,7 @@
 			};
 
 			ssc0: ssc@fffc0000 {
-				compatible = "atmel,at91rm9200-ssc";
+				compatible = "atmel,at91sam9rl-ssc";
 				reg = <0xfffc0000 0x4000>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
@@ -212,7 +212,7 @@
 			};
 
 			ssc1: ssc@fffc4000 {
-				compatible = "atmel,at91rm9200-ssc";
+				compatible = "atmel,at91sam9rl-ssc";
 				reg = <0xfffc4000 0x4000>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
-- 
1.8.5.2

