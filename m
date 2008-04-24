From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [RFC] [PATCH] asoc tlv320aic3x: revisit
	clocking	setup
Date: Thu, 24 Apr 2008 17:21:36 +0200
Message-ID: <20080424152136.GB10882@buzzloop.caiaq.de>
References: <20080424145437.GA10882@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 73F842453E
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 17:21:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080424145437.GA10882@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2008 at 04:54:37PM +0200, Daniel Mack wrote:
> attached is a patch that reworks the clocking setup for the aic3x codec.
> It drops the dividers table and calculates the values instead. When
> simulated, this code does the right thing for all the examples described
> in the datasheet. Please review and let me know about any concerns.

Same thing again, but some more comments.

Daniel


--A6N2fC+uXW/VQSAv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-rfc-clocking.diff"

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 630684f..ff634c9 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -51,6 +51,8 @@
 #define AUDIO_NAME "aic3x"
 #define AIC3X_VERSION "0.1"
 
+#define ABS(x) (((x) >= 0) ? (x) : -(x))
+
 /* codec private data */
 struct aic3x_priv {
 	unsigned int sysclk;
@@ -648,81 +650,6 @@ static int aic3x_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct aic3x_rate_divs {
-	u32 mclk;
-	u32 rate;
-	u32 fsref_reg;
-	u8 sr_reg:4;
-	u8 pllj_reg;
-	u16 plld_reg;
-};
-
-/* AIC3X codec mclk clock divider coefficients */
-static const struct aic3x_rate_divs aic3x_divs[] = {
-	/* 8k */
-	{12000000, 8000, 48000, 0xa, 16, 3840},
-	{19200000, 8000, 48000, 0xa, 10, 2400},
-	{22579200, 8000, 48000, 0xa, 8, 7075},
-	{33868800, 8000, 48000, 0xa, 5, 8049},
-	/* 11.025k */
-	{12000000, 11025, 44100, 0x6, 15, 528},
-	{19200000, 11025, 44100, 0x6, 9, 4080},
-	{22579200, 11025, 44100, 0x6, 8, 0},
-	{33868800, 11025, 44100, 0x6, 5, 3333},
-	/* 16k */
-	{12000000, 16000, 48000, 0x4, 16, 3840},
-	{19200000, 16000, 48000, 0x4, 10, 2400},
-	{22579200, 16000, 48000, 0x4, 8, 7075},
-	{33868800, 16000, 48000, 0x4, 5, 8049},
-	/* 22.05k */
-	{12000000, 22050, 44100, 0x2, 15, 528},
-	{19200000, 22050, 44100, 0x2, 9, 4080},
-	{22579200, 22050, 44100, 0x2, 8, 0},
-	{33868800, 22050, 44100, 0x2, 5, 3333},
-	/* 32k */
-	{12000000, 32000, 48000, 0x1, 16, 3840},
-	{19200000, 32000, 48000, 0x1, 10, 2400},
-	{22579200, 32000, 48000, 0x1, 8, 7075},
-	{33868800, 32000, 48000, 0x1, 5, 8049},
-	/* 44.1k */
-	{12000000, 44100, 44100, 0x0, 15, 528},
-	{19200000, 44100, 44100, 0x0, 9, 4080},
-	{22579200, 44100, 44100, 0x0, 8, 0},
-	{33868800, 44100, 44100, 0x0, 5, 3333},
-	/* 48k */
-	{12000000, 48000, 48000, 0x0, 16, 3840},
-	{19200000, 48000, 48000, 0x0, 10, 2400},
-	{22579200, 48000, 48000, 0x0, 8, 7075},
-	{33868800, 48000, 48000, 0x0, 5, 8049},
-	/* 64k */
-	{12000000, 64000, 96000, 0x1, 16, 3840},
-	{19200000, 64000, 96000, 0x1, 10, 2400},
-	{22579200, 64000, 96000, 0x1, 8, 7075},
-	{33868800, 64000, 96000, 0x1, 5, 8049},
-	/* 88.2k */
-	{12000000, 88200, 88200, 0x0, 15, 528},
-	{19200000, 88200, 88200, 0x0, 9, 4080},
-	{22579200, 88200, 88200, 0x0, 8, 0},
-	{33868800, 88200, 88200, 0x0, 5, 3333},
-	/* 96k */
-	{12000000, 96000, 96000, 0x0, 16, 3840},
-	{19200000, 96000, 96000, 0x0, 10, 2400},
-	{22579200, 96000, 96000, 0x0, 8, 7075},
-	{33868800, 96000, 96000, 0x0, 5, 8049},
-};
-
-static inline int aic3x_get_divs(int mclk, int rate)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aic3x_divs); i++) {
-		if (aic3x_divs[i].rate == rate && aic3x_divs[i].mclk == mclk)
-			return i;
-	}
-
-	return 0;
-}
-
 static int aic3x_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params)
 {
@@ -730,49 +657,106 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
-	int i;
-	u8 data, pll_p, pll_r, pll_j;
-	u16 pll_d;
-
-	i = aic3x_get_divs(aic3x->sysclk, params_rate(params));
+	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
+	u8 data, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
+	u16 pll_d = 1;
 
-	/* Route Left DAC to left channel input and
-	 * right DAC to right channel input */
-	data = (LDAC2LCH | RDAC2RCH);
-	switch (aic3x_divs[i].fsref_reg) {
-	case 44100:
-		data |= FSREF_44100;
+	/* select data word length */
+	data =
+	    aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
-	case 48000:
-		data |= FSREF_48000;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		data |= (0x01 << 4);
 		break;
-	case 88200:
-		data |= FSREF_44100 | DUAL_RATE_MODE;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		data |= (0x02 << 4);
 		break;
-	case 96000:
-		data |= FSREF_48000 | DUAL_RATE_MODE;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		data |= (0x03 << 4);
 		break;
 	}
+	aic3x_write(codec, AIC3X_ASD_INTF_CTRLB, data);
+
+	/* Fsref can be 44100 or 48000 */
+	fsref = (params_rate(params) % 11025 == 0) ? 44100 : 48000;
+
+	/* Try to find a value for Q which allows us to bypass the PLL and
+	 * generate CODEC_CLK directly. */
+	for (pll_q = 2; pll_q < 18; pll_q++)
+		if (aic3x->sysclk / (128 * pll_q) == fsref) {
+			bypass_pll = 1;
+			break;
+		}
+
+	if (bypass_pll) {
+		pll_q &= 0xf;
+		aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, 0);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
+		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
+	} else
+		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
+
+	/* Route Left DAC to left channel input and
+	 * right DAC to right channel input */
+	data = (LDAC2LCH | RDAC2RCH);
+	data |= (fsref == 44100) ? FSREF_44100 : FSREF_48000;
+	if (params_rate(params) >= 88200)
+		data |= DUAL_RATE_MODE;
 	aic3x_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
 
 	/* codec sample rate select */
-	data = aic3x_divs[i].sr_reg;
+	data = (fsref * 10) / params_rate(params);
+	data /= 5;
+	data -= 2;
 	data |= (data << 4);
 	aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, data);
 
-	/* Use PLL for generation Fsref by equation:
-	 * Fsref = (MCLK * K * R)/(2048 * P);
-	 * Fix P = 2 and R = 1 and calculate K, if
-	 * K = J.D, i.e. J - an interger portion of K and D is the fractional
-	 * one with 4 digits of precision;
-	 * Example:
-	 * For MCLK = 22.5792 MHz and Fsref = 48kHz:
-	 * Select P = 2, R= 1, K = 8.7074, which results in J = 8, D = 7074
+	if (bypass_pll)
+		return 0;
+
+	/* Use PLL
+	 * find an apropriate setup for j, d, r and p by iterating over
+	 * p and r - j and d are calculated for each fraction. 128 values
+	 * are probed, the closest one wins the game.
+	 * The sysclk is divided by 1000 to prevent integer overflows.
 	 */
-	pll_p = 2;
-	pll_r = 1;
-	pll_j = aic3x_divs[i].pllj_reg;
-	pll_d = aic3x_divs[i].plld_reg;
+	codec_clk = (2048 * fsref) / (aic3x->sysclk / 1000);
+
+	if (params_rate(params) >= 88200)
+		fsref *= 2;
+
+	for (r = 1; r <= 16; r++)
+		for (p = 1; p <= 8; p++) {
+			int clk, tmp = (codec_clk * pll_r * 10) / pll_p;
+			u8 j = tmp / 10000;
+			u16 d = tmp % 10000;
+
+			if (j > 63)
+				continue;
+
+			if (d != 0 && aic3x->sysclk < 10000000)
+				continue;
+
+			/* this is actually 1000 * ((j + (d/10000)) * r) / p
+			 * The term had to be converted to get rid of the
+			 * division by 10000 */
+			clk = ((10000 * j * r) + (d * r)) / (10 * p);
+
+			/* check whether this values get closer than the best
+			 * ones we had before */
+			if (ABS(codec_clk - clk) < ABS(codec_clk - last_clk)) {
+				pll_j = j; pll_d = d; pll_r = r; pll_p = p;
+				last_clk = clk;
+			}
+
+			if (clk == codec_clk)
+				break;
+		}
+
+	printk(KERN_INFO "%s(): best PLL setup guess: k=%d.%d r=%d p=%d\n",
+			__func__, pll_j, pll_d, pll_r, pll_p);
 
 	data = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
 	aic3x_write(codec, AIC3X_PLL_PROGA_REG, data | (pll_p << PLLP_SHIFT));
@@ -782,24 +766,6 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	aic3x_write(codec, AIC3X_PLL_PROGD_REG,
 		    (pll_d & 0x3F) << PLLD_LSB_SHIFT);
 
-	/* select data word length */
-	data =
-	    aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-		data |= (0x01 << 4);
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		data |= (0x02 << 4);
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		data |= (0x03 << 4);
-		break;
-	}
-	aic3x_write(codec, AIC3X_ASD_INTF_CTRLB, data);
-
 	return 0;
 }
 
@@ -826,16 +792,8 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
 
-	switch (freq) {
-	case 12000000:
-	case 19200000:
-	case 22579200:
-	case 33868800:
-		aic3x->sysclk = freq;
-		return 0;
-	}
-
-	return -EINVAL;
+	aic3x->sysclk = freq;
+	return 0;
 }
 
 static int aic3x_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index d0cdeeb..d49d001 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -109,6 +109,7 @@
 #define LLOPM_CTRL			86
 #define RLOPM_CTRL			93
 /* Clock generation control register */
+#define AIC3X_GPIOB_REG			101
 #define AIC3X_CLKGEN_CTRL_REG		102
 
 /* Page select register bits */
@@ -128,12 +129,15 @@
 
 /* PLL registers bitfields */
 #define PLLP_SHIFT		0
+#define PLLQ_SHIFT		3
 #define PLLR_SHIFT		0
 #define PLLJ_SHIFT		2
 #define PLLD_MSB_SHIFT		0
 #define PLLD_LSB_SHIFT		2
 
 /* Clock generation register bits */
+#define CODEC_CLKIN_PLLDIV	0
+#define CODEC_CLKIN_CLKDIV	1
 #define PLL_CLKIN_SHIFT		4
 #define MCLK_SOURCE		0x0
 #define PLL_CLKDIV_SHIFT	0

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--A6N2fC+uXW/VQSAv--
