From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Fri, 18 Apr 2008 13:41:13 +0200
Message-ID: <20080418114113.GC23651@buzzloop.caiaq.de>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
	<bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GPJrCs/72TxItFYR"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C98524B07
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 13:41:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2008 at 01:47:33PM +0300, Jarkko Nikula wrote:
> > Well, the constraint for that condition is that MCLK = 256*WCLK, and the
> > reason why that works for the chip without PLL is that Q=2. I stated
> > that a little better in the attached patch.
> >
> 
> I would rather refer there just "Fsref = CLKDIV_IN / (128*Q)" as the
> condition where PLL can be disabled (or is mandatory where it must be
> disabled?).
> 
> Referring to data sheet page 27 is not good as it's correct only for certain
> version of AIC33 spec and driver supports other AIC3x chips as well :-)

Ok, I agree. I changed that to find an appropriate value for Q
programmatically. Have a look at the attached patch, please. I hope i
finally got it now ;)

Daniel


Subject: [PATCH] asoc tlv320aic33: skip usage of PLL in some cases

Try to find an appropriate value for Q during clock setup in order to
bypass the usage of the PLL in some cases. This saves some entries in
the dividers table.

Signed-off-by: Daniel Mack <daniel@caiaq.de>


--GPJrCs/72TxItFYR
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-skip-pll.diff"

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 630684f..4ddfe91 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -720,7 +720,7 @@ static inline int aic3x_get_divs(int mclk, int rate)
 			return i;
 	}
 
-	return 0;
+	return -1;
 }
 
 static int aic3x_hw_params(struct snd_pcm_substream *substream,
@@ -730,11 +730,52 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
-	int i;
-	u8 data, pll_p, pll_r, pll_j;
+	int i, bypass_pll = 0;
+	u8 data, pll_p, pll_r, pll_j, pll_q;
 	u16 pll_d;
 
-	i = aic3x_get_divs(aic3x->sysclk, params_rate(params));
+	/* select data word length */
+	data =
+	    aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		data |= (0x01 << 4);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		data |= (0x02 << 4);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		data |= (0x03 << 4);
+		break;
+	}
+	aic3x_write(codec, AIC3X_ASD_INTF_CTRLB, data);
+
+	/* Try to find a value for Q which allows us to bypass the PLL and
+	 * generate CODEC_CLK directly. This saves some entries in
+	 * aic3x_divs[]. */
+	for (pll_q = 2; pll_q < 18; pll_q++)
+		if (params_rate(params) == aic3x->sysclk / (128 * pll_q)) {
+			bypass_pll = 1;
+			break;
+		}
+
+	 /* If the PLL is bypassed, use first entry in the dividers table
+	 * to lookup fsref. */
+	if (bypass_pll) {
+		pll_q &= 0xf;
+		i = aic3x_get_divs(aic3x_divs[0].mclk, params_rate(params));
+		aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, 0);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
+		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
+	} else {
+		i = aic3x_get_divs(aic3x->sysclk, params_rate(params));
+		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
+	}
+
+	if (i < 0)
+		return -EINVAL;
 
 	/* Route Left DAC to left channel input and
 	 * right DAC to right channel input */
@@ -755,6 +796,9 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	}
 	aic3x_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
 
+	if (bypass_pll)
+		return 0;
+
 	/* codec sample rate select */
 	data = aic3x_divs[i].sr_reg;
 	data |= (data << 4);
@@ -782,24 +826,6 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -826,16 +852,8 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
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

--GPJrCs/72TxItFYR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--GPJrCs/72TxItFYR--
