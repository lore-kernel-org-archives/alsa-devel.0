From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: select IIO_BUFFER" to the asoc tree
Date: Thu, 11 Jan 2018 10:39:55 +0000
Message-ID: <E1eZaH5-0002Wz-BF@debutante>
References: <20180111103346.1358598-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111103346.1358598-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, olivier moysan <olivier.moysan@st.com>, linux-kernel@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: select IIO_BUFFER

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

>From 9cee7972bd0c69bc05d2e2f09bccd81cc439328b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Jan 2018 11:33:26 +0100
Subject: [PATCH] ASoC: stm32: select IIO_BUFFER

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.15.1
