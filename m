From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 3/5 Clean up Linux 2.6.4-rc1 sound/core/Makefile
Date: Mon, 1 Mar 2004 14:45:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301144511.F24955@flint.arm.linux.org.uk>
References: <no.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040301144425.E24955@flint.arm.linux.org.uk>; from rmk+alsa@arm.linux.org.uk on Mon, Mar 01, 2004 at 02:34:13PM +0000
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

- Add SND_RAWMIDI for drivers which use the snd-rawmidi module.
- Remove snd-rawmidi from these drivers entries in sound/core/Makefile
- Remove any sound/core/Makefile entries which are left empty.

--- orig/sound/core/Makefile	Mon Mar  1 11:16:43 2004
+++ linux/sound/core/Makefile	Mon Mar  1 11:30:43 2004
@@ -37,56 +37,39 @@ obj-$(CONFIG_SND_SEQUENCER) += snd-timer
 obj-$(CONFIG_SND_BIT32_EMUL) += ioctl32/
 
 # Toplevel Module Dependency
-obj-$(CONFIG_SND_VIRMIDI) += snd-rawmidi.o snd.o snd-timer.o
-obj-$(CONFIG_SND_SERIAL_U16550) += snd-rawmidi.o snd.o snd-timer.o
-obj-$(CONFIG_SND_MTPAV) += snd-rawmidi.o snd.o snd-timer.o
-obj-$(CONFIG_SND_MPU401) += snd-rawmidi.o snd.o snd-timer.o
-obj-$(CONFIG_SND_ALS100) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_AZT2320) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_AZT3328) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_DT019X) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ES18XX) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_OPL3SA2) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_AD1816A) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CS4231) += snd-rawmidi.o
-obj-$(CONFIG_SND_CS4232) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CS4236) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ES1688) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_GUSCLASSIC) += snd-rawmidi.o
-obj-$(CONFIG_SND_GUSMAX) += snd-rawmidi.o
-obj-$(CONFIG_SND_GUSEXTREME) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_INTERWAVE) += snd-rawmidi.o
-obj-$(CONFIG_SND_INTERWAVE_STB) += snd-rawmidi.o
-obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_OPTI93X) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SB8) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SB16) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SBAWE) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ES968) += snd-rawmidi.o
-obj-$(CONFIG_SND_WAVEFRONT) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_SSCAPE) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ALS4000) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CMIPCI) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_CS4281) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ENS1370) += snd-rawmidi.o
-obj-$(CONFIG_SND_ENS1371) += snd-rawmidi.o
-obj-$(CONFIG_SND_ES1938) += snd-hwdep.o snd-rawmidi.o
-obj-$(CONFIG_SND_ES1968) += snd-rawmidi.o
-obj-$(CONFIG_SND_FM801) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_ICE1712) += snd-rawmidi.o
-obj-$(CONFIG_SND_ICE1724) += snd-rawmidi.o
-obj-$(CONFIG_SND_INTEL8X0) += snd-rawmidi.o
-obj-$(CONFIG_SND_SONICVIBES) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_VIA82XX) += snd-rawmidi.o
-obj-$(CONFIG_SND_ALI5451) += snd-rawmidi.o
-obj-$(CONFIG_SND_CS46XX) += snd-rawmidi.o
-obj-$(CONFIG_SND_EMU10K1) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_HDSP) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_TRIDENT) += snd-rawmidi.o
-obj-$(CONFIG_SND_YMFPCI) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_PC98_CS4232) += snd-rawmidi.o snd-hwdep.o
-obj-$(CONFIG_SND_USB_AUDIO) += snd-rawmidi.o
+obj-$(CONFIG_SND_VIRMIDI) += snd-timer.o
+obj-$(CONFIG_SND_SERIAL_U16550) += snd-timer.o
+obj-$(CONFIG_SND_MTPAV) += snd-timer.o
+obj-$(CONFIG_SND_MPU401) += snd-timer.o
+obj-$(CONFIG_SND_ALS100) += snd-hwdep.o
+obj-$(CONFIG_SND_AZT2320) += snd-hwdep.o
+obj-$(CONFIG_SND_AZT3328) += snd-hwdep.o
+obj-$(CONFIG_SND_DT019X) += snd-hwdep.o
+obj-$(CONFIG_SND_ES18XX) += snd-hwdep.o
+obj-$(CONFIG_SND_OPL3SA2) += snd-hwdep.o
+obj-$(CONFIG_SND_AD1816A) += snd-hwdep.o
+obj-$(CONFIG_SND_CS4232) += snd-hwdep.o
+obj-$(CONFIG_SND_CS4236) += snd-hwdep.o
+obj-$(CONFIG_SND_ES1688) += snd-hwdep.o
+obj-$(CONFIG_SND_GUSEXTREME) += snd-hwdep.o
+obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-hwdep.o
+obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-hwdep.o
+obj-$(CONFIG_SND_OPTI93X) += snd-hwdep.o
+obj-$(CONFIG_SND_SB8) += snd-hwdep.o
+obj-$(CONFIG_SND_SB16) += snd-hwdep.o
+obj-$(CONFIG_SND_SBAWE) += snd-hwdep.o
+obj-$(CONFIG_SND_WAVEFRONT) += snd-hwdep.o
+obj-$(CONFIG_SND_SSCAPE) += snd-hwdep.o
+obj-$(CONFIG_SND_ALS4000) += snd-hwdep.o
+obj-$(CONFIG_SND_CMIPCI) += snd-hwdep.o
+obj-$(CONFIG_SND_CS4281) += snd-hwdep.o
+obj-$(CONFIG_SND_ES1938) += snd-hwdep.o
+obj-$(CONFIG_SND_FM801) += snd-hwdep.o
+obj-$(CONFIG_SND_SONICVIBES) += snd-hwdep.o
+obj-$(CONFIG_SND_EMU10K1) += snd-hwdep.o
+obj-$(CONFIG_SND_HDSP) += snd-hwdep.o
+obj-$(CONFIG_SND_YMFPCI) += snd-hwdep.o
+obj-$(CONFIG_SND_PC98_CS4232) += snd-hwdep.o
 obj-$(CONFIG_SND_VXPOCKET) += snd-hwdep.o
 obj-$(CONFIG_SND_VXP440) += snd-hwdep.o
 obj-$(CONFIG_SND_VX222) += snd-hwdep.o
--- orig/sound/drivers/Kconfig	Mon Mar  1 11:16:44 2004
+++ linux/sound/drivers/Kconfig	Mon Mar  1 11:29:32 2004
@@ -15,6 +15,7 @@ config SND_DUMMY
 config SND_VIRMIDI
 	tristate "Virtual MIDI soundcard"
 	depends on SND_SEQUENCER
+	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include virtual MIDI driver. This driver allows to
 	  connect applications using raw MIDI devices to sequencer.
@@ -22,6 +23,7 @@ config SND_VIRMIDI
 config SND_MTPAV
 	tristate "MOTU MidiTimePiece AV multiport MIDI"
 	depends on SND
+	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include support for MOTU MidiTimePiece AV multiport
 	  MIDI adapter.
@@ -29,6 +31,7 @@ config SND_MTPAV
 config SND_SERIAL_U16550
 	tristate "UART16550 - MIDI only driver"
 	depends on SND
+	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include support for MIDI serial port driver. It works
 	  with serial UARTs 16550 and better.
@@ -36,6 +39,7 @@ config SND_SERIAL_U16550
 config SND_MPU401
 	tristate "Generic MPU-401 UART driver"
 	depends on SND
+	select SND_RAWMIDI
 	help
 	  Say 'Y' or 'M' to include support for MPU401 hardware using UART access.
 
--- orig/sound/isa/Kconfig	Mon Mar  1 11:16:44 2004
+++ linux/sound/isa/Kconfig	Mon Mar  1 11:22:41 2004
@@ -6,6 +6,7 @@ menu "ISA devices"
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
 	depends on SND && ISAPNP
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Analog Devices SoundPort AD1816A or
@@ -23,6 +24,7 @@ config SND_AD1848
 config SND_CS4231
 	tristate "Generic Cirrus Logic CS4231 driver"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for CS4231 chips from Cirrus Logic -
@@ -31,6 +33,7 @@ config SND_CS4231
 config SND_CS4232
 	tristate "Generic Cirrus Logic CS4232 driver"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for CS4232 chips from Cirrus Logic -
@@ -39,6 +42,7 @@ config SND_CS4232
 config SND_CS4236
 	tristate "Generic Cirrus Logic CS4236+ driver"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for CS4235,CS4236,CS4237B,CS4238B,CS4239
@@ -47,6 +51,7 @@ config SND_CS4236
 config SND_PC98_CS4232
 	tristate "NEC PC9800 CS4232 driver"
 	depends on SND && X86_PC9800
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for NEC PC-9801/PC-9821 on-board
@@ -55,6 +60,7 @@ config SND_PC98_CS4232
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
 	depends on SND && ISAPNP
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS AudioDrive ES968 chip.
@@ -62,6 +68,7 @@ config SND_ES968
 config SND_ES1688
 	tristate "Generic ESS ES688/ES1688 driver"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS AudioDrive ES688 or ES1688 chips.
@@ -69,6 +76,7 @@ config SND_ES1688
 config SND_ES18XX
 	tristate "Generic ESS ES18xx driver"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS AudioDrive ES18xx chips.
@@ -76,6 +84,7 @@ config SND_ES18XX
 config SND_GUSCLASSIC
 	tristate "Gravis UltraSound Classic"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Gravis UltraSound Classic soundcard.
@@ -83,6 +92,7 @@ config SND_GUSCLASSIC
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Gravis UltraSound Extreme soundcard.
@@ -90,6 +100,7 @@ config SND_GUSEXTREME
 config SND_GUSMAX
 	tristate "Gravis UltraSound MAX"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Gravis UltraSound MAX soundcard.
@@ -97,6 +108,7 @@ config SND_GUSMAX
 config SND_INTERWAVE
 	tristate "AMD InterWave, Gravis UltraSound PnP"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for AMD InterWave based soundcards
@@ -106,6 +118,7 @@ config SND_INTERWAVE
 config SND_INTERWAVE_STB
 	tristate "AMD InterWave + TEA6330T (UltraSound 32-Pro)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for AMD InterWave based soundcards
@@ -114,6 +127,7 @@ config SND_INTERWAVE_STB
 config SND_OPTI92X_AD1848
 	tristate "OPTi 82C92x - AD1848"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Opti92x soundcards equiped with
@@ -122,6 +136,7 @@ config SND_OPTI92X_AD1848
 config SND_OPTI92X_CS4231
 	tristate "OPTi 82C92x - CS4231"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Opti92x soundcards equiped with
@@ -130,6 +145,7 @@ config SND_OPTI92X_CS4231
 config SND_OPTI93X
 	tristate "OPTi 82C93x"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Opti93x soundcards.
@@ -137,6 +153,7 @@ config SND_OPTI93X
 config SND_SB8
 	tristate "Sound Blaster 1.0/2.0/Pro (8-bit)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster 1.0/2.0/Pro (8-bit)
@@ -145,6 +162,7 @@ config SND_SB8
 config SND_SB16
 	tristate "Sound Blaster 16 (PnP)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster 16 (including
@@ -153,6 +171,7 @@ config SND_SB16
 config SND_SBAWE
 	tristate "Sound Blaster AWE (32,64) (PnP)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster AWE (including
@@ -169,6 +188,7 @@ config SND_SB16_CSP
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Turtle Beach Maui, Tropez
@@ -177,6 +197,7 @@ config SND_WAVEFRONT
 config SND_ALS100
 	tristate "Avance Logic ALS100/ALS120"
 	depends on SND && ISAPNP
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Avance Logic ALS100, ALS110,
@@ -185,6 +206,7 @@ config SND_ALS100
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on SND && ISAPNP
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Aztech Systems AZT2320 soundcard.
@@ -199,6 +221,7 @@ config SND_CMI8330
 config SND_DT019X
 	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
 	depends on SND && ISAPNP
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Diamond Technologies DT-019X and
@@ -207,6 +230,7 @@ config SND_DT019X
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Yamaha OPL3SA2 or OPL3SA3 chips.
@@ -221,6 +245,7 @@ config SND_SGALAXY
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape PnP driver"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq SoundScape PnP
--- orig/sound/pci/Kconfig	Mon Mar  1 11:16:44 2004
+++ linux/sound/pci/Kconfig	Mon Mar  1 11:27:54 2004
@@ -6,6 +6,7 @@ menu "PCI devices"
 config SND_ALI5451
 	tristate "ALi PCI Audio M5451"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ALI PCI Audio M5451 sound core.
@@ -13,6 +14,7 @@ config SND_ALI5451
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168 (EXPERIMENTAL)"
 	depends on SND && EXPERIMENTAL
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Aztech AZF3328 (PCI168) soundcards.
@@ -28,6 +30,7 @@ config SND_BT87X
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	select GAMEPORT
 	help
@@ -43,6 +46,7 @@ config SND_CS46XX_NEW_DSP
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4281.
@@ -50,6 +54,7 @@ config SND_CS4281
 config SND_EMU10K1
 	tristate "EMU10K1 (SB Live! & Audigy, E-mu APS)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Sound Blaster PCI 512, Live!,
@@ -96,6 +101,7 @@ config SND_RME9652
 config SND_HDSP
 	tristate "RME Hammerfall DSP Audio"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for RME Hammerfall DSP Audio
@@ -104,6 +110,7 @@ config SND_HDSP
 config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Trident 4D-Wave DX/NX and
@@ -112,6 +119,7 @@ config SND_TRIDENT
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Yamaha PCI audio chips - 
@@ -120,6 +128,7 @@ config SND_YMFPCI
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Avance Logic ALS4000.
@@ -127,6 +136,7 @@ config SND_ALS4000
 config SND_CMIPCI
 	tristate "C-Media 8738, 8338"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for C-Media CMI8338 and 8738 PCI
@@ -135,6 +145,7 @@ config SND_CMIPCI
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1370.
@@ -142,6 +153,7 @@ config SND_ENS1370
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1371 and
@@ -150,6 +162,7 @@ config SND_ENS1371
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS Solo-1 (ES1938, ES1946, ES1969)
@@ -158,6 +171,7 @@ config SND_ES1938
 config SND_ES1968
 	tristate "ESS ES1968/1978 (Maestro-1/2/2E)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ESS Maestro 1/2/2E.
@@ -172,6 +186,7 @@ config SND_MAESTRO3
 config SND_FM801
 	tristate "ForteMedia FM801"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ForteMedia FM801 based soundcards.
@@ -186,6 +201,7 @@ config CONFIG_SND_FM801_TEA575X
 config SND_ICE1712
 	tristate "ICEnsemble ICE1712 (Envy24)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ICE1712 (Envy24) based soundcards.
@@ -196,6 +212,7 @@ config SND_ICE1712
 config SND_ICE1724
 	tristate "ICE/VT1724 (Envy24HT)"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for ICE/VT1724 (Envy24HT) based
@@ -206,6 +223,7 @@ config SND_ICE1724
 config SND_INTEL8X0
 	tristate "Intel i8x0/MX440, SiS 7012; Ali 5455; NForce Audio; AMD768/8111"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Intel8x0 based soundcards,
@@ -214,6 +232,7 @@ config SND_INTEL8X0
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for S3 SonicVibes based soundcards.
@@ -221,6 +240,7 @@ config SND_SONICVIBES
 config SND_VIA82XX
 	tristate "VIA 82C686A/B, 8233 South Bridge"
 	depends on SND
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for VIA VT82C686A/B, VT8233 South Bridge.
--- orig/sound/usb/Kconfig	Mon Mar  1 11:16:45 2004
+++ linux/sound/usb/Kconfig	Mon Mar  1 11:28:18 2004
@@ -6,6 +6,7 @@ menu "ALSA USB devices"
 config SND_USB_AUDIO
 	tristate "USB Audio/MIDI driver"
 	depends on SND && USB
+	select SND_RAWMIDI
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for USB audio and USB MIDI devices.

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
