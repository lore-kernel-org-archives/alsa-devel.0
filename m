From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix ES8328_I2C/SPI dependencies" to the asoc tree
Date: Sun, 19 Feb 2017 16:34:54 +0000
Message-ID: <E1cfURq-0004g4-S7@finisterre>
References: <20170206122820.1659902-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170206122820.1659902-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Romain Perier <romain.perier@collabora.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix ES8328_I2C/SPI dependencies

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

>From 245c5c7b0863eda23e8cb1907e74579a42185888 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Feb 2017 13:27:11 +0100
Subject: [PATCH] ASoC: fix ES8328_I2C/SPI dependencies

The two front-ends to the codec can now be selected individually, but fail to
build when the bus support is missing:

sound/built-in.o: In function `es8328_spi_probe':
es8328-spi.c:(.text+0x125854): undefined reference to `__devm_regmap_init_spi'
sound/built-in.o: In function `es8328_spi_driver_init':
es8328-spi.c:(.init.text+0x3589): undefined reference to `__spi_register_driver'

Related to this, the added dependency on SND_SOC_ES8328 breaks:

warning: (SND_SOC_ALL_CODECS) selects SND_SOC_ES8328_I2C which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && SND_SOC_ES8328 && I2C)

This adds the respective Kconfig dependencies and changes SND_SOC_ES8328 to a hidden
symbol that is selected implicitly by the two more specific options, as we do for
some other codecs. We have to remove the 'depends on' for SND_SOC_IMX_ES8328 in the
same step to avoid a recursive dependency.

Fixes: aa00f2c8aff7 ("ASoC: Allow to select ES8328_I2C and ES8328_SPI directly")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 12 +++++++-----
 sound/soc/fsl/Kconfig    |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cfa423338963..0426e5c53829 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -525,15 +525,17 @@ config SND_SOC_HDMI_CODEC
 	select HDMI
 
 config SND_SOC_ES8328
-	tristate "Everest Semi ES8328 CODEC"
+	tristate
 
 config SND_SOC_ES8328_I2C
-	depends on SND_SOC_ES8328
-	tristate "I2C support for Everest Semi ES8328 CODEC"
+	tristate "Everest Semi ES8328 CODEC (I2C)"
+	depends on I2C
+	select SND_SOC_ES8328
 
 config SND_SOC_ES8328_SPI
-	depends on SND_SOC_ES8328
-	tristate "SPI support for Everest Semi ES8328 CODEC"
+	tristate "Everest Semi ES8328 CODEC (SPI)"
+	depends on SPI_MASTER
+	select SND_SOC_ES8328
 
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 0b914a1ca8d2..37f9b6201918 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -244,7 +244,7 @@ config SND_SOC_IMX_WM8962
 
 config SND_SOC_IMX_ES8328
 	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
-	depends on OF && (I2C || SPI) && SND_SOC_ES8328
+	depends on OF && (I2C || SPI)
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_IMX_PCM_DMA
-- 
2.11.0
