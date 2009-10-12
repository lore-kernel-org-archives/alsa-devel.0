From: Ben Dooks <ben@simtec.co.uk>
Subject: S3C: Remove <plat/audio.h>
Date: Mon, 12 Oct 2009 21:17:09 +0100
Message-ID: <20091012201708.930764863@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C10010386F
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 22:21:13 +0200 (CEST)
Content-Disposition: inline; filename=asoc-audio-cleanups1.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Simtec Linux Team <linux@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org

Remove the <plat/audio.h> include from arch/arm/plat-s3c/include/plat/audio.h
as it provides nothing to the current kernel and is not in any future plans
for the system.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 arch/arm/plat-s3c/include/plat/audio.h |   45 ---------------------------------
 sound/soc/s3c24xx/neo1973_wm8753.c     |    1 
 sound/soc/s3c24xx/s3c-i2s-v2.c         |    1 
 sound/soc/s3c24xx/s3c2412-i2s.c        |    1 
 sound/soc/s3c24xx/s3c2443-ac97.c       |    1 
 sound/soc/s3c24xx/s3c24xx-i2s.c        |    2 -
 sound/soc/s3c24xx/s3c24xx-pcm.c        |    1 
 sound/soc/s3c24xx/s3c64xx-i2s.c        |    1 
 8 files changed, 1 insertion(+), 52 deletions(-)

Index: b/arch/arm/plat-s3c/include/plat/audio.h
===================================================================
--- a/arch/arm/plat-s3c/include/plat/audio.h	2009-10-12 21:11:08.000000000 +0100
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
Index: b/sound/soc/s3c24xx/s3c-i2s-v2.c
===================================================================
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c	2009-10-12 21:11:08.000000000 +0100
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c	2009-10-12 21:11:39.000000000 +0100
@@ -32,7 +32,6 @@
 
 #include <plat/regs-s3c2412-iis.h>
 
-#include <plat/audio.h>
 #include <mach/dma.h>
 
 #include "s3c-i2s-v2.h"
Index: b/sound/soc/s3c24xx/s3c2412-i2s.c
===================================================================
--- a/sound/soc/s3c24xx/s3c2412-i2s.c	2009-10-12 21:11:08.000000000 +0100
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c	2009-10-12 21:11:39.000000000 +0100
@@ -34,7 +34,6 @@
 
 #include <plat/regs-s3c2412-iis.h>
 
-#include <plat/audio.h>
 #include <mach/regs-gpio.h>
 #include <mach/dma.h>
 
Index: b/sound/soc/s3c24xx/s3c2443-ac97.c
===================================================================
--- a/sound/soc/s3c24xx/s3c2443-ac97.c	2009-10-12 21:11:08.000000000 +0100
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c	2009-10-12 21:11:39.000000000 +0100
@@ -32,7 +32,6 @@
 #include <plat/regs-ac97.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
-#include <plat/audio.h>
 #include <asm/dma.h>
 #include <mach/dma.h>
 
Index: b/sound/soc/s3c24xx/s3c24xx-i2s.c
===================================================================
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-10-12 21:11:08.000000000 +0100
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-10-12 21:11:39.000000000 +0100
@@ -32,7 +32,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
-#include <plat/audio.h>
+
 #include <asm/dma.h>
 #include <mach/dma.h>
 
Index: b/sound/soc/s3c24xx/s3c24xx-pcm.c
===================================================================
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-10-12 21:11:08.000000000 +0100
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-10-12 21:11:39.000000000 +0100
@@ -29,7 +29,6 @@
 #include <asm/dma.h>
 #include <mach/hardware.h>
 #include <mach/dma.h>
-#include <plat/audio.h>
 
 #include "s3c24xx-pcm.h"
 
Index: b/sound/soc/s3c24xx/neo1973_wm8753.c
===================================================================
--- a/sound/soc/s3c24xx/neo1973_wm8753.c	2009-10-12 21:13:18.000000000 +0100
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c	2009-10-12 21:13:29.000000000 +0100
@@ -29,7 +29,6 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <mach/hardware.h>
-#include <plat/audio.h>
 #include <linux/io.h>
 #include <mach/spi-gpio.h>
 
Index: b/sound/soc/s3c24xx/s3c64xx-i2s.c
===================================================================
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c	2009-10-12 21:13:35.000000000 +0100
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c	2009-10-12 21:13:40.000000000 +0100
@@ -31,7 +31,6 @@
 #include <plat/gpio-bank-d.h>
 #include <plat/gpio-bank-e.h>
 #include <plat/gpio-cfg.h>
-#include <plat/audio.h>
 
 #include <mach/map.h>
 #include <mach/dma.h>

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
