From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: AD/DA over sampling rate
	configuration" to the asoc tree
Date: Fri, 11 Nov 2016 15:52:18 +0000
Message-ID: <E1c5E7m-0002h4-CA@finisterre>
References: <1478835282-10687-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 778CE2674CF
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 16:52:34 +0100 (CET)
In-Reply-To: <1478835282-10687-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: AD/DA over sampling rate configuration

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d6d197458b5fc801b2274f5287a4df6ce74b230f Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 11 Nov 2016 11:34:42 +0800
Subject: [PATCH] ASoC: nau8825: AD/DA over sampling rate configuration

Over Sampling Rate (OSR) is defined as CLK_ADC frequency divided by the
audio sample rate (Fs).
OSR = CLK_ADC / FS
The available OSRs are 32, 64, 128 or 256. Note that the OSR and Fs
values must be selected such that the maximum frequency of CLK_ADC
is less than 6.144 MHz. It is recommended to match the relationship
between OSR and clock SRC according to following Table.
ADC_RATE: 00(OSR=32)  | CLK_ADC_SRC: 11(CODEC 1/8)
ADC_RATE: 01(OSR=64)  | CLK_ADC_SRC: 10(CODEC1/4)
ADC_RATE: 10(OSR=128) | CLK_ADC_SRC: 01(CODEC 1/2)
ADC_RATE: 11(OSR=256) | CLK_ADC_SRC: 00(CODEC CLK)

The over sampling rate about DAC follows the same rule with ADCs.
The driver changes the OSR to 64 value when initiation for better FLL
performance and applies the dynamic SRC change by different OSR.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/nau8825.h |  4 +++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 0db618b2f2b8..50cdb30297b4 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -43,6 +43,8 @@
 #define GAIN_AUGMENT 22500
 #define SIDETONE_BASE 207000
 
+/* the maximum frequency of CLK_ADC and CLK_DAC */
+#define CLK_DA_AD_MAX 6144000
 
 static int nau8825_configure_sysclk(struct nau8825 *nau8825,
 		int clk_id, unsigned int freq);
@@ -95,6 +97,27 @@ static const struct nau8825_fll_attr fll_pre_scalar[] = {
 	{ 8, 0x3 },
 };
 
+/* over sampling rate */
+struct nau8825_osr_attr {
+	unsigned int osr;
+	unsigned int clk_src;
+};
+
+static const struct nau8825_osr_attr osr_dac_sel[] = {
+	{ 64, 2 },	/* OSR 64, SRC 1/4 */
+	{ 256, 0 },	/* OSR 256, SRC 1 */
+	{ 128, 1 },	/* OSR 128, SRC 1/2 */
+	{ 0, 0 },
+	{ 32, 3 },	/* OSR 32, SRC 1/8 */
+};
+
+static const struct nau8825_osr_attr osr_adc_sel[] = {
+	{ 32, 3 },	/* OSR 32, SRC 1/8 */
+	{ 64, 2 },	/* OSR 64, SRC 1/4 */
+	{ 128, 1 },	/* OSR 128, SRC 1/2 */
+	{ 256, 0 },	/* OSR 256, SRC 1 */
+};
+
 static const struct reg_default nau8825_reg_defaults[] = {
 	{ NAU8825_REG_ENA_CTRL, 0x00ff },
 	{ NAU8825_REG_IIC_ADDR_SET, 0x0 },
@@ -1179,16 +1202,65 @@ static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
 	{"HPOR", NULL, "Class G"},
 };
 
+static int nau8825_clock_check(struct nau8825 *nau8825,
+	int stream, int rate, int osr)
+{
+	int osrate;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (osr >= ARRAY_SIZE(osr_dac_sel))
+			return -EINVAL;
+		osrate = osr_dac_sel[osr].osr;
+	} else {
+		if (osr >= ARRAY_SIZE(osr_adc_sel))
+			return -EINVAL;
+		osrate = osr_adc_sel[osr].osr;
+	}
+
+	if (!osrate || rate * osr > CLK_DA_AD_MAX) {
+		dev_err(nau8825->dev, "exceed the maximum frequency of CLK_ADC or CLK_DAC\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nau8825_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val_len = 0;
+	unsigned int val_len = 0, osr;
 
 	nau8825_sema_acquire(nau8825, 2 * HZ);
 
+	/* CLK_DAC or CLK_ADC = OSR * FS
+	 * DAC or ADC clock frequency is defined as Over Sampling Rate (OSR)
+	 * multiplied by the audio sample rate (Fs). Note that the OSR and Fs
+	 * values must be selected such that the maximum frequency is less
+	 * than 6.144 MHz.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_read(nau8825->regmap, NAU8825_REG_DAC_CTRL1, &osr);
+		osr &= NAU8825_DAC_OVERSAMPLE_MASK;
+		if (nau8825_clock_check(nau8825, substream->stream,
+			params_rate(params), osr))
+			return -EINVAL;
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_DAC_SRC_MASK,
+			osr_dac_sel[osr].clk_src << NAU8825_CLK_DAC_SRC_SFT);
+	} else {
+		regmap_read(nau8825->regmap, NAU8825_REG_ADC_RATE, &osr);
+		osr &= NAU8825_ADC_SYNC_DOWN_MASK;
+		if (nau8825_clock_check(nau8825, substream->stream,
+			params_rate(params), osr))
+			return -EINVAL;
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_ADC_SRC_MASK,
+			osr_adc_sel[osr].clk_src << NAU8825_CLK_ADC_SRC_SFT);
+	}
+
 	switch (params_width(params)) {
 	case 16:
 		val_len |= NAU8825_I2S_DL_16;
@@ -1774,9 +1846,9 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 	 * (audible hiss). Set it to something better.
 	 */
 	regmap_update_bits(regmap, NAU8825_REG_ADC_RATE,
-		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_128);
+		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
-		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_128);
+		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_64);
 	/* Disable DACR/L power */
 	regmap_update_bits(regmap, NAU8825_REG_CHARGE_PUMP,
 		NAU8825_POWER_DOWN_DACR | NAU8825_POWER_DOWN_DACL,
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 6365c9c3f8d9..167a2aaad256 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -115,6 +115,10 @@
 #define NAU8825_CLK_SRC_MASK			(1 << NAU8825_CLK_SRC_SFT)
 #define NAU8825_CLK_SRC_VCO			(1 << NAU8825_CLK_SRC_SFT)
 #define NAU8825_CLK_SRC_MCLK			(0 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_ADC_SRC_SFT		6
+#define NAU8825_CLK_ADC_SRC_MASK		(0x3 << NAU8825_CLK_ADC_SRC_SFT)
+#define NAU8825_CLK_DAC_SRC_SFT		4
+#define NAU8825_CLK_DAC_SRC_MASK		(0x3 << NAU8825_CLK_DAC_SRC_SFT)
 #define NAU8825_CLK_MCLK_SRC_MASK		(0xf << 0)
 
 /* FLL1 (0x04) */
-- 
2.10.2
