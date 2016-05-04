From: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] Revert "ASoC: rockchip: i2s: separate capture and
 playback"
Date: Wed,  4 May 2016 15:54:46 +0100
Message-ID: <1462373686-21794-2-git-send-email-john@metanate.com>
References: <1462373686-21794-1-git-send-email-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1462373686-21794-1-git-send-email-john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This reverts commit eba65d179c1149cf79e68608d452631f33d7f017.

This broke audio on Veyron Jerry Chromebooks and I now cannot reproduce
the problem I was trying to fix even with this commit reverted, so it
seems that this was completely the wrong thing to do.

Reported-by: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 72 ++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 34743ec61c49..574c6af28c06 100644
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
2.8.0.rc4.238.g874082a
