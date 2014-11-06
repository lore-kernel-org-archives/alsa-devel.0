From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: ssm4567: Add support for setting the
	DAI format and TDM configuration
Date: Thu,  6 Nov 2014 15:59:23 +0100
Message-ID: <1415285964-15930-2-git-send-email-lars@metafoo.de>
References: <1415285964-15930-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-022.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id F131F260859
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 15:59:26 +0100 (CET)
In-Reply-To: <1415285964-15930-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

The SSM4567 has support for a couple of different DAI formats. In TDM mode
it is also possible to select the TDM slot. This patch adds support for this
by implementing the set_fmt and set_tdm_slot callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm4567.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index e1e33d8..2176679 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -69,6 +69,22 @@
 #define SSM4567_DAC_FS_64000_96000	0x3
 #define SSM4567_DAC_FS_128000_192000	0x4
 
+/* SAI_CTRL_1 */
+#define SSM4567_SAI_CTRL_1_BCLK			BIT(6)
+#define SSM4567_SAI_CTRL_1_TDM_BLCKS_MASK	(0x3 << 4)
+#define SSM4567_SAI_CTRL_1_TDM_BLCKS_32		(0x0 << 4)
+#define SSM4567_SAI_CTRL_1_TDM_BLCKS_48		(0x1 << 4)
+#define SSM4567_SAI_CTRL_1_TDM_BLCKS_64		(0x2 << 4)
+#define SSM4567_SAI_CTRL_1_FSYNC		BIT(3)
+#define SSM4567_SAI_CTRL_1_LJ			BIT(2)
+#define SSM4567_SAI_CTRL_1_TDM			BIT(1)
+#define SSM4567_SAI_CTRL_1_PDM			BIT(0)
+
+/* SAI_CTRL_2 */
+#define SSM4567_SAI_CTRL_2_AUTO_SLOT		BIT(3)
+#define SSM4567_SAI_CTRL_2_TDM_SLOT_MASK	0x7
+#define SSM4567_SAI_CTRL_2_TDM_SLOT(x)		(x)
+
 struct ssm4567 {
 	struct regmap *regmap;
 };
@@ -194,6 +210,107 @@ static int ssm4567_mute(struct snd_soc_dai *dai, int mute)
 			SSM4567_DAC_MUTE, val);
 }
 
+static int ssm4567_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+	unsigned int rx_mask, int slots, int width)
+{
+	struct ssm4567 *ssm4567 = snd_soc_dai_get_drvdata(dai);
+	unsigned int blcks;
+	int slot;
+	int ret;
+
+	if (tx_mask == 0)
+		return -EINVAL;
+
+	if (rx_mask && rx_mask != tx_mask)
+		return -EINVAL;
+
+	slot = __ffs(tx_mask);
+	if (tx_mask != BIT(slot))
+		return -EINVAL;
+
+	switch (width) {
+	case 32:
+		blcks = SSM4567_SAI_CTRL_1_TDM_BLCKS_32;
+		break;
+	case 48:
+		blcks = SSM4567_SAI_CTRL_1_TDM_BLCKS_48;
+		break;
+	case 64:
+		blcks = SSM4567_SAI_CTRL_1_TDM_BLCKS_64;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(ssm4567->regmap, SSM4567_REG_SAI_CTRL_2,
+		SSM4567_SAI_CTRL_2_AUTO_SLOT | SSM4567_SAI_CTRL_2_TDM_SLOT_MASK,
+		SSM4567_SAI_CTRL_2_TDM_SLOT(slot));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1,
+		SSM4567_SAI_CTRL_1_TDM_BLCKS_MASK, blcks);
+}
+
+static int ssm4567_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct ssm4567 *ssm4567 = snd_soc_dai_get_drvdata(dai);
+	unsigned int ctrl1 = 0;
+	bool invert_fclk;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		invert_fclk = false;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ctrl1 |= SSM4567_SAI_CTRL_1_BCLK;
+		invert_fclk = false;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		ctrl1 |= SSM4567_SAI_CTRL_1_FSYNC;
+		invert_fclk = true;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		ctrl1 |= SSM4567_SAI_CTRL_1_BCLK;
+		invert_fclk = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl1 |= SSM4567_SAI_CTRL_1_LJ;
+		invert_fclk = !invert_fclk;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl1 |= SSM4567_SAI_CTRL_1_TDM;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctrl1 |= SSM4567_SAI_CTRL_1_TDM | SSM4567_SAI_CTRL_1_LJ;
+		break;
+	case SND_SOC_DAIFMT_PDM:
+		ctrl1 |= SSM4567_SAI_CTRL_1_PDM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (invert_fclk)
+		ctrl1 |= SSM4567_SAI_CTRL_1_FSYNC;
+
+	return regmap_write(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1, ctrl1);
+}
+
 static int ssm4567_set_power(struct ssm4567 *ssm4567, bool enable)
 {
 	int ret = 0;
@@ -248,6 +365,8 @@ static int ssm4567_set_bias_level(struct snd_soc_codec *codec,
 static const struct snd_soc_dai_ops ssm4567_dai_ops = {
 	.hw_params	= ssm4567_hw_params,
 	.digital_mute	= ssm4567_mute,
+	.set_fmt	= ssm4567_set_dai_fmt,
+	.set_tdm_slot	= ssm4567_set_tdm_slot,
 };
 
 static struct snd_soc_dai_driver ssm4567_dai = {
-- 
1.8.0
