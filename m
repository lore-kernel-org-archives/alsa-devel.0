From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC AT91RM92000 build
Date: Fri, 06 Oct 2006 16:57:39 +0100
Message-ID: <1160150259.16898.44.camel@localhost.localdomain>
References: <1159805839.2382.123.camel@localhost.localdomain>
	<s5h8xjwj8vb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-q79aQ5AiXjCWcNqOqaq8"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xjwj8vb.wl%tiwai@suse.de>
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


--=-q79aQ5AiXjCWcNqOqaq8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-10-04 at 19:20 +0200, Takashi Iwai wrote:
> At Mon, 02 Oct 2006 17:17:19 +0100,
> Liam Girdwood wrote:
> > 
> > Index: alsa-kernel/soc/at91/Kconfig
> > ===================================================================
> > --- /dev/null
> > +++ alsa-kernel/soc/at91/Kconfig
> > @@ -0,0 +1,23 @@
> > +menu "SoC Audio for the Atmel AT91"
> > +
> > +config SND_AT91_SOC
> > +	tristate "SoC Audio for the Atmel AT91 System-on-Chip"
> > +	depends on ARCH_AT91 && SND
> > +	select SND_PCM
> > +	help
> > +	  Say Y or M if you want to add support for codecs attached to
> > +	  the AT91 SSC interface. You will also need
> > +	  to select the audio interfaces to support below.
> > +
> > +config SND_AT91_SOC_I2S
> > +	tristate
> > +
> > +config SND_AT91_SOC_ETI_B1_WM8731
> > +	tristate "SoC I2S Audio support for Endrelia ETI-B1 board"
> > +	depends on SND_AT91_SOC && MACH_ETI_B1
> > +	select SND_AT91_SOC_I2S
> 
> Don't you need a selection of SND_SOC_WM8731 here?
> 

Fixed.

Liam

--=-q79aQ5AiXjCWcNqOqaq8
Content-Disposition: attachment; filename=asoc-at91-build.patch
Content-Type: text/x-patch; name=asoc-at91-build.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/soc/Makefile
===================================================================
--- alsa-kernel.orig/soc/Makefile
+++ alsa-kernel/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at91/
Index: alsa-kernel/soc/at91/Kconfig
===================================================================
--- /dev/null
+++ alsa-kernel/soc/at91/Kconfig
@@ -0,0 +1,24 @@
+menu "SoC Audio for the Atmel AT91"
+
+config SND_AT91_SOC
+	tristate "SoC Audio for the Atmel AT91 System-on-Chip"
+	depends on ARCH_AT91 && SND
+	select SND_PCM
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the AT91 SSC interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_AT91_SOC_I2S
+	tristate
+
+config SND_AT91_SOC_ETI_B1_WM8731
+	tristate "SoC I2S Audio support for Endrelia ETI-B1 board"
+	depends on SND_AT91_SOC && MACH_ETI_B1
+	select SND_AT91_SOC_I2S
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on Endrelia
+          ETI-B1 board.
+
+endmenu
Index: alsa-kernel/soc/at91/Makefile
===================================================================
--- /dev/null
+++ alsa-kernel/soc/at91/Makefile
@@ -0,0 +1,11 @@
+# AT91 Platform Support
+snd-soc-at91-objs := at91rm9200-pcm.o
+snd-soc-at91-i2s-objs := at91rm9200-i2s.o
+
+obj-$(CONFIG_SND_AT91_SOC) += snd-soc-at91.o
+obj-$(CONFIG_SND_AT91_SOC_I2S) += snd-soc-at91-i2s.o
+
+# AT91 Machine Support
+snd-soc-eti-b1-wm8731-objs := eti_b1_wm8731.o
+
+obj-$(CONFIG_SND_AT91_SOC_ETI_B1_WM8731) += snd-soc-eti-b1-wm8731.o
Index: alsa-kernel/soc/Kconfig
===================================================================
--- alsa-kernel.orig/soc/Kconfig
+++ alsa-kernel/soc/Kconfig
@@ -19,6 +19,12 @@ config SND_SOC
 	  This SoC audio support can also be built as a module.  If so, the module
 	  will be called snd-soc-core.
 
+# All the supported Soc's
+menu "SoC Platforms"
+depends on SND_SOC
+source "sound/soc/at91/Kconfig"
+endmenu
+
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
 

--=-q79aQ5AiXjCWcNqOqaq8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-q79aQ5AiXjCWcNqOqaq8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-q79aQ5AiXjCWcNqOqaq8--
