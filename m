From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Correct clock muxing for
	CLKR/FSR signals
Date: Thu,  8 Mar 2012 13:39:32 +0200
Message-ID: <1331206772-19716-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 429A710B9F6
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 12:39:47 +0100 (CET)
Received: by lagj5 with SMTP id j5so480468lag.31
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 03:39:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Remove the no longer valid check for McBSP1 regarding to signal mux
selection (on OMAP4 McBSP4 has 6 pin setup).
Only clear the srgr2, pcr0 register configuration if the requested clock
configuration will actually going to touch it. In this way we can avoid
issues if the CLKR/FSR mux has been configured after the clock selection.

We are going to check for the valid McBSP port in the
omap_mcbsp_6pin_src_mux() function based on the validity of the mux_signal
callback (which is only valid for ports having 6 pin setup).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello,

this patch fixes the remaining issue with the CLKR/FSR mux code.
The code in omap-mcbsp.c was checking for McBSP1 to let the mux to be
configured, which is no longer valid.
In omap-mcbsp.c we are only checking for OMAP version (OMAP1 does not have 6 pin
setup), and let the underlying code handle the validity of the McBSP port.

This patch depends on my previous CLKR/FSR series.

Regards,
Peter

 sound/soc/omap/mcbsp.c      |    9 ++++-----
 sound/soc/omap/omap-mcbsp.c |   34 +++++++++++++++-------------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 95413a1..e5f4444 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -690,7 +690,9 @@ int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
 {
 	const char *signal, *src;
-	int ret = 0;
+
+	if (mcbsp->pdata->mux_signal)
+		return -EINVAL;
 
 	switch (mux) {
 	case CLKR_SRC_CLKR:
@@ -713,10 +715,7 @@ int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
 		return -EINVAL;
 	}
 
-	if (mcbsp->pdata->mux_signal)
-		ret = mcbsp->pdata->mux_signal(mcbsp->dev, signal, src);
-
-	return ret;
+	return mcbsp->pdata->mux_signal(mcbsp->dev, signal, src);
 }
 
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d8409b0..626e2d6 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -511,17 +511,21 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			return -EBUSY;
 	}
 
-	/* The McBSP signal muxing functions are only available on McBSP1 */
-	if (clk_id == OMAP_MCBSP_CLKR_SRC_CLKR ||
-	    clk_id == OMAP_MCBSP_CLKR_SRC_CLKX ||
-	    clk_id == OMAP_MCBSP_FSR_SRC_FSR ||
-	    clk_id == OMAP_MCBSP_FSR_SRC_FSX)
-		if (cpu_class_is_omap1() || cpu_dai->id != 1)
-			return -EINVAL;
-
-	mcbsp->in_freq = freq;
-	regs->srgr2	&= ~CLKSM;
-	regs->pcr0	&= ~SCLKME;
+	if (clk_id == OMAP_MCBSP_SYSCLK_CLK ||
+	    clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK ||
+	    clk_id == OMAP_MCBSP_SYSCLK_CLKS_EXT ||
+	    clk_id == OMAP_MCBSP_SYSCLK_CLKX_EXT ||
+	    clk_id == OMAP_MCBSP_SYSCLK_CLKR_EXT) {
+		mcbsp->in_freq = freq;
+		regs->srgr2	&= ~CLKSM;
+		regs->pcr0	&= ~SCLKME;
+	} else if (cpu_class_is_omap1()) {
+		/*
+		 * McBSP CLKR/FSR signal muxing functions are only available on
+		 * OMAP2 or newer versions
+		 */
+		return -EINVAL;
+	}
 
 	switch (clk_id) {
 	case OMAP_MCBSP_SYSCLK_CLK:
@@ -552,23 +556,15 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 
 
 	case OMAP_MCBSP_CLKR_SRC_CLKR:
-		if (cpu_class_is_omap1())
-			break;
 		err = omap_mcbsp_6pin_src_mux(mcbsp, CLKR_SRC_CLKR);
 		break;
 	case OMAP_MCBSP_CLKR_SRC_CLKX:
-		if (cpu_class_is_omap1())
-			break;
 		err = omap_mcbsp_6pin_src_mux(mcbsp, CLKR_SRC_CLKX);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSR:
-		if (cpu_class_is_omap1())
-			break;
 		err = omap_mcbsp_6pin_src_mux(mcbsp, FSR_SRC_FSR);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSX:
-		if (cpu_class_is_omap1())
-			break;
 		err = omap_mcbsp_6pin_src_mux(mcbsp, FSR_SRC_FSX);
 		break;
 	default:
-- 
1.7.8.5
