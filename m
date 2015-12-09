From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: separate capture and
	playback" to the asoc tree
Date: Wed, 09 Dec 2015 20:44:01 +0000
Message-ID: <E1a6laj-000465-PZ@debutante>
References: <1449657147-26959-1-git-send-email-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95EB226145B
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 21:44:11 +0100 (CET)
In-Reply-To: <1449657147-26959-1-git-send-email-john@metanate.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Keeping <john@metanate.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: separate capture and playback

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eba65d179c1149cf79e68608d452631f33d7f017 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Wed, 9 Dec 2015 10:32:26 +0000
Subject: [PATCH] ASoC: rockchip: i2s: separate capture and playback

If we only clear the tx/rx state when both are disabled it is not
possible to start/stop one multiple times while the other is running.
Since the two are independently controlled, treat them as such and
remove the false dependency between capture and playback.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 72 +++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 83b1b9c9e017..acc6225d8d9d 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -82,8 +82,8 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
+				   I2S_XFER_TXS_START,
+				   I2S_XFER_TXS_START);
 
 		i2s->tx_start = true;
 	} else {
@@ -92,27 +92,23 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
-		if (!i2s->rx_start) {
-			regmap_update_bits(i2s->regmap, I2S_XFER,
-					   I2S_XFER_TXS_START |
-					   I2S_XFER_RXS_START,
-					   I2S_XFER_TXS_STOP |
-					   I2S_XFER_RXS_STOP);
+		regmap_update_bits(i2s->regmap, I2S_XFER,
+				   I2S_XFER_TXS_START,
+				   I2S_XFER_TXS_STOP);
 
-			regmap_update_bits(i2s->regmap, I2S_CLR,
-					   I2S_CLR_TXC | I2S_CLR_RXC,
-					   I2S_CLR_TXC | I2S_CLR_RXC);
+		regmap_update_bits(i2s->regmap, I2S_CLR,
+				   I2S_CLR_TXC,
+				   I2S_CLR_TXC);
 
-			regmap_read(i2s->regmap, I2S_CLR, &val);
+		regmap_read(i2s->regmap, I2S_CLR, &val);
 
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					break;
-				}
+		/* Should wait for clear operation to finish */
+		while (val & I2S_CLR_TXC) {
+			regmap_read(i2s->regmap, I2S_CLR, &val);
+			retry--;
+			if (!retry) {
+				dev_warn(i2s->dev, "fail to clear\n");
+				break;
 			}
 		}
 	}
@@ -128,8 +124,8 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
+				   I2S_XFER_RXS_START,
+				   I2S_XFER_RXS_START);
 
 		i2s->rx_start = true;
 	} else {
@@ -138,27 +134,23 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-		if (!i2s->tx_start) {
-			regmap_update_bits(i2s->regmap, I2S_XFER,
-					   I2S_XFER_TXS_START |
-					   I2S_XFER_RXS_START,
-					   I2S_XFER_TXS_STOP |
-					   I2S_XFER_RXS_STOP);
+		regmap_update_bits(i2s->regmap, I2S_XFER,
+				   I2S_XFER_RXS_START,
+				   I2S_XFER_RXS_STOP);
 
-			regmap_update_bits(i2s->regmap, I2S_CLR,
-					   I2S_CLR_TXC | I2S_CLR_RXC,
-					   I2S_CLR_TXC | I2S_CLR_RXC);
+		regmap_update_bits(i2s->regmap, I2S_CLR,
+				   I2S_CLR_RXC,
+				   I2S_CLR_RXC);
 
-			regmap_read(i2s->regmap, I2S_CLR, &val);
+		regmap_read(i2s->regmap, I2S_CLR, &val);
 
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					break;
-				}
+		/* Should wait for clear operation to finish */
+		while (val & I2S_CLR_RXC) {
+			regmap_read(i2s->regmap, I2S_CLR, &val);
+			retry--;
+			if (!retry) {
+				dev_warn(i2s->dev, "fail to clear\n");
+				break;
 			}
 		}
 	}
-- 
2.6.2
