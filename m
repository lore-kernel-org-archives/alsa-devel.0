From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7219: Correct BCLK inversion for DSP DAI format mode
Date: Tue, 5 Jan 2016 15:05:36 +0000
Message-ID: <20160105150536.7C29F3FAE8@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

By default the device latches data on the falling edge of the
BCLK in DSP mode, whereas the expectation for normal BCLK is to
latch on the rising edge. This updates the driver to invert the
BCLK configuration for DSP mode, to align with expected behaviour.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

This patch is based on the following commit:

'ASoC: da7219: Add regmap patch to support old silicon'
(Commit abd7c894fc41a9a674354e10ed6c55413e1db077, kernel/git/broonie/sound.git)


 sound/soc/codecs/da7219.c | 48 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 341a191..0d7a897 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1156,18 +1156,44 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}

-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		dai_clk_mode |= DA7219_DAI_WCLK_POL_INV;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		dai_clk_mode |= DA7219_DAI_CLK_POL_INV;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7219_DAI_WCLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			dai_clk_mode |= DA7219_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7219_DAI_WCLK_POL_INV |
+					DA7219_DAI_CLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		dai_clk_mode |= DA7219_DAI_WCLK_POL_INV |
-				DA7219_DAI_CLK_POL_INV;
+	case SND_SOC_DAIFMT_DSP_B:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			dai_clk_mode |= DA7219_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7219_DAI_WCLK_POL_INV |
+					DA7219_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7219_DAI_WCLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
--
1.9.3
