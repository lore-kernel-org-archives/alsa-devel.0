From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add devicetree binding support for rt5514-spi" to the asoc tree
Date: Tue, 19 Sep 2017 14:46:55 +0100
Message-ID: <E1duIrX-0008Kw-BX@debutante>
References: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, briannorris@chromium.org, dianders@chromium.org, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>broonie@kernel.org, mka@chromium.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add devicetree binding support for rt5514-spi

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d6604145dfccc3dd9e882dd3d6bd2545c9ff64e9 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 18 Sep 2017 19:14:34 +0800
Subject: [PATCH] ASoC: rt5514: Add devicetree binding support for rt5514-spi

Add devicetree binding support for rt5514 spi dsp codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5514.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index 929ca6756b02..4f33b0d96afe 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -1,22 +1,27 @@
 RT5514 audio CODEC
 
-This device supports I2C only.
+This device supports both I2C and SPI.
 
 Required properties:
 
 - compatible : "realtek,rt5514".
 
-- reg : The I2C address of the device.
+- reg : the I2C address of the device for I2C, the chip select
+        number for SPI.
 
 Optional properties:
 
 - clocks: The phandle of the master clock to the CODEC
 - clock-names: Should be "mclk"
 
+- interrupt-parent: The phandle for the interrupt controller.
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+	      depends on the interrupt controller.
+
 - realtek,dmic-init-delay-ms
-  Set the DMIC initial delay (ms) to wait it ready.
+  Set the DMIC initial delay (ms) to wait it ready for I2C.
 
-Pins on the device (for linking into audio routes) for RT5514:
+Pins on the device (for linking into audio routes) for I2C:
 
   * DMIC1L
   * DMIC1R
-- 
2.14.1
