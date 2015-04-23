From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 3/3] ASoC: davinci-macsp: Optimize implicit
	BLCK sample-rate rule
Date: Thu, 23 Apr 2015 16:16:06 +0300
Message-ID: <27b56f07d42230463c94c141783060baddca7147.1429794271.git.jsarha@ti.com>
References: <cover.1429794271.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 79344261ADB
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 15:16:21 +0200 (CEST)
In-Reply-To: <cover.1429794271.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

There is no need to copy the list of all supported sample-rates.
Finding the supported endpoints within the current range is enough
(see snd_interval_list()).

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index f841707..56da8ce 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1023,27 +1023,35 @@ static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
 		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	int sbits = params_width(params);
 	int slots = rd->mcasp->tdm_slots;
-	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
-	int i, count = 0;
+	struct snd_interval range;
+	int i;
+
+	snd_interval_any(&range);
+	range.empty = 1;
 
 	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
-		if (ri->min <= davinci_mcasp_dai_rates[i] &&
-		    ri->max >= davinci_mcasp_dai_rates[i]) {
+		if (snd_interval_test(ri, davinci_mcasp_dai_rates[i])) {
 			uint bclk_freq = sbits*slots*
 				davinci_mcasp_dai_rates[i];
 			int ppm;
 
 			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
-			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
-				list[count++] = davinci_mcasp_dai_rates[i];
+			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
+				if (range.empty) {
+					range.min = davinci_mcasp_dai_rates[i];
+					range.empty = 0;
+				}
+				range.max = davinci_mcasp_dai_rates[i];
+			}
 		}
 	}
+
 	dev_dbg(rd->mcasp->dev,
-		"%d frequencies (%d-%d) for %d sbits and %d tdm slots\n",
-		count, ri->min, ri->max, sbits, slots);
+		"Frequencies %d-%d -> %d-%d for %d sbits and %d tdm slots\n",
+		ri->min, ri->max, range.min, range.max, sbits, slots);
 
-	return snd_interval_list(hw_param_interval(params, rule->var),
-				 count, list, 0);
+	return snd_interval_refine(hw_param_interval(params, rule->var),
+				   &range);
 }
 
 static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
-- 
1.9.1
