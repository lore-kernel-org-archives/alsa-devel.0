From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Fri, 18 Apr 2008 12:35:20 +0200
Message-ID: <20080418103520.GB23651@buzzloop.caiaq.de>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
	<20080418100858.GA19457@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DB57424AE8
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 12:35:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080418100858.GA19457@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2008 at 11:08:59AM +0100, Mark Brown wrote:
> > Well, the reset default is 0 (as stated on page 44) and set_hw_params()
> > is the only location where this value is written. So if it's never 
> > written with a different value, it should always be set to its default,
> > no?
> 
> Not all systems use a static SYSCLK rate - sometimes systems will select
> the rate based on their current usage.  If the system has previously had
> to configure it then the register won't be at the default value any more.

Ok, I didn't consider that. New version of the patch attached which
resets AIC3X_PLL_PROGA_REG and AIC3X_SAMPLE_RATE_SEL_REG to appropriate
values in case the PLL setup is skipped.

Daniel


--OwLcNYc0lM97+oe1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-skip-pll.diff"

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 630684f..83a87f6 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -720,7 +720,7 @@ static inline int aic3x_get_divs(int mclk, int rate)
 			return i;
 	}
 
-	return 0;
+	return -1;
 }
 
 static int aic3x_hw_params(struct snd_pcm_substream *substream,
@@ -730,11 +730,44 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
-	int i;
+	int i, skip_pll;
 	u8 data, pll_p, pll_r, pll_j;
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
+	/* Do not use the PLL in case our MCLK is 256 * sample rate.
+	 * The Q value is set to 2 so the codec sees MCLK as clock
+	 * input (refer to datasheet page 27).
+	 * In this case, use a fake entry in the dividers table to get
+	 * the reference freq */
+	skip_pll = (aic3x->sysclk == params_rate(params) * 256);
+
+	if (skip_pll) {
+		i = aic3x_get_divs(aic3x_divs[0].mclk, params_rate(params));
+		aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, 0);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, 2 << PLLQ_SHIFT);
+	} else
+		i = aic3x_get_divs(aic3x->sysclk, params_rate(params));
+
+	if (i < 0)
+		return -EINVAL;
 
 	/* Route Left DAC to left channel input and
 	 * right DAC to right channel input */
@@ -755,6 +788,9 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	}
 	aic3x_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
 
+	if (skip_pll)
+		return 0;
+
 	/* codec sample rate select */
 	data = aic3x_divs[i].sr_reg;
 	data |= (data << 4);
@@ -782,24 +818,6 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -826,16 +844,8 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
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
index d0cdeeb..e310374 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -108,6 +108,7 @@
 #define DACR1_2_RLOPM_VOL		92
 #define LLOPM_CTRL			86
 #define RLOPM_CTRL			93
+
 /* Clock generation control register */
 #define AIC3X_CLKGEN_CTRL_REG		102
 
@@ -128,6 +129,7 @@
 
 /* PLL registers bitfields */
 #define PLLP_SHIFT		0
+#define PLLQ_SHIFT		3
 #define PLLR_SHIFT		0
 #define PLLJ_SHIFT		2
 #define PLLD_MSB_SHIFT		0

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--OwLcNYc0lM97+oe1--
