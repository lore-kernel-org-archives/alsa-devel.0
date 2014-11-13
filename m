From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: add register setting for TDM
Date: Thu, 13 Nov 2014 09:55:22 +0800
Message-ID: <1415843722-9003-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DBEA5260430
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 02:56:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We need to set extra register to avoid a recording issue in TDM
mode.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
* Change regmap_update_bits(rt5645->regmap to snd_soc_update_bits(codec
  since rt5645 struct is not in rt5645_set_tdm_slot
---
 sound/soc/codecs/rt5645.c | 5 ++++-
 sound/soc/codecs/rt5645.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d6298b3..82d705a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2114,8 +2114,11 @@ static int rt5645_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	struct snd_soc_codec *codec = dai->codec;
 	unsigned int val = 0;
 
-	if (rx_mask || tx_mask)
+	if (rx_mask || tx_mask) {
 		val |= (1 << 14);
+		snd_soc_update_bits(codec, RT5645_BASS_BACK,
+			RT5645_G_BB_BST_MASK, RT5645_G_BB_BST_25DB);
+	}
 
 	switch (slots) {
 	case 4:
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 82f681b..196daf0 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1855,6 +1855,7 @@
 #define RT5645_M_BB_HPF_R_SFT			6
 #define RT5645_G_BB_BST_MASK			(0x3f)
 #define RT5645_G_BB_BST_SFT			0
+#define RT5645_G_BB_BST_25DB			0x14
 
 /* MP3 Plus Control 1 (0xd0) */
 #define RT5645_M_MP3_L_MASK			(0x1 << 15)
-- 
1.8.1.1.439.g50a6b54
