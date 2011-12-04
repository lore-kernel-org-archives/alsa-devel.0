From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix dependency for SND_SOC_RAUMFELD and
 SND_PXA2XX_SOC_HX4700
Date: Sun, 04 Dec 2011 16:30:18 +0800
Message-ID: <1322987418.22605.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 46F8224617
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 09:30:27 +0100 (CET)
Received: by iakr3 with SMTP id r3so2541194iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 00:30:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Girdwood <lrg@ti.com>, Daniel Mack <daniel@caiaq.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_RAUMFELD selects SND_SOC_CS4270 which needs CONFIG_I2C,
and also selects SND_SOC_AK4104 which needs SPI_MASTER.
Thus make SND_SOC_RAUMFELD depend on I2C && SPI_MASTER.

Add depend on SPI_MASTER to fix below build error if CONFIG_SPI_MASTER
is not selected.

  LD      .tmp_vmlinux1
sound/built-in.o: In function `ak4104_spi_write':
last.c:(.text+0x290cc): undefined reference to `spi_sync'
sound/built-in.o: In function `ak4104_probe':
last.c:(.text+0x292a0): undefined reference to `spi_write_then_read'
sound/built-in.o: In function `ak4104_spi_probe':
last.c:(.text+0x29398): undefined reference to `spi_setup'
sound/built-in.o: In function `ak4104_init':
last.c:(.init.text+0x4ec): undefined reference to `spi_register_driver'
make: *** [.tmp_vmlinux1] Error 1

Add depend on I2C to fix below build error if CONFIG_I2C is not selected:
  CC      sound/soc/codecs/cs4270.o
sound/soc/codecs/cs4270.c: In function 'cs4270_i2c_probe':
sound/soc/codecs/cs4270.c:657: error: implicit declaration of function 'i2c_smbus_read_byte_data'
sound/soc/codecs/cs4270.c: In function 'cs4270_init':
sound/soc/codecs/cs4270.c:730: error: implicit declaration of function 'i2c_add_driver'
sound/soc/codecs/cs4270.c: In function 'cs4270_exit':
sound/soc/codecs/cs4270.c:736: error: implicit declaration of function 'i2c_del_driver'
make[3]: *** [sound/soc/codecs/cs4270.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

SND_PXA2XX_SOC_HX4700 selects SND_SOC_AK4641 which needs CONFIG_I2C.
Thus make SND_PXA2XX_SOC_HX4700 depend on I2C.

Add depend on I2C to fix below build error if CONFIG_I2C is not selected:
  CC      sound/soc/codecs/ak4641.o
sound/soc/codecs/ak4641.c: In function 'ak4641_modinit':
sound/soc/codecs/ak4641.c:646: error: implicit declaration of function 'i2c_add_driver'
sound/soc/codecs/ak4641.c: In function 'ak4641_exit':
sound/soc/codecs/ak4641.c:656: error: implicit declaration of function 'i2c_del_driver'
make[3]: *** [sound/soc/codecs/ak4641.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index ffd2242..a0f7d3c 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -151,6 +151,7 @@ config SND_SOC_ZYLONITE
 config SND_SOC_RAUMFELD
 	tristate "SoC Audio support Raumfeld audio adapter"
 	depends on SND_PXA2XX_SOC && (MACH_RAUMFELD_SPEAKER || MACH_RAUMFELD_CONNECTOR)
+	depends on I2C && SPI_MASTER
 	select SND_PXA_SOC_SSP
 	select SND_SOC_CS4270
 	select SND_SOC_AK4104
@@ -159,7 +160,7 @@ config SND_SOC_RAUMFELD
 
 config SND_PXA2XX_SOC_HX4700
 	tristate "SoC Audio support for HP iPAQ hx4700"
-	depends on SND_PXA2XX_SOC && MACH_H4700
+	depends on SND_PXA2XX_SOC && MACH_H4700 && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_AK4641
 	help
-- 
1.7.5.4
