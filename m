From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 2/2] clk: imx: add kpp clock for i.MX6UL
Date: Tue, 12 Jan 2016 18:29:19 +0100
Message-ID: <1452619759-14474-3-git-send-email-LW@KARO-electronics.de>
References: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
 <1452619759-14474-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452619759-14474-2-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bai Ping <b51503-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Xiubo Li <Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-fy+rA21nqHI@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add the necessary clock to use the KPP interface on i.MX6UL.

Signed-off-by: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
---
 drivers/clk/imx/clk-imx6ul.c             | 1 +
 include/dt-bindings/clock/imx6ul-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.=
c
index 3e31ec0..1ee28d3 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -365,6 +365,7 @@ static void __init imx6ul_clocks_init(struct device=
_node *ccm_node)
 	/* CCGR5 */
 	clks[IMX6UL_CLK_ROM]		=3D imx_clk_gate2("rom",		"ahb",		base + 0x7c,	=
0);
 	clks[IMX6UL_CLK_SDMA]		=3D imx_clk_gate2("sdma",		"ahb",		base + 0x7c=
,	6);
+	clks[IMX6UL_CLK_KPP]		=3D imx_clk_gate2("kpp",		"ipg",		base + 0x7c,	=
8);
 	clks[IMX6UL_CLK_WDOG2]		=3D imx_clk_gate2("wdog2",	"ipg",		base + 0x7=
c,	10);
 	clks[IMX6UL_CLK_SPBA]		=3D imx_clk_gate2("spba",		"ipg",		base + 0x7c=
,	12);
 	clks[IMX6UL_CLK_SPDIF]		=3D imx_clk_gate2_shared("spdif",		"spdif_pod=
f",	base + 0x7c,	14, &share_count_audio);
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bind=
ings/clock/imx6ul-clock.h
index 08ce4a7..fd8aee8 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -234,7 +234,8 @@
 #define IMX6UL_CLK_CSI_SEL		221
 #define IMX6UL_CLK_CSI_PODF		222
 #define IMX6UL_CLK_PLL3_120M		223
+#define IMX6UL_CLK_KPP			224
=20
-#define IMX6UL_CLK_END			224
+#define IMX6UL_CLK_END			225
=20
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
