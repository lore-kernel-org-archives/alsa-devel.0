From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt2701: fix return value check in mt2701_afe_pcm_dev_probe()
Date: Mon, 8 Jan 2018 02:15:01 +0000
Message-ID: <1515377701-37553-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Garlic Tseng <garlic.tseng@mediatek.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: dfa3cbb83e09 ("ASoC: mediatek: modify MT2701 AFE driver to adapt mfd device")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f0cd08f..5bc4e00 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1440,9 +1440,9 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
-	if (!afe->regmap) {
+	if (IS_ERR(afe->regmap)) {
 		dev_err(dev, "could not get regmap from parent\n");
-		return -ENODEV;
+		return PTR_ERR(afe->regmap);
 	}
 
 	mutex_init(&afe->irq_alloc_lock);
