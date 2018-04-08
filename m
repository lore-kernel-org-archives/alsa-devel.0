From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Sun,  8 Apr 2018 16:57:35 -0700
Message-ID: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, marex@denx.de
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

When the desired ratio is less than 256, the savesub (tolerance)
in the calculation would become 0. This will then fail the loop-
search immediately without reporting any errors.

But if the ratio is smaller enough, there is no need to calculate
the tolerance because PM divisor alone is enough to get the ratio.

So a simple fix could be just to set PM directly instead of going
into the loop-search.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Marek Vasut <marex@denx.de>
---
 sound/soc/fsl/fsl_esai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 40a7004..da8fd98 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
 
 	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
 
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <= 256) {
+		pm = ratio;
+		fp = 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
 
-- 
2.7.4
