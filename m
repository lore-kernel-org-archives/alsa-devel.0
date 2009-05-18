From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] soc: Correct print specifiers for unsigneds
Date: Mon, 18 May 2009 21:35:25 +0200
Message-ID: <4A11B87D.50505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 5565E103823
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 21:35:28 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4360556ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2009 12:35:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Unsigned variables should use `%u' rather than `%d'.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
This also comtains some changes that I already sent here
http://lkml.org/lkml/2009/5/11/497
Sorry for that, Is there some way to split these changes?

 sound/soc/atmel/playpaq_wm8510.c |    2 +-
 sound/soc/codecs/tlv320aic23.c   |    4 ++--
 sound/soc/codecs/uda134x.c       |    4 ++--
 sound/soc/codecs/wm8350.c        |    2 +-
 sound/soc/codecs/wm8400.c        |    8 ++++----
 sound/soc/codecs/wm8510.c        |    2 +-
 sound/soc/codecs/wm8580.c        |    4 ++--
 sound/soc/codecs/wm8753.c        |    6 +++---
 sound/soc/codecs/wm8900.c        |    6 +++---
 sound/soc/codecs/wm8990.c        |    2 +-
 sound/soc/codecs/wm9713.c        |    2 +-
 sound/soc/pxa/pxa-ssp.c          |    4 ++--
 sound/soc/s3c24xx/s3c-i2s-v2.c   |    4 ++--
 sound/soc/sh/ssi.c               |    2 +-
 14 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 7065753..9eb610c 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -117,7 +117,7 @@ static struct ssc_clock_data playpaq_wm8510_calc_ssc_clock(
 	 * Find actual rate, compare to requested rate
 	 */
 	actual_rate = (cd.ssc_rate / (cd.cmr_div * 2)) / (2 * (cd.period + 1));
-	pr_debug("playpaq_wm8510: Request rate = %d, actual rate = %d\n",
+	pr_debug("playpaq_wm8510: Request rate = %u, actual rate = %u\n",
 		 rate, actual_rate);
 
 
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index c3f4afb..a06b6bb 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -86,7 +86,7 @@ static int tlv320aic23_write(struct snd_soc_codec *codec, unsigned int reg,
 	 */
 
 	if ((reg < 0 || reg > 9) && (reg != 15)) {
-		printk(KERN_WARNING "%s Invalid register R%d\n", __func__, reg);
+		printk(KERN_WARNING "%s Invalid register R%u\n", __func__, reg);
 		return -1;
 	}
 
@@ -98,7 +98,7 @@ static int tlv320aic23_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 
-	printk(KERN_ERR "%s cannot write %03x to register R%d\n", __func__,
+	printk(KERN_ERR "%s cannot write %03x to register R%u\n", __func__,
 	       value, reg);
 
 	return -EIO;
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index ddefb8f..269b108 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -101,7 +101,7 @@ static int uda134x_write(struct snd_soc_codec *codec, unsigned int reg,
 	pr_debug("%s reg: %02X, value:%02X\n", __func__, reg, value);
 
 	if (reg >= UDA134X_REGS_NUM) {
-		printk(KERN_ERR "%s unkown register: reg: %d",
+		printk(KERN_ERR "%s unkown register: reg: %u",
 		       __func__, reg);
 		return -EINVAL;
 	}
@@ -296,7 +296,7 @@ static int uda134x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct uda134x_priv *uda134x = codec->private_data;
 
-	pr_debug("%s clk_id: %d, freq: %d, dir: %d\n", __func__,
+	pr_debug("%s clk_id: %d, freq: %u, dir: %d\n", __func__,
 		 clk_id, freq, dir);
 
 	/* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 0275321..e7348d3 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1108,7 +1108,7 @@ static int wm8350_set_fll(struct snd_soc_dai *codec_dai,
 	if (ret < 0)
 		return ret;
 	dev_dbg(wm8350->dev,
-		"FLL in %d FLL out %d N 0x%x K 0x%x div %d ratio %d",
+		"FLL in %u FLL out %u N 0x%x K 0x%x div %d ratio %d",
 		freq_in, freq_out, fll_div.n, fll_div.k, fll_div.div,
 		fll_div.ratio);
 
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 510efa6..502eefa 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -954,7 +954,7 @@ static int fll_factors(struct wm8400_priv *wm8400, struct fll_factors *factors,
 		factors->outdiv *= 2;
 		if (factors->outdiv > 32) {
 			dev_err(wm8400->wm8400->dev,
-				"Unsupported FLL output frequency %dHz\n",
+				"Unsupported FLL output frequency %uHz\n",
 				Fout);
 			return -EINVAL;
 		}
@@ -1003,7 +1003,7 @@ static int fll_factors(struct wm8400_priv *wm8400, struct fll_factors *factors,
 	factors->k = K / 10;
 
 	dev_dbg(wm8400->wm8400->dev,
-		"FLL: Fref=%d Fout=%d N=%x K=%x, FRATIO=%x OUTDIV=%x\n",
+		"FLL: Fref=%u Fout=%u N=%x K=%x, FRATIO=%x OUTDIV=%x\n",
 		Fref, Fout,
 		factors->n, factors->k, factors->fratio, factors->outdiv);
 
@@ -1473,8 +1473,8 @@ static int wm8400_codec_probe(struct platform_device *dev)
 
 	codec = &priv->codec;
 	codec->private_data = priv;
-	codec->control_data = dev->dev.driver_data;
-	priv->wm8400 = dev->dev.driver_data;
+	codec->control_data = dev_get_drvdata(&dev->dev);
+	priv->wm8400 = dev_get_drvdata(&dev->dev);
 
 	ret = regulator_bulk_get(priv->wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 6a4cea0..c8b8dba 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -298,7 +298,7 @@ static void pll_factors(unsigned int target, unsigned int source)
 
 	if ((Ndiv < 6) || (Ndiv > 12))
 		printk(KERN_WARNING
-			"WM8510 N value %d outwith recommended range!d\n",
+			"WM8510 N value %u outwith recommended range!d\n",
 			Ndiv);
 
 	pll_div.n = Ndiv;
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 9f6be3d..86c4b24 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -415,7 +415,7 @@ static int pll_factors(struct _pll_div *pll_div, unsigned int target,
 	unsigned int K, Ndiv, Nmod;
 	int i;
 
-	pr_debug("wm8580: PLL %dHz->%dHz\n", source, target);
+	pr_debug("wm8580: PLL %uHz->%uHz\n", source, target);
 
 	/* Scale the output frequency up; the PLL should run in the
 	 * region of 90-100MHz.
@@ -447,7 +447,7 @@ static int pll_factors(struct _pll_div *pll_div, unsigned int target,
 
 	if ((Ndiv < 5) || (Ndiv > 13)) {
 		printk(KERN_ERR
-			"WM8580 N=%d outside supported range\n", Ndiv);
+			"WM8580 N=%u outside supported range\n", Ndiv);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index a6e8f3f..d28eeac 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -703,7 +703,7 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int target,
 
 	if ((Ndiv < 6) || (Ndiv > 12))
 		printk(KERN_WARNING
-			"wm8753: unsupported N = %d\n", Ndiv);
+			"wm8753: unsupported N = %u\n", Ndiv);
 
 	pll_div->n = Ndiv;
 	Nmod = target % source;
@@ -1822,14 +1822,14 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 	codec->hw_write = (hw_write_t)wm8753_spi_write;
 	codec->dev = &spi->dev;
 
-	spi->dev.driver_data = wm8753;
+	dev_set_drvdata(&spi->dev, wm8753);
 
 	return wm8753_register(wm8753);
 }
 
 static int __devexit wm8753_spi_remove(struct spi_device *spi)
 {
-	struct wm8753_priv *wm8753 = spi->dev.driver_data;
+	struct wm8753_priv *wm8753 = dev_get_drvdata(&spi->dev);
 	wm8753_unregister(wm8753);
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 46c5ea1..3c78945 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -778,11 +778,11 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	}
 
 	if (target > 100000000)
-		printk(KERN_WARNING "wm8900: FLL rate %d out of range, Fref=%d"
-		       " Fout=%d\n", target, Fref, Fout);
+		printk(KERN_WARNING "wm8900: FLL rate %u out of range, Fref=%u"
+		       " Fout=%u\n", target, Fref, Fout);
 	if (div > 32) {
 		printk(KERN_ERR "wm8900: Invalid FLL division rate %u, "
-		       "Fref=%d, Fout=%d, target=%d\n",
+		       "Fref=%u, Fout=%u, target=%u\n",
 		       div, Fref, Fout, target);
 		return -EINVAL;
 	}
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 40cd274..d029818 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -998,7 +998,7 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int target,
 
 	if ((Ndiv < 6) || (Ndiv > 12))
 		printk(KERN_WARNING
-		"WM8990 N value outwith recommended range! N = %d\n", Ndiv);
+		"WM8990 N value outwith recommended range! N = %u\n", Ndiv);
 
 	pll_div->n = Ndiv;
 	Nmod = target % source;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 523bad0..c79e666 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -689,7 +689,7 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int source)
 	Ndiv = target / source;
 	if ((Ndiv < 5) || (Ndiv > 12))
 		printk(KERN_WARNING
-			"WM9713 PLL N value %d out of recommended range!\n",
+			"WM9713 PLL N value %u out of recommended range!\n",
 			Ndiv);
 
 	pll_div->n = Ndiv;
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 286be31..d656a90 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -323,7 +323,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 
 	dev_dbg(&ssp->pdev->dev,
-		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %d\n",
+		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
 		cpu_dai->id, clk_id, freq);
 
 	switch (clk_id) {
@@ -472,7 +472,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 			ssacd |= (0x6 << 4);
 
 			dev_dbg(&ssp->pdev->dev,
-				"Using SSACDD %x to supply %dHz\n",
+				"Using SSACDD %x to supply %uHz\n",
 				val, freq_out);
 			break;
 		}
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index ab680aa..3cd94c5 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -507,7 +507,7 @@ int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 		actual = clkrate / (fsdiv * div);
 		deviation = actual - rate;
 
-		printk(KERN_DEBUG "%dfs: div %d => result %d, deviation %d\n",
+		printk(KERN_DEBUG "%ufs: div %u => result %u, deviation %d\n",
 		       fsdiv, div, actual, deviation);
 
 		deviation = abs(deviation);
@@ -523,7 +523,7 @@ int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 			break;
 	}
 
-	printk(KERN_DEBUG "best: fs=%d, div=%d, rate=%d\n",
+	printk(KERN_DEBUG "best: fs=%u, div=%u, rate=%u\n",
 	       best_fs, best_div, best_rate);
 
 	info->fs_div = best_fs;
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 56fa087..b378096 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -145,7 +145,7 @@ static int ssi_hw_params(struct snd_pcm_substream *substream,
 	recv = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ? 0 : 1;
 
 	pr_debug("ssi_hw_params() enter\nssicr was    %08lx\n", ssicr);
-	pr_debug("bits: %d channels: %d\n", bits, channels);
+	pr_debug("bits: %u channels: %u\n", bits, channels);
 
 	ssicr &= ~(CR_TRMD | CR_CHNL_MASK | CR_DWL_MASK | CR_PDTA |
 		   CR_SWL_MASK);
