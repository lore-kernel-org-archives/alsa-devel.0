From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: Kconfig: Remove the deprecated
	options" to the asoc tree
Date: Tue, 18 Dec 2018 12:23:35 +0000 (GMT)
Message-ID: <20181218122335.19CAF11254FF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0626526782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 13:23:36 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: Kconfig: Remove the deprecated options

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0f4967bc21de0bb9e107f9ad3ced852daf66acd2 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 17 Dec 2018 14:21:42 +0200
Subject: [PATCH] ASoC: ti: Kconfig: Remove the deprecated options

We no longer have these options used anywhere.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig | 159 -------------------------------------------
 1 file changed, 159 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 698810c770f0..4bf3c15d4e51 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -46,14 +46,10 @@ config SND_SOC_OMAP_DMIC
 	  Say Y or M here if you want to have support for DMIC IP found in
 	  OMAP4 and OMAP5.
 
-config SND_OMAP_SOC_MCBSP
-	tristate
-
 config SND_SOC_OMAP_MCBSP
 	tristate "Multichannel Buffered Serial Port (McBSP) support"
 	depends on ARCH_OMAP || ARCH_OMAP1 || COMPILE_TEST
 	select SND_SOC_TI_SDMA_PCM
-	select SND_OMAP_SOC_MCBSP
 	help
 	  Say Y or M here if you want to have support for McBSP IP found in
 	  Texas Instruments OMAP1/2/3/4/5 SoCs.
@@ -209,160 +205,5 @@ config SND_SOC_DM365_VOICE_CODEC
 	  Say Y if you want to add support for SoC On-chip voice codec
 endchoice
 
-menu "Deprecated kconfig options:"
-
-config SND_AM33XX_SOC_EVM
-	tristate "SoC Audio for the AM33XX chip based boards"
-	depends on SOC_AM33XX && I2C
-	select SND_SOC_TLV320AIC3X
-	select SND_SOC_DAVINCI_MCASP
-	help
-	  Say Y or M if you want to add support for SoC audio on AM33XX
-	  boards using McASP and TLV320AIC3X codec. For example AM335X-EVM,
-	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
-	  setup.
-
-config SND_DAVINCI_SOC_EVM
-	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
-	depends on ARCH_DAVINCI && I2C
-	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
-	select SND_SOC_DAVINCI_EVM
-	help
-	  Say Y if you want to add support for SoC audio on TI
-	  DaVinci DM6446, DM355 or DM365 EVM platforms.
-
-choice
-	prompt "DM365 codec select"
-	depends on SND_DAVINCI_SOC_EVM
-	depends on MACH_DAVINCI_DM365_EVM
-
-config SND_DM365_AIC3X_CODEC
-	tristate "Audio Codec - AIC3101"
-	select SND_SOC_DM365_AIC3X_CODEC
-	help
-	  Say Y if you want to add support for AIC3101 audio codec
-
-config SND_DM365_VOICE_CODEC
-	tristate "Voice Codec - CQ93VC"
-	select SND_SOC_DM365_VOICE_CODEC
-	help
-	  Say Y if you want to add support for SoC On-chip voice codec
-endchoice
-
-config  SND_DM6467_SOC_EVM
-	tristate "SoC Audio support for DaVinci DM6467 EVM"
-	depends on MACH_DAVINCI_DM6467_EVM && I2C
-	select SND_SOC_DAVINCI_EVM
-
-	help
-	  Say Y if you want to add support for SoC audio on TI
-
-config  SND_DA830_SOC_EVM
-	tristate "SoC Audio support for DA830/OMAP-L137 EVM"
-	depends on MACH_DAVINCI_DA830_EVM && I2C
-	select SND_SOC_DAVINCI_EVM
-
-	help
-	  Say Y if you want to add support for SoC audio on TI
-	  DA830/OMAP-L137 EVM
-
-config  SND_DA850_SOC_EVM
-	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
-	depends on MACH_DAVINCI_DA850_EVM && I2C
-	select SND_SOC_DAVINCI_EVM
-	help
-	  Say Y if you want to add support for SoC audio on TI
-	  DA850/OMAP-L138 EVM
-
-config SND_OMAP_SOC_HDMI_AUDIO
-	tristate "HDMI audio support for OMAP4+ based SoCs"
-	select SND_SOC_OMAP_HDMI
-	help
-	  For HDMI audio to work OMAPDSS HDMI support should be
-	  enabled.
-	  The hdmi audio driver implements cpu-dai component using the
-	  callbacks provided by OMAPDSS and registers the component
-	  under DSS HDMI device. Omap-pcm is registered for platform
-	  component also under DSS HDMI device. Dummy codec is used as
-	  as codec component. The hdmi audio driver implements also
-	  the card and registers it under its own platform device.
-	  The device for the driver is registered by OMAPDSS hdmi
-	  driver.
-
-config SND_OMAP_SOC_N810
-	tristate "SoC Audio support for Nokia N810"
-	depends on MACH_NOKIA_N810 && I2C
-	select SND_SOC_NOKIA_N810
-	help
-	  Say Y if you want to add support for SoC audio on Nokia N810.
-
-config SND_OMAP_SOC_RX51
-	tristate "SoC Audio support for Nokia N900 (RX-51)"
-	depends on ARM && I2C && GPIOLIB && ARCH_OMAP3
-	select SND_SOC_NOKIA_RX51
-	help
-	  Say Y if you want to add support for SoC audio on Nokia N900
-	  cellphone.
-
-config SND_OMAP_SOC_AMS_DELTA
-	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
-	depends on MACH_AMS_DELTA && TTY
-	select SND_SOC_OMAP_AMS_DELTA
-	help
-	  Say Y  if you want to add support  for SoC audio device  connected to
-	  a handset and a speakerphone found on Amstrad E3 (Delta) videophone.
-
-	  Note that in order to get those devices fully supported,  you have to
-	  build  the kernel  with  standard  serial port  driver  included  and
-	  configured for at least 4 ports.  Then, from userspace, you must load
-	  a line discipline #19 on the modem (ttyS3) serial line.  The simplest
-	  way to achieve this is to install util-linux-ng  and use the included
-	  ldattach  utility.  This  can be  started  automatically  from  udev,
-	  a simple rule like this one should do the trick (it does for me):
-	  	ACTION=="add", KERNEL=="controlC0", \
-				RUN+="/usr/sbin/ldattach 19 /dev/ttyS3"
-
-config SND_OMAP_SOC_OSK5912
-	tristate "SoC Audio support for omap osk5912"
-	depends on MACH_OMAP_OSK && I2C
-	select SND_SOC_OMAP_OSK5912
-	help
-	  Say Y if you want to add support for SoC audio on osk5912.
-
-config SND_OMAP_SOC_OMAP_TWL4030
-	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
-	depends on TWL4030_CORE
-	select SND_SOC_OMAP3_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on TI SoC based boards
-	  using twl4030 as c codec. This driver currently supports:
-	  - Beagleboard or Devkit8000
-	  - Gumstix Overo or CompuLab CM-T35/CM-T3730
-	  - IGEP v2
-	  - OMAP3EVM
-	  - SDP3430
-	  - Zoom2
-
-config SND_OMAP_SOC_OMAP_ABE_TWL6040
-	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL6040_CORE && COMMON_CLK
-	depends on ARCH_OMAP4 || (SOC_OMAP5 && MFD_PALMAS) || COMPILE_TEST
-	select SND_SOC_OMAP_ABE_TWL6040
-	help
-	  Say Y if you want to add support for SoC audio on OMAP boards using
-	  ABE and twl6040 codec. This driver currently supports:
-	  - SDP4430/Blaze boards
-	  - PandaBoard (4430)
-	  - PandaBoardES (4460)
-	  - omap5-uevm (5432)
-
-config SND_OMAP_SOC_OMAP3_PANDORA
-	tristate "SoC Audio support for OMAP3 Pandora"
-	depends on TWL4030_CORE
-	select SND_SOC_OMAP3_PANDORA
-	help
-	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
-endmenu
-
 endmenu
 
-- 
2.19.0.rc2
