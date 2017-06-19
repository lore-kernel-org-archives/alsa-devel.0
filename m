From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: change configuration flag" to the asoc tree
Date: Mon, 19 Jun 2017 17:24:04 +0100
Message-ID: <E1dMzTA-0002Rs-Ap@debutante>
References: <1497863395-14405-1-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497863395-14405-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: change configuration flag

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

>From 5561b66bd0297b029d2aba40b044ac191fcca98c Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Mon, 19 Jun 2017 11:09:55 +0200
Subject: [PATCH] ASoC: stm32: change configuration flag

Use a specific flag for SAI and I2S interfaces,
instead of common flag.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/Kconfig  | 19 ++++++++++++++++---
 sound/soc/stm/Makefile |  6 +++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index a6372de54042..23600a5dd46f 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -1,8 +1,21 @@
-menuconfig SND_SOC_STM32
-	tristate "STMicroelectronics STM32 SOC audio support"
+menu "STMicroelectronics STM32 SOC audio support"
+
+config SND_SOC_STM32_SAI
+	tristate "STM32 SAI interface (Serial Audio Interface) support"
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
-	  Say Y if you want to enable ASoC support for STM32
+	  Say Y if you want to enable SAI for STM32
+
+config SND_SOC_STM32_I2S
+	tristate "STM32 I2S interface (SPI/I2S block) support"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on SND_SOC
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select REGMAP_MMIO
+	help
+	  Say Y if you want to enable I2S for STM32
+
+endmenu
diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
index 82519313c0b4..4140c67fa47b 100644
--- a/sound/soc/stm/Makefile
+++ b/sound/soc/stm/Makefile
@@ -1,10 +1,10 @@
 # SAI
 snd-soc-stm32-sai-sub-objs := stm32_sai_sub.o
-obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai-sub.o
+obj-$(CONFIG_SND_SOC_STM32_SAI) += snd-soc-stm32-sai-sub.o
 
 snd-soc-stm32-sai-objs := stm32_sai.o
-obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai.o
+obj-$(CONFIG_SND_SOC_STM32_SAI) += snd-soc-stm32-sai.o
 
 # I2S
 snd-soc-stm32-i2s-objs := stm32_i2s.o
-obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-i2s.o
+obj-$(CONFIG_SND_SOC_STM32_I2S) += snd-soc-stm32-i2s.o
-- 
2.11.0
