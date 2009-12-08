From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: PLL computation in TLV320AIC3x SoC driver
Date: Tue, 8 Dec 2009 12:28:30 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pitbull.cosy.sbg.ac.at (pitbull.cosy.sbg.ac.at [141.201.2.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C07B2454C
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 12:28:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vbarinov@embeddedalley.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm trying to use the SoC TLV320AIC3x codec driver with sysclk 16384000 
and ran into some problems with setting PLL; below is a patch against 
linux-2.6-asoc

note that the original code uses variables pll_r and pll_p instead of the 
loop variable r and p to compute tmp, this seems broken

further, the original code does not respect the constraints on j (>= 4, <= 
55 for d==0) according to the codec's datasheet, and similarly for d!=0

I've tested the code with a number of reasonable sysclk values and got 
sane PLL values; please apply if acceptable

thanks, regards, p.


diff --git a/sound/soc/codecs/tlv320aic3x.c 
b/sound/soc/codecs/tlv320aic3x.c
index 3395cf9..e84e473 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -766,9 +766,10 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
        struct snd_soc_codec *codec = socdev->card->codec;
        struct aic3x_priv *aic3x = codec->private_data;
        int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
-       u8 data, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
-       u16 pll_d = 1;
+       u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
+       u16 d, pll_d = 1;
        u8 reg;
+       int clk;
 
        /* select data word length */
        data =
@@ -835,47 +836,62 @@ static int aic3x_hw_params(struct snd_pcm_substream 
*substream,
                return 0;
 
        /* Use PLL
-        * find an apropriate setup for j, d, r and p by iterating over
-        * p and r - j and d are calculated for each fraction.
-        * Up to 128 values are probed, the closest one wins the game.
+        * find an appropriate setup for j, d, r and p by iterating over
+        * p, r and j first, then trying to compute the fraction d.
+        * Up to 6528 values are probed, the closest one wins the game.
         * The sysclk is divided by 1000 to prevent integer overflows.
         */
        codec_clk = (2048 * fsref) / (aic3x->sysclk / 1000);
 
-       for (r = 1; r <= 16; r++)
-               for (p = 1; p <= 8; p++) {
-                       int clk, tmp = (codec_clk * pll_r * 10) / pll_p;
-                       u8 j = tmp / 10000;
-                       u16 d = tmp % 10000;
-
-                       if (j > 63)
-                               continue;
-
-                       if (d != 0 && aic3x->sysclk < 10000000)
-                               continue;
-
-                       /* This is actually 1000 * ((j + (d/10000)) * r) / p
-                        * The term had to be converted to get rid of the
-                        * division by 10000 */
-                       clk = ((10000 * j * r) + (d * r)) / (10 * p);
-
-                       /* check whether this values get closer than the best
-                        * ones we had before */
-                       if (abs(codec_clk - clk) < abs(codec_clk - last_clk)) {
-                               pll_j = j; pll_d = d; pll_r = r; pll_p = p;
-                               last_clk = clk;
-                       }
-
-                       /* Early exit for exact matches */
-                       if (clk == codec_clk)
-                               break;
-               }
+    for (r = 1; r <= 16; r++)
+        for (p = 1; p <= 8; p++) {
+            for (j = 4; j <= 55; j++) {
+                /* This is actually 1000 * ((j + (d/10000)) * r) / p
+                 * The term had to be converted to get rid of the
+                 * division by 10000; d = 0 here */
+                int clk = (1000 * j * r) / p;
+
+                /* check whether this values get closer than the best
+                 * ones we had before */
+                if (abs(codec_clk - clk) < abs(codec_clk - last_clk)) {
+                    pll_j = j; pll_d = 0; pll_r = r; pll_p = p;
+                    last_clk = clk;
+                }
+
+                /* Early exit for exact matches */
+                if (clk == codec_clk)
+                    goto found;
+            }
+        }
+
+    /* try with d != 0 */
+    for (p = 1; p <= 8; p++) {
+        j = codec_clk * p / 1000;
+
+        if (j < 4 || j > 11) continue;
+
+        /* do not use codec_clk here since we'd loose precision */
+        d = ((2048 * fsref * 10) / (aic3x->sysclk / 1000)) % 10000;
+        clk = (10000 * j + d) / (10 * p);
+
+        /* check whether this values get closer than the best
+         * ones we had before */
+        if (abs(codec_clk - clk) < abs(codec_clk - last_clk)) {
+            pll_j = j; pll_d = d; pll_r = 1; pll_p = 1;
+            last_clk = clk;
+        }
+
+        /* Early exit for exact matches */
+        if (clk == codec_clk)
+            goto found;
+    }
 
        if (last_clk == 0) {
                printk(KERN_ERR "%s(): unable to setup PLL\n", __func__);
                return -EINVAL;
        }
 
+found:
        data = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
        aic3x_write(codec, AIC3X_PLL_PROGA_REG, data | (pll_p << PLLP_SHIFT));
        aic3x_write(codec, AIC3X_OVRF_STATUS_AND_PLLR_REG, pll_r << PLLR_SHIFT);

-- 

Peter Meerwald
Kaigasse 3 / 8
A-5020 Salzburg / AUSTRIA
+43-664-2444418 (mobile)
