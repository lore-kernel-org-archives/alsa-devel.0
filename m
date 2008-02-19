From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Support AC97CLK on PXA3xx via the clock API
Date: Tue, 19 Feb 2008 16:04:16 +0000
Message-ID: <1203437058-7288-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080219160341.GA6387@rakim.wolfsonmicro.main>
	<1203437058-7288-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E445103939
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 17:04:20 +0100 (CET)
In-Reply-To: <1203437058-7288-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.miao@marvell.com>, Russell King <rmk@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The AC97 clock rate on PXA3xx is generated with a configurable divider
from sys_pll.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/pxa3xx.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 696f606..df568e5 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -110,6 +110,25 @@ unsigned int pxa3xx_get_memclk_frequency_10khz(void)
 }
 
 /*
+ * Return the current AC97 clock frequency.
+ */
+static unsigned long clk_pxa3xx_ac97_getrate(struct clk *clk)
+{
+	unsigned long rate = 312000000;
+	unsigned long ac97_div;
+
+	ac97_div = AC97_DIV;
+
+	/* This may loose precision for some rates but won't for the 
+	 * standard 24.576MHz.
+	 */
+	rate /= (ac97_div >> 12) & 0x7fff;
+	rate *= (ac97_div & 0xfff);
+
+	return rate;
+}
+
+/*
  * Return the current HSIO bus clock frequency
  */
 static unsigned long clk_pxa3xx_hsio_getrate(struct clk *clk)
@@ -164,6 +183,12 @@ static const struct clkops clk_pxa3xx_hsio_ops = {
 	.getrate	= clk_pxa3xx_hsio_getrate,
 };
 
+static const struct clkops clk_pxa3xx_ac97_ops = {
+	.enable		= clk_pxa3xx_cken_enable,
+	.disable	= clk_pxa3xx_cken_disable,
+	.getrate	= clk_pxa3xx_ac97_getrate,
+};
+
 static void clk_pout_enable(struct clk *clk)
 {
 	OSCC |= OSCC_PEN;
@@ -205,8 +230,9 @@ static struct clk pxa3xx_clks[] = {
 		.delay          = 70,
 	},
 
-	PXA3xx_CK("LCDCLK", LCD,    &clk_pxa3xx_hsio_ops, &pxa_device_fb.dev),
-	PXA3xx_CK("CAMCLK", CAMERA, &clk_pxa3xx_hsio_ops, NULL),
+	PXA3xx_CK("LCDCLK",  LCD,    &clk_pxa3xx_hsio_ops, &pxa_device_fb.dev),
+	PXA3xx_CK("CAMCLK",  CAMERA, &clk_pxa3xx_hsio_ops, NULL),
+	PXA3xx_CK("AC97CLK", AC97,   &clk_pxa3xx_ac97_ops, NULL),
 
 	PXA3xx_CKEN("UARTCLK", FFUART, 14857000, 1, &pxa_device_ffuart.dev),
 	PXA3xx_CKEN("UARTCLK", BTUART, 14857000, 1, &pxa_device_btuart.dev),
-- 
1.5.4.2
