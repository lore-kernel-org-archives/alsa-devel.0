From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fsl: refine DMA/FIQ dependencies
Date: Tue, 03 Jun 2014 14:11:56 +0200
Message-ID: <6452477.9e3eS6Cip1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A902610A3
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 14:12:09 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 31ee2bfd724ab ("ASoC: fsl: select SND_SOC_IMX_PCM_DMA
where needed") started selecting SND_SOC_IMX_PCM_DMA and
SND_SOC_IMX_PCM_FIQ for two drivers when building for i.MX.
This has turned out too aggressive, as FIQ is only available
for i.mx2 through i.mx5, but not i.mx6 or vybrid.

Further, two more drivers have become user-selectable in the
meantime, and they both depend on DMA for the imx platform
as well.

This changes the selection of FIQ to depend on the TZIC or
AVIC interrupt controllers that actually export the imx
specific FIQ interfaces, and adds the missing select statements
for SAI and ESAI.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3793362..52bbe9f 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -5,6 +5,7 @@ comment "Common SoC Audio options for Freescale CPUs:"
 config SND_SOC_FSL_SAI
 	tristate "Synchronous Audio Interface (SAI) module support"
 	select REGMAP_MMIO
+	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to add Synchronous Audio Interface (SAI)
@@ -15,7 +16,7 @@ config SND_SOC_FSL_SAI
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module support"
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
-	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && ARCH_MXC
+	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
 	select REGMAP_MMIO
 	help
 	  Say Y if you want to add Synchronous Serial Interface (SSI)
@@ -27,7 +28,7 @@ config SND_SOC_FSL_SPDIF
 	tristate "Sony/Philips Digital Interface module support"
 	select REGMAP_MMIO
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
-	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && ARCH_MXC
+	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
 	  support for the Freescale CPUs.
@@ -37,6 +38,7 @@ config SND_SOC_FSL_SPDIF
 config SND_SOC_FSL_ESAI
 	tristate "Enhanced Serial Audio Interface (ESAI) module support"
 	select REGMAP_MMIO
+	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	select SND_SOC_FSL_UTILS
 	help
 	  Say Y if you want to add Enhanced Synchronous Audio Interface
