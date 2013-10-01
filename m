From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ASoC: omap: Fix incorrect ARM dependency
Date: Tue,  1 Oct 2013 21:20:50 +0300
Message-ID: <1380651650-32131-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D95E265334
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 20:23:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Commit b0e0a4d ("ASoC: omap: Enable COMPILE_TEST build for DT platforms")
added two incorrect CONFIG_ARCH_ARM dependencies making impossible to select
audio support for Nokia RX-51. Fix this by using correct CONFIG_ARM.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
This is a fix for 3.12-rc. I.e. not for next merge window.
---
 sound/soc/omap/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index daa78a0..4a07f71 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,6 +1,6 @@
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
-	depends on (ARCH_OMAP && DMA_OMAP) || (ARCH_ARM && COMPILE_TEST)
+	depends on (ARCH_OMAP && DMA_OMAP) || (ARM && COMPILE_TEST)
 	select SND_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
@@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810
 
 config SND_OMAP_SOC_RX51
 	tristate "SoC Audio support for Nokia RX-51"
-	depends on SND_OMAP_SOC && ARCH_ARM && (MACH_NOKIA_RX51 || COMPILE_TEST)
+	depends on SND_OMAP_SOC && ARM && (MACH_NOKIA_RX51 || COMPILE_TEST)
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2
-- 
1.8.4.rc3
