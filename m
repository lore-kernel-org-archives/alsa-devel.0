From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Support the TDM docking mode"
	to the asoc tree
Date: Thu, 20 Jul 2017 13:23:45 +0100
Message-ID: <E1dYAUb-000166-GB@debutante>
References: <1500516460-22008-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05ADD266CD2
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 14:24:01 +0200 (CEST)
In-Reply-To: <1500516460-22008-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, harshapriya.n@intel.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Support the TDM docking mode

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

>From e8be3a5ad335316ddf1b90e0386426093187bfc7 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Thu, 20 Jul 2017 12:05:34 +0800
Subject: [PATCH] ASoC: rt5514: Support the TDM docking mode

The TDM docking mode can share the bus to other devices simultaneously.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 33 ++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5514.h | 12 ++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 4ca73bf83cc1..a105c84ef555 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -871,11 +871,38 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val = 0;
+	unsigned int val = 0, val2 = 0;
 
 	if (rx_mask || tx_mask)
 		val |= RT5514_TDM_MODE;
 
+	switch (tx_mask) {
+	case 0x3:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH2 |
+			RT5514_TDM_DOCKING_START_SLOT0;
+		break;
+
+	case 0x30:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH2 |
+			RT5514_TDM_DOCKING_START_SLOT4;
+		break;
+
+	case 0xf:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH4 |
+			RT5514_TDM_DOCKING_START_SLOT0;
+		break;
+
+	case 0xf0:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH4 |
+			RT5514_TDM_DOCKING_START_SLOT4;
+		break;
+
+	default:
+		break;
+	}
+
+
+
 	switch (slots) {
 	case 4:
 		val |= RT5514_TDMSLOT_SEL_RX_4CH | RT5514_TDMSLOT_SEL_TX_4CH;
@@ -921,6 +948,10 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK |
 		RT5514_TDM_MODE2, val);
 
+	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL2,
+		RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH_MASK |
+		RT5514_TDM_DOCKING_START_MASK, val2);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 02bc212a86d9..75024a4bb7f5 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -164,6 +164,18 @@
 #define RT5514_I2S_DL_24			(0x2 << 0)
 #define RT5514_I2S_DL_8				(0x3 << 0)
 
+/* RT5514_I2S_CTRL2 (0x2014) */
+#define RT5514_TDM_DOCKING_MODE			(0x1 << 31)
+#define RT5514_TDM_DOCKING_MODE_SFT		31
+#define RT5514_TDM_DOCKING_VALID_CH_MASK	(0x1 << 29)
+#define RT5514_TDM_DOCKING_VALID_CH_SFT		29
+#define RT5514_TDM_DOCKING_VALID_CH2		(0x0 << 29)
+#define RT5514_TDM_DOCKING_VALID_CH4		(0x1 << 29)
+#define RT5514_TDM_DOCKING_START_MASK		(0x1 << 28)
+#define RT5514_TDM_DOCKING_START_SFT		28
+#define RT5514_TDM_DOCKING_START_SLOT0		(0x0 << 28)
+#define RT5514_TDM_DOCKING_START_SLOT4		(0x1 << 28)
+
 /* RT5514_DIG_SOURCE_CTRL (0x20a4) */
 #define RT5514_AD1_DMIC_INPUT_SEL		(0x1 << 1)
 #define RT5514_AD1_DMIC_INPUT_SEL_SFT		1
-- 
2.13.2
