From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] ASoC: jz4740-i2s: Make probe function __init_or_module
Date: Fri,  7 Jun 2019 18:14:58 +0200
Message-ID: <20190607161500.17379-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: od@zcrc.me, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 13408de34055..1f596770b01a 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -492,7 +492,7 @@ static const struct of_device_id jz4740_of_matches[] = {
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 #endif
 
-static int jz4740_i2s_dev_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
-- 
2.21.0.593.g511ec345e18
