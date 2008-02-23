From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] ALSA: update the Kconfig files to be easier to
	use
Date: Sat, 23 Feb 2008 01:06:46 -0400
Message-ID: <a60a39d8e6feb80702ce.1203746806@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 0653C103830
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 07:04:50 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so702662wag.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 22:04:49 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This update to the Kconfig files allows the ability to select/deselect
entire submenus, starting with the root "Sound device support" on the main
kernel configuration page. Inside sound support, ALSA/OSS can be easily
enabled/disabled. Inside ALSA, entire classes of devices can be easily
enabled/disabled at the ALSA menu (e.g. ISA, PCI, USB devices) without
having to manually disable individual cards within the submenus.
Modified menus: main, isa, pci, pcmcia, soc, spi, usb

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r 39df17389b57 -r a60a39d8e6fe Kconfig
--- a/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,11 +1,9 @@
 # sound/Config.in
 #
 
-menu "Sound"
+menuconfig SOUND
+	tristate "Sound device support"
 	depends on HAS_IOMEM
-
-config SOUND
-	tristate "Sound card support"
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.  Be sure to have all the information
@@ -33,21 +31,22 @@ config SOUND
 	  Kernel patches and supporting utilities to do that are in the pcsp
 	  package, available at <ftp://ftp.infradead.org/pub/pcsp/>.
 
+if SOUND
+
 source "sound/oss/dmasound/Kconfig"
 
 if !M68K
 
-menu "Advanced Linux Sound Architecture"
-	depends on SOUND!=n
-
-config SND
-	tristate "Advanced Linux Sound Architecture"
-	depends on SOUND
-	help
+menuconfig SND
+        tristate "Advanced Linux Sound Architecture"
+        depends on SOUND!=n
+        help
 	  Say 'Y' or 'M' to enable ALSA (Advanced Linux Sound Architecture),
 	  the new base sound system.
 
 	  For more information, see <http://www.alsa-project.org/>
+
+if SND
 
 source "sound/core/Kconfig"
 
@@ -63,9 +62,7 @@ source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
 
-if SPI
 source "sound/spi/Kconfig"
-endif
 
 source "sound/mips/Kconfig"
 
@@ -85,22 +82,21 @@ source "sound/parisc/Kconfig"
 
 source "sound/soc/Kconfig"
 
-endmenu
+endif # SND
 
-menu "Open Sound System"
+menuconfig SOUND_PRIME
+        tristate "Open Sound System (DEPRECATED)"
 	depends on SOUND!=n
-
-config SOUND_PRIME
-	tristate "Open Sound System (DEPRECATED)"
-	depends on SOUND
 	help
 	  Say 'Y' or 'M' to enable Open Sound System drivers.
 
+if SOUND_PRIME
+
 source "sound/oss/Kconfig"
 
-endmenu
+endif # SOUND_PRIME
 
-endif
+endif # !M68K
 
 config AC97_BUS
 	tristate
@@ -110,4 +106,4 @@ config AC97_BUS
 	  sound although they're sharing the AC97 bus. Concerned drivers
 	  should "select" this.
 
-endmenu
+endif # SOUND
diff -r 39df17389b57 -r a60a39d8e6fe isa/Kconfig
--- a/isa/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/isa/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,4 +1,13 @@
 # ALSA ISA drivers
+
+menuconfig SND_ISA
+        bool "ISA devices"
+	depends on SND!=n && ISA && ISA_DMA_API
+        default y
+        help
+          Support for sound devices connected via the ISA bus.
+
+if SND_ISA
 
 config SND_AD1848_LIB
         tristate
@@ -21,14 +30,10 @@ config SND_SB16_DSP
         select SND_PCM
         select SND_SB_COMMON
 
-menu "ISA devices"
-	depends on SND!=n && ISA && ISA_DMA_API
-
 config SND_ADLIB
 	tristate "AdLib FM card"
-	depends on SND
-	select SND_OPL3_LIB
-	help
+	select SND_OPL3_LIB
+	---help---
 	  Say Y here to include support for AdLib FM cards.
 
 	  To compile this driver as a module, choose M here: the module
@@ -36,12 +41,12 @@ config SND_ADLIB
 
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
-	depends on SND && PNP && ISA
-	select ISAPNP
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_PCM
-	help
+	depends on PNP
+	select ISAPNP
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	---help---
 	  Say Y here to include support for Analog Devices SoundPort
 	  AD1816A or compatible sound chips.
 
@@ -50,9 +55,8 @@ config SND_AD1816A
 
 config SND_AD1848
 	tristate "Generic AD1848/CS4248 driver"
-	depends on SND
-	select SND_AD1848_LIB
-	help
+	select SND_AD1848_LIB
+	---help---
 	  Say Y here to include support for AD1848 (Analog Devices) or
 	  CS4248 (Cirrus Logic - Crystal Semiconductors) chips.
 	  
@@ -64,12 +68,12 @@ config SND_AD1848
 
 config SND_ALS100
 	tristate "Avance Logic ALS100/ALS120"
-	depends on SND && PNP && ISA
-	select ISAPNP
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_SB16_DSP
-	help
+	depends on PNP
+	select ISAPNP
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_SB16_DSP
+	---help---
 	  Say Y here to include support for soundcards based on Avance
 	  Logic ALS100, ALS110, ALS120 and ALS200 chips.
 
@@ -78,12 +82,12 @@ config SND_ALS100
 
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
-	depends on SND && PNP && ISA
-	select ISAPNP
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_CS4231_LIB
-	help
+	depends on PNP
+	select ISAPNP
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_CS4231_LIB
+	---help---
 	  Say Y here to include support for soundcards based on the
 	  Aztech Systems AZT2320 chip.
 
@@ -92,10 +96,9 @@ config SND_AZT2320
 
 config SND_CMI8330
 	tristate "C-Media CMI8330"
-	depends on SND
-	select SND_AD1848_LIB
-	select SND_SB16_DSP
-	help
+	select SND_AD1848_LIB
+	select SND_SB16_DSP
+	---help---
 	  Say Y here to include support for soundcards based on the
 	  C-Media CMI8330 chip.
 
@@ -104,10 +107,9 @@ config SND_CMI8330
 
 config SND_CS4231
 	tristate "Generic Cirrus Logic CS4231 driver"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_CS4231_LIB
-	help
+	select SND_MPU401_UART
+	select SND_CS4231_LIB
+	---help---
 	  Say Y here to include support for CS4231 chips from Cirrus
 	  Logic - Crystal Semiconductors.
 
@@ -116,11 +118,10 @@ config SND_CS4231
 
 config SND_CS4232
 	tristate "Generic Cirrus Logic CS4232 driver"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_CS4231_LIB
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_CS4231_LIB
+	---help---
 	  Say Y here to include support for CS4232 chips from Cirrus
 	  Logic - Crystal Semiconductors.
 
@@ -129,11 +130,10 @@ config SND_CS4232
 
 config SND_CS4236
 	tristate "Generic Cirrus Logic CS4236+ driver"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_CS4231_LIB
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_CS4231_LIB
+	---help---
 	  Say Y to include support for CS4235,CS4236,CS4237B,CS4238B,
 	  CS4239 chips from Cirrus Logic - Crystal Semiconductors.
 
@@ -142,12 +142,12 @@ config SND_CS4236
 
 config SND_DT019X
 	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
-	depends on SND && PNP && ISA
-	select ISAPNP
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_SB16_DSP
-	help
+	depends on PNP
+	select ISAPNP
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_SB16_DSP
+	---help---
 	  Say Y here to include support for soundcards based on the
 	  Diamond Technologies DT-019X or Avance Logic ALS-007 chips.
 
@@ -156,11 +156,11 @@ config SND_DT019X
 
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
-	depends on SND && PNP && ISA
+	depends on PNP
 	select ISAPNP
 	select SND_MPU401_UART
 	select SND_SB8_DSP
-	help
+	---help---
 	  Say Y here to include support for ESS AudioDrive ES968 chips.
 
 	  To compile this driver as a module, choose M here: the module
@@ -168,11 +168,10 @@ config SND_ES968
 
 config SND_ES1688
 	tristate "Generic ESS ES688/ES1688 driver"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_PCM
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	---help---
 	  Say Y here to include support for ESS AudioDrive ES688 or
 	  ES1688 chips.
 
@@ -181,11 +180,10 @@ config SND_ES1688
 
 config SND_ES18XX
 	tristate "Generic ESS ES18xx driver"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_PCM
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	---help---
 	  Say Y here to include support for ESS AudioDrive ES18xx chips.
 
 	  To compile this driver as a module, choose M here: the module
@@ -193,11 +191,11 @@ config SND_ES18XX
 
 config SND_SC6000
 	tristate "Gallant SC-6000, Audio Excel DSP 16"
-	depends on SND && HAS_IOPORT
-	select SND_AD1848_LIB
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	help
+	depends on HAS_IOPORT
+	select SND_AD1848_LIB
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	---help---
 	  Say Y here to include support for Gallant SC-6000 card and clones:
 	  Audio Excel DSP 16 and Zoltrix AV302.
 
@@ -209,11 +207,10 @@ config SND_GUS_SYNTH
 
 config SND_GUSCLASSIC
 	tristate "Gravis UltraSound Classic"
-	depends on SND
-	select SND_RAWMIDI
-	select SND_PCM
-	select SND_GUS_SYNTH
-	help
+	select SND_RAWMIDI
+	select SND_PCM
+	select SND_GUS_SYNTH
+	---help---
 	  Say Y here to include support for Gravis UltraSound Classic
 	  soundcards.
 
@@ -222,12 +219,11 @@ config SND_GUSCLASSIC
 
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
-	depends on SND
 	select SND_HWDEP
 	select SND_MPU401_UART
 	select SND_PCM
 	select SND_GUS_SYNTH
-	help
+	---help---
 	  Say Y here to include support for Gravis UltraSound Extreme
 	  soundcards.
 
@@ -236,11 +232,10 @@ config SND_GUSEXTREME
 
 config SND_GUSMAX
 	tristate "Gravis UltraSound MAX"
-	depends on SND
-	select SND_RAWMIDI
-	select SND_CS4231_LIB
-	select SND_GUS_SYNTH
-	help
+	select SND_RAWMIDI
+	select SND_CS4231_LIB
+	select SND_GUS_SYNTH
+	---help---
 	  Say Y here to include support for Gravis UltraSound MAX
 	  soundcards.
 
@@ -249,11 +244,11 @@ config SND_GUSMAX
 
 config SND_INTERWAVE
 	tristate "AMD InterWave, Gravis UltraSound PnP"
-	depends on SND && PNP && ISA
-	select SND_RAWMIDI
-	select SND_CS4231_LIB
-	select SND_GUS_SYNTH
-	help
+	depends on PNP
+	select SND_RAWMIDI
+	select SND_CS4231_LIB
+	select SND_GUS_SYNTH
+	---help---
 	  Say Y here to include support for AMD InterWave based
 	  soundcards (Gravis UltraSound Plug & Play, STB SoundRage32,
 	  MED3210, Dynasonic Pro, Panasonic PCA761AW).
@@ -263,11 +258,11 @@ config SND_INTERWAVE
 
 config SND_INTERWAVE_STB
 	tristate "AMD InterWave + TEA6330T (UltraSound 32-Pro)"
-	depends on SND && PNP && ISA
-	select SND_RAWMIDI
-	select SND_CS4231_LIB
-	select SND_GUS_SYNTH
-	help
+	depends on PNP
+	select SND_RAWMIDI
+	select SND_CS4231_LIB
+	select SND_GUS_SYNTH
+	---help---
 	  Say Y here to include support for AMD InterWave based
 	  soundcards with a TEA6330T bass and treble regulator
 	  (UltraSound 32-Pro).
@@ -277,11 +272,10 @@ config SND_INTERWAVE_STB
 
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_CS4231_LIB
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_CS4231_LIB
+	---help---
 	  Say Y here to include support for Yamaha OPL3-SA2 and OPL3-SA3
 	  chips.
 
@@ -290,12 +284,11 @@ config SND_OPL3SA2
 
 config SND_OPTI92X_AD1848
 	tristate "OPTi 82C92x - AD1848"
-	depends on SND
 	select SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
 	select SND_AD1848_LIB
-	help
+	---help---
 	  Say Y here to include support for soundcards based on Opti
 	  82C92x or OTI-601 chips and using an AD1848 codec.
 
@@ -304,12 +297,11 @@ config SND_OPTI92X_AD1848
 
 config SND_OPTI92X_CS4231
 	tristate "OPTi 82C92x - CS4231"
-	depends on SND
 	select SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
 	select SND_CS4231_LIB
-	help
+	---help---
 	  Say Y here to include support for soundcards based on Opti
 	  82C92x chips and using a CS4231 codec.
 
@@ -318,11 +310,10 @@ config SND_OPTI92X_CS4231
 
 config SND_OPTI93X
 	tristate "OPTi 82C93x"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_PCM
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	---help---
 	  Say Y here to include support for soundcards based on Opti
 	  82C93x chips.
 
@@ -331,12 +322,11 @@ config SND_OPTI93X
 
 config SND_MIRO
 	tristate "Miro miroSOUND PCM1pro/PCM12/PCM20radio driver"
-	depends on SND
 	select SND_OPL4_LIB
 	select SND_CS4231_LIB
 	select SND_MPU401_UART
 	select SND_PCM
-	help
+	---help---
 	  Say 'Y' or 'M' to include support for Miro miroSOUND PCM1 pro, 
 	  miroSOUND PCM12 and miroSOUND PCM20 Radio soundcards.
 
@@ -345,11 +335,10 @@ config SND_MIRO
 
 config SND_SB8
 	tristate "Sound Blaster 1.0/2.0/Pro (8-bit)"
-	depends on SND
 	select SND_OPL3_LIB
 	select SND_RAWMIDI
 	select SND_SB8_DSP
-	help
+	---help---
 	  Say Y here to include support for Creative Sound Blaster 1.0/
 	  2.0/Pro (8-bit) or 100% compatible soundcards.
 
@@ -358,11 +347,10 @@ config SND_SB8
 
 config SND_SB16
 	tristate "Sound Blaster 16 (PnP)"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_SB16_DSP
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_SB16_DSP
+	---help---
 	  Say Y here to include support for Sound Blaster 16 soundcards
 	  (including the Plug and Play version).
 
@@ -371,11 +359,10 @@ config SND_SB16
 
 config SND_SBAWE
 	tristate "Sound Blaster AWE (32,64) (PnP)"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_SB16_DSP
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_SB16_DSP
+	---help---
 	  Say Y here to include support for Sound Blaster AWE soundcards
 	  (including the Plug and Play version).
 
@@ -386,7 +373,7 @@ config SND_SB16_CSP
 	bool "Sound Blaster 16/AWE CSP support"
 	depends on (SND_SB16 || SND_SBAWE) && (BROKEN || !PPC)
 	select FW_LOADER if !SND_SB16_CSP_FIRMWARE_IN_KERNEL
-	help
+	---help---
 	  Say Y here to include support for the CSP core.  This special
 	  coprocessor can do variable tasks like various compression and
 	  decompression algorithms.
@@ -395,16 +382,15 @@ config SND_SB16_CSP_FIRMWARE_IN_KERNEL
 	bool "In-kernel firmware for SB16 CSP"
 	depends on SND_SB16_CSP
 	default y
-	help
+	---help---
 	  Say Y here to include the static firmware built in the kernel
 	  for the SB16 CSP controller.  If you choose N here, you need
 	  to install the firmware files from the alsa-firmware package.
 
 config SND_SGALAXY
 	tristate "Aztech Sound Galaxy"
-	depends on SND
-	select SND_AD1848_LIB
-	help
+	select SND_AD1848_LIB
+	---help---
 	  Say Y here to include support for Aztech Sound Galaxy
 	  soundcards.
 
@@ -413,11 +399,10 @@ config SND_SGALAXY
 
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape PnP driver"
-	depends on SND
 	select SND_HWDEP
 	select SND_MPU401_UART
 	select SND_CS4231_LIB
-	help
+	---help---
 	  Say Y here to include support for Ensoniq SoundScape PnP
 	  soundcards.
 
@@ -426,12 +411,11 @@ config SND_SSCAPE
 
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
-	depends on SND
 	select FW_LOADER
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_CS4231_LIB
-	help
+	---help---
 	  Say Y here to include support for Turtle Beach Maui, Tropez
 	  and Tropez+ soundcards based on the Wavefront chip.
 
@@ -442,10 +426,10 @@ config SND_WAVEFRONT_FIRMWARE_IN_KERNEL
 	bool "In-kernel firmware for Wavefront"
 	depends on SND_WAVEFRONT
 	default y
-	help
+	---help---
 	  Say Y here to include the static firmware for FX DSP built in
 	  the kernel for the Wavefront driver.  If you choose N here,
 	  you need to install the firmware files from the
 	  alsa-firmware package.
 
-endmenu
+endif # SND_ISA
diff -r 39df17389b57 -r a60a39d8e6fe pci/Kconfig
--- a/pci/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/pci/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,13 +1,18 @@
 # ALSA PCI drivers
 
-menu "PCI devices"
-	depends on SND!=n && PCI
+menuconfig SND_PCI
+        bool "PCI devices"
+        depends on SND!=n && PCI
+        default y
+        help
+          Support for sound devices connected via the PCI bus.
+
+if SND_PCI
 
 config SND_AD1889
 	tristate "Analog Devices AD1889"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated AC97 sound
 	  device found in particular on the Hewlett-Packard [BCJ]-xxx0
 	  class PA-RISC workstations, using the AD1819 codec.
@@ -17,11 +22,10 @@ config SND_AD1889
 
 config SND_ALS300
 	tristate "Avance Logic ALS300/ALS300+"
-	depends on SND
-	select SND_PCM
-	select SND_AC97_CODEC
-	select SND_OPL3_LIB
-	help
+	select SND_PCM
+	select SND_AC97_CODEC
+	select SND_OPL3_LIB
+	---help---
 	  Say 'Y' or 'M' to include support for Avance Logic ALS300/ALS300+
 
 	  To compile this driver as a module, choose M here: the module
@@ -29,12 +33,12 @@ config SND_ALS300
 
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
-	depends on SND && ISA_DMA_API
+	depends on ISA_DMA_API
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	select SND_SB_COMMON
-	help
+	---help---
 	  Say Y here to include support for soundcards based on Avance Logic
 	  ALS4000 chips.
 
@@ -43,10 +47,9 @@ config SND_ALS4000
 
 config SND_ALI5451
 	tristate "ALi M5451 PCI Audio Controller"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated AC97 sound
 	  device on motherboards using the ALi M5451 Audio Controller
 	  (M1535/M1535D/M1535+/M1535D+ south bridges).  Newer chipsets
@@ -57,9 +60,8 @@ config SND_ALI5451
 
 config SND_ATIIXP
 	tristate "ATI IXP AC97 Controller"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated AC97 sound
 	  device on motherboards with ATI chipsets (ATI IXP 150/200/250/
 	  300/400).
@@ -69,9 +71,8 @@ config SND_ATIIXP
 
 config SND_ATIIXP_MODEM
 	tristate "ATI IXP Modem"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated MC97 modem on
 	  motherboards with ATI chipsets (ATI IXP 150/200/250).
 
@@ -80,10 +81,9 @@ config SND_ATIIXP_MODEM
 
 config SND_AU8810
 	tristate "Aureal Advantage"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for Aureal Advantage soundcards.
 
 	  Supported features: Hardware Mixer, SRC, EQ and SPDIF output.
@@ -95,10 +95,9 @@ config SND_AU8810
 
 config SND_AU8820
 	tristate "Aureal Vortex"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for Aureal Vortex soundcards.
 
 	  Supported features: Hardware Mixer and SRC. For more info, email
@@ -109,10 +108,9 @@ config SND_AU8820
 
 config SND_AU8830
 	tristate "Aureal Vortex 2"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for Aureal Vortex 2 soundcards.
 
 	  Supported features: Hardware Mixer, SRC, EQ and SPDIF output.
@@ -124,8 +122,7 @@ config SND_AU8830
 
 config SND_AW2
 	tristate "Emagic Audiowerk 2"
-	depends on SND
-	help
+	---help---
 	  Say Y here to include support for Emagic Audiowerk 2 soundcards.
 
 	  Supported features: Analog and SPDIF output. Analog or SPDIF input.
@@ -139,11 +136,11 @@ config SND_AW2
 
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168 (EXPERIMENTAL)"
-	depends on SND && EXPERIMENTAL
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_PCM
-	help
+	depends on EXPERIMENTAL
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	---help---
 	  Say Y here to include support for Aztech AZF3328 (PCI168)
 	  soundcards.
 
@@ -152,9 +149,8 @@ config SND_AZT3328
 
 config SND_BT87X
 	tristate "Bt87x Audio Capture"
-	depends on SND
-	select SND_PCM
-	help
+	select SND_PCM
+	---help---
 	  If you want to record audio from TV cards based on
 	  Brooktree Bt878/Bt879 chips, say Y here and read
 	  <file:Documentation/sound/alsa/Bt87x.txt>.
@@ -165,7 +161,7 @@ config SND_BT87X_OVERCLOCK
 config SND_BT87X_OVERCLOCK
 	bool "Bt87x Audio overclocking"
 	depends on SND_BT87X
-	help
+	---help---
 	  Say Y here if 448000 Hz isn't enough for you and you want to
 	  record from the analog input with up to 1792000 Hz.
 
@@ -174,11 +170,10 @@ config SND_BT87X_OVERCLOCK
 
 config SND_CA0106
 	tristate "SB Audigy LS / Live 24bit"
-	depends on SND
 	select SND_AC97_CODEC
 	select SND_RAWMIDI
 	select SND_VMASTER
-	help
+	---help---
 	  Say Y here to include support for the Sound Blaster Audigy LS
 	  and Live 24bit.
 
@@ -187,11 +182,10 @@ config SND_CA0106
 
 config SND_CMIPCI
 	tristate "C-Media 8338, 8738, 8768, 8770"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_PCM
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_PCM
+	---help---
 	  If you want to use soundcards based on C-Media CMI8338, CMI8738,
 	  CMI8768 or CMI8770 chips, say Y here and read
 	  <file:Documentation/sound/alsa/CMIPCI.txt>.
@@ -201,15 +195,13 @@ config SND_CMIPCI
 
 config SND_OXYGEN_LIB
         tristate
-	depends on SND
 	select SND_PCM
 	select SND_MPU401_UART
 
 config SND_OXYGEN
 	tristate "C-Media 8788 (Oxygen)"
-	depends on SND
 	select SND_OXYGEN_LIB
-	help
+	---help---
 	  Say Y here to include support for sound cards based on the
 	  C-Media CMI8788 (Oxygen HD Audio) chip:
 	   * Asound A-8788
@@ -225,11 +217,10 @@ config SND_OXYGEN
 
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_RAWMIDI
-	select SND_AC97_CODEC
-	help
+	select SND_OPL3_LIB
+	select SND_RAWMIDI
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for Cirrus Logic CS4281 chips.
 
 	  To compile this driver as a module, choose M here: the module
@@ -237,10 +228,9 @@ config SND_CS4281
 
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
-	depends on SND
-	select SND_RAWMIDI
-	select SND_AC97_CODEC
-	help
+	select SND_RAWMIDI
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for Cirrus Logic CS4610/CS4612/
 	  CS4614/CS4615/CS4622/CS4624/CS4630/CS4280 chips.
 
@@ -251,16 +241,16 @@ config SND_CS46XX_NEW_DSP
 	bool "Cirrus Logic (Sound Fusion) New DSP support"
 	depends on SND_CS46XX
 	default y
-	help
+	---help---
 	  Say Y here to use a new DSP image for SPDIF and dual codecs.
 
 	  This works better than the old code, so say Y.
 
 config SND_CS5530
 	tristate "CS5530 Audio"
-	depends on SND && ISA_DMA_API
+	depends on ISA_DMA_API
 	select SND_SB16_DSP
-	help
+	---help---
 	  Say Y here to include support for audio on Cyrix/NatSemi CS5530 chips.
 
 	  To compile this driver as a module, choose M here: the module
@@ -268,10 +258,10 @@ config SND_CS5530
 
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
-	depends on SND && X86 && !X86_64
-	select SND_PCM
-	select SND_AC97_CODEC
-	help
+	depends on X86 && !X86_64
+	select SND_PCM
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for audio on CS5535 chips. It is
 	  referred to as NS CS5535 IO or AMD CS5535 IO companion in
 	  various literature. This driver also supports the CS5536 audio
@@ -286,10 +276,9 @@ config SND_CS5535AUDIO
 
 config SND_DARLA20
 	tristate "(Echoaudio) Darla20"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Darla.
 
 	  To compile this driver as a module, choose M here: the module
@@ -297,10 +286,9 @@ config SND_DARLA20
 
 config SND_GINA20
 	tristate "(Echoaudio) Gina20"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Gina.
 
 	  To compile this driver as a module, choose M here: the module
@@ -308,11 +296,10 @@ config SND_GINA20
 
 config SND_LAYLA20
 	tristate "(Echoaudio) Layla20"
-	depends on SND
-	select FW_LOADER
-	select SND_RAWMIDI
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_RAWMIDI
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Layla.
 
 	  To compile this driver as a module, choose M here: the module
@@ -320,10 +307,9 @@ config SND_LAYLA20
 
 config SND_DARLA24
 	tristate "(Echoaudio) Darla24"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Darla24.
 
 	  To compile this driver as a module, choose M here: the module
@@ -331,10 +317,9 @@ config SND_DARLA24
 
 config SND_GINA24
 	tristate "(Echoaudio) Gina24"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Gina24.
 
 	  To compile this driver as a module, choose M here: the module
@@ -342,11 +327,10 @@ config SND_GINA24
 
 config SND_LAYLA24
 	tristate "(Echoaudio) Layla24"
-	depends on SND
-	select FW_LOADER
-	select SND_RAWMIDI
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_RAWMIDI
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Layla24.
 
 	  To compile this driver as a module, choose M here: the module
@@ -354,11 +338,10 @@ config SND_LAYLA24
 
 config SND_MONA
 	tristate "(Echoaudio) Mona"
-	depends on SND
-	select FW_LOADER
-	select SND_RAWMIDI
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_RAWMIDI
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Mona.
 
 	  To compile this driver as a module, choose M here: the module
@@ -366,11 +349,10 @@ config SND_MONA
 
 config SND_MIA
 	tristate "(Echoaudio) Mia"
-	depends on SND
-	select FW_LOADER
-	select SND_RAWMIDI
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_RAWMIDI
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Mia and Mia-midi.
 
 	  To compile this driver as a module, choose M here: the module
@@ -378,11 +360,10 @@ config SND_MIA
 
 config SND_ECHO3G
 	tristate "(Echoaudio) 3G cards"
-	depends on SND
-	select FW_LOADER
-	select SND_RAWMIDI
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_RAWMIDI
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Gina3G and Layla3G.
 
 	  To compile this driver as a module, choose M here: the module
@@ -390,10 +371,9 @@ config SND_ECHO3G
 
 config SND_INDIGO
 	tristate "(Echoaudio) Indigo"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Indigo.
 
 	  To compile this driver as a module, choose M here: the module
@@ -401,10 +381,9 @@ config SND_INDIGO
 
 config SND_INDIGOIO
 	tristate "(Echoaudio) Indigo IO"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Indigo IO.
 
 	  To compile this driver as a module, choose M here: the module
@@ -412,10 +391,9 @@ config SND_INDIGOIO
 
 config SND_INDIGODJ
 	tristate "(Echoaudio) Indigo DJ"
-	depends on SND
-	select FW_LOADER
-	select SND_PCM
-	help
+	select FW_LOADER
+	select SND_PCM
+	---help---
 	  Say 'Y' or 'M' to include support for Echoaudio Indigo DJ.
 
 	  To compile this driver as a module, choose M here: the module
@@ -423,12 +401,11 @@ config SND_INDIGODJ
 
 config SND_EMU10K1
 	tristate "Emu10k1 (SB Live!, Audigy, E-mu APS)"
-	depends on SND
 	select FW_LOADER
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
-	help
+	---help---
 	  Say Y to include support for Sound Blaster PCI 512, Live!,
 	  Audigy and E-mu APS (partially supported) soundcards.
 
@@ -441,10 +418,9 @@ config SND_EMU10K1
 
 config SND_EMU10K1X
 	tristate "Emu10k1X (Dell OEM Version)"
-	depends on SND
-	select SND_AC97_CODEC
-	select SND_RAWMIDI
-	help
+	select SND_AC97_CODEC
+	select SND_RAWMIDI
+	---help---
 	  Say Y here to include support for the Dell OEM version of the
 	  Sound Blaster Live!.
 
@@ -453,10 +429,9 @@ config SND_EMU10K1X
 
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
-	depends on SND
-	select SND_RAWMIDI
-	select SND_PCM
-	help
+	select SND_RAWMIDI
+	select SND_PCM
+	---help---
 	  Say Y here to include support for Ensoniq AudioPCI ES1370 chips.
 
 	  To compile this driver as a module, choose M here: the module
@@ -464,10 +439,9 @@ config SND_ENS1370
 
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
-	depends on SND
-	select SND_RAWMIDI
-	select SND_AC97_CODEC
-	help
+	select SND_RAWMIDI
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for Ensoniq AudioPCI ES1371 chips and
 	  Sound Blaster PCI 64 or 128 soundcards.
 
@@ -476,11 +450,10 @@ config SND_ENS1371
 
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on ESS Solo-1
 	  (ES1938, ES1946, ES1969) chips.
 
@@ -489,10 +462,9 @@ config SND_ES1938
 
 config SND_ES1968
 	tristate "ESS ES1968/1978 (Maestro-1/2/2E)"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on ESS Maestro
 	  1/2/2E chips.
 
@@ -501,11 +473,10 @@ config SND_ES1968
 
 config SND_FM801
 	tristate "ForteMedia FM801"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on the ForteMedia
 	  FM801 chip.
 
@@ -515,7 +486,7 @@ config SND_FM801_TEA575X_BOOL
 config SND_FM801_TEA575X_BOOL
 	bool "ForteMedia FM801 + TEA5757 tuner"
 	depends on SND_FM801
-	help
+	---help---
 	  Say Y here to include support for soundcards based on the ForteMedia
 	  FM801 chip with a TEA5757 tuner connected to GPIO1-3 pins (Media
 	  Forte SF256-PCS-02) into the snd-fm801 driver.
@@ -531,10 +502,9 @@ config SND_FM801_TEA575X
 
 config SND_HDA_INTEL
 	tristate "Intel HD Audio"
-	depends on SND
 	select SND_PCM
 	select SND_VMASTER
-	help
+	---help---
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) motherboard devices.
 
@@ -545,7 +515,7 @@ config SND_HDA_HWDEP
 	bool "Build hwdep interface for HD-audio driver"
 	depends on SND_HDA_INTEL
 	select SND_HWDEP
-	help
+	---help---
 	  Say Y here to build a hwdep interface for HD-audio driver.
 	  This interface can be used for out-of-band communication
 	  with codecs for debugging purposes.
@@ -554,7 +524,7 @@ config SND_HDA_CODEC_REALTEK
 	bool "Build Realtek HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
 
@@ -562,7 +532,7 @@ config SND_HDA_CODEC_ANALOG
 	bool "Build Analog Device HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include Analog Device HD-audio codec support in
 	  snd-hda-intel driver, such as AD1986A.
 
@@ -570,7 +540,7 @@ config SND_HDA_CODEC_SIGMATEL
 	bool "Build IDT/Sigmatel HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include IDT (Sigmatel) HD-audio codec support in
 	  snd-hda-intel driver, such as STAC9200.
 
@@ -578,7 +548,7 @@ config SND_HDA_CODEC_VIA
 	bool "Build VIA HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include VIA HD-audio codec support in
 	  snd-hda-intel driver, such as VT1708.
 
@@ -586,7 +556,7 @@ config SND_HDA_CODEC_ATIHDMI
 	bool "Build ATI HDMI HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include ATI HDMI HD-audio codec support in
 	  snd-hda-intel driver, such as ATI RS600 HDMI.
 
@@ -594,7 +564,7 @@ config SND_HDA_CODEC_CONEXANT
 	bool "Build Conexant HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include Conexant HD-audio codec support in
 	  snd-hda-intel driver, such as CX20549.
 
@@ -602,7 +572,7 @@ config SND_HDA_CODEC_CMEDIA
 	bool "Build C-Media HD-audio codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include C-Media HD-audio codec support in
 	  snd-hda-intel driver, such as CMI9880.
 
@@ -610,7 +580,7 @@ config SND_HDA_CODEC_SI3054
 	bool "Build Silicon Labs 3054 HD-modem codec support"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to include Silicon Labs 3054 HD-modem codec
 	  (and compatibles) support in snd-hda-intel driver.
 
@@ -618,14 +588,14 @@ config SND_HDA_GENERIC
 	bool "Enable generic HD-audio codec parser"
 	depends on SND_HDA_INTEL
 	default y
-	help
+	---help---
 	  Say Y here to enable the generic HD-audio codec parser
 	  in snd-hda-intel driver.
 
 config SND_HDA_POWER_SAVE
 	bool "Aggressive power-saving on HD-audio"
 	depends on SND_HDA_INTEL && EXPERIMENTAL
-	help
+	---help---
 	  Say Y here to enable more aggressive power-saving mode on
 	  HD-audio driver.  The power-saving timeout can be configured
 	  via power_save option or over sysfs on-the-fly.
@@ -634,17 +604,16 @@ config SND_HDA_POWER_SAVE_DEFAULT
 	int "Default time-out for HD-audio power-save mode"
 	depends on SND_HDA_POWER_SAVE
 	default 0
-	help
+	---help---
 	  The default time-out value in seconds for HD-audio automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
 config SND_HDSP
 	tristate "RME Hammerfall DSP Audio"
-	depends on SND
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
-	help
+	---help---
 	  Say Y here to include support for RME Hammerfall DSP Audio
 	  soundcards.
 
@@ -653,11 +622,10 @@ config SND_HDSP
 
 config SND_HDSPM
 	tristate "RME Hammerfall DSP MADI"
-	depends on SND
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
-	help
+	---help---
 	  Say Y here to include support for RME Hammerfall DSP MADI
 	  soundcards.
 
@@ -666,9 +634,8 @@ config SND_HDSPM
 
 config SND_HIFIER
 	tristate "TempoTec HiFier Fantasia"
-	depends on SND
 	select SND_OXYGEN_LIB
-	help
+	---help---
 	  Say Y here to include support for the MediaTek/TempoTec HiFier
 	  Fantasia sound card.
 
@@ -677,10 +644,9 @@ config SND_HIFIER
 
 config SND_ICE1712
 	tristate "ICEnsemble ICE1712 (Envy24)"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on the
 	  ICE1712 (Envy24) chip.
 
@@ -694,10 +660,9 @@ config SND_ICE1712
 
 config SND_ICE1724
 	tristate "ICE/VT1724/1720 (Envy24HT/PT)"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on
 	  ICE/VT1724/1720 (Envy24HT/PT) chips.
 
@@ -711,9 +676,8 @@ config SND_ICE1724
 
 config SND_INTEL8X0
 	tristate "Intel/SiS/nVidia/AMD/ALi AC97 Controller"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated AC97 sound
 	  device on motherboards with Intel/SiS/nVidia/AMD chipsets, or
 	  ALi chipsets using the M5455 Audio Controller.  (There is a
@@ -724,9 +688,8 @@ config SND_INTEL8X0
 
 config SND_INTEL8X0M
 	tristate "Intel/SiS/nVidia/AMD MC97 Modem"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated MC97 modem on
 	  motherboards with Intel/SiS/nVidia/AMD chipsets.
 
@@ -735,10 +698,9 @@ config SND_INTEL8X0M
 
 config SND_KORG1212
 	tristate "Korg 1212 IO"
-	depends on SND
 	select FW_LOADER if !SND_KORG1212_FIRMWARE_IN_KERNEL
 	select SND_PCM
-	help
+	---help---
 	  Say Y here to include support for Korg 1212IO soundcards.
 
 	  To compile this driver as a module, choose M here: the module
@@ -748,17 +710,16 @@ config SND_KORG1212_FIRMWARE_IN_KERNEL
 	bool "In-kernel firmware for Korg1212 driver"
 	depends on SND_KORG1212
 	default y
-	help
+	---help---
 	  Say Y here to include the static firmware built in the kernel
 	  for the Korg1212 driver.  If you choose N here, you need to
 	  install the firmware files from the alsa-firmware package.
 
 config SND_MAESTRO3
 	tristate "ESS Allegro/Maestro3"
-	depends on SND
 	select FW_LOADER if !SND_MAESTRO3_FIRMWARE_IN_KERNEL
 	select SND_AC97_CODEC
-	help
+	---help---
 	  Say Y here to include support for soundcards based on ESS Maestro 3
 	  (Allegro) chips.
 
@@ -769,17 +730,16 @@ config SND_MAESTRO3_FIRMWARE_IN_KERNEL
 	bool "In-kernel firmware for Maestro3 driver"
 	depends on SND_MAESTRO3
 	default y
-	help
+	---help---
 	  Say Y here to include the static firmware built in the kernel
 	  for the Maestro3 driver.  If you choose N here, you need to
 	  install the firmware files from the alsa-firmware package.
 
 config SND_MIXART
 	tristate "Digigram miXart"
-	depends on SND
 	select SND_HWDEP
 	select SND_PCM
-	help
+	---help---
 	  If you want to use Digigram miXart soundcards, say Y here and
 	  read <file:Documentation/sound/alsa/MIXART.txt>.
 
@@ -788,9 +748,8 @@ config SND_MIXART
 
 config SND_NM256
 	tristate "NeoMagic NM256AV/ZX"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for NeoMagic NM256AV/ZX chips.
 
 	  To compile this driver as a module, choose M here: the module
@@ -798,10 +757,9 @@ config SND_NM256
 
 config SND_PCXHR
 	tristate "Digigram PCXHR"
-	depends on SND
 	select SND_PCM
 	select SND_HWDEP
-	help
+	---help---
 	  Say Y here to include support for Digigram PCXHR boards.
 
 	  To compile this driver as a module, choose M here: the module
@@ -809,12 +767,11 @@ config SND_PCXHR
 
 config SND_RIPTIDE
 	tristate "Conexant Riptide"
-	depends on SND
-	select FW_LOADER
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select FW_LOADER
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say 'Y' or 'M' to include support for Conexant Riptide chip.
 
 	  To compile this driver as a module, choose M here: the module
@@ -822,9 +779,8 @@ config SND_RIPTIDE
 
 config SND_RME32
 	tristate "RME Digi32, 32/8, 32 PRO"
-	depends on SND
-	select SND_PCM
-	help
+	select SND_PCM
+	---help---
 	  Say Y to include support for RME Digi32, Digi32 PRO and
 	  Digi32/8 (Sek'd Prodif32, Prodif96 and Prodif Gold) audio
 	  devices.
@@ -834,9 +790,8 @@ config SND_RME32
 
 config SND_RME96
 	tristate "RME Digi96, 96/8, 96/8 PRO"
-	depends on SND
-	select SND_PCM
-	help
+	select SND_PCM
+	---help---
 	  Say Y here to include support for RME Digi96, Digi96/8 and
 	  Digi96/8 PRO/PAD/PST soundcards.
 
@@ -845,9 +800,8 @@ config SND_RME96
 
 config SND_RME9652
 	tristate "RME Digi9652 (Hammerfall)"
-	depends on SND
-	select SND_PCM
-	help
+	select SND_PCM
+	---help---
 	  Say Y here to include support for RME Hammerfall (RME
 	  Digi9652/Digi9636) soundcards.
 
@@ -856,9 +810,9 @@ config SND_RME9652
 
 config SND_SIS7019
 	tristate "SiS 7019 Audio Accelerator"
-	depends on SND && X86 && !X86_64
-	select SND_AC97_CODEC
-	help
+	depends on X86 && !X86_64
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the SiS 7019 Audio Accelerator.
 
 	  To compile this driver as a module, choose M here: the module
@@ -866,11 +820,10 @@ config SND_SIS7019
 
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SND
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on the S3
 	  SonicVibes chip.
 
@@ -879,10 +832,9 @@ config SND_SONICVIBES
 
 config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for soundcards based on Trident
 	  4D-Wave DX/NX or SiS 7018 chips.
 
@@ -891,10 +843,9 @@ config SND_TRIDENT
 
 config SND_VIA82XX
 	tristate "VIA 82C686A/B, 8233/8235 AC97 Controller"
-	depends on SND
-	select SND_MPU401_UART
-	select SND_AC97_CODEC
-	help
+	select SND_MPU401_UART
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated AC97 sound
 	  device on motherboards with VIA chipsets.
 
@@ -903,9 +854,8 @@ config SND_VIA82XX
 
 config SND_VIA82XX_MODEM
 	tristate "VIA 82C686A/B, 8233 based Modems"
-	depends on SND
-	select SND_AC97_CODEC
-	help
+	select SND_AC97_CODEC
+	---help---
 	  Say Y here to include support for the integrated MC97 modem on
 	  motherboards with VIA chipsets.
 
@@ -914,9 +864,8 @@ config SND_VIA82XX_MODEM
 
 config SND_VIRTUOSO
 	tristate "Asus Virtuoso 200 (Xonar)"
-	depends on SND
 	select SND_OXYGEN_LIB
-	help
+	---help---
 	  Say Y here to include support for sound cards based on the
 	  Asus AV200 chip, i.e., Xonar D2 and Xonar D2X.
 
@@ -925,9 +874,8 @@ config SND_VIRTUOSO
 
 config SND_VX222
 	tristate "Digigram VX222"
-	depends on SND
 	select SND_VX_LIB
-	help
+	---help---
 	  Say Y here to include support for Digigram VX222 soundcards.
 
 	  To compile this driver as a module, choose M here: the module
@@ -935,12 +883,11 @@ config SND_VX222
 
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
-	depends on SND
 	select FW_LOADER if !SND_YMFPCI_FIRMWARE_IN_KERNEL
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	help
+	---help---
 	  Say Y here to include support for Yamaha PCI audio chips -
 	  YMF724, YMF724F, YMF740, YMF740C, YMF744, YMF754.
 
@@ -951,7 +898,7 @@ config SND_YMFPCI_FIRMWARE_IN_KERNEL
 	bool "In-kernel firmware for YMFPCI driver"
 	depends on SND_YMFPCI
 	default y
-	help
+	---help---
 	  Say Y here to include the static firmware built in the kernel
 	  for the YMFPCI driver.  If you choose N here, you need to
 	  install the firmware files from the alsa-firmware package.
@@ -960,7 +907,7 @@ config SND_AC97_POWER_SAVE
 	bool "AC97 Power-Saving Mode"
 	depends on SND_AC97_CODEC && EXPERIMENTAL
 	default n
-	help
+	---help---
 	  Say Y here to enable the aggressive power-saving support of
 	  AC97 codecs.  In this mode, the power-mode is dynamically
 	  controlled at each open/close.
@@ -973,8 +920,8 @@ config SND_AC97_POWER_SAVE_DEFAULT
 	int "Default time-out for AC97 power-save mode"
 	depends on SND_AC97_POWER_SAVE
 	default 0
-	help
+	---help---
 	  The default time-out value in seconds for AC97 automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
-endmenu
+endif # SND_PCI
diff -r 39df17389b57 -r a60a39d8e6fe pcmcia/Kconfig
--- a/pcmcia/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/pcmcia/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,11 +1,16 @@
 # ALSA PCMCIA drivers
 
-menu "PCMCIA devices"
+menuconfig SND_PCMCIA
+        bool "PCMCIA devices"
 	depends on SND!=n && PCMCIA
+        default y
+        help
+          Support for sound devices connected via a PCMCIA interface.
+
+if SND_PCMCIA
 
 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
-	depends on SND && PCMCIA
 	select SND_VX_LIB
 	help
 	  Say Y here to include support for Digigram VXpocket and
@@ -16,7 +21,6 @@ config SND_VXPOCKET
 
 config SND_PDAUDIOCF
 	tristate "Sound Core PDAudioCF"
-	depends on SND && PCMCIA
 	select SND_PCM
 	help
 	  Say Y here to include support for Sound Core PDAudioCF
@@ -25,4 +29,4 @@ config SND_PDAUDIOCF
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-pdaudiocf.
 
-endmenu
+endif # SND_PCMCIA
diff -r 39df17389b57 -r a60a39d8e6fe soc/Kconfig
--- a/soc/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/soc/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,27 +1,24 @@
-#
-# SoC audio configuration
-#
+# ALSA SoC audio configuration
 
-menu "System on Chip audio support"
-	depends on SND!=n
+menuconfig SND_SOC
+        tristate "SoC (System on Chip) devices"
+        depends on SND!=n
+        select SND_PCM
+        help
+	  If you want ASoC support, you should say Y here and also to the
+	  specific driver for your SoC platform below.
+	  
+	  ASoC provides power efficient ALSA support for embedded battery 
+          powered SoC based systems like PDAs, phones and personal media 
+          players.
+
+	  This ASoC audio support can also be built as a module.  If so, the 
+          module will be called snd-soc-core.
+
+if SND_SOC
 
 config SND_SOC_AC97_BUS
 	bool
-
-config SND_SOC
-	tristate "ALSA for SoC audio support"
-	depends on SND
-	select SND_PCM
-	---help---
-
-	  If you want ASoC support, you should say Y here and also to the
-	  specific driver for your SoC platform below.
-	  
-	  ASoC provides power efficient ALSA support for embedded battery powered
-	  SoC based systems like PDA's, Phones and Personal Media Players.
-
-	  This ASoC audio support can also be built as a module.  If so, the module
-	  will be called snd-soc-core.
 
 # All the supported Soc's
 source "sound/soc/at91/Kconfig"
@@ -34,4 +31,4 @@ source "sound/soc/davinci/Kconfig"
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
 
-endmenu
+endif # SND_SOC
diff -r 39df17389b57 -r a60a39d8e6fe spi/Kconfig
--- a/spi/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/spi/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,13 +1,19 @@
-#SPI drivers
+# ALSA SPI drivers
 
-menu "SPI devices"
-	depends on SND != n
+menuconfig SND_SPI
+        bool "SPI devices"
+        depends on SND!=n && SPI
+        default y
+        help
+          Support for sound devices connected via the SPI bus.
+
+if SND_SPI
 
 config SND_AT73C213
 	tristate "Atmel AT73C213 DAC driver"
 	depends on ATMEL_SSC
 	select SND_PCM
-	help
+	---help---
 	  Say Y here if you want to use the Atmel AT73C213 external DAC. This
 	  DAC can be found on Atmel development boards.
 
@@ -22,10 +28,10 @@ config SND_AT73C213_TARGET_BITRATE
 	depends on SND_AT73C213
 	default "48000"
 	range 8000 50000
-	help
+	---help---
 	  Sets the target bitrate for the bitrate calculator in the driver.
 	  Limited by hardware to be between 8000 Hz and 50000 Hz.
 
 	  Set to 48000 Hz by default.
 
-endmenu
+endif # SND_SPI
diff -r 39df17389b57 -r a60a39d8e6fe usb/Kconfig
--- a/usb/Kconfig	Fri Feb 22 17:57:02 2008 +0100
+++ b/usb/Kconfig	Sat Feb 23 01:04:07 2008 -0500
@@ -1,15 +1,20 @@
 # ALSA USB drivers
 
-menu "USB devices"
-	depends on SND!=n && USB!=n
+menuconfig SND_USB
+        bool "USB devices"
+        depends on SND!=n && USB!=n
+        default y
+        help
+          Support for sound devices connected via the USB bus.
+
+if SND_USB
 
 config SND_USB_AUDIO
 	tristate "USB Audio/MIDI driver"
-	depends on SND && USB
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
-	help
+	---help---
 	  Say Y here to include support for USB audio and USB MIDI
 	  devices.
 
@@ -18,11 +23,11 @@ config SND_USB_AUDIO
 
 config SND_USB_USX2Y
 	tristate "Tascam US-122, US-224 and US-428 USB driver"
-	depends on SND && USB && (X86 || PPC || ALPHA)
+	depends on (X86 || PPC || ALPHA)
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
-	help
+	---help---
 	  Say Y here to include support for Tascam USB Audio/MIDI
 	  interfaces or controllers US-122, US-224 and US-428.
 
@@ -31,11 +36,10 @@ config SND_USB_USX2Y
 
 config SND_USB_CAIAQ
 	tristate "Native Instruments USB audio devices"
-	depends on SND && USB
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
-	help
+	---help---
 	   Say Y here to include support for caiaq USB audio interfaces,
 	   namely:
 
@@ -50,10 +54,10 @@ config SND_USB_CAIAQ
 	   will be called snd-usb-caiaq.
 
 config SND_USB_CAIAQ_INPUT
-	bool "enable input device for controllers"
+	bool "Enable input device for controllers"
 	depends on SND_USB_CAIAQ
 	depends on INPUT=y || INPUT=SND_USB_CAIAQ
-	help
+	---help---
 	  Say Y here to support input controllers like buttons, knobs,
 	  alpha dials and analog pedals on the following products:
 
@@ -63,5 +67,4 @@ config SND_USB_CAIAQ_INPUT
 	   * Native Instruments Kore Controller 2
 	   * Native Instruments Audio Kontrol 1
 
-endmenu
-
+endif # SND_USB
