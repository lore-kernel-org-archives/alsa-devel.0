From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] ASoC: mcbsp: Trivial cleanup in asoc-ti-mcbsp.h
Date: Mon, 30 Dec 2013 10:37:48 +0530
Message-ID: <1388380068-31424-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 60391261680
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 06:11:25 +0100 (CET)
Received: by mail-pa0-f49.google.com with SMTP id kx10so11245044pab.22
 for <alsa-devel@alsa-project.org>; Sun, 29 Dec 2013 21:11:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, broonie@kernel.org, trivial@kernel.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 2203747c9771 ("ARM: omap: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/asoc-ti-mcbsp.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/platform_data/asoc-ti-mcbsp.h
index c78d90b28b19..3c73c045f8da 100644
--- a/include/linux/platform_data/asoc-ti-mcbsp.h
+++ b/include/linux/platform_data/asoc-ti-mcbsp.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/mach/mcbsp.h
- *
  * Defines for Multi-Channel Buffered Serial Port
  *
  * Copyright (C) 2002 RidgeRun, Inc.
@@ -21,8 +19,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  */
-#ifndef __ASM_ARCH_OMAP_MCBSP_H
-#define __ASM_ARCH_OMAP_MCBSP_H
+#ifndef __ASOC_TI_MCBSP_H
+#define __ASOC_TI_MCBSP_H
 
 #include <linux/spinlock.h>
 #include <linux/clk.h>
-- 
1.7.9.5
