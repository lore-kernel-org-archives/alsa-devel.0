From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Restructure the
	davinci_mcasp_calc_clk_div()" to the asoc tree
Date: Tue, 10 May 2016 19:49:47 +0100
Message-ID: <E1b0Cj5-00087m-BY@debutante>
References: <1462790552-6438-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E052674F6
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:49:53 +0200 (CEST)
In-Reply-To: <1462790552-6438-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Restructure the davinci_mcasp_calc_clk_div()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3e9bee11d83190b852d428b3e35a942c6e2293cd Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 13:42:31 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Restructure the
 davinci_mcasp_calc_clk_div()

Change the return value to error_pmm instead of the BCLK div and handle the
divider configuration to McASP within the function when the set flag is
true.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 99061c4f3257..58fe112c5335 100644
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
2.8.1
