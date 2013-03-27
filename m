From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/2] ARM: clk: Bugfix imx35 iomux clock
Date: Wed, 27 Mar 2013 12:22:31 +0100
Message-ID: <1364383352-27267-2-git-send-email-mpa@pengutronix.de>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Sascha Hauer <kernel@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Markus Pargmann <mpa@pengutronix.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch enables iomuxc_gate clock. It is necessary to be able to
reconfigure iomux pads. Without this clock enabled, the
clk_disable_unused function will disable this clock and the iomux pads
are not configurable anymore. This happens at every boot. After a reboot
(watchdog system reset) the clock is not enabled again, so all iomux pad
reconfigurations in boot code are without effect.

The iomux pads should be always configurable, so this patch always
enables it.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Cc: stable@vger.kernel.org
---
 arch/arm/mach-imx/clk-imx35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index e13a8fa..b95898a 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -265,6 +265,7 @@ int __init mx35_clocks_init(void)
 	clk_prepare_enable(clk[iim_gate]);
 	clk_prepare_enable(clk[emi_gate]);
 	clk_prepare_enable(clk[max_gate]);
+	clk_prepare_enable(clk[iomuxc_gate]);
 
 	/*
 	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
-- 
1.8.2.rc2
