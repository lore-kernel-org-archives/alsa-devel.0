From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA
	where needed
Date: Tue, 29 Apr 2014 21:36:22 +0200
Message-ID: <5363504.ttXVrGSYNO@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel>
 <20140429165630.GD16981@sirena.org.uk> <8655908.M1OtjG8JKI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id EE6EC265062
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 21:36:53 +0200 (CEST)
In-Reply-To: <8655908.M1OtjG8JKI@wuerfel>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
manually, either as loadable modules or built-in. This unfortunately
leads to a link error if one or both of them are built-in, while
the imx-pcm-dma framework is a loadable module:

sound/built-in.o: In function `fsl_ssi_probe':
:(.text+0x51fb8): undefined reference to `imx_pcm_dma_init'
sound/built-in.o: In function `fsl_spdif_probe':
:(.text+0x52e20): undefined reference to `imx_pcm_dma_init'

This changes Kconfig to prevent this case by using 'select' to turn
on the imx-pcm-dma code from both drivers. For consistency, we also
turn on the imx-pcm-fiq code, which is an alternative to the dma
implementation.

Note that imx-pcm-fiq is platform dependent, so we must not enable
that unless we are building a kernel for i.MX. Note also the
"if SND_IMX_SOC != n" syntax as opposed to the normal "if SND_IMX_SOC".
This is needed to avoid turning on the options as 'm' if 'SND_IMX_SOC'
is a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index fb26345..b2a1ade 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -9,6 +9,8 @@ config SND_SOC_FSL_SAI
 
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module support"
+	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && ARCH_MXC
 	help
 	  Say Y if you want to add Synchronous Serial Interface (SSI)
 	  support for the Freescale CPUs.
@@ -18,6 +20,8 @@ config SND_SOC_FSL_SSI
 config SND_SOC_FSL_SPDIF
 	tristate "Sony/Philips Digital Interface module support"
 	select REGMAP_MMIO
+	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && ARCH_MXC
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
 	  support for the Freescale CPUs.
