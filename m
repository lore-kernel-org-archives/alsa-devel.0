From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Rename property for reset
	GPIO" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:11 +0000
Message-ID: <E1eKO1f-0000bm-FW@debutante>
References: <20171129171359.29382-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3E15267AC9
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:33:16 +0100 (CET)
In-Reply-To: <20171129171359.29382-3-afd@ti.com>
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

   ASoC: tlv320aic3x: Rename property for reset GPIO

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

>From 943293232ca45988ba0aa693b51025c58e1189ca Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 11:13:53 -0600
Subject: [PATCH] ASoC: tlv320aic3x: Rename property for reset GPIO

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

[Rewrote title & first paragraph for clarity & accuracy -- broonie]

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index ba5b45c483f5..9796c4639262 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -17,7 +17,7 @@ Required properties:
 
 Optional properties:
 
-- gpio-reset - gpio pin number used for codec reset
+- reset-gpios - GPIO specification for the active low RESET input.
 - ai3x-gpio-func - <array of 2 int> - AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
 				    - Not supported on tlv320aic3104
 - ai3x-micbias-vg - MicBias Voltage required.
@@ -34,6 +34,10 @@ Optional properties:
 - AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies for the
   device as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
+Deprecated properties:
+
+- gpio-reset - gpio pin number used for codec reset
+
 CODEC output pins:
   * LLOUT
   * RLOUT
@@ -61,10 +65,14 @@ The pins can be used in referring sound node's audio-routing property.
 
 Example:
 
+#include <dt-bindings/gpio/gpio.h>
+
 tlv320aic3x: tlv320aic3x@1b {
 	compatible = "ti,tlv320aic3x";
 	reg = <0x1b>;
 
+	reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+
 	AVDD-supply = <&regulator>;
 	IOVDD-supply = <&regulator>;
 	DRVDD-supply = <&regulator>;
-- 
2.15.0
