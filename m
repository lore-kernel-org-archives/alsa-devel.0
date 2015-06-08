From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/9] ASoC: tas2552: Correct the PLL
	configuration
Date: Mon, 8 Jun 2015 15:19:48 +0300
Message-ID: <1433765996-28930-2-git-send-email-peter.ujfalusi@ti.com>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C835826040E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:04 +0200 (CEST)
In-Reply-To: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Do not restrict the sampling rate to 44.1/48KHz. The pll_clk clock should
be (sampling rate * 512) in all cases.
Correct the J.D calculation (the D part was incorrectly calculated).
Restore PLL enable status after we are done with the configuration.
Implement hardware constraint handling towards the pll_clkin:
if D != 0 (in J.D) then 1.1MHz <= pll_clkin <= 9.2MHz needs to be checked.
If the PLL setup does not met with this constraint, fall back to BCLK as
reference clock, if BCLK fails, use the internal 1.8MHz clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 138 ++++++++++++++++++++++++++++++---------------
 sound/soc/codecs/tas2552.h |  11 ++--
 2 files changed, 95 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 891e2c529df3..0ca55aaeaaf2 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -77,7 +77,9 @@ struct tas2552_data {
 	struct gpio_desc *enable_gpio;
 	unsigned char regs[TAS2552_VBAT_DATA];
 	unsigned int pll_clkin;
+	int pll_clk_id;
 	unsigned int pdm_clk;
+	int pdm_clk_id;
 
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
@@ -158,16 +160,90 @@ static void tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)
 }
 #endif
 
+static int tas2552_setup_pll(struct snd_soc_codec *codec,
+			     struct snd_pcm_hw_params *params)
+{
+	struct tas2552_data *tas2552 = dev_get_drvdata(codec->dev);
+	bool bypass_pll = false;
+	unsigned int pll_clk = params_rate(params) * 512;
+	unsigned int pll_clkin = tas2552->pll_clkin;
+	u8 pll_enable;
+
+	if (!pll_clkin) {
+		if (tas2552->pll_clk_id != TAS2552_PLL_CLKIN_BCLK)
+			return -EINVAL;
+
+		pll_clkin = snd_soc_params_to_bclk(params);
+		pll_clkin += tas2552->tdm_delay;
+	}
+
+	pll_enable = snd_soc_read(codec, TAS2552_CFG_2) & TAS2552_PLL_ENABLE;
+	snd_soc_update_bits(codec, TAS2552_CFG_2, TAS2552_PLL_ENABLE, 0);
+
+	if (pll_clkin == pll_clk)
+		bypass_pll = true;
+
+	if (bypass_pll) {
+		/* By pass the PLL configuration */
+		snd_soc_update_bits(codec, TAS2552_PLL_CTRL_2,
+				    TAS2552_PLL_BYPASS, TAS2552_PLL_BYPASS);
+	} else {
+		/* Fill in the PLL control registers for J & D
+		 * pll_clk = (.5 * pll_clkin * J.D) / 2^p
+		 * Need to fill in J and D here based on incoming freq
+		 */
+		unsigned int d;
+		u8 j;
+		u8 pll_sel = (tas2552->pll_clk_id << 3) & TAS2552_PLL_SRC_MASK;
+		u8 p = snd_soc_read(codec, TAS2552_PLL_CTRL_1);
+
+		p = (p >> 7);
+
+recalc:
+		j = (pll_clk * 2 * (1 << p)) / pll_clkin;
+		d = (pll_clk * 2 * (1 << p)) % pll_clkin;
+		d /= (pll_clkin / 10000);
+
+		if (d && (pll_clkin < 512000 || pll_clkin > 9200000)) {
+			if (tas2552->pll_clk_id == TAS2552_PLL_CLKIN_BCLK) {
+				pll_clkin = 1800000;
+				pll_sel = (TAS2552_PLL_CLKIN_1_8_FIXED << 3) &
+							TAS2552_PLL_SRC_MASK;
+			} else {
+				pll_clkin = snd_soc_params_to_bclk(params);
+				pll_clkin += tas2552->tdm_delay;
+				pll_sel = (TAS2552_PLL_CLKIN_BCLK << 3) &
+							TAS2552_PLL_SRC_MASK;
+			}
+			goto recalc;
+		}
+
+		snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_PLL_SRC_MASK,
+				    pll_sel);
+
+		snd_soc_update_bits(codec, TAS2552_PLL_CTRL_1,
+				    TAS2552_PLL_J_MASK, j);
+		/* Will clear the PLL_BYPASS bit */
+		snd_soc_write(codec, TAS2552_PLL_CTRL_2,
+			      TAS2552_PLL_D_UPPER(d));
+		snd_soc_write(codec, TAS2552_PLL_CTRL_3,
+			      TAS2552_PLL_D_LOWER(d));
+	}
+
+	/* Restore PLL status */
+	snd_soc_update_bits(codec, TAS2552_CFG_2, TAS2552_PLL_ENABLE,
+			    pll_enable);
+
+	return 0;
+}
+
 static int tas2552_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct tas2552_data *tas2552 = dev_get_drvdata(codec->dev);
-	int sample_rate, pll_clk;
-	int d;
 	int cpf;
-	u8 p, j;
 	u8 ser_ctrl1_reg, wclk_rate;
 
 	switch (params_width(params)) {
@@ -245,49 +321,7 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_update_bits(codec, TAS2552_CFG_3, TAS2552_WCLK_FREQ_MASK,
 			    wclk_rate);
 
-	if (!tas2552->pll_clkin)
-		return -EINVAL;
-
-	snd_soc_update_bits(codec, TAS2552_CFG_2, TAS2552_PLL_ENABLE, 0);
-
-	if (tas2552->pll_clkin == TAS2552_245MHZ_CLK ||
-	    tas2552->pll_clkin == TAS2552_225MHZ_CLK) {
-		/* By pass the PLL configuration */
-		snd_soc_update_bits(codec, TAS2552_PLL_CTRL_2,
-				    TAS2552_PLL_BYPASS_MASK,
-				    TAS2552_PLL_BYPASS);
-	} else {
-		/* Fill in the PLL control registers for J & D
-		 * PLL_CLK = (.5 * freq * J.D) / 2^p
-		 * Need to fill in J and D here based on incoming freq
-		 */
-		p = snd_soc_read(codec, TAS2552_PLL_CTRL_1);
-		p = (p >> 7);
-		sample_rate = params_rate(params);
-
-		if (sample_rate == 48000)
-			pll_clk = TAS2552_245MHZ_CLK;
-		else if (sample_rate == 44100)
-			pll_clk = TAS2552_225MHZ_CLK;
-		else {
-			dev_vdbg(codec->dev, "Substream sample rate is not found %i\n",
-					params_rate(params));
-			return -EINVAL;
-		}
-
-		j = (pll_clk * 2 * (1 << p)) / tas2552->pll_clkin;
-		d = (pll_clk * 2 * (1 << p)) % tas2552->pll_clkin;
-
-		snd_soc_update_bits(codec, TAS2552_PLL_CTRL_1,
-				TAS2552_PLL_J_MASK, j);
-		snd_soc_write(codec, TAS2552_PLL_CTRL_2,
-					(d >> 7) & TAS2552_PLL_D_UPPER_MASK);
-		snd_soc_write(codec, TAS2552_PLL_CTRL_3,
-				d & TAS2552_PLL_D_LOWER_MASK);
-
-	}
-
-	return 0;
+	return tas2552_setup_pll(codec, params);
 }
 
 #define TAS2552_DAI_FMT_MASK	(TAS2552_BCLKDIR | \
@@ -370,12 +404,21 @@ static int tas2552_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	switch (clk_id) {
 	case TAS2552_PLL_CLKIN_MCLK:
-	case TAS2552_PLL_CLKIN_BCLK:
 	case TAS2552_PLL_CLKIN_IVCLKIN:
+		if (freq < 512000 || freq > 24576000) {
+			/* out of range PLL_CLKIN, fall back to use BCLK */
+			dev_warn(codec->dev, "Out of range PLL_CLKIN: %u\n",
+				 freq);
+			clk_id = TAS2552_PLL_CLKIN_BCLK;
+			freq = 0;
+		}
+		/* fall through */
+	case TAS2552_PLL_CLKIN_BCLK:
 	case TAS2552_PLL_CLKIN_1_8_FIXED:
 		mask = TAS2552_PLL_SRC_MASK;
 		val = (clk_id << 3) & mask; /* bit 4:5 in the register */
 		reg = TAS2552_CFG_1;
+		tas2552->pll_clk_id = clk_id;
 		tas2552->pll_clkin = freq;
 		break;
 	case TAS2552_PDM_CLK_PLL:
@@ -385,6 +428,7 @@ static int tas2552_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		mask = TAS2552_PDM_CLK_SEL_MASK;
 		val = (clk_id >> 1) & mask; /* bit 0:1 in the register */
 		reg = TAS2552_PDM_CFG;
+		tas2552->pdm_clk_id = clk_id;
 		tas2552->pdm_clk = freq;
 		break;
 	default:
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index bbb820495516..6806516a62cd 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -128,12 +128,9 @@
 #define TAS2552_APT_THRESH_2_1_7	(0x11 << 2)
 
 /* PLL Control Register */
-#define TAS2552_245MHZ_CLK			24576000
-#define TAS2552_225MHZ_CLK			22579200
-#define TAS2552_PLL_J_MASK			0x7f
-#define TAS2552_PLL_D_UPPER_MASK	0x3f
-#define TAS2552_PLL_D_LOWER_MASK	0xff
-#define TAS2552_PLL_BYPASS_MASK		0x80
-#define TAS2552_PLL_BYPASS			0x80
+#define TAS2552_PLL_J_MASK		0x7f
+#define TAS2552_PLL_D_UPPER(x)		(((x) >> 8) & 0x3f)
+#define TAS2552_PLL_D_LOWER(x)		((x) & 0xff)
+#define TAS2552_PLL_BYPASS		(1 << 7)
 
 #endif
-- 
2.4.2
