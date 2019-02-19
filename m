From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1977: Add MICBIAS example in DT bindings" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:20 +0000 (GMT)
Message-ID: <20190219155020.7E59C11284C0@debutante.sirena.org.uk>
References: <20190219141139.24216-2-bogdan.togorean@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219141139.24216-2-bogdan.togorean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Togorean <bogdan.togorean@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau1977: Add MICBIAS example in DT bindings

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

>From fb7a97456e324b4ac13044db17a4f5b974e49e33 Mon Sep 17 00:00:00 2001
From: Bogdan Togorean <bogdan.togorean@gmail.com>
Date: Tue, 19 Feb 2019 16:11:38 +0200
Subject: [PATCH] ASoC: adau1977: Add MICBIAS example in DT bindings

Add MICBIAS property to the optional devicetree bindings.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/adi,adau1977.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
index e79aeef73f28..87c16e6f2e7c 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -23,6 +23,12 @@ Optional properties:
  - DVDD-supply: supply voltage for the digital core, please consult
                 Documentation/devicetree/bindings/regulator/regulator.txt
 
+- adi,micbias: configures the voltage setting for the MICBIAS pin.
+		Select 0/1/2/3/4/5/6/7/8 to specify MICBIAS voltage
+		5V/5.5V/6V/6.5V/7V/7.5V/8V/8.5V/9V
+		If not specified the default value will be "7" meaning 8.5 Volts.
+		This property is only valid for the ADAU1977
+
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -40,6 +46,7 @@ Examples:
 		AVDD-supply = <&regulator>;
 		DVDD-supply = <&regulator_digital>;
 
+		adi,micbias = <3>;
 		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
 
-- 
2.20.1
