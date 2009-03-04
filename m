From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 3/9] S3C: Move <mach/audio.h> to <plat/audio.h>
Date: Wed, 04 Mar 2009 00:49:28 +0000
Message-ID: <20090304005138.561717090@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 478E924403
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:00 +0100 (CET)
Content-Disposition: inline; filename=audio/move-mach-audio-header.patch
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Ben Dooks <ben@simtec.co.uk>

The <mach/audio.h> file needs to be common to both ARCH_S3C2410 and
ARCH_S3C64XX as they share common driver code, so move it to <plat/audio.h>.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

 Index: linux.git/arch/arm/mach-s3c2410/include/mach/audio.h
===================================================================
Index: linux.git/arch/arm/mach-s3c2410/include/mach/audio.h
===================================================================
--- linux.git.orig/arch/arm/mach-s3c2410/include/mach/audio.h	2009-01-15 15:17:05.000000000 +0000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,45 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/audio.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/SWLINUX/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX - Audio platfrom_device info
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_AUDIO_H
-#define __ASM_ARCH_AUDIO_H __FILE__
-
-/* struct s3c24xx_iis_ops
- *
- * called from the s3c24xx audio core to deal with the architecture
- * or the codec's setup and control.
- *
- * the pointer to itself is passed through in case the caller wants to
- * embed this in an larger structure for easy reference to it's context.
-*/
-
-struct s3c24xx_iis_ops {
-	struct module *owner;
-
-	int	(*startup)(struct s3c24xx_iis_ops *me);
-	void	(*shutdown)(struct s3c24xx_iis_ops *me);
-	int	(*suspend)(struct s3c24xx_iis_ops *me);
-	int	(*resume)(struct s3c24xx_iis_ops *me);
-
-	int	(*open)(struct s3c24xx_iis_ops *me, struct snd_pcm_substream *strm);
-	int	(*close)(struct s3c24xx_iis_ops *me, struct snd_pcm_substream *strm);
-	int	(*prepare)(struct s3c24xx_iis_ops *me, struct snd_pcm_substream *strm, struct snd_pcm_runtime *rt);
-};
-
-struct s3c24xx_platdata_iis {
-	const char		*codec_clk;
-	struct s3c24xx_iis_ops	*ops;
-	int			(*match_dev)(struct device *dev);
-};
-
-#endif /* __ASM_ARCH_AUDIO_H */
Index: linux.git/arch/arm/plat-s3c/include/plat/audio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/arch/arm/plat-s3c/include/plat/audio.h	2009-01-19 11:56:35.000000000 +0000
@@ -0,0 +1,45 @@
+/* arch/arm/mach-s3c2410/include/mach/audio.h
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *	http://www.simtec.co.uk/products/SWLINUX/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C24XX - Audio platfrom_device info
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_AUDIO_H
+#define __ASM_ARCH_AUDIO_H __FILE__
+
+/* struct s3c24xx_iis_ops
+ *
+ * called from the s3c24xx audio core to deal with the architecture
+ * or the codec's setup and control.
+ *
+ * the pointer to itself is passed through in case the caller wants to
+ * embed this in an larger structure for easy reference to it's context.
+*/
+
+struct s3c24xx_iis_ops {
+	struct module *owner;
+
+	int	(*startup)(struct s3c24xx_iis_ops *me);
+	void	(*shutdown)(struct s3c24xx_iis_ops *me);
+	int	(*suspend)(struct s3c24xx_iis_ops *me);
+	int	(*resume)(struct s3c24xx_iis_ops *me);
+
+	int	(*open)(struct s3c24xx_iis_ops *me, struct snd_pcm_substream *strm);
+	int	(*close)(struct s3c24xx_iis_ops *me, struct snd_pcm_substream *strm);
+	int	(*prepare)(struct s3c24xx_iis_ops *me, struct snd_pcm_substream *strm, struct snd_pcm_runtime *rt);
+};
+
+struct s3c24xx_platdata_iis {
+	const char		*codec_clk;
+	struct s3c24xx_iis_ops	*ops;
+	int			(*match_dev)(struct device *dev);
+};
+
+#endif /* __ASM_ARCH_AUDIO_H */
Index: linux.git/sound/soc/s3c24xx/neo1973_wm8753.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/neo1973_wm8753.c	2009-01-19 11:56:33.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/neo1973_wm8753.c	2009-01-19 11:56:35.000000000 +0000
@@ -29,7 +29,7 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <mach/hardware.h>
-#include <mach/audio.h>
+#include <plat/audio.h>
 #include <linux/io.h>
 #include <mach/spi-gpio.h>
 
Index: linux.git/sound/soc/s3c24xx/s3c2412-i2s.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/s3c2412-i2s.c	2009-01-19 11:56:33.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c2412-i2s.c	2009-01-19 11:56:39.000000000 +0000
@@ -34,7 +34,7 @@
 #include <plat/regs-s3c2412-iis.h>
 
 #include <mach/regs-gpio.h>
-#include <mach/audio.h>
+#include <plat/audio.h>
 #include <mach/dma.h>
 
 #include "s3c24xx-pcm.h"
Index: linux.git/sound/soc/s3c24xx/s3c2443-ac97.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/s3c2443-ac97.c	2009-01-15 21:41:03.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c2443-ac97.c	2009-01-19 11:56:35.000000000 +0000
@@ -31,7 +31,7 @@
 #include <plat/regs-ac97.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
-#include <mach/audio.h>
+#include <plat/audio.h>
 #include <asm/dma.h>
 #include <mach/dma.h>
 
Index: linux.git/sound/soc/s3c24xx/s3c24xx-i2s.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-01-19 11:56:33.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-01-19 11:56:35.000000000 +0000
@@ -30,7 +30,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
-#include <mach/audio.h>
+#include <plat/audio.h>
 #include <asm/dma.h>
 #include <mach/dma.h>
 
Index: linux.git/sound/soc/s3c24xx/s3c24xx-pcm.c
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-01-15 21:41:03.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-01-19 11:56:35.000000000 +0000
@@ -29,7 +29,7 @@
 #include <asm/dma.h>
 #include <mach/hardware.h>
 #include <mach/dma.h>
-#include <mach/audio.h>
+#include <plat/audio.h>
 
 #include "s3c24xx-pcm.h"
 

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
