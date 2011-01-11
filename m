From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] sound: ASoC: fix migor audio build
Date: Tue, 11 Jan 2011 08:34:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101110829080.3893@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 0967424535
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 08:34:54 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Commit 6d803ba736abb5e122dede70a4720e4843dd6df4 "ARM: 6483/1: arm & sh: 
factorised duplicated clkdev.c" broke compilation of migor audio. Use the 
correct header to fix the problem.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index df13338..6088a6a 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -8,11 +8,11 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clkdev.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
 
-#include <asm/clkdev.h>
 #include <asm/clock.h>
 
 #include <cpu/sh7722.h>
