From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 11/22] ASoC: tas2552: Correct dai format support
Date: Thu, 4 Jun 2015 15:22:35 +0300
Message-ID: <1433420571-5421-12-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 97B322664C2
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:22 +0200 (CEST)
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

DSP_A mode require one bit delay from the FS, DSP_B is without data delay.
When checking the requested format, also match the bit and fs inversion
flag along with the format since it is not possible to change inversion.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 34495241c674..2f4c2b52a9fa 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -188,11 +188,14 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+#define TAS2552_DAI_FMT_MASK	(TAS2552_BIT_CLK_MASK | \
+				 TAS2552_WORD_CLK_MASK | \
+				 TAS2552_DATA_FORMAT_MASK)
 static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	u8 delay = 0;
 	u8 serial_format;
-	u8 serial_control_mask;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
@@ -212,19 +215,19 @@ static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	serial_control_mask = TAS2552_BIT_CLK_MASK | TAS2552_WORD_CLK_MASK;
-
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		serial_format &= TAS2552_DAIFMT_I2S_MASK;
+	switch (fmt & (SND_SOC_DAIFMT_FORMAT_MASK |
+		       SND_SOC_DAIFMT_INV_MASK)) {
+	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
 		break;
-	case SND_SOC_DAIFMT_DSP_A:
+	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
+		delay = 1;
+	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
 		serial_format |= TAS2552_DAIFMT_DSP;
 		break;
-	case SND_SOC_DAIFMT_RIGHT_J:
+	case (SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_NB_NF):
 		serial_format |= TAS2552_DAIFMT_RIGHT_J;
 		break;
-	case SND_SOC_DAIFMT_LEFT_J:
+	case (SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF):
 		serial_format |= TAS2552_DAIFMT_LEFT_J;
 		break;
 	default:
@@ -232,11 +235,9 @@ static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	if (fmt & SND_SOC_DAIFMT_FORMAT_MASK)
-		serial_control_mask |= TAS2552_DATA_FORMAT_MASK;
-
-	snd_soc_update_bits(codec, TAS2552_SER_CTRL_1, serial_control_mask,
-						serial_format);
+	snd_soc_update_bits(codec, TAS2552_SER_CTRL_1, TAS2552_DAI_FMT_MASK,
+			    serial_format);
+	snd_soc_write(codec, TAS2552_SER_CTRL_2, delay);
 
 	return 0;
 }
-- 
2.4.2
