From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 2/5 Clean up Linux 2.6.4-rc1 sound/core/Makefile
Date: Mon, 1 Mar 2004 14:44:25 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301144425.E24955@flint.arm.linux.org.uk>
References: <no.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040301144231.D24955@flint.arm.linux.org.uk>; from rmk+alsa@arm.linux.org.uk on Mon, Mar 01, 2004 at 02:30:02PM +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

This is part of a patch series to clean up sound/core/Makefile in Linux
2.6.4-rc1.

- Add "select SND_PCM" statements to appropriate Kconfig entries for
  drivers whose configuration symbol is used to build snd-pcm,
  snd-timer, and snd-page-alloc.

- Remove snd-pcm, snd-timer and snd-page-alloc from these in
  sound/core/Makefile.

- Remove snd from these entries as well - all SND_xxx configuration
  symbols depend on CONFIG_SND, so we won't even consider building
  any of these drivers unless SND is already set to 'y' or 'm'.

--- orig/sound/arm/Kconfig	Sat Nov  2 18:58:37 2002
+++ linux/sound/arm/Kconfig	Mon Mar  1 13:03:57 2004
@@ -6,6 +6,7 @@ menu "ALSA ARM devices"
 config SND_SA11XX_UDA1341
 	tristate "SA11xx UDA1341TS driver (H3600)"
 	depends on ARCH_SA1100 && SND && L3
+	select SND_PCM
 	help
 	  Say Y or M if you have a Compaq iPaq H3x00 handheld computer and want
 	  to use its Philips UDA 1341 audio chip.
--- orig/sound/core/Makefile	Mon Mar  1 10:51:26 2004
+++ linux/sound/core/Makefile	Mon Mar  1 11:11:07 2004
@@ -37,74 +37,58 @@ obj-$(CONFIG_SND_SEQUENCER) += snd-timer
 obj-$(CONFIG_SND_BIT32_EMUL) += ioctl32/
 
 # Toplevel Module Dependency
-obj-$(CONFIG_SND_DUMMY) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
 obj-$(CONFIG_SND_VIRMIDI) += snd-rawmidi.o snd.o snd-timer.o
 obj-$(CONFIG_SND_SERIAL_U16550) += snd-rawmidi.o snd.o snd-timer.o
 obj-$(CONFIG_SND_MTPAV) += snd-rawmidi.o snd.o snd-timer.o
 obj-$(CONFIG_SND_MPU401) += snd-rawmidi.o snd.o snd-timer.o
-obj-$(CONFIG_SND_ALS100) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_AZT2320) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_AZT3328) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CMI8330) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_DT019X) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ES18XX) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_OPL3SA2) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SGALAXY) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_AD1816A) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_AD1848) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_CS4231) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_CS4232) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CS4236) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ES1688) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_GUSCLASSIC) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_GUSMAX) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_GUSEXTREME) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_INTERWAVE) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_INTERWAVE_STB) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_OPTI93X) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SB8) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SB16) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SBAWE) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ES968) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_WAVEFRONT) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SSCAPE) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ALS4000) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CMIPCI) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CS4281) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ENS1370) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_ENS1371) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_ES1938) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-hwdep.o snd-rawmidi.o
-obj-$(CONFIG_SND_ES1968) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_FM801) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ICE1712) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_ICE1724) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_INTEL8X0) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_MAESTRO3) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_RME32) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_RME96) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_SONICVIBES) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_VIA82XX) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_ALI5451) += snd.o snd-rawmidi.o snd-timer.o snd-page-alloc.o snd-pcm.o
-obj-$(CONFIG_SND_CS46XX) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_EMU10K1) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_KORG1212) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_NM256) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_RME9652) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_HDSP) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_TRIDENT) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_YMFPCI) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_POWERMAC) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
+obj-$(CONFIG_SND_ALS100) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_AZT2320) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_AZT3328) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_DT019X) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_ES18XX) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_OPL3SA2) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_AD1816A) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_CS4231) += snd-rawmidi.o
+obj-$(CONFIG_SND_CS4232) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_CS4236) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_ES1688) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_GUSCLASSIC) += snd-rawmidi.o
+obj-$(CONFIG_SND_GUSMAX) += snd-rawmidi.o
+obj-$(CONFIG_SND_GUSEXTREME) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_INTERWAVE) += snd-rawmidi.o
+obj-$(CONFIG_SND_INTERWAVE_STB) += snd-rawmidi.o
+obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_OPTI93X) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_SB8) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_SB16) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_SBAWE) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_ES968) += snd-rawmidi.o
+obj-$(CONFIG_SND_WAVEFRONT) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_SSCAPE) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_ALS4000) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_CMIPCI) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_CS4281) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_ENS1370) += snd-rawmidi.o
+obj-$(CONFIG_SND_ENS1371) += snd-rawmidi.o
+obj-$(CONFIG_SND_ES1938) += snd-hwdep.o snd-rawmidi.o
+obj-$(CONFIG_SND_ES1968) += snd-rawmidi.o
+obj-$(CONFIG_SND_FM801) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_ICE1712) += snd-rawmidi.o
+obj-$(CONFIG_SND_ICE1724) += snd-rawmidi.o
+obj-$(CONFIG_SND_INTEL8X0) += snd-rawmidi.o
+obj-$(CONFIG_SND_SONICVIBES) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_VIA82XX) += snd-rawmidi.o
+obj-$(CONFIG_SND_ALI5451) += snd-rawmidi.o
+obj-$(CONFIG_SND_CS46XX) += snd-rawmidi.o
+obj-$(CONFIG_SND_EMU10K1) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_HDSP) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_TRIDENT) += snd-rawmidi.o
+obj-$(CONFIG_SND_YMFPCI) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_PC98_CS4232) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_USB_AUDIO) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
-obj-$(CONFIG_SND_SUN_AMD7930) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_SUN_CS4231) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_HARMONY) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_VXPOCKET) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-hwdep.o
-obj-$(CONFIG_SND_VXP440) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-hwdep.o
-obj-$(CONFIG_SND_VX222) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-hwdep.o
-obj-$(CONFIG_SND_BT87X) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
+obj-$(CONFIG_SND_PC98_CS4232) += snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_USB_AUDIO) += snd-rawmidi.o
+obj-$(CONFIG_SND_VXPOCKET) += snd-hwdep.o
+obj-$(CONFIG_SND_VXP440) += snd-hwdep.o
+obj-$(CONFIG_SND_VX222) += snd-hwdep.o
 
 obj-m := $(sort $(obj-m))
--- orig/sound/drivers/Kconfig	Sat Nov  2 18:58:37 2002
+++ linux/sound/drivers/Kconfig	Mon Mar  1 10:52:04 2004
@@ -6,6 +6,7 @@ menu "Generic devices"
 config SND_DUMMY
 	tristate "Dummy (/dev/null) soundcard"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include dummy driver. This driver does nothing, but
 	  emulates various mixer controls and PCM devices.
--- orig/sound/isa/Kconfig	Sat Jun 14 22:35:08 2003
+++ linux/sound/isa/Kconfig	Mon Mar  1 10:56:02 2004
@@ -6,6 +6,7 @@ menu "ISA devices"
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
 	depends on SND && ISAPNP
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Analog Devices SoundPort AD1816A or
 	  compatible sound chips.
@@ -13,6 +14,7 @@ config SND_AD1816A
 config SND_AD1848
 	tristate "Generic AD1848/CS4248 driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for AD1848 (Analog Devices) or CS4248 
 	  (Cirrus Logic - Crystal Semiconductors) chips. Please, for newer chips
@@ -21,6 +23,7 @@ config SND_AD1848
 config SND_CS4231
 	tristate "Generic Cirrus Logic CS4231 driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for CS4231 chips from Cirrus Logic -
 	  Crystal Semiconductors.
@@ -28,6 +31,7 @@ config SND_CS4231
 config SND_CS4232
 	tristate "Generic Cirrus Logic CS4232 driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for CS4232 chips from Cirrus Logic -
 	  Crystal Semiconductors.
@@ -35,6 +39,7 @@ config SND_CS4232
 config SND_CS4236
 	tristate "Generic Cirrus Logic CS4236+ driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for CS4235,CS4236,CS4237B,CS4238B,CS4239
 	  chips from Cirrus Logic - Crystal Semiconductors.
@@ -42,6 +47,7 @@ config SND_CS4236
 config SND_PC98_CS4232
 	tristate "NEC PC9800 CS4232 driver"
 	depends on SND && X86_PC9800
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for NEC PC-9801/PC-9821 on-board
 	  soundchip based on CS4232.
@@ -49,42 +55,49 @@ config SND_PC98_CS4232
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
 	depends on SND && ISAPNP
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS AudioDrive ES968 chip.
 
 config SND_ES1688
 	tristate "Generic ESS ES688/ES1688 driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS AudioDrive ES688 or ES1688 chips.
 
 config SND_ES18XX
 	tristate "Generic ESS ES18xx driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS AudioDrive ES18xx chips.
 
 config SND_GUSCLASSIC
 	tristate "Gravis UltraSound Classic"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Gravis UltraSound Classic soundcard.
 
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Gravis UltraSound Extreme soundcard.
 
 config SND_GUSMAX
 	tristate "Gravis UltraSound MAX"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Gravis UltraSound MAX soundcard.
 
 config SND_INTERWAVE
 	tristate "AMD InterWave, Gravis UltraSound PnP"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for AMD InterWave based soundcards
 	  (Gravis UltraSound Plug & Play, STB SoundRage32, MED3210, Dynasonic Pro,
@@ -93,6 +106,7 @@ config SND_INTERWAVE
 config SND_INTERWAVE_STB
 	tristate "AMD InterWave + TEA6330T (UltraSound 32-Pro)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for AMD InterWave based soundcards
 	  with TEA6330T bass and treble regulator (UltraSound 32-Pro).
@@ -100,6 +114,7 @@ config SND_INTERWAVE_STB
 config SND_OPTI92X_AD1848
 	tristate "OPTi 82C92x - AD1848"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Opti92x soundcards equiped with
 	  AD1848 codec.
@@ -107,6 +122,7 @@ config SND_OPTI92X_AD1848
 config SND_OPTI92X_CS4231
 	tristate "OPTi 82C92x - CS4231"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Opti92x soundcards equiped with
 	  CS4231 codec.
@@ -114,12 +130,14 @@ config SND_OPTI92X_CS4231
 config SND_OPTI93X
 	tristate "OPTi 82C93x"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Opti93x soundcards.
 
 config SND_SB8
 	tristate "Sound Blaster 1.0/2.0/Pro (8-bit)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster 1.0/2.0/Pro (8-bit)
 	  soundcards or 100% compatible from Creative.
@@ -127,6 +145,7 @@ config SND_SB8
 config SND_SB16
 	tristate "Sound Blaster 16 (PnP)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster 16 (including
 	  Plug and Play version).
@@ -134,6 +153,7 @@ config SND_SB16
 config SND_SBAWE
 	tristate "Sound Blaster AWE (32,64) (PnP)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster AWE (including
 	  Plug and Play version).
@@ -149,6 +169,7 @@ config SND_SB16_CSP
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Turtle Beach Maui, Tropez
 	  and Tropez+ soundcards based on Wavefront chip.
@@ -156,6 +177,7 @@ config SND_WAVEFRONT
 config SND_ALS100
 	tristate "Avance Logic ALS100/ALS120"
 	depends on SND && ISAPNP
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Avance Logic ALS100, ALS110,
 	  ALS120 and ALS200 soundcards.
@@ -163,18 +185,21 @@ config SND_ALS100
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on SND && ISAPNP
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Aztech Systems AZT2320 soundcard.
 
 config SND_CMI8330
 	tristate "C-Media CMI8330"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for C-Media CMI8330 based soundcards.
 
 config SND_DT019X
 	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
 	depends on SND && ISAPNP
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Diamond Technologies DT-019X and
 	  Avance Logic ALS-007 soundcards.
@@ -182,18 +207,21 @@ config SND_DT019X
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Yamaha OPL3SA2 or OPL3SA3 chips.
 
 config SND_SGALAXY
 	tristate "Aztech Sound Galaxy"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Aztech Sound Galaxy.
 
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape PnP driver"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq SoundScape PnP
 	  soundcard.
--- orig/sound/pci/Kconfig	Wed Feb 18 22:35:55 2004
+++ linux/sound/pci/Kconfig	Mon Mar  1 11:03:28 2004
@@ -6,18 +6,21 @@ menu "PCI devices"
 config SND_ALI5451
 	tristate "ALi PCI Audio M5451"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ALI PCI Audio M5451 sound core.
 
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168 (EXPERIMENTAL)"
 	depends on SND && EXPERIMENTAL
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Aztech AZF3328 (PCI168) soundcards.
 
 config SND_BT87X
         tristate "Bt87x Audio Capture"
         depends on SND
+	select SND_PCM
         help
           Say 'Y' or 'M' to include support for recording audio from TV cards
           based on Brooktree Bt878/Bt879 chips.
@@ -25,6 +28,7 @@ config SND_BT87X
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
 	depends on SND
+	select SND_PCM
 	select GAMEPORT
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4610 / CS4612 /
@@ -39,12 +43,14 @@ config SND_CS46XX_NEW_DSP
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4281.
 
 config SND_EMU10K1
 	tristate "EMU10K1 (SB Live! & Audigy, E-mu APS)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster PCI 512, Live!,
 	  Audigy and E-mu APS (partially supported).
@@ -52,18 +58,21 @@ config SND_EMU10K1
 config SND_KORG1212
 	tristate "Korg 1212 IO"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Korg 1212IO.
 
 config SND_NM256
 	tristate "NeoMagic NM256AV/ZX"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for NeoMagic NM256AV/ZX chips.
 
 config SND_RME32
 	tristate "RME Digi32, 32/8, 32 PRO"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for RME Digi32, Digi32 PRO and
 	  Digi32/8 (Sek'd Prodif32, Prodif96 and Prodif Gold) audio devices.
@@ -71,6 +80,7 @@ config SND_RME32
 config SND_RME96
 	tristate "RME Digi96, 96/8, 96/8 PRO"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for RME Digi96, Digi96/8 and
 	  Digi96/8 PRO/PAD/PST.
@@ -78,6 +88,7 @@ config SND_RME96
 config SND_RME9652
 	tristate "RME Digi9652 (Hammerfall)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for RME Hammerfall (RME Digi9652 /
 	  Digi9636) soundcards.
@@ -85,6 +96,7 @@ config SND_RME9652
 config SND_HDSP
 	tristate "RME Hammerfall DSP Audio"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for RME Hammerfall DSP Audio
 	  soundcards.
@@ -92,6 +104,7 @@ config SND_HDSP
 config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Trident 4D-Wave DX/NX and
 	  SiS 7018 soundcards.
@@ -99,6 +112,7 @@ config SND_TRIDENT
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Yamaha PCI audio chips - 
 	  YMF724, YMF724F, YMF740, YMF740C, YMF744, YMF754.
@@ -106,12 +120,14 @@ config SND_YMFPCI
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Avance Logic ALS4000.
 
 config SND_CMIPCI
 	tristate "C-Media 8738, 8338"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for C-Media CMI8338 and 8738 PCI
 	  soundcards.
@@ -119,12 +135,14 @@ config SND_CMIPCI
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1370.
 
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1371 and
 	  Sound Blaster PCI 64 or 128 soundcards.
@@ -132,6 +150,7 @@ config SND_ENS1371
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS Solo-1 (ES1938, ES1946, ES1969)
 	  soundcard.
@@ -139,18 +158,21 @@ config SND_ES1938
 config SND_ES1968
 	tristate "ESS ES1968/1978 (Maestro-1/2/2E)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS Maestro 1/2/2E.
 
 config SND_MAESTRO3
 	tristate "ESS Allegro/Maestro3"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS Maestro 3 (Allegro) soundcard.
 
 config SND_FM801
 	tristate "ForteMedia FM801"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ForteMedia FM801 based soundcards.
 
@@ -164,6 +186,7 @@ config CONFIG_SND_FM801_TEA575X
 config SND_ICE1712
 	tristate "ICEnsemble ICE1712 (Envy24)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ICE1712 (Envy24) based soundcards.
 	  Currently supported hardware is: MidiMan M Audio - Delta 1010(LT), Dio 2496,
@@ -173,6 +196,7 @@ config SND_ICE1712
 config SND_ICE1724
 	tristate "ICE/VT1724 (Envy24HT)"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ICE/VT1724 (Envy24HT) based
 	  soundcards.
@@ -182,6 +206,7 @@ config SND_ICE1724
 config SND_INTEL8X0
 	tristate "Intel i8x0/MX440, SiS 7012; Ali 5455; NForce Audio; AMD768/8111"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Intel8x0 based soundcards,
 	  SiS 7012, AMD768/8111, NVidia NForce and ALi 5455 chips.
@@ -189,18 +214,21 @@ config SND_INTEL8X0
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for S3 SonicVibes based soundcards.
 
 config SND_VIA82XX
 	tristate "VIA 82C686A/B, 8233 South Bridge"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for VIA VT82C686A/B, VT8233 South Bridge.
 
 config SND_VX222
 	tristate "Digigram VX222"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Digigram VX222 soundcards.
 
--- orig/sound/ppc/Kconfig	Sat Nov  2 18:58:41 2002
+++ linux/sound/ppc/Kconfig	Mon Mar  1 11:10:19 2004
@@ -6,6 +6,7 @@ menu "ALSA PowerMac devices"
 config SND_POWERMAC
 	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
 	depends on SND
+	select SND_PCM
 
 endmenu
 
--- orig/sound/parisc/Kconfig	Sat Jun 14 22:35:12 2003
+++ linux/sound/parisc/Kconfig	Mon Mar  1 11:11:03 2004
@@ -6,6 +6,7 @@ menu "ALSA PA-RISC devices"
 config SND_HARMONY
 	tristate "Harmony/Vivace sound chip"
 	depends on SND
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Harmony/Vivace soundchip
 	  on HP712s, 715/new and many other GSC based machines.
--- orig/sound/sparc/Kconfig	Sat Nov  2 18:58:41 2002
+++ linux/sound/sparc/Kconfig	Mon Mar  1 11:10:48 2004
@@ -6,11 +6,13 @@ menu "ALSA Sparc devices"
 config SND_SUN_AMD7930
 	tristate "Sun AMD7930"
 	depends on SBUS && SND
+	select SND_PCM
 
 #  dep_tristate 'Sun DBRI' CONFIG_SND_SUN_DBRI $CONFIG_SND
 config SND_SUN_CS4231
 	tristate "Sun CS4231"
 	depends on SND
+	select SND_PCM
 
 endmenu
 
--- orig/sound/usb/Kconfig	Sat Dec 28 17:08:02 2002
+++ linux/sound/usb/Kconfig	Mon Mar  1 11:05:38 2004
@@ -6,6 +6,7 @@ menu "ALSA USB devices"
 config SND_USB_AUDIO
 	tristate "USB Audio/MIDI driver"
 	depends on SND && USB
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for USB audio and USB MIDI devices.
 
--- orig/sound/pcmcia/Kconfig	Wed Feb 18 22:36:01 2004
+++ linux/sound/pcmcia/Kconfig	Mon Mar  1 11:05:15 2004
@@ -6,12 +6,14 @@ menu "PCMCIA devices"
 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
 	depends on SND && PCMCIA && ISA
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Digigram VXpocket soundcard.
 
 config SND_VXP440
 	tristate "Digigram VXpocket 440"
 	depends on SND && PCMCIA && ISA
+	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Digigram VXpocket 440 soundcard.
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
