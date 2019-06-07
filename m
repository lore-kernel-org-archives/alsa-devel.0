From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] ASoC/codecs: jz4740: Make probe function __init_or_module
Date: Fri,  7 Jun 2019 18:14:59 +0200
Message-ID: <20190607161500.17379-2-paul@crapouillou.net>
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
 sound/soc/codecs/jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 974e17fa1911..f7293004971d 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -314,7 +314,7 @@ static const struct regmap_config jz4740_codec_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int jz4740_codec_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_codec_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_codec *jz4740_codec;
-- 
2.21.0.593.g511ec345e18
