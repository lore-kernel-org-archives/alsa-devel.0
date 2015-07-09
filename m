From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [RFT PATCH 2/2] ASoC: zx: spdif: Fix devm_ioremap_resource return value check
Date: Thu,  9 Jul 2015 22:19:29 +0900
Message-ID: <1436447969-24583-2-git-send-email-k.kozlowski.k@gmail.com>
References: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jun Nie <jun.nie@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Value returned by devm_ioremap_resource() was checked for non-NULL but
devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
error this could lead to dereference of ERR_PTR.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: <stable@vger.kernel.org>
Fixes: 6fc3d24d4277 ("ASoC: zx: Add zx296702 SPDIF support")

---

Patch only compile tested.
---
 sound/soc/zte/zx296702-spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx296702-spdif.c b/sound/soc/zte/zx296702-spdif.c
index 11a0e46a1156..26265ce4caca 100644
--- a/sound/soc/zte/zx296702-spdif.c
+++ b/sound/soc/zte/zx296702-spdif.c
@@ -322,9 +322,9 @@ static int zx_spdif_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	zx_spdif->mapbase = res->start;
 	zx_spdif->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (!zx_spdif->reg_base) {
+	if (IS_ERR(zx_spdif->reg_base)) {
 		dev_err(&pdev->dev, "ioremap failed!\n");
-		return -EIO;
+		return PTR_ERR(zx_spdif->reg_base);
 	}
 
 	zx_spdif_dev_init(zx_spdif->reg_base);
-- 
2.1.4
