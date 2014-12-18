From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] ALSA: atmel: fix building the ac97 driver for
	at91-multiplatform
Date: Fri, 19 Dec 2014 00:13:10 +0100
Message-ID: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F31F26048D
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 00:13:14 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Alexander Stein <alexanders83@web.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Arnd Bergmann <arnd@arndb.de>

at91 will no longer export the mach/cpu.h and mach/hardware.h header files
in the future, which would break building the atmel ac97c driver.

Since the cpu_is_* check is only used to find out whether we are running
on avr32 or arm/at91, we can hardcode that check in the ARM case.

Unfortunately the driver is missing other work to be useful again on ARM,
if anyone wants to actually use it, they need to add a DT binding, and
the driver should really be converted to use the ASoC framework.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: http://www.spinics.net/lists/arm-kernel/msg382068.html
---
 sound/atmel/ac97c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index b59427d5a697..83975f8d5947 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -34,10 +34,10 @@
 #include <linux/platform_data/dma-dw.h>
 #include <linux/dma/dw.h>
 
+#ifdef CONFIG_AVR32
 #include <mach/cpu.h>
-
-#ifdef CONFIG_ARCH_AT91
-#include <mach/hardware.h>
+#else
+#define cpu_is_at32ap7000() (0)
 #endif
 
 #include "ac97c.h"
-- 
2.1.0
