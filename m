From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 4/5 Clean up Linux 2.6.4-rc1 sound/core/Makefile
Date: Mon, 1 Mar 2004 14:45:45 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301144545.G24955@flint.arm.linux.org.uk>
References: <no.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040301144511.F24955@flint.arm.linux.org.uk>; from rmk+alsa@arm.linux.org.uk on Mon, Mar 01, 2004 at 02:39:17PM +0000
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

- Add SND_HWDEP for drivers which use the snd-hwdep module.
- Remove snd-hwdep from these drivers entries in sound/core/Makefile,
  removing any sound/core/Makefile entries which are left empty.

--- orig/sound/core/Makefile	Mon Mar  1 11:37:21 2004
+++ linux/sound/core/Makefile	Mon Mar  1 11:46:31 2004
@@ -41,37 +41,5 @@ obj-$(CONFIG_SND_VIRMIDI) += snd-timer.o
 obj-$(CONFIG_SND_SERIAL_U16550) += snd-timer.o
 obj-$(CONFIG_SND_MTPAV) += snd-timer.o
 obj-$(CONFIG_SND_MPU401) += snd-timer.o
-obj-$(CONFIG_SND_ALS100) += snd-hwdep.o
-obj-$(CONFIG_SND_AZT2320) += snd-hwdep.o
-obj-$(CONFIG_SND_AZT3328) += snd-hwdep.o
-obj-$(CONFIG_SND_DT019X) += snd-hwdep.o
-obj-$(CONFIG_SND_ES18XX) += snd-hwdep.o
-obj-$(CONFIG_SND_OPL3SA2) += snd-hwdep.o
-obj-$(CONFIG_SND_AD1816A) += snd-hwdep.o
-obj-$(CONFIG_SND_CS4232) += snd-hwdep.o
-obj-$(CONFIG_SND_CS4236) += snd-hwdep.o
-obj-$(CONFIG_SND_ES1688) += snd-hwdep.o
-obj-$(CONFIG_SND_GUSEXTREME) += snd-hwdep.o
-obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-hwdep.o
-obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-hwdep.o
-obj-$(CONFIG_SND_OPTI93X) += snd-hwdep.o
-obj-$(CONFIG_SND_SB8) += snd-hwdep.o
-obj-$(CONFIG_SND_SB16) += snd-hwdep.o
-obj-$(CONFIG_SND_SBAWE) += snd-hwdep.o
-obj-$(CONFIG_SND_WAVEFRONT) += snd-hwdep.o
-obj-$(CONFIG_SND_SSCAPE) += snd-hwdep.o
-obj-$(CONFIG_SND_ALS4000) += snd-hwdep.o
-obj-$(CONFIG_SND_CMIPCI) += snd-hwdep.o
-obj-$(CONFIG_SND_CS4281) += snd-hwdep.o
-obj-$(CONFIG_SND_ES1938) += snd-hwdep.o
-obj-$(CONFIG_SND_FM801) += snd-hwdep.o
-obj-$(CONFIG_SND_SONICVIBES) += snd-hwdep.o
-obj-$(CONFIG_SND_EMU10K1) += snd-hwdep.o
-obj-$(CONFIG_SND_HDSP) += snd-hwdep.o
-obj-$(CONFIG_SND_YMFPCI) += snd-hwdep.o
-obj-$(CONFIG_SND_PC98_CS4232) += snd-hwdep.o
-obj-$(CONFIG_SND_VXPOCKET) += snd-hwdep.o
-obj-$(CONFIG_SND_VXP440) += snd-hwdep.o
-obj-$(CONFIG_SND_VX222) += snd-hwdep.o
 
 obj-m := $(sort $(obj-m))
--- orig/sound/isa/Kconfig	Mon Mar  1 11:37:22 2004
+++ linux/sound/isa/Kconfig	Mon Mar  1 11:42:33 2004
@@ -6,6 +6,7 @@ menu "ISA devices"
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
 	depends on SND && ISAPNP
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -33,6 +34,7 @@ config SND_CS4231
 config SND_CS4232
 	tristate "Generic Cirrus Logic CS4232 driver"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -42,6 +44,7 @@ config SND_CS4232
 config SND_CS4236
 	tristate "Generic Cirrus Logic CS4236+ driver"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -51,6 +54,7 @@ config SND_CS4236
 config SND_PC98_CS4232
 	tristate "NEC PC9800 CS4232 driver"
 	depends on SND && X86_PC9800
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -68,6 +72,7 @@ config SND_ES968
 config SND_ES1688
 	tristate "Generic ESS ES688/ES1688 driver"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -76,6 +81,7 @@ config SND_ES1688
 config SND_ES18XX
 	tristate "Generic ESS ES18xx driver"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -92,6 +98,7 @@ config SND_GUSCLASSIC
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -127,6 +134,7 @@ config SND_INTERWAVE_STB
 config SND_OPTI92X_AD1848
 	tristate "OPTi 82C92x - AD1848"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -136,6 +144,7 @@ config SND_OPTI92X_AD1848
 config SND_OPTI92X_CS4231
 	tristate "OPTi 82C92x - CS4231"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -145,6 +154,7 @@ config SND_OPTI92X_CS4231
 config SND_OPTI93X
 	tristate "OPTi 82C93x"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -153,6 +163,7 @@ config SND_OPTI93X
 config SND_SB8
 	tristate "Sound Blaster 1.0/2.0/Pro (8-bit)"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -162,6 +173,7 @@ config SND_SB8
 config SND_SB16
 	tristate "Sound Blaster 16 (PnP)"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -171,6 +183,7 @@ config SND_SB16
 config SND_SBAWE
 	tristate "Sound Blaster AWE (32,64) (PnP)"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -188,6 +201,7 @@ config SND_SB16_CSP
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -197,6 +211,7 @@ config SND_WAVEFRONT
 config SND_ALS100
 	tristate "Avance Logic ALS100/ALS120"
 	depends on SND && ISAPNP
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -206,6 +221,7 @@ config SND_ALS100
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on SND && ISAPNP
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -221,6 +237,7 @@ config SND_CMI8330
 config SND_DT019X
 	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
 	depends on SND && ISAPNP
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -230,6 +247,7 @@ config SND_DT019X
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -245,6 +263,7 @@ config SND_SGALAXY
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape PnP driver"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
--- orig/sound/pci/Kconfig	Mon Mar  1 11:37:22 2004
+++ linux/sound/pci/Kconfig	Mon Mar  1 11:46:13 2004
@@ -14,6 +14,7 @@ config SND_ALI5451
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168 (EXPERIMENTAL)"
 	depends on SND && EXPERIMENTAL
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -46,6 +47,7 @@ config SND_CS46XX_NEW_DSP
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -54,6 +56,7 @@ config SND_CS4281
 config SND_EMU10K1
 	tristate "EMU10K1 (SB Live! & Audigy, E-mu APS)"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -101,6 +104,7 @@ config SND_RME9652
 config SND_HDSP
 	tristate "RME Hammerfall DSP Audio"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -119,6 +123,7 @@ config SND_TRIDENT
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -128,6 +133,7 @@ config SND_YMFPCI
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -136,6 +142,7 @@ config SND_ALS4000
 config SND_CMIPCI
 	tristate "C-Media 8738, 8338"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -162,6 +169,7 @@ config SND_ENS1371
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -186,6 +194,7 @@ config SND_MAESTRO3
 config SND_FM801
 	tristate "ForteMedia FM801"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -232,6 +241,7 @@ config SND_INTEL8X0
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
 	depends on SND
+	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -248,6 +258,7 @@ config SND_VIA82XX
 config SND_VX222
 	tristate "Digigram VX222"
 	depends on SND
+	select SND_HWDEP
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Digigram VX222 soundcards.
--- orig/sound/pcmcia/Kconfig	Mon Mar  1 11:16:45 2004
+++ linux/sound/pcmcia/Kconfig	Mon Mar  1 11:46:29 2004
@@ -6,6 +6,7 @@ menu "PCMCIA devices"
 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
 	depends on SND && PCMCIA && ISA
+	select SND_HWDEP
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for Digigram VXpocket soundcard.
@@ -13,6 +14,7 @@ config SND_VXPOCKET
 config SND_VXP440
 	tristate "Digigram VXpocket 440"
 	depends on SND && PCMCIA && ISA
+	select SND_HWDEP
 	select SND_PCM
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
