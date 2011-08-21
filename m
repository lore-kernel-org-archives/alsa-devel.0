From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 2/3] ARM: mx28evk: set a initial clock rate for
	saif
Date: Mon, 22 Aug 2011 01:05:00 +0800
Message-ID: <1313946300-3861-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CD342447B
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Aug 2011 18:52:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de, lrg@ti.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>

---
Note this patch still needs another patch from Wolfram to work.
I send out it in this series as
[PATCH 3/3] arm: mxs: disable clock-gates when setting saif-clocks

As discussed with Wolfram, that patch may still have some later work
to do. However, we just send out it for testers to work first.
---
 arch/arm/mach-mxs/clock-mx28.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index f589c6c..2a2db65 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -788,6 +788,15 @@ int __init mx28_clocks_init(void)
 	clk_set_parent(&saif0_clk, &pll0_clk);
 	clk_set_parent(&saif1_clk, &pll0_clk);
 
+	/*
+	 * Set an initial clk rate for saif's internal logic to work properly,
+	 * this is especially for the saif working on EXTMASTER mode that who
+	 * uses other saif's BITCLK&LRCLK but it still needs a basic clk which
+	 * should be bigger enough for its internal logic.
+	 */
+	clk_set_rate(&saif0_clk, 24000000);
+	clk_set_rate(&saif1_clk, 24000000);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);
-- 
1.7.0.4
