From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v3 05/10] ARM: mxs: add saif clock
Date: Fri, 15 Jul 2011 20:09:35 +0800
Message-ID: <1310731780-1645-6-git-send-email-b29396@freescale.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 41016243F8
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 13:45:36 +0200 (CEST)
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Set pll0 as parent.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5dcc59d..7b3657b 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -640,6 +640,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
 	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
+	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
+	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
 };
 
 static int clk_misc_init(void)
@@ -774,6 +776,8 @@ int __init mx28_clocks_init(void)
 	clk_enable(&uart_clk);
 
 	clk_set_parent(&lcdif_clk, &ref_pix_clk);
+	clk_set_parent(&saif0_clk, &pll0_clk);
+	clk_set_parent(&saif1_clk, &pll0_clk);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-- 
1.7.0.4
