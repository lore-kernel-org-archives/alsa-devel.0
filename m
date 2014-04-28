From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
	needed
Date: Mon, 28 Apr 2014 16:46:30 +0200
Message-ID: <6606961.lAGLvkNsEj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 1185E261600
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 16:46:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
manually. However, these two options are for drivers that both
require the imx-pcm-dma framework and result in a link error if that
is not provided.

This changes Kconfig to automatically select SND_SOC_IMX_PCM_DMA
to avoid the problem, as we do for other drivers that need the same
framework.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index fb26345..25abd21 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -9,6 +9,7 @@ config SND_SOC_FSL_SAI
 
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module support"
+	select SND_SOC_IMX_PCM_DMA
 	help
 	  Say Y if you want to add Synchronous Serial Interface (SSI)
 	  support for the Freescale CPUs.
@@ -17,6 +18,7 @@ config SND_SOC_FSL_SSI
 
 config SND_SOC_FSL_SPDIF
 	tristate "Sony/Philips Digital Interface module support"
+	select SND_SOC_IMX_PCM_DMA
 	select REGMAP_MMIO
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
