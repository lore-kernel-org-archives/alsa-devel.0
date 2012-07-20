From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 4/4] ARM: mx28evk: add missed clkmux select for
	saif
Date: Fri, 20 Jul 2012 17:20:27 +0800
Message-ID: <1342776027-31758-5-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id F335B265315
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 11:31:30 +0200 (CEST)
In-Reply-To: <1342776027-31758-1-git-send-email-b29396@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, shawn.guo@freescale.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Added missed clkmux setting for mx28evk.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8cac94b..82f27a4 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
+#include <mach/digctl.h>
 
 static int __init mxs_icoll_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
@@ -79,6 +80,8 @@ static void __init imx28_evk_init(void)
 	clk = clk_get_sys("enet_out", NULL);
 	if (!IS_ERR(clk))
 		clk_prepare_enable(clk);
+
+	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
 
 static void __init mxs_machine_init(void)
-- 
1.7.0.4
