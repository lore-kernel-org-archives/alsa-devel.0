From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: [PATCH] ASoC:pcm512x: Fix divide by zero issue.
Date: Fri, 20 Mar 2015 21:13:45 +0000
Message-ID: <1426886025-10731-1-git-send-email-hm@hmbedded.co.uk>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, peda@axentia.se
Cc: tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, corbet@lwn.net, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Howard Mitchell <hm@hmbedded.co.uk>
List-Id: alsa-devel@alsa-project.org

If den=1 and pllin_rate>20MHz then den and num are adjusted to 0
causing a divide by zero error a few lines further on. Therefore
this patch correctly scales num and den such that
pllin_rate/den < 20MHz as required in the device data sheet.

Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>
---
 sound/soc/codecs/pcm512x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 5301c4a..8472099 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -713,8 +713,8 @@ static int pcm512x_find_pll_coeff(struct snd_soc_dai *dai,
 
 	/* pllin_rate / P (or here, den) cannot be greater than 20 MHz */
 	if (pllin_rate / den > 20000000 && num < 8) {
-		num *= 20000000 / (pllin_rate / den);
-		den *= 20000000 / (pllin_rate / den);
+		num *= DIV_ROUND_UP(pllin_rate / den, 20000000);
+		den *= DIV_ROUND_UP(pllin_rate / den, 20000000);
 	}
 	dev_dbg(dev, "num / den = %lu / %lu\n", num, den);
 
-- 
1.7.9.5

