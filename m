From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/20] ASoC: davinci: Kconfig/Makefile: Generic
	EVM machine driver related cleanup
Date: Thu, 14 Nov 2013 11:35:18 +0200
Message-ID: <1384421737-4467-3-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D6B7261A18
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:35:44 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have several boards using the same machine driver for audio support.
All of these machines can select a generic machine driver config option to
build the needed driver while keeping the config options used within the
driver for compile time code path selection.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig  | 20 ++++++++++----------
 sound/soc/davinci/Makefile |  8 ++------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index fb91826..be66771 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -11,11 +11,15 @@ config SND_DAVINCI_SOC_MCASP
 config SND_DAVINCI_SOC_VCIF
 	tristate
 
+config SND_DAVINCI_SOC_GENERIC_EVM
+	tristate
+	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_MCASP
+
 config SND_AM33XX_SOC_EVM
 	tristate "SoC Audio for the AM33XX chip based boards"
 	depends on SND_DAVINCI_SOC && SOC_AM33XX
-	select SND_SOC_TLV320AIC3X
-	select SND_DAVINCI_SOC_MCASP
+	select SND_DAVINCI_SOC_GENERIC_EVM
 	help
 	  Say Y or M if you want to add support for SoC audio on AM33XX
 	  boards using McASP and TLV320AIC3X codec. For example AM335X-EVM,
@@ -26,8 +30,7 @@ config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
 	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
-	select SND_DAVINCI_SOC_I2S
-	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_GENERIC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
 	  DaVinci DM6446, DM355 or DM365 EVM platforms.
@@ -54,8 +57,7 @@ endchoice
 config  SND_DM6467_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6467 EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM6467_EVM
-	select SND_DAVINCI_SOC_MCASP
-	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_GENERIC_EVM
 	select SND_SOC_SPDIF
 
 	help
@@ -64,8 +66,7 @@ config  SND_DM6467_SOC_EVM
 config  SND_DA830_SOC_EVM
 	tristate "SoC Audio support for DA830/OMAP-L137 EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA830_EVM
-	select SND_DAVINCI_SOC_MCASP
-	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_GENERIC_EVM
 
 	help
 	  Say Y if you want to add support for SoC audio on TI
@@ -74,8 +75,7 @@ config  SND_DA830_SOC_EVM
 config  SND_DA850_SOC_EVM
 	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
-	select SND_DAVINCI_SOC_MCASP
-	select SND_SOC_TLV320AIC3X
+	select SND_DAVINCI_SOC_GENERIC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
 	  DA850/OMAP-L138 EVM
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index bc81e79..744d4d9 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -9,11 +9,7 @@ obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
 obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 
-# DAVINCI Machine Support
+# Generic DAVINCI/AM33xx Machine Support
 snd-soc-evm-objs := davinci-evm.o
 
-obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
-obj-$(CONFIG_SND_AM33XX_SOC_EVM) += snd-soc-evm.o
-obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
-obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
-obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
-- 
1.8.4.2
