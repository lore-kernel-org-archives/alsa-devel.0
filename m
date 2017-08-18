From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 2/2] ASoC: mediatek: switch to use platform_get_irq_byname()
Date: Fri, 18 Aug 2017 09:28:50 +0800
Message-ID: <3c24b787fab90c898450a3027b2d11bf1c04ff24.1503019482.git.ryder.lee@mediatek.com>
References: <8e309915033984c0b949254beef44a8307f479f4.1503019482.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e309915033984c0b949254beef44a8307f479f4.1503019482.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, Garlic Tseng <garlic.tseng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Switch to use platform_get_irq_byname() so that binding can be agnostic
of the IRQ order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
CC: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index bc5d4db..c7d38bf 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1496,14 +1496,12 @@ static int mt2701_afe_runtime_resume(struct device *dev)
 
 static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 {
-	int ret, i;
-	unsigned int irq_id;
 	struct mtk_base_afe *afe;
 	struct mt2701_afe_private *afe_priv;
 	struct resource *res;
 	struct device *dev;
+	int i, irq_id, ret;
 
-	ret = 0;
 	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
 		return -ENOMEM;
@@ -1516,11 +1514,12 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 	dev = afe->dev;
 
-	irq_id = platform_get_irq(pdev, 0);
-	if (!irq_id) {
-		dev_err(dev, "%s no irq found\n", dev->of_node->name);
-		return -ENXIO;
+	irq_id = platform_get_irq_byname(pdev, "asys");
+	if (irq_id < 0) {
+		dev_err(dev, "unable to get ASYS IRQ\n");
+		return irq_id;
 	}
+
 	ret = devm_request_irq(dev, irq_id, mt2701_asys_isr,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
 	if (ret) {
-- 
1.9.1
