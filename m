From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V5 1/5] powerpc: introduce macro
	spin_event_timeout()
Date: Tue, 26 May 2009 08:34:06 -0400
Message-ID: <20090526123406.17472.79948.stgit@terra>
References: <20090526123235.17472.73912.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id DBA8824790
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 14:34:09 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so2769045ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 05:34:08 -0700 (PDT)
In-Reply-To: <20090526123235.17472.73912.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

The macro spin_event_timeout() takes a condition and timeout value
(in microseconds) as parameters.  It spins until either the condition is true
or the timeout expires.  It returns the result of the condition when the loop
was terminated.

This primary purpose of this macro is to poll on a hardware register until a
status bit changes.  The timeout ensures that the loop still terminates if the
bit doesn't change as expected.  This macro makes it easier for driver
developers to perform this kind of operation properly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/delay.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index f9200a6..af4a270 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -2,8 +2,11 @@
 #define _ASM_POWERPC_DELAY_H
 #ifdef __KERNEL__
 
+#include <asm/time.h>
+
 /*
  * Copyright 1996, Paul Mackerras.
+ * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -30,5 +33,35 @@ extern void udelay(unsigned long usecs);
 #define mdelay(n)	udelay((n) * 1000)
 #endif
 
+/**
+ * spin_event_timeout - spin until a condition gets true or a timeout elapses
+ * @condition: a C expression to evalate
+ * @timeout: timeout, in microseconds
+ * @delay: the number of microseconds to delay between eache evaluation of
+ *         @condition
+ * @rc: the last value of the condition
+ *
+ * The process spins until the condition evaluates to true (non-zero) or the
+ * timeout elapses.  Upon exit, @rc contains the value of the condition. This
+ * allows you to test the condition without incurring any side effects.
+ *
+ * This primary purpose of this macro is to poll on a hardware register
+ * until a status bit changes.  The timeout ensures that the loop still
+ * terminates even if the bit never changes.  The delay is for devices that
+ * need a delay in between successive reads.
+ *
+ * gcc will optimize out the if-statement if @delay is a constant.
+ */
+#define spin_event_timeout(condition, timeout, delay, rc)                   \
+{                                                                           \
+	unsigned long __loops = tb_ticks_per_usec * timeout;                \
+	unsigned long __start = get_tbl();                                  \
+	while (!(rc = (condition)) && (tb_ticks_since(__start) <= __loops)) \
+		if (delay)                                                  \
+			udelay(delay);                                      \
+		else	                                                    \
+			cpu_relax();                                        \
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DELAY_H */
