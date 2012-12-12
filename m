From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8993: Refactor set_pll code to avoid
	GCC warnings
Date: Wed, 12 Dec 2012 01:19:52 -0200
Message-ID: <1355282392-30693-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 by alsa0.perex.cz (Postfix) with ESMTP id BDCF9261603
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 04:20:08 +0100 (CET)
Received: by mail-qa0-f50.google.com with SMTP id cr7so245005qab.16
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 19:20:08 -0800 (PST)
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

sound/soc/codecs/wm8983.c:873:40: warning: 'pll_div.k' may be used uninitialized in this function [-Wuninitialized]
sound/soc/codecs/wm8983.c:870:9: warning: 'pll_div.n' may be used uninitialized in this function [-Wuninitialized]
sound/soc/codecs/wm8983.c:869:23: warning: 'pll_div.div2' may be used uninitialized in this function [-Wuninitialized]

Do the same as in commit 86ce6c9a (ASoC: WM8804: Refactor set_pll code to avoid 
GCC warnings).

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8983.c |   41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 9fe1e04..e7c73ff 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -851,30 +851,33 @@ static int wm8983_set_pll(struct snd_soc_dai *dai, int pll_id,
 	struct pll_div pll_div;
 
 	codec = dai->codec;
-	if (freq_in && freq_out) {
+	if (!freq_in || !freq_out) {
+		/* disable the PLL before re-programming it */
+		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+				    WM8983_PLLEN_MASK, 0);
+		return 0;
+	} else {
 		ret = pll_factors(&pll_div, freq_out * 4 * 2, freq_in);
 		if (ret)
 			return ret;
-	}
-
-	/* disable the PLL before re-programming it */
-	snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
-			    WM8983_PLLEN_MASK, 0);
 
-	if (!freq_in || !freq_out)
-		return 0;
+		/* disable the PLL before re-programming it */
+		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+				    WM8983_PLLEN_MASK, 0);
+
+		/* set PLLN and PRESCALE */
+		snd_soc_write(codec, WM8983_PLL_N,
+		      	(pll_div.div2 << WM8983_PLL_PRESCALE_SHIFT)
+			| pll_div.n);
+		/* set PLLK */
+		snd_soc_write(codec, WM8983_PLL_K_3, pll_div.k & 0x1ff);
+		snd_soc_write(codec, WM8983_PLL_K_2, (pll_div.k >> 9) & 0x1ff);
+		snd_soc_write(codec, WM8983_PLL_K_1, (pll_div.k >> 18));
+		/* enable the PLL */
+		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+			    		WM8983_PLLEN_MASK, WM8983_PLLEN);
+	}
 
-	/* set PLLN and PRESCALE */
-	snd_soc_write(codec, WM8983_PLL_N,
-		      (pll_div.div2 << WM8983_PLL_PRESCALE_SHIFT)
-		      | pll_div.n);
-	/* set PLLK */
-	snd_soc_write(codec, WM8983_PLL_K_3, pll_div.k & 0x1ff);
-	snd_soc_write(codec, WM8983_PLL_K_2, (pll_div.k >> 9) & 0x1ff);
-	snd_soc_write(codec, WM8983_PLL_K_1, (pll_div.k >> 18));
-	/* enable the PLL */
-	snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
-			    WM8983_PLLEN_MASK, WM8983_PLLEN);
 	return 0;
 }
 
-- 
1.7.9.5
