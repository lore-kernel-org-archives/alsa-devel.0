From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8990: Use snd_soc_update_bits for
	read-modify-write
Date: Fri, 14 Oct 2011 14:30:05 +0800
Message-ID: <1318573805.4610.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.213.177])
	by alsa0.perex.cz (Postfix) with ESMTP id A83DF24485
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 08:30:12 +0200 (CEST)
Received: by yxk36 with SMTP id 36so507461yxk.22
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 23:30:11 -0700 (PDT)
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

This patch also includes a comment fix in wm8990_set_dai_pll(),
if freq_in and freq_out are 0, what we do is to clear WM8990_PLL_ENA bit.
Thus the comment should be "Turn off PLL".

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8990.c |   67 ++++++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index b9c5ecc..d29a962 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -981,7 +981,6 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int target,
 static int wm8990_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
-	u16 reg;
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct _pll_div pll_div;
 
@@ -989,13 +988,12 @@ static int wm8990_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		pll_factors(&pll_div, freq_out * 4, freq_in);
 
 		/* Turn on PLL */
-		reg = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_2);
-		reg |= WM8990_PLL_ENA;
-		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_2, reg);
+		snd_soc_update_bits(codec, WM8990_POWER_MANAGEMENT_2,
+				    WM8990_PLL_ENA, WM8990_PLL_ENA);
 
 		/* sysclk comes from PLL */
-		reg = snd_soc_read(codec, WM8990_CLOCKING_2);
-		snd_soc_write(codec, WM8990_CLOCKING_2, reg | WM8990_SYSCLK_SRC);
+		snd_soc_update_bits(codec, WM8990_CLOCKING_2,
+				    WM8990_SYSCLK_SRC, WM8990_SYSCLK_SRC);
 
 		/* set up N , fractional mode and pre-divisor if necessary */
 		snd_soc_write(codec, WM8990_PLL1, pll_div.n | WM8990_SDM |
@@ -1003,10 +1001,9 @@ static int wm8990_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		snd_soc_write(codec, WM8990_PLL2, (u8)(pll_div.k>>8));
 		snd_soc_write(codec, WM8990_PLL3, (u8)(pll_div.k & 0xFF));
 	} else {
-		/* Turn on PLL */
-		reg = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_2);
-		reg &= ~WM8990_PLL_ENA;
-		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_2, reg);
+		/* Turn off PLL */
+		snd_soc_update_bits(codec, WM8990_POWER_MANAGEMENT_2,
+				    WM8990_PLL_ENA, 0);
 	}
 	return 0;
 }
@@ -1084,28 +1081,23 @@ static int wm8990_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 reg;
 
 	switch (div_id) {
 	case WM8990_MCLK_DIV:
-		reg = snd_soc_read(codec, WM8990_CLOCKING_2) &
-			~WM8990_MCLK_DIV_MASK;
-		snd_soc_write(codec, WM8990_CLOCKING_2, reg | div);
+		snd_soc_update_bits(codec, WM8990_CLOCKING_2,
+				    WM8990_MCLK_DIV_MASK, div);
 		break;
 	case WM8990_DACCLK_DIV:
-		reg = snd_soc_read(codec, WM8990_CLOCKING_2) &
-			~WM8990_DAC_CLKDIV_MASK;
-		snd_soc_write(codec, WM8990_CLOCKING_2, reg | div);
+		snd_soc_update_bits(codec, WM8990_CLOCKING_2,
+				    WM8990_DAC_CLKDIV_MASK, div);
 		break;
 	case WM8990_ADCCLK_DIV:
-		reg = snd_soc_read(codec, WM8990_CLOCKING_2) &
-			~WM8990_ADC_CLKDIV_MASK;
-		snd_soc_write(codec, WM8990_CLOCKING_2, reg | div);
+		snd_soc_update_bits(codec, WM8990_CLOCKING_2,
+				    WM8990_ADC_CLKDIV_MASK, div);
 		break;
 	case WM8990_BCLK_DIV:
-		reg = snd_soc_read(codec, WM8990_CLOCKING_1) &
-			~WM8990_BCLK_DIV_MASK;
-		snd_soc_write(codec, WM8990_CLOCKING_1, reg | div);
+		snd_soc_update_bits(codec, WM8990_CLOCKING_1,
+				    WM8990_BCLK_DIV_MASK, div);
 		break;
 	default:
 		return -EINVAL;
@@ -1164,7 +1156,6 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
 	int ret;
-	u16 val;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1172,9 +1163,8 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*50k */
-		val = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_1) &
-			~WM8990_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x2);
+		snd_soc_update_bits(codec, WM8990_POWER_MANAGEMENT_1,
+				    WM8990_VMID_MODE_MASK, 0x2);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -1239,9 +1229,8 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* VMID=2*250k */
-		val = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_1) &
-			~WM8990_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x4);
+		snd_soc_update_bits(codec, WM8990_POWER_MANAGEMENT_1,
+				    WM8990_VMID_MODE_MASK, 0x4);
 		break;
 
 	case SND_SOC_BIAS_OFF:
@@ -1255,8 +1244,8 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 			WM8990_BUFIOEN);
 
 		/* mute DAC */
-		val = snd_soc_read(codec, WM8990_DAC_CTRL);
-		snd_soc_write(codec, WM8990_DAC_CTRL, val | WM8990_DAC_MUTE);
+		snd_soc_update_bits(codec, WM8990_DAC_CTRL,
+				    WM8990_DAC_MUTE, WM8990_DAC_MUTE);
 
 		/* Enable any disabled outputs */
 		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f03);
@@ -1344,7 +1333,6 @@ static int wm8990_resume(struct snd_soc_codec *codec)
 static int wm8990_probe(struct snd_soc_codec *codec)
 {
 	int ret;
-	u16 reg;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret < 0) {
@@ -1357,15 +1345,14 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 	/* charge output caps */
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	reg = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_4);
-	snd_soc_write(codec, WM8990_AUDIO_INTERFACE_4, reg | WM8990_ALRCGPIO1);
+	snd_soc_update_bits(codec, WM8990_AUDIO_INTERFACE_4,
+			    WM8990_ALRCGPIO1, WM8990_ALRCGPIO1);
 
-	reg = snd_soc_read(codec, WM8990_GPIO1_GPIO2) &
-		~WM8990_GPIO1_SEL_MASK;
-	snd_soc_write(codec, WM8990_GPIO1_GPIO2, reg | 1);
+	snd_soc_update_bits(codec, WM8990_GPIO1_GPIO2,
+			    WM8990_GPIO1_SEL_MASK, 1);
 
-	reg = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_2);
-	snd_soc_write(codec, WM8990_POWER_MANAGEMENT_2, reg | WM8990_OPCLK_ENA);
+	snd_soc_update_bits(codec, WM8990_POWER_MANAGEMENT_2,
+			    WM8990_OPCLK_ENA, WM8990_OPCLK_ENA);
 
 	snd_soc_write(codec, WM8990_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8990_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
-- 
1.7.4.1
