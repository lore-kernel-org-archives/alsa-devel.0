From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: OMAP: Add functionality to set CLKR and
	FSR sources in McBSP DAI
Date: Fri, 28 Aug 2009 15:35:35 +0300
Message-ID: <1251462935-28373-1-git-send-email-jhnikula@gmail.com>
References: <20090828120519.GA15915@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E84C24133
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 14:35:38 +0200 (CEST)
Received: by ewy10 with SMTP id 10so2350543ewy.13
	for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2009 05:35:37 -0700 (PDT)
In-Reply-To: <20090828120519.GA15915@opensource.wolfsonmicro.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The McBSP1 port in OMAP3 processors (I believe OMAP2 too but I don't have
specifications to check it) have additional CLKR and FSR pins for McBSP1
receiver. Reset default is that receiver is using bit clock and frame
sync signal from those pins but it is possible to configure to use
also CLKX and FSX pins as well. In fact, other McBSP ports are doing that
internally that transmitter and receiver share the CLKX and FSX.

Add functionaly that machine drivers can set the CLKR and FSR sources by
using the snd_soc_dai_set_sysclk.

Thanks to "Aggarwal, Anuj" <anuj.aggarwal@ti.com> for reporting the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/omap-mcbsp.c |   41 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.h |    4 ++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 0e173e7..3341f49 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -512,6 +512,40 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 	return 0;
 }
 
+static int omap_mcbsp_dai_set_rcvr_src(struct omap_mcbsp_data *mcbsp_data,
+				       int clk_id)
+{
+	int sel_bit, set = 0;
+	u16 reg = OMAP2_CONTROL_DEVCONF0;
+
+	if (cpu_class_is_omap1())
+		return -EINVAL; /* TODO: Can this be implemented for OMAP1? */
+	if (mcbsp_data->bus_id != 0)
+		return -EINVAL;
+
+	switch (clk_id) {
+	case OMAP_MCBSP_CLKR_SRC_CLKX:
+		set = 1;
+	case OMAP_MCBSP_CLKR_SRC_CLKR:
+		sel_bit = 3;
+		break;
+	case OMAP_MCBSP_FSR_SRC_FSX:
+		set = 1;
+	case OMAP_MCBSP_FSR_SRC_FSR:
+		sel_bit = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (set)
+		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
+	else
+		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
+
+	return 0;
+}
+
 static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
@@ -534,6 +568,13 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
 		regs->pcr0	|= SCLKME;
 		break;
+
+	case OMAP_MCBSP_CLKR_SRC_CLKR:
+	case OMAP_MCBSP_CLKR_SRC_CLKX:
+	case OMAP_MCBSP_FSR_SRC_FSR:
+	case OMAP_MCBSP_FSR_SRC_FSX:
+		err = omap_mcbsp_dai_set_rcvr_src(mcbsp_data, clk_id);
+		break;
 	default:
 		err = -ENODEV;
 	}
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index c8147aa..647d2f9 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -32,6 +32,10 @@ enum omap_mcbsp_clksrg_clk {
 	OMAP_MCBSP_SYSCLK_CLK,		/* Internal ICLK */
 	OMAP_MCBSP_SYSCLK_CLKX_EXT,	/* External CLKX pin */
 	OMAP_MCBSP_SYSCLK_CLKR_EXT,	/* External CLKR pin */
+	OMAP_MCBSP_CLKR_SRC_CLKR,	/* CLKR from CLKR pin */
+	OMAP_MCBSP_CLKR_SRC_CLKX,	/* CLKR from CLKX pin */
+	OMAP_MCBSP_FSR_SRC_FSR,		/* FSR from FSR pin */
+	OMAP_MCBSP_FSR_SRC_FSX,		/* FSR from FSX pin */
 };
 
 /* McBSP dividers */
-- 
1.6.3.3
