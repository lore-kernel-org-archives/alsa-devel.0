From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: [PATCH] alsa: fix invalid hardware.h include in ac97c
	for AVR32 architecture
Date: Mon, 24 Jan 2011 16:09:56 +0100
Message-ID: <1295881796-27625-1-git-send-email-hcegtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [194.19.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 325DA244B4
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 16:10:33 +0100 (CET)
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
Cc: kernel@avr32linux.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

This patch fixes the non-compiling AC97C driver for AVR32 architecture by
include mach/hardware.h only for AT91 architecture. The AVR32 architecture does
not supply the hardware.h include file.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
CC: stable@vger.kernel.org
---
This patch also applies to the stable kernels, as the ac97c.c file has not been
compilable for AVR32 since commit 7177395fdd919e561544a7d1c0ac196098a2ae2d

 sound/atmel/ac97c.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 10c3a87..b310702 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -33,9 +33,12 @@
 #include <linux/dw_dmac.h>
 
 #include <mach/cpu.h>
-#include <mach/hardware.h>
 #include <mach/gpio.h>
 
+#ifdef CONFIG_ARCH_AT91
+#include <mach/hardware.h>
+#endif
+
 #include "ac97c.h"
 
 enum {
-- 
1.7.1
