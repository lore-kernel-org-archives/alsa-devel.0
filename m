From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: stm32: select IIO_BUFFER
Date: Thu, 11 Jan 2018 11:33:26 +0100
Message-ID: <20180111103346.1358598-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8077D266E76
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 11:34:03 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, olivier moysan <olivier.moysan@st.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The new stm32_adfsdm driver has incomplete dependencies as shown
by Kconfig:

warning: (SND_SOC_STM32_DFSDM && LMP91000) selects IIO_BUFFER_CB which has unmet direct dependencies (IIO && IIO_BUFFER)
sound/soc/stm/stm32_adfsdm.o: In function `stm32_adfsdm_trigger':
stm32_adfsdm.c:(.text+0x8c): undefined reference to `stm32_dfsdm_get_buff_cb'
stm32_adfsdm.c:(.text+0x9c): undefined reference to `stm32_dfsdm_release_buff_cb'

This makes the dependency on SND_SOC_STM32_DFSDM unconditional, so we can
always resolve the stm32_dfsdm_get_buff_cb/stm32_dfsdm_release_buff_cb
symbols and get the implied IIO_BUFFER dependency.

compile-testing on other platforms is still possible as long as that IIO
driver is there.

Fixes: 55da094824c4 ("ASoC: stm32: add DFSDM DAI support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/stm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index a78f7700d489..3ad881fc40a1 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -30,8 +30,9 @@ config SND_SOC_STM32_SPDIFRX
 
 config SND_SOC_STM32_DFSDM
 	tristate "SoC Audio support for STM32 DFSDM"
-	depends on (ARCH_STM32 && OF && STM32_DFSDM_ADC) || COMPILE_TEST
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on SND_SOC
+	depends on STM32_DFSDM_ADC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_SOC_DMIC
 	select IIO_BUFFER_CB
-- 
2.9.0
