From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add more width and channels
	support in the TDM mode" to the asoc tree
Date: Mon, 15 May 2017 17:02:04 +0900
Message-ID: <E1dAAxA-0002Kj-16@finisterre>
References: <1493692976-7167-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9026126684C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:14 +0200 (CEST)
In-Reply-To: <1493692976-7167-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add more width and channels support in the TDM mode

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

>From d60bc8d6c6d7e5f9765852b0be57de639ba65808 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 2 May 2017 10:42:56 +0800
Subject: [PATCH] ASoC: rt5514: Add more width and channels support in the TDM
 mode

This patch adds more width and channels support in the TDM mode.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 23 +++++++++++++++++++++--
 sound/soc/codecs/rt5514.h |  6 ++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index f91221b1ddf0..ff97360c03db 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -906,9 +906,23 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	if (rx_mask || tx_mask)
 		val |= RT5514_TDM_MODE;
 
-	if (slots == 4)
+	switch (slots) {
+	case 4:
 		val |= RT5514_TDMSLOT_SEL_RX_4CH | RT5514_TDMSLOT_SEL_TX_4CH;
+		break;
+
+	case 6:
+		val |= RT5514_TDMSLOT_SEL_RX_6CH | RT5514_TDMSLOT_SEL_TX_6CH;
+		break;
+
+	case 8:
+		val |= RT5514_TDMSLOT_SEL_RX_8CH | RT5514_TDMSLOT_SEL_TX_8CH;
+		break;
 
+	case 2:
+	default:
+		break;
+	}
 
 	switch (slot_width) {
 	case 20:
@@ -919,6 +933,10 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		val |= RT5514_CH_LEN_RX_24 | RT5514_CH_LEN_TX_24;
 		break;
 
+	case 25:
+		val |= RT5514_TDM_MODE2;
+		break;
+
 	case 32:
 		val |= RT5514_CH_LEN_RX_32 | RT5514_CH_LEN_TX_32;
 		break;
@@ -930,7 +948,8 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 
 	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL1, RT5514_TDM_MODE |
 		RT5514_TDMSLOT_SEL_RX_MASK | RT5514_TDMSLOT_SEL_TX_MASK |
-		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK, val);
+		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK |
+		RT5514_TDM_MODE2, val);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 5d343fb6d125..02bc212a86d9 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -117,6 +117,8 @@
 #define RT5514_POW_ADCFEDL_BIT			0
 
 /* RT5514_I2S_CTRL1 (0x2010) */
+#define RT5514_TDM_MODE2			(0x1 << 30)
+#define RT5514_TDM_MODE2_SFT			30
 #define RT5514_TDM_MODE				(0x1 << 28)
 #define RT5514_TDM_MODE_SFT			28
 #define RT5514_I2S_LR_MASK			(0x1 << 26)
@@ -136,6 +138,8 @@
 #define RT5514_TDMSLOT_SEL_RX_MASK		(0x3 << 10)
 #define RT5514_TDMSLOT_SEL_RX_SFT		10
 #define RT5514_TDMSLOT_SEL_RX_4CH		(0x1 << 10)
+#define RT5514_TDMSLOT_SEL_RX_6CH		(0x2 << 10)
+#define RT5514_TDMSLOT_SEL_RX_8CH		(0x3 << 10)
 #define RT5514_CH_LEN_RX_MASK			(0x3 << 8)
 #define RT5514_CH_LEN_RX_SFT			8
 #define RT5514_CH_LEN_RX_16			(0x0 << 8)
@@ -145,6 +149,8 @@
 #define RT5514_TDMSLOT_SEL_TX_MASK		(0x3 << 6)
 #define RT5514_TDMSLOT_SEL_TX_SFT		6
 #define RT5514_TDMSLOT_SEL_TX_4CH		(0x1 << 6)
+#define RT5514_TDMSLOT_SEL_TX_6CH		(0x2 << 6)
+#define RT5514_TDMSLOT_SEL_TX_8CH		(0x3 << 6)
 #define RT5514_CH_LEN_TX_MASK			(0x3 << 4)
 #define RT5514_CH_LEN_TX_SFT			4
 #define RT5514_CH_LEN_TX_16			(0x0 << 4)
-- 
2.11.0
