From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fix ES8328_I2C/SPI dependencies
Date: Mon,  6 Feb 2017 13:27:11 +0100
Message-ID: <20170206122820.1659902-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id A9271266DA1
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 13:28:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/Kconfig | 12 +++++++-----
 sound/soc/fsl/Kconfig    |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 37a4a43628b4..e49e9da7f1f6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -526,15 +526,17 @@ config SND_SOC_HDMI_CODEC
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
2.9.0
