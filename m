From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: [PATCH] Patch Dreamcast AICA driver to handle Maple
	bus support
Date: Sun, 9 Sep 2007 21:22:17 +0100
Message-ID: <92a12cdb0709091322r5dd65f5dse0668cff4fbd43b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ECB7243DF
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 22:22:22 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1352259wag
	for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2007 13:22:21 -0700 (PDT)
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
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net
Cc: Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

This patches the AICA sound driver for the Dreamcast to handle the
well known flakiness of the Dreamcast's G2 bus.

This is dependent on getting Maple bus support (see
http://lkml.org/lkml/2007/9/9/70) into the kernel.

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 7397865..a42c58f 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -35,6 +35,7 @@
 #include <linux/timer.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/maple.h>
 #include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -43,7 +44,7 @@
 #include <sound/info.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#include <asm/dreamcast/sysasic.h>
+#include <asm/mach/sysasic.h>
 #include "aica.h"

 MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
@@ -218,6 +219,12 @@ static int aica_dma_transfer(int channels, int buffer_size,
 	period_offset = dreamcastcard->clicks;
 	period_offset %= (AICA_PERIOD_NUMBER / channels);
 	runtime = substream->runtime;
+	/* If maple dma is running, wait for it to finish */
+	do{ cpu_relax();}
+	while (!maple_dma_done());
+	/* Turn off the maple dma now */
+	ctrl_outl(0, MAPLE_ENABLE);
+	local_irq_disable();	
 	for (q = 0; q < channels; q++) {
 		err = dma_xfer(AICA_DMA_CHANNEL,
 			       (unsigned long) (runtime->dma_area +
@@ -232,6 +239,9 @@ static int aica_dma_transfer(int channels, int buffer_size,
 			break;
 		dma_wait_for_completion(AICA_DMA_CHANNEL);
 	}
+	/* restore maple dma */
+	local_irq_enable();
+	maplebus_init_hardware();
 	return err;
 }
