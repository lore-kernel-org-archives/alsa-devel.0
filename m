From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ASoC: davinci-mcasp: Improve the sysclk
	selection
Date: Mon, 15 Feb 2016 16:11:33 +0200
Message-ID: <1455545495-20292-3-git-send-email-peter.ujfalusi@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id E8316261ADB
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:11:46 +0100 (CET)
In-Reply-To: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

When McASP is master the bclk can be generated from two main source:
AUXCLK: functional clock for McASP or
AHCLK: from external source or internal mux in dra7x family

With this patch it is possible to select between the two source. The patch
is not breaking existing machine drivers since historically the clk_id was
ignored and left as 0 in all cases.

When output clock is configured - which can be only the AHCLK, we select
the AUXCLK as source for the internal HCLK. In this case the HCLK rate is
the same as the output clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/dt-bindings/sound/ti-mcasp.h |  4 ++++
 sound/soc/davinci/davinci-mcasp.c    | 34 +++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/dt-bindings/sound/ti-mcasp.h b/include/dt-bindings/sound/ti-mcasp.h
index 03519ab67b44..86ee4d0d79b5 100644
--- a/include/dt-bindings/sound/ti-mcasp.h
+++ b/include/dt-bindings/sound/ti-mcasp.h
@@ -1,6 +1,10 @@
 #ifndef _DT_BINDINGS_TI_MCASP_H
 #define _DT_BINDINGS_TI_MCASP_H
 
+/* Source of High-frequency transmit/receive clock */
+#define MCASP_CLK_HCLK_AHCLK		0 /* AHCLKX/R */
+#define MCASP_CLK_HCLK_AUXCLK		1 /* Internal functional clock */
+
 /* clock divider IDs */
 #define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
 #define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a4e40606742a..1bd86c8e7bc8 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -596,18 +596,38 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
 	pm_runtime_get_sync(mcasp->dev);
-	if (dir == SND_SOC_CLOCK_OUT) {
+
+	if (dir == SND_SOC_CLOCK_IN) {
+		switch (clk_id) {
+		case MCASP_CLK_HCLK_AHCLK:
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+			break;
+		case MCASP_CLK_HCLK_AUXCLK:
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			break;
+		default:
+			dev_err(mcasp->dev, "Invalid clk id: %d\n", clk_id);
+			goto out;
+		}
+	} else {
+		/* Select AUXCLK as HCLK */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
-	} else {
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	}
-
+	/*
+	 * When AHCLK X/R is selected to be output it means that the HCLK is
+	 * the same clock - coming via AUXCLK.
+	 */
 	mcasp->sysclk_freq = freq;
-
+out:
 	pm_runtime_put(mcasp->dev);
 	return 0;
 }
-- 
2.7.1
