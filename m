From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Mon, 3 Jun 2013 16:18:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306031612520.1304-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 1716326500C
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 22:18:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to Takashi Iwai, CONFIG_SND_VERBOSE_PRINTK is "useless".  All 
it does is add filenames and line numbers to certain log messages.

This patch gets rid of it.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Joe Perches <joe@perches.com>

---

Updating all the snd_printk() and snd_printd() calls will be a huge
job.  Getting rid of the verbose logging is a lot easier, so that's
where I'm starting.

Alan Stern

[as1688]

 Documentation/DocBook/writing-an-alsa-driver.tmpl |    7 +---
 arch/arm/configs/eseries_pxa_defconfig            |    1 
 arch/arm/configs/omap2plus_defconfig              |    1 
 arch/arm/configs/s3c2410_defconfig                |    1 
 arch/arm/configs/trizeps4_defconfig               |    1 
 arch/ia64/configs/generic_defconfig               |    1 
 arch/ia64/configs/gensparse_defconfig             |    1 
 arch/mips/configs/pnx8335_stb225_defconfig        |    1 
 arch/powerpc/configs/ppc6xx_defconfig             |    1 
 arch/sh/configs/edosk7760_defconfig               |    1 
 arch/sh/configs/sh7785lcr_32bit_defconfig         |    1 
 include/sound/core.h                              |    4 +-
 sound/core/Kconfig                                |    9 ------
 sound/core/misc.c                                 |   33 ----------------------
 sound/pci/hda/hda_intel.c                         |    4 --
 15 files changed, 5 insertions(+), 62 deletions(-)

Index: usb-3.10/Documentation/DocBook/writing-an-alsa-driver.tmpl
===================================================================
--- usb-3.10.orig/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ usb-3.10/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -6087,11 +6087,8 @@ struct _snd_pcm_runtime {
       <title><function>snd_printk()</function> and friends</title>
       <para>
         ALSA provides a verbose version of the
-      <function>printk()</function> function. If a kernel config
-      <constant>CONFIG_SND_VERBOSE_PRINTK</constant> is set, this
-      function prints the given message together with the file name
-      and the line of the caller. The <constant>KERN_XXX</constant>
-      prefix is processed as 
+      <function>printk()</function> function.
+      The <constant>KERN_XXX</constant> prefix is processed as
       well as the original <function>printk()</function> does, so it's
       recommended to add this prefix, e.g. 
 
Index: usb-3.10/arch/arm/configs/eseries_pxa_defconfig
===================================================================
--- usb-3.10.orig/arch/arm/configs/eseries_pxa_defconfig
+++ usb-3.10/arch/arm/configs/eseries_pxa_defconfig
@@ -90,7 +90,6 @@ CONFIG_SND=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_DYNAMIC_MINORS=y
-CONFIG_SND_VERBOSE_PRINTK=y
 # CONFIG_SND_PCMCIA is not set
 CONFIG_SND_SOC=m
 CONFIG_SND_PXA2XX_SOC=m
Index: usb-3.10/arch/arm/configs/omap2plus_defconfig
===================================================================
--- usb-3.10.orig/arch/arm/configs/omap2plus_defconfig
+++ usb-3.10/arch/arm/configs/omap2plus_defconfig
@@ -192,7 +192,6 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
Index: usb-3.10/arch/arm/configs/s3c2410_defconfig
===================================================================
--- usb-3.10.orig/arch/arm/configs/s3c2410_defconfig
+++ usb-3.10/arch/arm/configs/s3c2410_defconfig
@@ -315,7 +315,6 @@ CONFIG_SND_SEQUENCER=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
-CONFIG_SND_VERBOSE_PRINTK=y
 # CONFIG_SND_DRIVERS is not set
 # CONFIG_SND_ARM is not set
 # CONFIG_SND_SPI is not set
Index: usb-3.10/arch/arm/configs/trizeps4_defconfig
===================================================================
--- usb-3.10.orig/arch/arm/configs/trizeps4_defconfig
+++ usb-3.10/arch/arm/configs/trizeps4_defconfig
@@ -159,7 +159,6 @@ CONFIG_SND=y
 CONFIG_SND_SEQUENCER=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_PXA2XX_AC97=y
 CONFIG_SND_USB_AUDIO=m
Index: usb-3.10/arch/ia64/configs/generic_defconfig
===================================================================
--- usb-3.10.orig/arch/ia64/configs/generic_defconfig
+++ usb-3.10/arch/ia64/configs/generic_defconfig
@@ -127,7 +127,6 @@ CONFIG_SND_SEQ_DUMMY=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DUMMY=m
 CONFIG_SND_VIRMIDI=m
 CONFIG_SND_MTPAV=m
Index: usb-3.10/arch/ia64/configs/gensparse_defconfig
===================================================================
--- usb-3.10.orig/arch/ia64/configs/gensparse_defconfig
+++ usb-3.10/arch/ia64/configs/gensparse_defconfig
@@ -115,7 +115,6 @@ CONFIG_SND_SEQ_DUMMY=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DUMMY=m
 CONFIG_SND_VIRMIDI=m
 CONFIG_SND_MTPAV=m
Index: usb-3.10/arch/mips/configs/pnx8335_stb225_defconfig
===================================================================
--- usb-3.10.orig/arch/mips/configs/pnx8335_stb225_defconfig
+++ usb-3.10/arch/mips/configs/pnx8335_stb225_defconfig
@@ -73,7 +73,6 @@ CONFIG_SND_SEQUENCER=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_EXT2_FS=m
 # CONFIG_DNOTIFY is not set
Index: usb-3.10/arch/powerpc/configs/ppc6xx_defconfig
===================================================================
--- usb-3.10.orig/arch/powerpc/configs/ppc6xx_defconfig
+++ usb-3.10/arch/powerpc/configs/ppc6xx_defconfig
@@ -870,7 +870,6 @@ CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_DYNAMIC_MINORS=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_DEBUG_VERBOSE=y
 CONFIG_SND_PCM_XRUN_DEBUG=y
Index: usb-3.10/arch/sh/configs/edosk7760_defconfig
===================================================================
--- usb-3.10.orig/arch/sh/configs/edosk7760_defconfig
+++ usb-3.10/arch/sh/configs/edosk7760_defconfig
@@ -90,7 +90,6 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 # CONFIG_SND_VERBOSE_PROCFS is not set
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_SOC=y
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
Index: usb-3.10/arch/sh/configs/sh7785lcr_32bit_defconfig
===================================================================
--- usb-3.10.orig/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ usb-3.10/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -105,7 +105,6 @@ CONFIG_SND_HRTIMER=y
 CONFIG_SND_DYNAMIC_MINORS=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 # CONFIG_SND_VERBOSE_PROCFS is not set
-CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_DEBUG_VERBOSE=y
 # CONFIG_SND_DRIVERS is not set
Index: usb-3.10/include/sound/core.h
===================================================================
--- usb-3.10.orig/include/sound/core.h
+++ usb-3.10/include/sound/core.h
@@ -335,7 +335,7 @@ enum {
 	SND_PR_VERBOSE,
 };
 
-#if defined(CONFIG_SND_DEBUG) || defined(CONFIG_SND_VERBOSE_PRINTK)
+#if defined(CONFIG_SND_DEBUG)
 __printf(4, 5)
 void __snd_printk(unsigned int level, const char *file, int line,
 		  const char *format, ...);
@@ -349,7 +349,7 @@ void __snd_printk(unsigned int level, co
  * @fmt: format string
  *
  * Works like printk() but prints the file and the line of the caller
- * when configured with CONFIG_SND_VERBOSE_PRINTK.
+ * when configured with CONFIG_SND_DEBUG.
  */
 #define snd_printk(fmt, args...) \
 	__snd_printk(0, __FILE__, __LINE__, fmt, ##args)
Index: usb-3.10/sound/core/Kconfig
===================================================================
--- usb-3.10.orig/sound/core/Kconfig
+++ usb-3.10/sound/core/Kconfig
@@ -173,15 +173,6 @@ config SND_VERBOSE_PROCFS
           useful information to developers when a problem occurs).  On the
           other side, it makes the ALSA subsystem larger.
 
-config SND_VERBOSE_PRINTK
-	bool "Verbose printk"
-	help
-	  Say Y here to enable verbose log messages.  These messages
-	  will help to identify source file and position containing
-	  printed messages.
-
-	  You don't need this unless you're debugging ALSA.
-
 config SND_DEBUG
 	bool "Debug"
 	help
Index: usb-3.10/sound/core/misc.c
===================================================================
--- usb-3.10.orig/sound/core/misc.c
+++ usb-3.10/sound/core/misc.c
@@ -51,27 +51,11 @@ void release_and_free_resource(struct re
 
 EXPORT_SYMBOL(release_and_free_resource);
 
-#ifdef CONFIG_SND_VERBOSE_PRINTK
-/* strip the leading path if the given path is absolute */
-static const char *sanity_file_name(const char *path)
-{
-	if (*path == '/')
-		return strrchr(path, '/') + 1;
-	else
-		return path;
-}
-#endif
-
-#if defined(CONFIG_SND_DEBUG) || defined(CONFIG_SND_VERBOSE_PRINTK)
+#if defined(CONFIG_SND_DEBUG)
 void __snd_printk(unsigned int level, const char *path, int line,
 		  const char *format, ...)
 {
 	va_list args;
-#ifdef CONFIG_SND_VERBOSE_PRINTK
-	int kern_level;
-	struct va_format vaf;
-	char verbose_fmt[] = KERN_DEFAULT "ALSA %s:%d %pV";
-#endif
 
 #ifdef CONFIG_SND_DEBUG
 	if (debug < level)
@@ -79,22 +63,7 @@ void __snd_printk(unsigned int level, co
 #endif
 
 	va_start(args, format);
-#ifdef CONFIG_SND_VERBOSE_PRINTK
-	vaf.fmt = format;
-	vaf.va = &args;
-
-	kern_level = printk_get_level(format);
-	if (kern_level) {
-		const char *end_of_header = printk_skip_level(format);
-		memcpy(verbose_fmt, format, end_of_header - format);
-		vaf.fmt = end_of_header;
-	} else if (level)
-		memcpy(verbose_fmt, KERN_DEBUG, sizeof(KERN_DEBUG) - 1);
-	printk(verbose_fmt, sanity_file_name(path), line, &vaf);
-
-#else
 	vprintk(format, args);
-#endif
 	va_end(args);
 }
 EXPORT_SYMBOL_GPL(__snd_printk);
Index: usb-3.10/sound/pci/hda/hda_intel.c
===================================================================
--- usb-3.10.orig/sound/pci/hda/hda_intel.c
+++ usb-3.10/sound/pci/hda/hda_intel.c
@@ -189,11 +189,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},
 			 "{ULI, M5461}}");
 MODULE_DESCRIPTION("Intel HDA driver");
 
-#ifdef CONFIG_SND_VERBOSE_PRINTK
-#define SFX	/* nop */
-#else
 #define SFX	"hda-intel "
-#endif
 
 #if defined(CONFIG_PM) && defined(CONFIG_VGA_SWITCHEROO)
 #ifdef CONFIG_SND_HDA_CODEC_HDMI
