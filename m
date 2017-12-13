From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Use
	snd_soc_update_bits() in aic32x4_hw_params()" to the asoc tree
Date: Wed, 13 Dec 2017 15:45:03 +0000
Message-ID: <E1eP9DT-0002H8-5V@debutante>
References: <20171212224311.24045-8-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 214DF26790A
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 16:45:05 +0100 (CET)
In-Reply-To: <20171212224311.24045-8-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Use snd_soc_update_bits() in aic32x4_hw_params()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 64aab89974ebddf4cc67e4ed8996d879a9d054b9 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 12 Dec 2017 16:43:09 -0600
Subject: [PATCH] ASoC: tlv320aic32x4: Use snd_soc_update_bits() in
 aic32x4_hw_params()

Make the code easier to read by using snd_soc_update_bits() over
read/modify/write sequences. Also use separate per-register
variables instead of re-using "data". This can prevent accidental
over-writing and makes it clear for which register each bit value is
intended.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 90 ++++++++++++++++++++--------------------
 sound/soc/codecs/tlv320aic32x4.h |  8 ++++
 2 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 5deabe36ae94..63a52cdb7afe 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -676,7 +676,8 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
-	u8 data;
+	u8 iface1_reg = 0;
+	u8 dacsetup_reg = 0;
 	int i;
 
 	i = aic32x4_get_divs(aic32x4->sysclk, params_rate(params));
@@ -685,87 +686,88 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 		return i;
 	}
 
-	/* Use PLL as CODEC_CLKIN and DAC_MOD_CLK as BDIV_CLKIN */
-	snd_soc_write(codec, AIC32X4_CLKMUX, AIC32X4_CODEC_CLKIN_PLL);
-	snd_soc_write(codec, AIC32X4_IFACE3, AIC32X4_DACMOD2BCLK);
+	/* MCLK as PLL_CLKIN */
+	snd_soc_update_bits(codec, AIC32X4_CLKMUX, AIC32X4_PLL_CLKIN_MASK,
+			    AIC32X4_PLL_CLKIN_MCLK << AIC32X4_PLL_CLKIN_SHIFT);
+	/* PLL as CODEC_CLKIN */
+	snd_soc_update_bits(codec, AIC32X4_CLKMUX, AIC32X4_CODEC_CLKIN_MASK,
+			    AIC32X4_CODEC_CLKIN_PLL << AIC32X4_CODEC_CLKIN_SHIFT);
+	/* DAC_MOD_CLK as BDIV_CLKIN */
+	snd_soc_update_bits(codec, AIC32X4_IFACE3, AIC32X4_BDIVCLK_MASK,
+			    AIC32X4_DACMOD2BCLK << AIC32X4_BDIVCLK_SHIFT);
 
-	/* We will fix R value to 1 and will make P & J=K.D as varialble */
-	data = snd_soc_read(codec, AIC32X4_PLLPR);
-	data &= ~(7 << 4);
-	snd_soc_write(codec, AIC32X4_PLLPR,
-		      (data | (aic32x4_divs[i].p_val << 4) | 0x01));
+	/* We will fix R value to 1 and will make P & J=K.D as variable */
+	snd_soc_update_bits(codec, AIC32X4_PLLPR, AIC32X4_PLL_R_MASK, 0x01);
 
+	/* PLL P value */
+	snd_soc_update_bits(codec, AIC32X4_PLLPR, AIC32X4_PLL_P_MASK,
+			    aic32x4_divs[i].p_val << AIC32X4_PLL_P_SHIFT);
+
+	/* PLL J value */
 	snd_soc_write(codec, AIC32X4_PLLJ, aic32x4_divs[i].pll_j);
 
+	/* PLL D value */
 	snd_soc_write(codec, AIC32X4_PLLDMSB, (aic32x4_divs[i].pll_d >> 8));
-	snd_soc_write(codec, AIC32X4_PLLDLSB,
-		      (aic32x4_divs[i].pll_d & 0xff));
+	snd_soc_write(codec, AIC32X4_PLLDLSB, (aic32x4_divs[i].pll_d & 0xff));
 
 	/* NDAC divider value */
-	data = snd_soc_read(codec, AIC32X4_NDAC);
-	data &= ~(0x7f);
-	snd_soc_write(codec, AIC32X4_NDAC, data | aic32x4_divs[i].ndac);
+	snd_soc_update_bits(codec, AIC32X4_NDAC,
+			    AIC32X4_NDAC_MASK, aic32x4_divs[i].ndac);
 
 	/* MDAC divider value */
-	data = snd_soc_read(codec, AIC32X4_MDAC);
-	data &= ~(0x7f);
-	snd_soc_write(codec, AIC32X4_MDAC, data | aic32x4_divs[i].mdac);
+	snd_soc_update_bits(codec, AIC32X4_MDAC,
+			    AIC32X4_MDAC_MASK, aic32x4_divs[i].mdac);
 
 	/* DOSR MSB & LSB values */
 	snd_soc_write(codec, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
-	snd_soc_write(codec, AIC32X4_DOSRLSB,
-		      (aic32x4_divs[i].dosr & 0xff));
+	snd_soc_write(codec, AIC32X4_DOSRLSB, (aic32x4_divs[i].dosr & 0xff));
 
 	/* NADC divider value */
-	data = snd_soc_read(codec, AIC32X4_NADC);
-	data &= ~(0x7f);
-	snd_soc_write(codec, AIC32X4_NADC, data | aic32x4_divs[i].nadc);
+	snd_soc_update_bits(codec, AIC32X4_NADC,
+			    AIC32X4_NADC_MASK, aic32x4_divs[i].nadc);
 
 	/* MADC divider value */
-	data = snd_soc_read(codec, AIC32X4_MADC);
-	data &= ~(0x7f);
-	snd_soc_write(codec, AIC32X4_MADC, data | aic32x4_divs[i].madc);
+	snd_soc_update_bits(codec, AIC32X4_MADC,
+			    AIC32X4_MADC_MASK, aic32x4_divs[i].madc);
 
 	/* AOSR value */
 	snd_soc_write(codec, AIC32X4_AOSR, aic32x4_divs[i].aosr);
 
 	/* BCLK N divider */
-	data = snd_soc_read(codec, AIC32X4_BCLKN);
-	data &= ~(0x7f);
-	snd_soc_write(codec, AIC32X4_BCLKN, data | aic32x4_divs[i].blck_N);
+	snd_soc_update_bits(codec, AIC32X4_BCLKN,
+			    AIC32X4_BCLK_MASK, aic32x4_divs[i].blck_N);
 
-	data = snd_soc_read(codec, AIC32X4_IFACE1);
-	data = data & ~(3 << 4);
 	switch (params_width(params)) {
 	case 16:
-		data |= (AIC32X4_WORD_LEN_16BITS <<
-			 AIC32X4_IFACE1_DATALEN_SHIFT);
+		iface1_reg |= (AIC32X4_WORD_LEN_16BITS <<
+			       AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 20:
-		data |= (AIC32X4_WORD_LEN_20BITS <<
-			 AIC32X4_IFACE1_DATALEN_SHIFT);
+		iface1_reg |= (AIC32X4_WORD_LEN_20BITS <<
+			       AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 24:
-		data |= (AIC32X4_WORD_LEN_24BITS <<
-			 AIC32X4_IFACE1_DATALEN_SHIFT);
+		iface1_reg |= (AIC32X4_WORD_LEN_24BITS <<
+			       AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 32:
-		data |= (AIC32X4_WORD_LEN_32BITS <<
-			 AIC32X4_IFACE1_DATALEN_SHIFT);
+		iface1_reg |= (AIC32X4_WORD_LEN_32BITS <<
+			       AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	}
-	snd_soc_write(codec, AIC32X4_IFACE1, data);
+	snd_soc_update_bits(codec, AIC32X4_IFACE1,
+			    AIC32X4_IFACE1_DATALEN_MASK, iface1_reg);
 
 	if (params_channels(params) == 1) {
-		data = AIC32X4_RDAC2LCHN | AIC32X4_LDAC2LCHN;
+		dacsetup_reg = AIC32X4_RDAC2LCHN | AIC32X4_LDAC2LCHN;
 	} else {
 		if (aic32x4->swapdacs)
-			data = AIC32X4_RDAC2LCHN | AIC32X4_LDAC2RCHN;
+			dacsetup_reg = AIC32X4_RDAC2LCHN | AIC32X4_LDAC2RCHN;
 		else
-			data = AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN;
+			dacsetup_reg = AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN;
 	}
-	snd_soc_update_bits(codec, AIC32X4_DACSETUP, AIC32X4_DAC_CHAN_MASK,
-			data);
+	snd_soc_update_bits(codec, AIC32X4_DACSETUP,
+			    AIC32X4_DAC_CHAN_MASK, dacsetup_reg);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 67772e5585b8..e9df49edbf19 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -115,21 +115,29 @@ int aic32x4_remove(struct device *dev);
 
 /* AIC32X4_PLLPR */
 #define AIC32X4_PLLEN			BIT(7)
+#define AIC32X4_PLL_P_MASK		GENMASK(6, 4)
+#define AIC32X4_PLL_P_SHIFT		(4)
+#define AIC32X4_PLL_R_MASK		GENMASK(3, 0)
 
 /* AIC32X4_NDAC */
 #define AIC32X4_NDACEN			BIT(7)
+#define AIC32X4_NDAC_MASK		GENMASK(6, 0)
 
 /* AIC32X4_MDAC */
 #define AIC32X4_MDACEN			BIT(7)
+#define AIC32X4_MDAC_MASK		GENMASK(6, 0)
 
 /* AIC32X4_NADC */
 #define AIC32X4_NADCEN			BIT(7)
+#define AIC32X4_NADC_MASK		GENMASK(6, 0)
 
 /* AIC32X4_MADC */
 #define AIC32X4_MADCEN			BIT(7)
+#define AIC32X4_MADC_MASK		GENMASK(6, 0)
 
 /* AIC32X4_BCLKN */
 #define AIC32X4_BCLKEN			BIT(7)
+#define AIC32X4_BCLK_MASK		GENMASK(6, 0)
 
 /* AIC32X4_IFACE1 */
 #define AIC32X4_IFACE1_DATATYPE_MASK	GENMASK(7, 6)
-- 
2.15.1
