From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Rename property for
	reset GPIO" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:17 +0000
Message-ID: <E1eKO1l-0000e6-GO@debutante>
References: <20171129171359.29382-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E6B2679C0
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:33:22 +0100 (CET)
In-Reply-To: <20171129171359.29382-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Rename property for reset GPIO

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f00e0030bcbf49936d265330f6e0b8c739ad90c3 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 11:13:52 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Rename property for reset GPIO

The property used to specify a GPIO intended for reset is "reset-gpios",
but this binding uses "gpio-reset".  It is not compatible with newer
methods used to fetch GPIO pins and to prevent the spread of this error
to other bindings let's rename to be more standard.

We also standardize the pin as active-low, different device trees have
marked the GPIO different ways, luckily the driver currently uses the
low-level GPIO set function which does not respect the active-low flag,
but future changes may change this. This is an active-low reset, mark
it as such.

Lastly, add an example of use for this property.

[Rewrote the title & first paragraph of the commit message for clarity
-- broonie]

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index 6fbba562eaa7..5b3c33bb99e5 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -22,7 +22,7 @@ Required properties:
 
 Optional properties:
 
-- gpio-reset - gpio pin number used for codec reset
+- reset-gpios - GPIO specification for the active low RESET input.
 - ai31xx-micbias-vg - MicBias Voltage setting
         1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
         2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
@@ -30,6 +30,10 @@ Optional properties:
 	If this node is not mentioned or if the value is unknown, then
 	micbias	is set to 2.0V.
 
+Deprecated properties:
+
+- gpio-reset - gpio pin number used for codec reset
+
 CODEC output pins:
   * HPL
   * HPR
@@ -48,6 +52,7 @@ CODEC input pins:
 The pins can be used in referring sound node's audio-routing property.
 
 Example:
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/tlv320aic31xx-micbias.h>
 
 tlv320aic31xx: tlv320aic31xx@18 {
@@ -56,6 +61,8 @@ tlv320aic31xx: tlv320aic31xx@18 {
 
 	ai31xx-micbias-vg = <MICBIAS_OFF>;
 
+	reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
 	HPVDD-supply = <&regulator>;
 	SPRVDD-supply = <&regulator>;
 	SPLVDD-supply = <&regulator>;
-- 
2.15.0
