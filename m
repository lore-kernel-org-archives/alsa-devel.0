From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/7] ASoC: rockchip: Revert "ASoC: rockchip: i2s: separate capture and playback"
Date: Thu,  5 May 2016 10:03:36 +0200
Message-ID: <1462435421-21205-3-git-send-email-enric.balletbo@collabora.com>
References: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

From: John Keeping <john@metanate.com>

This reverts commit eba65d179c1149cf79e68608d452631f33d7f017.

This broke audio on Veyron Jerry Chromebooks and I now cannot reproduce
the problem I was trying to fix even with this commit reverted, so it
seems that this was completely the wrong thing to do.

Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 72 ++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 34743ec..574c6af 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -82,8 +82,8 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START,
-				   I2S_XFER_TXS_START);
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
 
 		i2s->tx_start = true;
 	} else {
@@ -92,23 +92,27 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
-		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START,
-				   I2S_XFER_TXS_STOP);
-
-		regmap_update_bits(i2s->regmap, I2S_CLR,
-				   I2S_CLR_TXC,
-				   I2S_CLR_TXC);
+		if (!i2s->rx_start) {
+			regmap_update_bits(i2s->regmap, I2S_XFER,
+					   I2S_XFER_TXS_START |
+					   I2S_XFER_RXS_START,
+					   I2S_XFER_TXS_STOP |
+					   I2S_XFER_RXS_STOP);
 
-		regmap_read(i2s->regmap, I2S_CLR, &val);
+			regmap_update_bits(i2s->regmap, I2S_CLR,
+					   I2S_CLR_TXC | I2S_CLR_RXC,
+					   I2S_CLR_TXC | I2S_CLR_RXC);
 
-		/* Should wait for clear operation to finish */
-		while (val & I2S_CLR_TXC) {
 			regmap_read(i2s->regmap, I2S_CLR, &val);
-			retry--;
-			if (!retry) {
-				dev_warn(i2s->dev, "fail to clear\n");
-				break;
+
+			/* Should wait for clear operation to finish */
+			while (val) {
+				regmap_read(i2s->regmap, I2S_CLR, &val);
+				retry--;
+				if (!retry) {
+					dev_warn(i2s->dev, "fail to clear\n");
+					break;
+				}
 			}
 		}
 	}
@@ -124,8 +128,8 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_RXS_START,
-				   I2S_XFER_RXS_START);
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
 
 		i2s->rx_start = true;
 	} else {
@@ -134,23 +138,27 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_RXS_START,
-				   I2S_XFER_RXS_STOP);
-
-		regmap_update_bits(i2s->regmap, I2S_CLR,
-				   I2S_CLR_RXC,
-				   I2S_CLR_RXC);
+		if (!i2s->tx_start) {
+			regmap_update_bits(i2s->regmap, I2S_XFER,
+					   I2S_XFER_TXS_START |
+					   I2S_XFER_RXS_START,
+					   I2S_XFER_TXS_STOP |
+					   I2S_XFER_RXS_STOP);
 
-		regmap_read(i2s->regmap, I2S_CLR, &val);
+			regmap_update_bits(i2s->regmap, I2S_CLR,
+					   I2S_CLR_TXC | I2S_CLR_RXC,
+					   I2S_CLR_TXC | I2S_CLR_RXC);
 
-		/* Should wait for clear operation to finish */
-		while (val & I2S_CLR_RXC) {
 			regmap_read(i2s->regmap, I2S_CLR, &val);
-			retry--;
-			if (!retry) {
-				dev_warn(i2s->dev, "fail to clear\n");
-				break;
+
+			/* Should wait for clear operation to finish */
+			while (val) {
+				regmap_read(i2s->regmap, I2S_CLR, &val);
+				retry--;
+				if (!retry) {
+					dev_warn(i2s->dev, "fail to clear\n");
+					break;
+				}
 			}
 		}
 	}
-- 
2.1.0
