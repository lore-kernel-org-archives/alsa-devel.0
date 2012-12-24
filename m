From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8985: Refactor set_pll code to
	avoid gcc warnings
Date: Mon, 24 Dec 2012 15:55:37 -0200
Message-ID: <1356371738-15997-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f181.google.com (mail-ye0-f181.google.com
 [209.85.213.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C3CD826163E
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 18:56:02 +0100 (CET)
Received: by mail-ye0-f181.google.com with SMTP id m11so1270934yen.12
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 09:56:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Refactor set_pll code to avoid the following warnings:

sound/soc/codecs/wm8985.c:852:50: warning: 'pll_div.k' may be used uninitialized in this function
sound/soc/codecs/wm8985.c:849:9: warning: 'pll_div.n' may be used uninitialized in this function
sound/soc/codecs/wm8985.c:848:23: warning: 'pll_div.div2' may be used uninitialized in this function

Do the same as in commit 86ce6c9a (ASoC: WM8804: Refactor set_pll code to avoid 
GCC warnings).

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8985.c |   43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index ab37826..dd6ce3b 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -830,33 +830,30 @@ static int wm8985_set_pll(struct snd_soc_dai *dai, int pll_id,
 	struct pll_div pll_div;
 
 	codec = dai->codec;
-	if (freq_in && freq_out) {
+	if (!freq_in || !freq_out) {
+		/* disable the PLL */
+		snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
+				    WM8985_PLLEN_MASK, 0);
+	} else {
 		ret = pll_factors(&pll_div, freq_out * 4 * 2, freq_in);
 		if (ret)
 			return ret;
-	}
 
-	/* disable the PLL before reprogramming it */
-	snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
-			    WM8985_PLLEN_MASK, 0);
-	
-	if (!freq_in || !freq_out)
-		return 0;
-
-	/* set PLLN and PRESCALE */
-	snd_soc_write(codec, WM8985_PLL_N,
-		      (pll_div.div2 << WM8985_PLL_PRESCALE_SHIFT)
-		      | pll_div.n);
-	/* set PLLK */
-	snd_soc_write(codec, WM8985_PLL_K_3, pll_div.k & 0x1ff);
-	snd_soc_write(codec, WM8985_PLL_K_2, (pll_div.k >> 9) & 0x1ff);
-	snd_soc_write(codec, WM8985_PLL_K_1, (pll_div.k >> 18));
-	/* set the source of the clock to be the PLL */
-	snd_soc_update_bits(codec, WM8985_CLOCK_GEN_CONTROL,
-			    WM8985_CLKSEL_MASK, WM8985_CLKSEL);
-	/* enable the PLL */
-	snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
-			    WM8985_PLLEN_MASK, WM8985_PLLEN);
+		/* set PLLN and PRESCALE */
+		snd_soc_write(codec, WM8985_PLL_N,
+			      (pll_div.div2 << WM8985_PLL_PRESCALE_SHIFT)
+			      | pll_div.n);
+		/* set PLLK */
+		snd_soc_write(codec, WM8985_PLL_K_3, pll_div.k & 0x1ff);
+		snd_soc_write(codec, WM8985_PLL_K_2, (pll_div.k >> 9) & 0x1ff);
+		snd_soc_write(codec, WM8985_PLL_K_1, (pll_div.k >> 18));
+		/* set the source of the clock to be the PLL */
+		snd_soc_update_bits(codec, WM8985_CLOCK_GEN_CONTROL,
+				    WM8985_CLKSEL_MASK, WM8985_CLKSEL);
+		/* enable the PLL */
+		snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
+				    WM8985_PLLEN_MASK, WM8985_PLLEN);
+	}
 	return 0;
 }
 
-- 
1.7.9.5
