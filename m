From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/15] ASoC: fsl: fiq and dma cannot both be
	modules
Date: Mon, 21 Jan 2013 17:15:58 +0000
Message-ID: <1358788568-11137-6-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by alsa0.perex.cz (Postfix) with ESMTP id DDA5B2616C5
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 18:17:06 +0100 (CET)
In-Reply-To: <1358788568-11137-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, arm@kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The dma and fiq portions of the imx-pcm driver both
have a module_init() call, of which there can be only
one in any given module. This changes Kconfig to enforce
either the driver to be built-in in the kernel, or
to have only one of the two when building imx-pcm as
a module.

Without this patch, we cannot build the ARM 'allmodconfig', or
we get this error:

sound/soc/fsl/imx-pcm-dma.o: In function `init_module':
sound/soc/fsl/imx-pcm-dma.c:177: multiple definition of `init_module'
sound/soc/fsl/imx-pcm-fiq.o:sound/soc/fsl/imx-pcm-fiq.c:334: first defined here
sound/soc/fsl/imx-pcm-dma.o: In function `cleanup_module':
sound/soc/fsl/imx-pcm-dma.c:177: multiple definition of `cleanup_module'
sound/soc/fsl/imx-pcm-fiq.o:sound/soc/fsl/imx-pcm-fiq.c:334: first defined here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/fsl/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3b98159..282b08e 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -127,6 +127,7 @@ config SND_SOC_IMX_AUDMUX
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1
+	depends on !SND_SOC_IMX_PCM_DMA || SND_IMX_SOC=y
 	select SND_SOC_WM8350
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
@@ -149,6 +150,7 @@ config SND_SOC_MX27VIS_AIC32X4
 config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
+	depends on !SND_SOC_IMX_PCM_DMA || SND_IMX_SOC=y
 	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
@@ -165,6 +167,7 @@ config SND_SOC_EUKREA_TLV320
 		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
 	depends on I2C
+	depends on !SND_SOC_IMX_PCM_DMA || SND_IMX_SOC=y
 	select SND_SOC_TLV320AIC23
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
-- 
1.7.10.4
