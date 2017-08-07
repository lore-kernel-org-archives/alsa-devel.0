From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
Date: Mon,  7 Aug 2017 12:40:44 +0200
Message-ID: <20170807104101.3540159-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A5662669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 12:41:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

When the audio driver selects CONFIG_PXA_SSP to be a loadable
module on a platform other than PXA, and the PXA SPI driver
is built-in, we get a link error in the SPI driver:

drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_remove':
spi-pxa2xx.c:(.text+0x5f0): undefined reference to `pxa_ssp_free'
drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_probe':
spi-pxa2xx.c:(.text+0xeac): undefined reference to `pxa_ssp_request'
spi-pxa2xx.c:(.text+0x1468): undefined reference to `pxa_ssp_free'
spi-pxa2xx.c:(.text+0x15bc): undefined reference to `pxa_ssp_free'

Fixes: 73d7ee2e831f ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 484ab3c2ad67..1d392582559d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -33,7 +33,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate
-	select PXA_SSP
+	select PXA_SSP if ARCH_PXA
 
 config SND_MMP_SOC_SSPA
 	tristate
@@ -141,7 +141,6 @@ config SND_PXA910_SOC
 config SND_SOC_TTC_DKB
 	tristate "SoC Audio support for TTC DKB"
 	depends on SND_PXA910_SOC && MACH_TTC_DKB && I2C=y
-	select PXA_SSP
 	select SND_PXA_SOC_SSP
 	select SND_MMP_SOC
 	select MFD_88PM860X
-- 
2.9.0
