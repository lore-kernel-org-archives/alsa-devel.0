From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Thu, 17 Apr 2008 21:25:52 +0200
Message-ID: <20080417192552.GC17039@buzzloop.caiaq.de>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2008210383E
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 21:26:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080417191245.GA17039@buzzloop.caiaq.de>
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
Cc: Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2008 at 09:12:45PM +0200, Daniel Mack wrote:
> This patch makes the tlv320aic33 driver skip the initialisation of the
> PLL in case the sysclk is 256 * samplerate. Had to do some minor
> refactoring too - the check whether a sysclk set by set_sysclk() is
> valid is now done in set_hw_params().

Sorry, there was a small typo in the patch I just submitted.
Use this one instead.

Daniel


--5/uDoXvLw7AC5HRs
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-tlv320aic33-skip-pll.diff"

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 630684f..7d3f109 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -720,7 +720,7 @@ static inline int aic3x_get_divs(int mclk, int rate)
 			return i;
 	}
 
-	return 0;
+	return -1;
 }
 
 static int aic3x_hw_params(struct snd_pcm_substream *substream,
@@ -730,11 +730,40 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
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
+	/* Do not use the PLL in case our sysclk is 256 * sample rate.
+	 * In this case, use a fake entry in the dividers table to get
+	 * the reference freq */
+	skip_pll = (aic3x->sysclk == 256 * params_rate(params));
+
+	if (skip_pll)
+		i = aic3x_get_divs(aic3x_divs[0].mclk, params_rate(params));
+	else
+		i = aic3x_get_divs(aic3x->sysclk, params_rate(params));
+
+	if (i < 0)
+		return -EINVAL;
 
 	/* Route Left DAC to left channel input and
 	 * right DAC to right channel input */
@@ -755,6 +784,9 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	}
 	aic3x_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
 
+	if (skip_pll)
+		return 0;
+
 	/* codec sample rate select */
 	data = aic3x_divs[i].sr_reg;
 	data |= (data << 4);
@@ -782,24 +814,6 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -826,16 +840,8 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
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

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--5/uDoXvLw7AC5HRs--
