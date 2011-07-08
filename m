From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 05/10] ARM: mxs: add saif clock
Date: Fri, 8 Jul 2011 23:59:45 +0800
Message-ID: <1310140790-2132-6-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310140790-2132-1-git-send-email-b29396@freescale.com>
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
Cc: s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Set pll0 as parent.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
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
