From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 1/4] ASoC: rockchip: i2s: add a delay before
	i2s clear
Date: Fri,  9 Jun 2017 16:52:46 +0800
Message-ID: <1496998369-30556-2-git-send-email-sugar.zhang@rock-chips.com>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AD6D2675B6
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 10:56:52 +0200 (CEST)
In-Reply-To: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

in order to guarantee i2s lrck signal integrity, when i2s stop,
need at least one lrck cycle to ensure signal integrity.

the max delay time is when lrck is 8khz, the delay time is
125us(1/8khz), using udelay(150) with a 25us margin.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 974915c..f548433 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -116,6 +116,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 					   I2S_XFER_TXS_STOP |
 					   I2S_XFER_RXS_STOP);
 
+			udelay(150);
 			regmap_update_bits(i2s->regmap, I2S_CLR,
 					   I2S_CLR_TXC | I2S_CLR_RXC,
 					   I2S_CLR_TXC | I2S_CLR_RXC);
@@ -162,6 +163,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 					   I2S_XFER_TXS_STOP |
 					   I2S_XFER_RXS_STOP);
 
+			udelay(150);
 			regmap_update_bits(i2s->regmap, I2S_CLR,
 					   I2S_CLR_TXC | I2S_CLR_RXC,
 					   I2S_CLR_TXC | I2S_CLR_RXC);
-- 
1.9.1
