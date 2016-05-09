From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: davinci-mcasp: Calculate AUXCLK
	divider when setting up master clocks
Date: Mon, 9 May 2016 13:42:32 +0300
Message-ID: <1462790552-6438-5-git-send-email-peter.ujfalusi@ti.com>
References: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1146B2657C3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:42:43 +0200 (CEST)
In-Reply-To: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

If the McASP is used as clock master and the reference clock is AUXCLK we
can have additional level of divider. The BCLK divider is limited to
maximum 32, if the desired bclk can not be reached with this, the AUXCLK
divider also needs to be used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 3df9565c1645..0f66fda2c772 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1003,13 +1003,31 @@ static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
 				      unsigned int bclk_freq, bool set)
 {
 	int error_ppm;
-	int div = mcasp->sysclk_freq / bclk_freq;
-	int rem = mcasp->sysclk_freq % bclk_freq;
+	unsigned int sysclk_freq = mcasp->sysclk_freq;
+	u32 reg = mcasp_get_reg(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG);
+	int div = sysclk_freq / bclk_freq;
+	int rem = sysclk_freq % bclk_freq;
+	int aux_div = 1;
+
+	if (div > (ACLKXDIV_MASK + 1)) {
+		if (reg & AHCLKXE) {
+			aux_div = div / (ACLKXDIV_MASK + 1);
+			if (div % (ACLKXDIV_MASK + 1))
+				aux_div++;
+
+			sysclk_freq /= aux_div;
+			div = sysclk_freq / bclk_freq;
+			rem = sysclk_freq % bclk_freq;
+		} else if (set) {
+			dev_warn(mcasp->dev, "Too fast reference clock (%u)\n",
+				 sysclk_freq);
+		}
+	}
 
 	if (rem != 0) {
 		if (div == 0 ||
-		    ((mcasp->sysclk_freq / div) - bclk_freq) >
-		    (bclk_freq - (mcasp->sysclk_freq / (div+1)))) {
+		    ((sysclk_freq / div) - bclk_freq) >
+		    (bclk_freq - (sysclk_freq / (div+1)))) {
 			div++;
 			rem = rem - bclk_freq;
 		}
@@ -1023,6 +1041,9 @@ static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
 				 error_ppm);
 
 		__davinci_mcasp_set_clkdiv(mcasp, MCASP_CLKDIV_BCLK, div, 0);
+		if (reg & AHCLKXE)
+			__davinci_mcasp_set_clkdiv(mcasp, MCASP_CLKDIV_AUXCLK,
+						   aux_div, 0);
 	}
 
 	return error_ppm;
-- 
2.8.2
