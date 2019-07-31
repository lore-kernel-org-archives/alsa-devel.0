From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Incorrect SR and WSS computation" to the
 asoc tree
Date: Wed, 31 Jul 2019 12:29:51 +0100 (BST)
Message-ID: <20190731112951.BC2C42742C99@ypsilon.sirena.org.uk>
References: <20190729152130.27955-1-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190729152130.27955-1-codekipper@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marcus Cooper <codekipper@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>, maxime.ripard@free-electrons.com, wens@csie.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Incorrect SR and WSS computation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 52f87f3ca251f5e43b42e78ab9816b2b07718bfe Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Mon, 29 Jul 2019 17:21:30 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Incorrect SR and WSS computation

The A64 audio codec uses the original I2S block but the SR and
WSS computation currently assigned is for the newer block.

Fixes: 619c15f7fac9 (ASoC: sun4i-i2s: Change SR and WSS computation)
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Link: https://lore.kernel.org/r/20190729152130.27955-1-codekipper@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9b2232908b65..7fa5c61169db 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1002,8 +1002,8 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
-	.get_sr			= sun8i_i2s_get_sr_wss,
-	.get_wss		= sun8i_i2s_get_sr_wss,
+	.get_sr			= sun4i_i2s_get_sr,
+	.get_wss		= sun4i_i2s_get_wss,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
-- 
2.20.1
