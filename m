From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7218: Correct BCLK inversion for DSP
	DAI format mode
Date: Tue, 5 Jan 2016 18:15:33 +0000
Message-ID: <20160105181533.4BC793FAE8@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.108])
 by alsa0.perex.cz (Postfix) with ESMTP id AA5B4260410
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 19:15:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
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

'ASoC: da7218: Enable mic level detection reporting to user-space'
(Commit e05c25a1af29d65260ed1458f2cc4a959030ebd2, kernel/git/broonie/sound.git)

 sound/soc/codecs/da7218.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 752ed04..c7cc88a 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1954,17 +1954,44 @@ static int da7218_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}

-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		dai_clk_mode |= DA7218_DAI_WCLK_POL_INV;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		dai_clk_mode |= DA7218_DAI_CLK_POL_INV;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			dai_clk_mode |= DA7218_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV |
+					DA7218_DAI_CLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		dai_clk_mode |= DA7218_DAI_WCLK_POL_INV | DA7218_DAI_CLK_POL_INV;
+	case SND_SOC_DAIFMT_DSP_B:
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			dai_clk_mode |= DA7218_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV |
+					DA7218_DAI_CLK_POL_INV;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			dai_clk_mode |= DA7218_DAI_WCLK_POL_INV;
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
--
1.9.3
