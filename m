From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH v2 1/1] ASoC: stm32: add of dependency for
	stm32 drivers
Date: Mon, 5 Feb 2018 11:49:45 +0100
Message-ID: <1517827785-6275-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C52CF266CFE
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 11:49:53 +0100 (CET)
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
 sound/soc/stm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 3ad881f..48f9ddd 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -2,7 +2,7 @@ menu "STMicroelectronics STM32 SOC audio support"
 
 config SND_SOC_STM32_SAI
 	tristate "STM32 SAI interface (Serial Audio Interface) support"
-	depends on ARCH_STM32 || COMPILE_TEST
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -11,7 +11,7 @@ config SND_SOC_STM32_SAI
 
 config SND_SOC_STM32_I2S
 	tristate "STM32 I2S interface (SPI/I2S block) support"
-	depends on ARCH_STM32 || COMPILE_TEST
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -20,7 +20,7 @@ config SND_SOC_STM32_I2S
 
 config SND_SOC_STM32_SPDIFRX
 	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
-	depends on ARCH_STM32 || COMPILE_TEST
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
1.9.1
