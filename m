From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/1] ASoC: stm32: add of dependency for stm32
	drivers
Date: Thu, 1 Feb 2018 09:54:41 +0100
Message-ID: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D8082267692
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 09:54:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add of dependency for STM32 ASoC drivers.
DFSDM of dependency is already inherited
from STM32_DFSDM_ADC dependency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 3ad881f..b5375f9 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
 config SND_SOC_STM32_SAI
 	tristate "STM32 SAI interface (Serial Audio Interface) support"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -12,6 +13,7 @@ config SND_SOC_STM32_SAI
 config SND_SOC_STM32_I2S
 	tristate "STM32 I2S interface (SPI/I2S block) support"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -21,6 +23,7 @@ config SND_SOC_STM32_I2S
 config SND_SOC_STM32_SPDIFRX
 	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
1.9.1
