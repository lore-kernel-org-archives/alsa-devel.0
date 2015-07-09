From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [RFT PATCH 1/2] ASoC: zx: i2s: Fix devm_ioremap_resource return value check
Date: Thu,  9 Jul 2015 22:19:28 +0900
Message-ID: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jun Nie <jun.nie@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Value returned by devm_ioremap_resource() was checked for non-NULL but
devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
error this could lead to dereference of ERR_PTR.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: <stable@vger.kernel.org>
Fixes: e5d4cd87800c ("ASoC: zx: Add ZTE zx296702 I2S DAI driver")

---

Patch only compile tested.
---
 sound/soc/zte/zx296702-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
index 98d96e1b17e0..1930c42e1f55 100644
--- a/sound/soc/zte/zx296702-i2s.c
+++ b/sound/soc/zte/zx296702-i2s.c
@@ -393,9 +393,9 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	zx_i2s->mapbase = res->start;
 	zx_i2s->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (!zx_i2s->reg_base) {
+	if (IS_ERR(zx_i2s->reg_base)) {
 		dev_err(&pdev->dev, "ioremap failed!\n");
-		return -EIO;
+		return PTR_ERR(zx_i2s->reg_base);
 	}
 
 	writel_relaxed(0, zx_i2s->reg_base + ZX_I2S_FIFO_CTRL);
-- 
2.1.4
