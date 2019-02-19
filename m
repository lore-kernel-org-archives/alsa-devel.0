From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1977: Fix reset-gpios typo" to the
	asoc tree
Date: Tue, 19 Feb 2019 11:47:06 +0000 (GMT)
Message-ID: <20190219114706.5072811284A6@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B387265523
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 12:47:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bogdan Togorean <bogdan.togorean@analog.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau1977: Fix reset-gpios typo

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

>From d98afe1353b6dbd1527f3833da70d8525e6dbae3 Mon Sep 17 00:00:00 2001
From: Bogdan Togorean <bogdan.togorean@analog.com>
Date: Fri, 15 Feb 2019 12:26:33 +0200
Subject: [PATCH] ASoC: adau1977: Fix reset-gpios typo

This change fixes a typo in the dt-binding examples (reset_gpio ->
reset-gpios).
Even though 'reset-gpio' is a valid construct for gpiolib the naming
'reset-gpios' is more suited for dt-bindings documentation.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/adi,adau1977.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
index e79aeef73f28..11acd94b1665 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -17,7 +17,7 @@ Required properties:
                 Documentation/devicetree/bindings/regulator/regulator.txt
 
 Optional properties:
- - reset-gpio:  the reset pin for the chip, for more details consult
+ - reset-gpios: the reset pin for the chip, for more details consult
                 Documentation/devicetree/bindings/gpio/gpio.txt
 
  - DVDD-supply: supply voltage for the digital core, please consult
@@ -40,7 +40,7 @@ Examples:
 		AVDD-supply = <&regulator>;
 		DVDD-supply = <&regulator_digital>;
 
-		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
 
 	adau1977_i2c: adau1977@11 {
@@ -50,5 +50,5 @@ Examples:
 		AVDD-supply = <&regulator>;
 		DVDD-supply = <&regulator_digital>;
 
-		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
-- 
2.20.1
