From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 1/1] ASoC: stm32: change configuration flag
Date: Mon, 19 Jun 2017 11:09:55 +0200
Message-ID: <1497863395-14405-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 28FDC266851
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 11:10:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Use a specific flag for SAI and I2S interfaces,
instead of common flag.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig  | 19 ++++++++++++++++---
 sound/soc/stm/Makefile |  6 +++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index a6372de..23600a5 100644
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
index 8251931..4140c67 100644
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
1.9.1
