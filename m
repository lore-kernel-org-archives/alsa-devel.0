From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: bf5xx-ad73311: Fix prototype for bf5xx_probe
Date: Thu, 15 Sep 2011 11:04:56 +0800
Message-ID: <1316055896.3496.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Cliff Cai <Cliff.Cai@analog.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix below build warning:
sound/soc/blackfin/bf5xx-ad73311.c: warning: initialization from incompatible pointer type

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/blackfin/bf5xx-ad73311.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 732a247..b94eb7e 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -128,7 +128,7 @@ static int snd_ad73311_configure(void)
 	return 0;
 }
 
-static int bf5xx_probe(struct platform_device *pdev)
+static int bf5xx_probe(struct snd_soc_card *card)
 {
 	int err;
 	if (gpio_request(GPIO_SE, "AD73311_SE")) {
-- 
1.7.4.1
