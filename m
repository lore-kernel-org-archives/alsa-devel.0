From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Fix the incorrect limitation of the bit clock rate
Date: Tue, 10 Feb 2015 21:31:43 -0800
Message-ID: <1423632703-3683-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, timur@tabi.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, scerveau@voxtok.com
List-Id: alsa-devel@alsa-project.org

According to i.MX Reference Manual, the bit-clock frequency generated
by SSI must be never greater than 1/5 of the peripheral clock frequency.

This peripheral clock, however, is not baudclk but the IPG clock (i.e.
ssi_private->clk in the fsl_ssi driver).

So this patch just simply fixes the incorrect limitation applied to
the bit clock (baudclk) rate.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 059496e..d7365c5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -603,10 +603,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	factor = (div2 + 1) * (7 * psr + 1) * 2;
 
 	for (i = 0; i < 255; i++) {
-		/* The bclk rate must be smaller than 1/5 sysclk rate */
-		if (factor * (i + 1) < 5)
-			continue;
-
 		tmprate = freq * factor * (i + 2);
 
 		if (baudclk_is_used)
@@ -614,6 +610,13 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		else
 			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
 
+		/*
+		 * Hardware limitation: The bclk rate must be
+		 * never greater than 1/5 IPG clock rate
+		 */
+		if (clkrate * 5 > clk_get_rate(ssi_private->clk))
+			continue;
+
 		clkrate /= factor;
 		afreq = clkrate / (i + 1);
 
-- 
1.9.1
