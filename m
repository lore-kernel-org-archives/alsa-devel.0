From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: switch to use
	platform_get_irq_byname()" to the asoc tree
Date: Fri, 18 Aug 2017 12:48:31 +0100
Message-ID: <E1diflP-0000sb-An@finisterre>
References: <3c24b787fab90c898450a3027b2d11bf1c04ff24.1503019482.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BCADA266943
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 13:48:36 +0200 (CEST)
In-Reply-To: <3c24b787fab90c898450a3027b2d11bf1c04ff24.1503019482.git.ryder.lee@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: switch to use platform_get_irq_byname()

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

>From f6c1626e28f22115ded520300b56fa049c068f4f Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Fri, 18 Aug 2017 09:28:50 +0800
Subject: [PATCH] ASoC: mediatek: switch to use platform_get_irq_byname()

Switch to use platform_get_irq_byname() so that binding can be agnostic
of the IRQ order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
CC: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 10dcd69c5ffa..8fda182f849b 100644
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
2.13.2
