From: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v2 3/3] ASoC: mediatek: mt8183: fix tdm out
	data is valid on rising edge
Date: Sat, 24 Aug 2019 12:37:25 +0800
Message-ID: <1566621445-26989-4-git-send-email-jiaxin.yu@mediatek.com>
References: <1566621445-26989-1-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id DD337F80145
 for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2019 06:43:28 +0200 (CEST)
In-Reply-To: <1566621445-26989-1-git-send-email-jiaxin.yu@mediatek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jiaxin.yu@mediatek.com, tzungbi@google.com, linux-mediatek@lists.infradead.org, eason.yen@mediatek.com
List-Id: alsa-devel@alsa-project.org

This patch correct tdm out bck inverse register to AUDIO_TOP_CON3[3].

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c | 4 +++-
 sound/soc/mediatek/mt8183/mt8183-reg.h     | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c b/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
index d34cabdbf889..0d69cf440407 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
@@ -505,7 +505,9 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 
 	/* set tdm */
 	if (tdm_priv->bck_invert)
-		tdm_con |= 1 << BCK_INVERSE_SFT;
+		regmap_update_bits(afe->regmap, AUDIO_TOP_CON3,
+				   BCK_INVERSE_MASK_SFT,
+				   0x1 << BCK_INVERSE_SFT);
 
 	if (tdm_priv->lck_invert)
 		tdm_con |= 1 << LRCK_INVERSE_SFT;
diff --git a/sound/soc/mediatek/mt8183/mt8183-reg.h b/sound/soc/mediatek/mt8183/mt8183-reg.h
index e0482f2826da..e544a09e1913 100644
--- a/sound/soc/mediatek/mt8183/mt8183-reg.h
+++ b/sound/soc/mediatek/mt8183/mt8183-reg.h
@@ -413,6 +413,11 @@
 #define AFE_MAX_REGISTER AFE_GENERAL2_ASRC_2CH_CON13
 #define AFE_IRQ_STATUS_BITS 0x1fff
 
+/* AUDIO_TOP_CON3 */
+#define BCK_INVERSE_SFT                              3
+#define BCK_INVERSE_MASK                             0x1
+#define BCK_INVERSE_MASK_SFT                         (0x1 << 3)
+
 /* AFE_DAC_CON0 */
 #define AWB2_ON_SFT                                   29
 #define AWB2_ON_MASK                                  0x1
@@ -1596,9 +1601,6 @@
 #define TDM_EN_SFT                                    0
 #define TDM_EN_MASK                                   0x1
 #define TDM_EN_MASK_SFT                               (0x1 << 0)
-#define BCK_INVERSE_SFT                               1
-#define BCK_INVERSE_MASK                              0x1
-#define BCK_INVERSE_MASK_SFT                          (0x1 << 1)
 #define LRCK_INVERSE_SFT                              2
 #define LRCK_INVERSE_MASK                             0x1
 #define LRCK_INVERSE_MASK_SFT                         (0x1 << 2)
-- 
2.18.0
