From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Don't try to round-up for PM divisor calculation
Date: Wed,  4 Mar 2015 21:05:04 -0800
Message-ID: <1425531904-3770-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

According to i.MX6 Series Reference Manual, the formula to calculate
the sys clock is

sysclk rate = bclk rate * (div2 + 1) * (7 * psr + 1) * (pm + 1) * 2

Commit aafa85e71a75 ("ASoC: fsl_ssi: Add DAI master mode support for
SSI on i.MX series") added the divisor calculation which relies on
the clk_round_rate(). However, at that time, clk_round_rate() didn't
provide closest clock rates for some cases because it might not use
a correct rounding policy. So using the original formula (pm + 1) for
PM divisor was not able to give us a desired clock rate. And then we
used (pm + 2) to do the trick.

However, the clk-divider driver has been refined a lot since commit
b11d282dbea2 ("clk: divider: fix rate calculation for fractional rates")
Now using (pm + 2) trick would result an incorrect clock rate.

So this patch fixes the problem by removing the useless trick.

Reported-by: Stephane Cerveau <scerveau@voxtok.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 05575f4..6b0c8f7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -603,7 +603,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	factor = (div2 + 1) * (7 * psr + 1) * 2;
 
 	for (i = 0; i < 255; i++) {
-		tmprate = freq * factor * (i + 2);
+		tmprate = freq * factor * (i + 1);
 
 		if (baudclk_is_used)
 			clkrate = clk_get_rate(ssi_private->baudclk);
-- 
1.9.1
