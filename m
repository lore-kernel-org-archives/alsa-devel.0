From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] ASoC/codecs: jz4725b: Make probe function __init_or_module
Date: Fri,  7 Jun 2019 18:15:00 +0200
Message-ID: <20190607161500.17379-3-paul@crapouillou.net>
References: <20190607161500.17379-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607161500.17379-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: od@zcrc.me, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 766354c73076..eef7221e4acd 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -541,7 +541,7 @@ static const struct regmap_config jz4725b_codec_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
-static int jz4725b_codec_probe(struct platform_device *pdev)
+static int __init_or_module jz4725b_codec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz_icdc *icdc;
-- 
2.21.0.593.g511ec345e18
