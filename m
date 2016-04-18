From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 3/7] ARM: davinci: da850: add clocks for mcbsp0 and 1
Date: Mon, 18 Apr 2016 14:32:42 +0200
Message-ID: <1460982766-18632-4-git-send-email-petr@barix.com>
References: <1460982766-18632-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460982766-18632-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add clock definitions "davinci-mcbsp.0" and "davinci-mcbsp.1" in order
to make McBSP driver work on the DA850 platform.

The McBSP 0 and 1 interfaces were not defined for the DA850 platform.
Neither were the related clocks. In order to make the use of McBSP via
devicetree the clocks need to be defined.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
v1: initial
v2: no change
v3: no change

 arch/arm/mach-davinci/da850.c | 16 ++++++++++++++++
 arch/arm/mach-davinci/psc.h   |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 97d8779a9a65..2b9d972e30ac 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -306,6 +306,20 @@ static struct clk mcasp_clk = {
 	.flags		= DA850_CLK_ASYNC3,
 };
 
+static struct clk mcbsp0_clk = {
+	.name		= "mcbsp0",
+	.parent		= &pll1_sysclk2,
+	.lpsc		= DA850_LPSC1_McBSP0,
+	.gpsc		= 1,
+};
+
+static struct clk mcbsp1_clk = {
+	.name		= "mcbsp1",
+	.parent		= &pll1_sysclk2,
+	.lpsc		= DA850_LPSC1_McBSP1,
+	.gpsc		= 1,
+};
+
 static struct clk lcdc_clk = {
 	.name		= "lcdc",
 	.parent		= &pll0_sysclk2,
@@ -464,6 +478,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
 	CLK("davinci_mdio.0",	"fck",		&emac_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
+	CLK("davinci-mcbsp.0",	NULL,		&mcbsp0_clk),
+	CLK("davinci-mcbsp.1",	NULL,		&mcbsp1_clk),
 	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
diff --git a/arch/arm/mach-davinci/psc.h b/arch/arm/mach-davinci/psc.h
index 99d47cfa301f..8af9f09fc10c 100644
--- a/arch/arm/mach-davinci/psc.h
+++ b/arch/arm/mach-davinci/psc.h
@@ -171,6 +171,8 @@
 #define DA8XX_LPSC1_I2C			11
 #define DA8XX_LPSC1_UART1		12
 #define DA8XX_LPSC1_UART2		13
+#define DA850_LPSC1_McBSP0		14
+#define DA850_LPSC1_McBSP1		15
 #define DA8XX_LPSC1_LCDC		16
 #define DA8XX_LPSC1_PWM			17
 #define DA850_LPSC1_MMC_SD1		18
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
