From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V2 09/10] ARM: mxs: correct the using of frac div for saif
Date: Wed, 13 Jul 2011 11:40:23 +0800
Message-ID: <1310528423-25143-1-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310483085-31442-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: alsa-devel@alsa-project.org

According to spec, set to 1 is the enable of fractional devide
or the clock can not be generated properly.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
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
