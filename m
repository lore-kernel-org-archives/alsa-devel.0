From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt8183: make some
	functions static
Date: Wed, 13 Feb 2019 06:29:44 +0000
Message-ID: <20190213062944.146366-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D6F267482
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 07:15:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Shunli Wang <shunli.wang@mediatek.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warnings:

sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:966:5: warning:
 symbol 'mt8183_dai_i2s_get_share' was not declared. Should it be static?
sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:986:5: warning:
 symbol 'mt8183_dai_i2s_set_priv' was not declared. Should it be static?

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index c25024f72e72..777e93d70bea 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -963,7 +963,7 @@ static const struct mtk_afe_i2s_priv mt8183_i2s_priv[DAI_I2S_NUM] = {
 	},
 };
 
-int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	const struct device_node *of_node = afe->dev->of_node;
@@ -983,7 +983,7 @@ int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 	return 0;
 }
 
-int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_i2s_priv *i2s_priv;
