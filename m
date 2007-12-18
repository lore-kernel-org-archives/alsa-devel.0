From: Harald Welte <laforge@openmoko.org>
Subject: [PATCH 3/12] neo1973: ASoC include pathname fix
Date: Tue, 18 Dec 2007 12:07:00 +0100
Message-ID: <20071218110700.GJ29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ED7624466
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 12:10:08 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

[PATCH] Fix s3c24xx include file path changes in asoc driver

Signed-off-by: Harald Welte <laforge@openmoko.org>

---

Index: linux-2.6.22/sound/soc/s3c24xx/neo1973_wm8753.c
===================================================================
--- linux-2.6.22.orig/sound/soc/s3c24xx/neo1973_wm8753.c
+++ linux-2.6.22/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -30,13 +30,15 @@
 
 #include <asm/mach-types.h>
 #include <asm/hardware/scoop.h>
-#include <asm/arch/regs-iis.h>
 #include <asm/arch/regs-clock.h>
 #include <asm/arch/regs-gpio.h>
 #include <asm/hardware.h>
 #include <asm/arch/audio.h>
 #include <asm/io.h>
 #include <asm/arch/spi-gpio.h>
+
+#include <asm/plat-s3c24xx/regs-iis.h>
+
 #include "../codecs/wm8753.h"
 #include "lm4857.h"
 #include "s3c24xx-pcm.h"
Index: linux-2.6.22/sound/soc/s3c24xx/s3c24xx-i2s.c
===================================================================
--- linux-2.6.22.orig/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ linux-2.6.22/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -33,13 +33,14 @@
 
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/arch/regs-iis.h>
 #include <asm/arch/regs-gpio.h>
 #include <asm/arch/regs-clock.h>
 #include <asm/arch/audio.h>
 #include <asm/dma.h>
 #include <asm/arch/dma.h>
 
+#include <asm/plat-s3c24xx/regs-iis.h>
+
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-i2s.h"
 
-- 
- Harald Welte <laforge@openmoko.org>          	        http://openmoko.org/
============================================================================
Software for the world's first truly open Free Software mobile phone
