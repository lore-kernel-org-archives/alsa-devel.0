From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH] ASoC: atmel-ssc: change disable to disable in
	dts node
Date: Thu, 13 Dec 2012 10:05:07 +0800
Message-ID: <1355364307-31584-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DEF2615D1
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 03:10:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Change the value of status to disabled to keep the consistent

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi |    4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi |    4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index aaa42d8..03c56cb 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -217,7 +217,7 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffbc000 0x4000>;
 				interrupts = <14 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			adc0: adc@fffe0000 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 3b721ee..15f12dd 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -179,14 +179,14 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff98000 0x4000>;
 				interrupts = <16 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			ssc1: ssc@fff9c000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff9c000 0x4000>;
 				interrupts = <17 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			macb0: ethernet@fffbc000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index acfa207..44a38d0 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -232,14 +232,14 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfff9c000 0x4000>;
 				interrupts = <16 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			ssc1: ssc@fffa0000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfffa0000 0x4000>;
 				interrupts = <17 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			adc0: adc@fffb0000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 69667d0..0beff72 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -92,7 +92,7 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
 				interrupts = <28 4 5>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			tcb0: timer@f8008000 {
-- 
1.7.9.5
