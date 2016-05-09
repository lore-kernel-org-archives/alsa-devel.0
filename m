From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: davinci-mcasp: Restructure the
	davinci_mcasp_calc_clk_div()
Date: Mon, 9 May 2016 13:42:31 +0300
Message-ID: <1462790552-6438-4-git-send-email-peter.ujfalusi@ti.com>
References: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FC922606F5
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:42:42 +0200 (CEST)
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

Change the return value to error_pmm instead of the BCLK div and handle the
divider configuration to McASP within the function when the set flag is
true.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 47be74d74384..3df9565c1645 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1000,9 +1000,9 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
 }
 
 static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
-				      unsigned int bclk_freq,
-				      int *error_ppm)
+				      unsigned int bclk_freq, bool set)
 {
+	int error_ppm;
 	int div = mcasp->sysclk_freq / bclk_freq;
 	int rem = mcasp->sysclk_freq % bclk_freq;
 
@@ -1014,13 +1014,18 @@ static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
 			rem = rem - bclk_freq;
 		}
 	}
-	if (error_ppm)
-		*error_ppm =
-			(div*1000000 + (int)div64_long(1000000LL*rem,
-						       (int)bclk_freq))
-			/div - 1000000;
+	error_ppm = (div*1000000 + (int)div64_long(1000000LL*rem,
+		     (int)bclk_freq)) / div - 1000000;
 
-	return div;
+	if (set) {
+		if (error_ppm)
+			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
+				 error_ppm);
+
+		__davinci_mcasp_set_clkdiv(mcasp, MCASP_CLKDIV_BCLK, div, 0);
+	}
+
+	return error_ppm;
 }
 
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
@@ -1045,18 +1050,11 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		int slots = mcasp->tdm_slots;
 		int rate = params_rate(params);
 		int sbits = params_width(params);
-		int ppm, div;
 
 		if (mcasp->slot_width)
 			sbits = mcasp->slot_width;
 
-		div = davinci_mcasp_calc_clk_div(mcasp, rate*sbits*slots,
-						 &ppm);
-		if (ppm)
-			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
-				 ppm);
-
-		__davinci_mcasp_set_clkdiv(mcasp, 1, div, 0);
+		davinci_mcasp_calc_clk_div(mcasp, rate * sbits * slots, true);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
@@ -1167,7 +1165,8 @@ static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
 				davinci_mcasp_dai_rates[i];
 			int ppm;
 
-			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq,
+							 false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
 				if (range.empty) {
 					range.min = davinci_mcasp_dai_rates[i];
@@ -1206,8 +1205,9 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 			if (rd->mcasp->slot_width)
 				sbits = rd->mcasp->slot_width;
 
-			davinci_mcasp_calc_clk_div(rd->mcasp, sbits*slots*rate,
-						   &ppm);
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp,
+							 sbits * slots * rate,
+							 false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
 				snd_mask_set(&nfmt, i);
 				count++;
-- 
2.8.2
