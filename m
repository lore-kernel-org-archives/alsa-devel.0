From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/22] ASoC: tas2552: Add TDM support
Date: Thu, 4 Jun 2015 15:22:37 +0300
Message-ID: <1433420571-5421-14-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id D93F42663DF
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:26 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TDM support is achieved using DSP transfer mode and setting a programmable
offset which specifies where data begins with respect to the frame sync.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 59 ++++++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/tas2552.h |  3 +++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 7615d1bc5f5d..432aa54fe707 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -78,6 +78,9 @@ struct tas2552_data {
 	unsigned char regs[TAS2552_VBAT_DATA];
 	unsigned int pll_clkin;
 	unsigned int pdm_clk;
+
+	unsigned int dai_fmt;
+	unsigned int tdm_delay;
 };
 
 /* Input mux controls */
@@ -191,10 +194,29 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 #define TAS2552_DAI_FMT_MASK	(TAS2552_BCLKDIR | \
 				 TAS2552_WCLKDIR | \
 				 TAS2552_DATAFORMAT_MASK)
+static int tas2552_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct tas2552_data *tas2552 = snd_soc_codec_get_drvdata(codec);
+	int delay = 0;
+
+	/* TDM slot selection only valid in DSP_A/_B mode */
+	if (tas2552->dai_fmt == SND_SOC_DAIFMT_DSP_A)
+		delay += (tas2552->tdm_delay + 1);
+	else if (tas2552->dai_fmt == SND_SOC_DAIFMT_DSP_B)
+		delay += tas2552->tdm_delay;
+
+	/* Configure data delay */
+	snd_soc_write(codec, TAS2552_SER_CTRL_2, delay);
+
+	return 0;
+}
+
 static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u8 delay = 0;
+	struct tas2552_data *tas2552 = dev_get_drvdata(codec->dev);
 	u8 serial_format;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -220,7 +242,6 @@ static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
 		break;
 	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
-		delay = 1;
 	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
 		serial_format |= TAS2552_DATAFORMAT_DSP;
 		break;
@@ -234,11 +255,10 @@ static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		dev_vdbg(codec->dev, "DAI Format is not found\n");
 		return -EINVAL;
 	}
+	tas2552->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
 	snd_soc_update_bits(codec, TAS2552_SER_CTRL_1, TAS2552_DAI_FMT_MASK,
 			    serial_format);
-	snd_soc_write(codec, TAS2552_SER_CTRL_2, delay);
-
 	return 0;
 }
 
@@ -278,6 +298,35 @@ static int tas2552_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int tas2552_set_dai_tdm_slot(struct snd_soc_dai *dai,
+				    unsigned int tx_mask, unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct tas2552_data *tas2552 = snd_soc_codec_get_drvdata(codec);
+	unsigned int lsb;
+
+	if (unlikely(!tx_mask)) {
+		dev_err(codec->dev, "tx masks need to be non 0\n");
+		return -EINVAL;
+	}
+
+	/* TDM based on DSP mode requires slots to be adjacent */
+	lsb = __ffs(tx_mask);
+	if ((lsb + 1) != __fls(tx_mask)) {
+		dev_err(codec->dev, "Invalid mask, slots must be adjacent\n");
+		return -EINVAL;
+	}
+
+	tas2552->tdm_delay = lsb * slot_width;
+
+	/* DOUT in high-impedance on inactive bit clocks */
+	snd_soc_update_bits(codec, TAS2552_DOUT,
+			    TAS2552_SDOUT_TRISTATE, TAS2552_SDOUT_TRISTATE);
+
+	return 0;
+}
+
 static int tas2552_mute(struct snd_soc_dai *dai, int mute)
 {
 	u8 cfg1_reg = 0;
@@ -330,8 +379,10 @@ static const struct dev_pm_ops tas2552_pm = {
 
 static struct snd_soc_dai_ops tas2552_speaker_dai_ops = {
 	.hw_params	= tas2552_hw_params,
+	.prepare	= tas2552_prepare,
 	.set_sysclk	= tas2552_set_dai_sysclk,
 	.set_fmt	= tas2552_set_dai_fmt,
+	.set_tdm_slot	= tas2552_set_dai_tdm_slot,
 	.digital_mute = tas2552_mute,
 };
 
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 0a12b511e951..5bdc7eaaddea 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -62,6 +62,9 @@
 #define TAS2552_LIM_EN			(1 << 2)
 #define TAS2552_IVSENSE_EN		(1 << 1)
 
+/* DOUT Register Masks */
+#define TAS2552_SDOUT_TRISTATE		(1 << 2)
+
 /* Serial Interface Control Register Masks */
 #define TAS2552_DATAFORMAT_I2S		(0x0 << 2)
 #define TAS2552_DATAFORMAT_DSP		(0x1 << 2)
-- 
2.4.2
