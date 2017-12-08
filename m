From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] ASoC: atmel-classd: select correct Kconfig
	symbol
Date: Fri,  8 Dec 2017 15:18:53 +0100
Message-ID: <20171208141853.3879-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 770F8267BC5
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 15:19:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SND_ATMEL_SOC_CLASSD selects SND_ATMEL_SOC_DMA but the driver itself
handles its own DMA operations and doesn't need anything from
atmel-pcm-dma.c or atmel_ssc_dai.c.

Replace SND_ATMEL_SOC_DMA by SND_SOC_GENERIC_DMAENGINE_PCM which is the
only one actually required.

This may end up in a configuration leading to a link error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
atmel_ssc_dai.c:(.text+0x79c): undefined reference to `atmel_pcm_dma_platform_register'
atmel_ssc_dai.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_register'
sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_put_audio':
atmel_ssc_dai.c:(.text+0xf24): undefined reference to `atmel_pcm_dma_platform_unregister'
atmel_ssc_dai.c:(.text+0xf24): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_unregister'

Tested on sama5d2 xplained with the following configuration
where nothing selects SND_ATMEL_SOC_DMA:

CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_ATMEL_SOC_CLASSD=y

Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e0a25b6d1862 ("ASoC: atmel-classd: add the Audio Class D Amplifier")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 4a56f3dfba51..dcee145dd179 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -64,7 +64,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
 config SND_ATMEL_SOC_CLASSD
 	tristate "Atmel ASoC driver for boards using CLASSD"
 	depends on ARCH_AT91 || COMPILE_TEST
-	select SND_ATMEL_SOC_DMA
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
 	  Say Y if you want to add support for Atmel ASoC driver for boards using
-- 
2.15.1
