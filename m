From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: TDM support" to the asoc tree
Date: Mon, 15 May 2017 17:02:08 +0900
Message-ID: <E1dAAxE-0002Lm-Uy@finisterre>
References: <1493689378-13662-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A382266DCF
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:18 +0200 (CEST)
In-Reply-To: <1493689378-13662-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: TDM support

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

>From fa1014302791a1e436387e93a90f38717d7f9b03 Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Tue, 2 May 2017 09:42:58 +0800
Subject: [PATCH] ASoC: nau8824: TDM support

Support TDM format for NAU88L24.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8824.h | 12 +++++++++++
 2 files changed, 64 insertions(+)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index cca974d26136..3a309b18035e 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1125,6 +1125,57 @@ static int nau8824_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 }
 
 /**
+ * nau8824_set_tdm_slot - configure DAI TDM.
+ * @dai: DAI
+ * @tx_mask: Bitmask representing active TX slots. Ex.
+ *                 0xf for normal 4 channel TDM.
+ *                 0xf0 for shifted 4 channel TDM
+ * @rx_mask: Bitmask [0:1] representing active DACR RX slots.
+ *                 Bitmask [2:3] representing active DACL RX slots.
+ *                 00=CH0,01=CH1,10=CH2,11=CH3. Ex.
+ *                 0xf for DACL/R selecting TDM CH3.
+ *                 0xf0 for DACL/R selecting shifted TDM CH3.
+ * @slots: Number of slots in use.
+ * @slot_width: Width in bits for each slot.
+ *
+ * Configures a DAI for TDM operation. Only support 4 slots TDM.
+ */
+static int nau8824_set_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	unsigned int tslot_l = 0, ctrl_val = 0;
+
+	if (slots > 4 || ((tx_mask & 0xf0) && (tx_mask & 0xf)) ||
+		((rx_mask & 0xf0) && (rx_mask & 0xf)) ||
+		((rx_mask & 0xf0) && (tx_mask & 0xf)) ||
+		((rx_mask & 0xf) && (tx_mask & 0xf0)))
+		return -EINVAL;
+
+	ctrl_val |= (NAU8824_TDM_MODE | NAU8824_TDM_OFFSET_EN);
+	if (tx_mask & 0xf0) {
+		tslot_l = 4 * slot_width;
+		ctrl_val |= (tx_mask >> 4);
+	} else {
+		ctrl_val |= tx_mask;
+	}
+	if (rx_mask & 0xf0)
+		ctrl_val |= ((rx_mask >> 4) << NAU8824_TDM_DACR_RX_SFT);
+	else
+		ctrl_val |= (rx_mask << NAU8824_TDM_DACR_RX_SFT);
+
+	regmap_update_bits(nau8824->regmap, NAU8824_REG_TDM_CTRL,
+		NAU8824_TDM_MODE | NAU8824_TDM_OFFSET_EN |
+		NAU8824_TDM_DACL_RX_MASK | NAU8824_TDM_DACR_RX_MASK |
+		NAU8824_TDM_TX_MASK, ctrl_val);
+	regmap_update_bits(nau8824->regmap, NAU8824_REG_PORT0_LEFT_TIME_SLOT,
+		NAU8824_TSLOT_L_MASK, tslot_l);
+
+	return 0;
+}
+
+/**
  * nau8824_calc_fll_param - Calculate FLL parameters.
  * @fll_in: external clock provided to codec.
  * @fs: sampling rate.
@@ -1440,6 +1491,7 @@ static struct snd_soc_codec_driver nau8824_codec_driver = {
 static const struct snd_soc_dai_ops nau8824_dai_ops = {
 	.hw_params = nau8824_hw_params,
 	.set_fmt = nau8824_set_fmt,
+	.set_tdm_slot = nau8824_set_tdm_slot,
 };
 
 #define NAU8824_RATES SNDRV_PCM_RATE_8000_192000
diff --git a/sound/soc/codecs/nau8824.h b/sound/soc/codecs/nau8824.h
index 87ac9a382aed..21eae2431c83 100644
--- a/sound/soc/codecs/nau8824.h
+++ b/sound/soc/codecs/nau8824.h
@@ -258,6 +258,18 @@
 #define NAU8824_I2S_MS_SLAVE		(0 << NAU8824_I2S_MS_SFT)
 #define NAU8824_I2S_BLK_DIV_MASK	0x7
 
+/* PORT0_LEFT_TIME_SLOT (0x1E) */
+#define NAU8824_TSLOT_L_MASK	0x3ff
+
+/* TDM_CTRL (0x20) */
+#define NAU8824_TDM_MODE		(0x1 << 15)
+#define NAU8824_TDM_OFFSET_EN		(0x1 << 14)
+#define NAU8824_TDM_DACL_RX_SFT	6
+#define NAU8824_TDM_DACL_RX_MASK	(0x3 << NAU8824_TDM_DACL_RX_SFT)
+#define NAU8824_TDM_DACR_RX_SFT	4
+#define NAU8824_TDM_DACR_RX_MASK	(0x3 << NAU8824_TDM_DACR_RX_SFT)
+#define NAU8824_TDM_TX_MASK		0xf
+
 /* ADC_FILTER_CTRL (0x24) */
 #define NAU8824_ADC_SYNC_DOWN_MASK	0x3
 #define NAU8824_ADC_SYNC_DOWN_32	0
-- 
2.11.0
