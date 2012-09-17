From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 33/34] ARM: imx: remove header file mach/irqs.h
Date: Mon, 17 Sep 2012 13:35:02 +0800
Message-ID: <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 122FF2615F1
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 07:37:28 +0200 (CEST)
Received: by pbbro8 with SMTP id ro8so10200165pbb.38
 for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2012 22:37:28 -0700 (PDT)
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The only mach/irqs.h user outside arch/arm/mach-imx is
sound/soc/fsl/imx-pcm-fiq.c, which refers to mxc_set_irq_fiq().
Though moving the declaration into imx-pcm-fiq.c will result in
the checkpatch below, let's do it to gain the multi-platform support
for mach-imx.

 WARNING: externs should be avoided in .c files

Inside arch/arm/mach-imx, the only users to mach/irqs.h are avic.c
and tzic.c for referring to macro FIQ_START.  Let's move the macro
into irq-common.h and get rid of mach/irqs.h completely.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 arch/arm/mach-imx/avic.c              |    1 -
 arch/arm/mach-imx/include/mach/irqs.h |   21 ---------------------
 arch/arm/mach-imx/irq-common.h        |    3 +++
 arch/arm/mach-imx/tzic.c              |    2 --
 sound/soc/fsl/imx-pcm-fiq.c           |    3 ++-
 5 files changed, 5 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-imx/include/mach/irqs.h

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index adc64bc..0eff23e 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 #include "hardware.h"
diff --git a/arch/arm/mach-imx/include/mach/irqs.h b/arch/arm/mach-imx/include/mach/irqs.h
deleted file mode 100644
index d73f5e8..0000000
--- a/arch/arm/mach-imx/include/mach/irqs.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_IRQS_H__
-#define __ASM_ARCH_MXC_IRQS_H__
-
-extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
-
-/* all normal IRQs can be FIQs */
-#define FIQ_START	0
-/* switch between IRQ and FIQ */
-extern int mxc_set_irq_fiq(unsigned int irq, unsigned int type);
-
-#endif /* __ASM_ARCH_MXC_IRQS_H__ */
diff --git a/arch/arm/mach-imx/irq-common.h b/arch/arm/mach-imx/irq-common.h
index 6ccb3a1..5b2dabb 100644
--- a/arch/arm/mach-imx/irq-common.h
+++ b/arch/arm/mach-imx/irq-common.h
@@ -19,6 +19,9 @@
 #ifndef __PLAT_MXC_IRQ_COMMON_H__
 #define __PLAT_MXC_IRQ_COMMON_H__
 
+/* all normal IRQs can be FIQs */
+#define FIQ_START	0
+
 struct mxc_extra_irq
 {
 	int (*set_priority)(unsigned char irq, unsigned char prio);
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index c7625b4..9721161 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -21,8 +21,6 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include <mach/irqs.h>
-
 #include "common.h"
 #include "hardware.h"
 #include "irq-common.h"
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 22c6130..84c9aed 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -29,7 +29,6 @@
 
 #include <asm/fiq.h>
 
-#include <mach/irqs.h>
 #include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "imx-ssi.h"
@@ -269,6 +268,8 @@ static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+extern int mxc_set_irq_fiq(unsigned int irq, unsigned int type);
+
 static void imx_pcm_fiq_free(struct snd_pcm *pcm)
 {
 	mxc_set_irq_fiq(ssi_irq, 0);
-- 
1.7.9.5
