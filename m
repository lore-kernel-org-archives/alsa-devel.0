From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] soc: neo1973_wm8753 audio support does not require scoop
Date: Fri, 28 Jan 2011 12:00:18 -0700
Message-ID: <201101281200.18371.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This driver does not use any of the functionality provided by the scoop
hardware.  Remove the unneeded header.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index c7a2451..c5b3113 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -24,7 +24,6 @@
 #include <sound/tlv.h>
 
 #include <asm/mach-types.h>
-#include <asm/hardware/scoop.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <mach/hardware.h>
