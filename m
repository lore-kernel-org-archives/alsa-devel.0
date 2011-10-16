From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: wm8900: Use snd_soc_update_bits for
 read-modify-write
Date: Sun, 16 Oct 2011 23:30:21 +0800
Message-ID: <1318779021.3106.5.camel@phoenix>
References: <1318778876.3106.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C96E7103813
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Oct 2011 17:30:28 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so2488319ggn.38
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2011 08:30:28 -0700 (PDT)
In-Reply-To: <1318778876.3106.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8900.c |  109 +++++++++++++++++---------------------------
 1 files changed, 42 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 86de396..3d0dc15 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -742,26 +742,20 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 {
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
 	struct _fll_div fll_div;
-	unsigned int reg;
 
 	if (wm8900->fll_in == freq_in && wm8900->fll_out == freq_out)
 		return 0;
 
 	/* The digital side should be disabled during any change. */
-	reg = snd_soc_read(codec, WM8900_REG_POWER1);
-	snd_soc_write(codec, WM8900_REG_POWER1,
-		     reg & (~WM8900_REG_POWER1_FLL_ENA));
+	snd_soc_update_bits(codec, WM8900_REG_POWER1,
+			    WM8900_REG_POWER1_FLL_ENA, 0);
 
 	/* Disable the FLL? */
 	if (!freq_in || !freq_out) {
-		reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
-		snd_soc_write(codec, WM8900_REG_CLOCKING1,
-			     reg & (~WM8900_REG_CLOCKING1_MCLK_SRC));
-
-		reg = snd_soc_read(codec, WM8900_REG_FLLCTL1);
-		snd_soc_write(codec, WM8900_REG_FLLCTL1,
-			     reg & (~WM8900_REG_FLLCTL1_OSC_ENA));
-
+		snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+				    WM8900_REG_CLOCKING1_MCLK_SRC, 0);
+		snd_soc_update_bits(codec, WM8900_REG_FLLCTL1,
+				    WM8900_REG_FLLCTL1_OSC_ENA, 0);
 		wm8900->fll_in = freq_in;
 		wm8900->fll_out = freq_out;
 
@@ -796,15 +790,14 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 	else
 		snd_soc_write(codec, WM8900_REG_FLLCTL6, 0);
 
-	reg = snd_soc_read(codec, WM8900_REG_POWER1);
-	snd_soc_write(codec, WM8900_REG_POWER1,
-		     reg | WM8900_REG_POWER1_FLL_ENA);
+	snd_soc_update_bits(codec, WM8900_REG_POWER1,
+			    WM8900_REG_POWER1_FLL_ENA,
+			    WM8900_REG_POWER1_FLL_ENA);
 
 reenable:
-	reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
-	snd_soc_write(codec, WM8900_REG_CLOCKING1,
-		     reg | WM8900_REG_CLOCKING1_MCLK_SRC);
-
+	snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+			    WM8900_REG_CLOCKING1_MCLK_SRC,
+			    WM8900_REG_CLOCKING1_MCLK_SRC);
 	return 0;
 }
 
@@ -818,43 +811,35 @@ static int wm8900_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 				 int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	unsigned int reg;
 
 	switch (div_id) {
 	case WM8900_BCLK_DIV:
-		reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
-		snd_soc_write(codec, WM8900_REG_CLOCKING1,
-			     div | (reg & ~WM8900_REG_CLOCKING1_BCLK_MASK));
+		snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+				    WM8900_REG_CLOCKING1_BCLK_MASK, div);
 		break;
 	case WM8900_OPCLK_DIV:
-		reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
-		snd_soc_write(codec, WM8900_REG_CLOCKING1,
-			     div | (reg & ~WM8900_REG_CLOCKING1_OPCLK_MASK));
+		snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+				    WM8900_REG_CLOCKING1_OPCLK_MASK, div);
 		break;
 	case WM8900_DAC_LRCLK:
-		reg = snd_soc_read(codec, WM8900_REG_AUDIO4);
-		snd_soc_write(codec, WM8900_REG_AUDIO4,
-			     div | (reg & ~WM8900_LRC_MASK));
+		snd_soc_update_bits(codec, WM8900_REG_AUDIO4,
+				    WM8900_LRC_MASK, div);
 		break;
 	case WM8900_ADC_LRCLK:
-		reg = snd_soc_read(codec, WM8900_REG_AUDIO3);
-		snd_soc_write(codec, WM8900_REG_AUDIO3,
-			     div | (reg & ~WM8900_LRC_MASK));
+		snd_soc_update_bits(codec, WM8900_REG_AUDIO3,
+				    WM8900_LRC_MASK, div);
 		break;
 	case WM8900_DAC_CLKDIV:
-		reg = snd_soc_read(codec, WM8900_REG_CLOCKING2);
-		snd_soc_write(codec, WM8900_REG_CLOCKING2,
-			     div | (reg & ~WM8900_REG_CLOCKING2_DAC_CLKDIV));
+		snd_soc_update_bits(codec, WM8900_REG_CLOCKING2,
+				    WM8900_REG_CLOCKING2_DAC_CLKDIV, div);
 		break;
 	case WM8900_ADC_CLKDIV:
-		reg = snd_soc_read(codec, WM8900_REG_CLOCKING2);
-		snd_soc_write(codec, WM8900_REG_CLOCKING2,
-			     div | (reg & ~WM8900_REG_CLOCKING2_ADC_CLKDIV));
+		snd_soc_update_bits(codec, WM8900_REG_CLOCKING2,
+				    WM8900_REG_CLOCKING2_ADC_CLKDIV, div);
 		break;
 	case WM8900_LRCLK_MODE:
-		reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
-		snd_soc_write(codec, WM8900_REG_DACCTRL,
-			     div | (reg & ~WM8900_REG_DACCTRL_AIF_LRCLKRATE));
+		snd_soc_update_bits(codec, WM8900_REG_DACCTRL,
+				    WM8900_REG_DACCTRL_AIF_LRCLKRATE, div);
 		break;
 	default:
 		return -EINVAL;
@@ -1037,12 +1022,12 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* Enable thermal shutdown */
-		reg = snd_soc_read(codec, WM8900_REG_GPIO);
-		snd_soc_write(codec, WM8900_REG_GPIO,
-			     reg | WM8900_REG_GPIO_TEMP_ENA);
-		reg = snd_soc_read(codec, WM8900_REG_ADDCTL);
-		snd_soc_write(codec, WM8900_REG_ADDCTL,
-			     reg | WM8900_REG_ADDCTL_TEMP_SD);
+		snd_soc_update_bits(codec, WM8900_REG_GPIO,
+				    WM8900_REG_GPIO_TEMP_ENA,
+				    WM8900_REG_GPIO_TEMP_ENA);
+		snd_soc_update_bits(codec, WM8900_REG_ADDCTL,
+				    WM8900_REG_ADDCTL_TEMP_SD,
+				    WM8900_REG_ADDCTL_TEMP_SD);
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
@@ -1205,26 +1190,16 @@ static int wm8900_probe(struct snd_soc_codec *codec)
 	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the volume update bits */
-	snd_soc_write(codec, WM8900_REG_LINVOL,
-		      snd_soc_read(codec, WM8900_REG_LINVOL) | 0x100);
-	snd_soc_write(codec, WM8900_REG_RINVOL,
-		      snd_soc_read(codec, WM8900_REG_RINVOL) | 0x100);
-	snd_soc_write(codec, WM8900_REG_LOUT1CTL,
-		      snd_soc_read(codec, WM8900_REG_LOUT1CTL) | 0x100);
-	snd_soc_write(codec, WM8900_REG_ROUT1CTL,
-		      snd_soc_read(codec, WM8900_REG_ROUT1CTL) | 0x100);
-	snd_soc_write(codec, WM8900_REG_LOUT2CTL,
-		      snd_soc_read(codec, WM8900_REG_LOUT2CTL) | 0x100);
-	snd_soc_write(codec, WM8900_REG_ROUT2CTL,
-		      snd_soc_read(codec, WM8900_REG_ROUT2CTL) | 0x100);
-	snd_soc_write(codec, WM8900_REG_LDAC_DV,
-		      snd_soc_read(codec, WM8900_REG_LDAC_DV) | 0x100);
-	snd_soc_write(codec, WM8900_REG_RDAC_DV,
-		      snd_soc_read(codec, WM8900_REG_RDAC_DV) | 0x100);
-	snd_soc_write(codec, WM8900_REG_LADC_DV,
-		      snd_soc_read(codec, WM8900_REG_LADC_DV) | 0x100);
-	snd_soc_write(codec, WM8900_REG_RADC_DV,
-		      snd_soc_read(codec, WM8900_REG_RADC_DV) | 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_LINVOL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_RINVOL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_LOUT1CTL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_ROUT1CTL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_LOUT2CTL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_ROUT2CTL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_LDAC_DV, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_RDAC_DV, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_LADC_DV, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8900_REG_RADC_DV, 0x100, 0x100);
 
 	/* Set the DAC and mixer output bias */
 	snd_soc_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
-- 
1.7.4.1
