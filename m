From: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] ASoC: rockchip: i2s: remove unused variables
Date: Wed,  9 Dec 2015 10:32:27 +0000
Message-ID: <1449657147-26959-2-git-send-email-john@metanate.com>
References: <1449657147-26959-1-git-send-email-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1449657147-26959-1-git-send-email-john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The previous commit removed the only use of these variables.

Signed-off-by: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index acc6225..8b0a588 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -34,13 +34,6 @@ struct rk_i2s_dev {
 
 	struct regmap *regmap;
 
-/*
- * Used to indicate the tx/rx status.
- * I2S controller hopes to start the tx and rx together,
- * also to stop them when they are both try to stop.
-*/
-	bool tx_start;
-	bool rx_start;
 	bool is_master_mode;
 };
 
@@ -84,11 +77,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_XFER,
 				   I2S_XFER_TXS_START,
 				   I2S_XFER_TXS_START);
-
-		i2s->tx_start = true;
 	} else {
-		i2s->tx_start = false;
-
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
@@ -126,11 +115,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_XFER,
 				   I2S_XFER_RXS_START,
 				   I2S_XFER_RXS_START);
-
-		i2s->rx_start = true;
 	} else {
-		i2s->rx_start = false;
-
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-- 
2.6.3.462.gbe2c914
