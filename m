From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: make some functions
	static" to the asoc tree
Date: Wed, 13 Feb 2019 11:53:31 +0000 (GMT)
Message-ID: <20190213115331.C15821128158@debutante.sirena.org.uk>
References: <20190213062944.146366-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 688F1267497
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 12:53:35 +0100 (CET)
In-Reply-To: <20190213062944.146366-1-weiyongjun1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Shunli Wang <shunli.wang@mediatek.com>, Brugger <matthias.bgg@gmail.com>, Matthias@sirena.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: make some functions static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 03bf3aeb03a8562a7ad6ed629e49953f132217c1 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 13 Feb 2019 06:29:44 +0000
Subject: [PATCH] ASoC: mediatek: mt8183: make some functions static

Fixes the following sparse warnings:

sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:966:5: warning:
 symbol 'mt8183_dai_i2s_get_share' was not declared. Should it be static?
sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:986:5: warning:
 symbol 'mt8183_dai_i2s_set_priv' was not declared. Should it be static?

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
-- 
2.20.1
