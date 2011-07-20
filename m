From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v4 09/10] ARM: mxs: correct the using of frac
	div for saif
Date: Wed, 20 Jul 2011 11:41:45 +0800
Message-ID: <1311133306-9496-10-git-send-email-b29396@freescale.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 26632103889
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 05:16:31 +0200 (CEST)
In-Reply-To: <1311133306-9496-1-git-send-email-b29396@freescale.com>
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

According to spec, set to 1 is the enable of fractional devide
or the clock can not be generated properly.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 7b3657b..7954013 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -710,11 +710,11 @@ static int clk_misc_init(void)
 
 	/* SAIF has to use frac div for functional operation */
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF0);
-	reg &= ~BM_CLKCTRL_SAIF0_DIV_FRAC_EN;
+	reg |= BM_CLKCTRL_SAIF0_DIV_FRAC_EN;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF0);
 
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF1);
-	reg &= ~BM_CLKCTRL_SAIF1_DIV_FRAC_EN;
+	reg |= BM_CLKCTRL_SAIF1_DIV_FRAC_EN;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_SAIF1);
 
 	/*
-- 
1.7.0.4
