From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/3] ASoC: mchp-i2s-mcc: Wait for RX/TX RDY only if controller is running
Date: Tue, 20 Aug 2019 19:24:10 +0300
Message-ID: <20190820162411.24836-3-codrin.ciubotariu@microchip.com>
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

Since hw_free() can be called multiple times and not just after a stop
trigger command, we should check whether the RX or TX ready interrupt was
truly enabled previously. For this, we assure that the condition of the
wait event is always true, except when RX/TX interrupts are enabled.

Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 86495883ca3f..8272915fa09b 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -686,22 +686,24 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		err = wait_event_interruptible_timeout(dev->wq_txrdy,
 						       dev->tx_rdy,
 						       msecs_to_jiffies(500));
+		if (err == 0) {
+			dev_warn_once(dev->dev,
+				      "Timeout waiting for Tx ready\n");
+			regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
+				     MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels));
+			dev->tx_rdy = 1;
+		}
 	} else {
 		err = wait_event_interruptible_timeout(dev->wq_rxrdy,
 						       dev->rx_rdy,
 						       msecs_to_jiffies(500));
-	}
-
-	if (err == 0) {
-		u32 idra;
-
-		dev_warn_once(dev->dev, "Timeout waiting for %s\n",
-			      is_playback ? "Tx ready" : "Rx ready");
-		if (is_playback)
-			idra = MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels);
-		else
-			idra = MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels);
-		regmap_write(dev->regmap, MCHP_I2SMCC_IDRA, idra);
+		if (err == 0) {
+			dev_warn_once(dev->dev,
+				      "Timeout waiting for Rx ready\n");
+			regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
+				     MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
+			dev->rx_rdy = 1;
+		}
 	}
 
 	if (!mchp_i2s_mcc_is_running(dev)) {
@@ -809,6 +811,8 @@ static int mchp_i2s_mcc_dai_probe(struct snd_soc_dai *dai)
 
 	init_waitqueue_head(&dev->wq_txrdy);
 	init_waitqueue_head(&dev->wq_rxrdy);
+	dev->tx_rdy = 1;
+	dev->rx_rdy = 1;
 
 	snd_soc_dai_init_dma_data(dai, &dev->playback, &dev->capture);
 
-- 
2.20.1
