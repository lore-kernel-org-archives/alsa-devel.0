From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC pxa2xx build support
Date: Thu, 12 Oct 2006 11:31:37 +0100
Message-ID: <1160649097.13780.18.camel@localhost.localdomain>
References: <1160497219.24436.117.camel@localhost.localdomain>
	<s5hd590m6ab.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2V25FkgrlfuEN73meiKA"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd590m6ab.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-2V25FkgrlfuEN73meiKA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-10-10 at 19:26 +0200, Takashi Iwai wrote:
> At Tue, 10 Oct 2006 17:20:19 +0100,
> Liam Girdwood wrote:
> > 
> > Index: alsa-kernel/soc/pxa/Kconfig
> > ===================================================================
> > --- /dev/null
> > +++ alsa-kernel/soc/pxa/Kconfig
> > @@ -0,0 +1,60 @@
> > +menu "SoC Audio for the Intel PXA2xx"
> > +
> > +config SND_PXA2xx_SOC
> 
> Use only capital letters for a config name.
> 

Fixed.

Thanks

Liam


--=-2V25FkgrlfuEN73meiKA
Content-Disposition: attachment; filename=asoc-pxa2xx-build.patch
Content-Type: text/x-patch; name=asoc-pxa2xx-build.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/soc/pxa/Kconfig
===================================================================
--- /dev/null
+++ alsa-kernel/soc/pxa/Kconfig
@@ -0,0 +1,60 @@
+menu "SoC Audio for the Intel PXA2xx"
+
+config SND_PXA2XX_SOC
+	tristate "SoC Audio for the Intel PXA2xx chip"
+	depends on ARCH_PXA && SND
+	select SND_PCM
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the PXA2xx AC97, I2S or SSP interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_PXA2XX_AC97
+	tristate
+	select SND_AC97_CODEC
+
+config SND_PXA2XX_SOC_AC97
+	tristate
+	select SND_AC97_BUS
+	select SND_SOC_AC97_BUS
+
+config SND_PXA2XX_SOC_I2S
+	tristate
+
+config SND_PXA2XX_SOC_CORGI
+	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
+	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx
+	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on Sharp
+	  Zaurus SL-C7x0 models (Corgi, Shepherd, Husky).
+
+config SND_PXA2XX_SOC_SPITZ
+	tristate "SoC Audio support for Sharp Zaurus SL-Cxx00"
+	depends on SND_PXA2XX_SOC && PXA_SHARP_Cxx00
+	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8750
+	help
+	  Say Y if you want to add support for SoC audio on Sharp
+	  Zaurus SL-Cxx00 models (Spitz, Borzoi and Akita).
+
+config SND_PXA2XX_SOC_POODLE
+	tristate "SoC Audio support for Poodle"
+	depends on SND_PXA2XX_SOC && MACH_POODLE
+	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on Sharp
+	  Zaurus SL-5600 model (Poodle).
+
+config SND_PXA2XX_SOC_TOSA
+	tristate "SoC AC97 Audio support for Tosa"
+	depends on SND_PXA2XX_SOC && MACH_TOSA
+	select SND_PXA2XX_SOC_AC97
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for SoC audio on Sharp
+	  Zaurus SL-C6000x models (Tosa).
+
+endmenu
Index: alsa-kernel/soc/pxa/Makefile
===================================================================
--- /dev/null
+++ alsa-kernel/soc/pxa/Makefile
@@ -0,0 +1,20 @@
+# PXA Platform Support
+snd-soc-pxa2xx-objs := pxa2xx-pcm.o
+snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
+snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
+
+obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
+obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
+obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
+
+# PXA Machine Support
+snd-soc-corgi-objs := corgi.o
+snd-soc-poodle-objs := poodle.o
+snd-soc-tosa-objs := tosa.o
+snd-soc-spitz-objs := spitz.o
+
+obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
+obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
+obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
+obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
+
Index: alsa-kernel/soc/Kconfig
===================================================================
--- alsa-kernel.orig/soc/Kconfig
+++ alsa-kernel/soc/Kconfig
@@ -23,6 +23,7 @@ config SND_SOC
 menu "SoC Platforms"
 depends on SND_SOC
 source "sound/soc/at91/Kconfig"
+source "sound/soc/pxa/Kconfig"
 endmenu
 
 # Supported codecs
Index: alsa-kernel/soc/Makefile
===================================================================
--- alsa-kernel.orig/soc/Makefile
+++ alsa-kernel/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/

--=-2V25FkgrlfuEN73meiKA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-2V25FkgrlfuEN73meiKA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-2V25FkgrlfuEN73meiKA--
