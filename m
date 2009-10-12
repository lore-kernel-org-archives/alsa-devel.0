From: Ben Dooks <ben@simtec.co.uk>
Subject: gta02: fix includes
Date: Mon, 12 Oct 2009 21:17:00 +0100
Message-ID: <20091012201700.042515646@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A7ED103866
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 22:21:13 +0200 (CEST)
Content-Disposition: inline; filename=fix-gta02-audio.patch
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

The gta02 build is missing <mach/regs-gpio.h> and is also using the
incorrect <asm/io.h> header (it should be <linux/io.h>). Fix these
two problems.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
===================================================================
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c	2009-10-10 22:55:53.000000000 +0100
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c	2009-10-10 22:58:31.000000000 +0100
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -29,7 +31,7 @@
 #include <plat/regs-iis.h>
 
 #include <mach/regs-clock.h>
-#include <asm/io.h>
+#include <mach/regs-gpioj.h>
 #include <mach/gta02.h>
 #include "../codecs/wm8753.h"
 #include "s3c24xx-pcm.h"

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
