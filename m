From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/3] ASoC: mchp-i2s-mcc: Fix unprepare of GCLK
Date: Tue, 20 Aug 2019 19:24:09 +0300
Message-ID: <20190820162411.24836-2-codrin.ciubotariu@microchip.com>
References: <20190820162411.24836-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820162411.24836-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

If hw_free() gets called after hw_params(), GCLK remains prepared,
preventing further use of it. This patch fixes this by unpreparing the
clock in hw_free() or if hw_params() gets an error.

Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 8272915fa09b..ab7d5f98e759 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -670,8 +670,13 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(dev->regmap, MCHP_I2SMCC_MRA, mra);
-	if (ret < 0)
+	if (ret < 0) {
+		if (dev->gclk_use) {
+			clk_unprepare(dev->gclk);
+			dev->gclk_use = 0;
+		}
 		return ret;
+	}
 	return regmap_write(dev->regmap, MCHP_I2SMCC_MRB, mrb);
 }
 
@@ -710,9 +715,13 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		regmap_write(dev->regmap, MCHP_I2SMCC_CR, MCHP_I2SMCC_CR_CKDIS);
 
 		if (dev->gclk_running) {
-			clk_disable_unprepare(dev->gclk);
+			clk_disable(dev->gclk);
 			dev->gclk_running = 0;
 		}
+		if (dev->gclk_use) {
+			clk_unprepare(dev->gclk);
+			dev->gclk_use = 0;
+		}
 	}
 
 	return 0;
-- 
2.20.1
