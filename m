From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: correct irq clear method" to the asoc tree
Date: Fri, 02 Oct 2015 11:45:06 +0100
Message-ID: <E1Zhxpq-0003AQ-S5@finisterre>
References: <035301d0f9b5$c22cff30$4686fd90$@tangramtek.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <035301d0f9b5$c22cff30$4686fd90$@tangramtek.com>
Sender: stable-owner@vger.kernel.org
To: Yitian Bu <yitian.bu@tangramtek.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: correct irq clear method

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

>From 4873867e5f2bd90faad861dd94865099fc3140f3 Mon Sep 17 00:00:00 2001
From: Yitian Bu <buyitian@gmail.com>
Date: Fri, 2 Oct 2015 15:18:41 +0800
Subject: [PATCH] ASoC: dwc: correct irq clear method

from Designware I2S datasheet, tx/rx XRUN irq is cleared by
reading register TOR/ROR, rather than by writing into them.

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/dwc/designware_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a3e97b4..0d28e3b 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -131,10 +131,10 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		for (i = 0; i < 4; i++)
-			i2s_write_reg(dev->i2s_base, TOR(i), 0);
+			i2s_read_reg(dev->i2s_base, TOR(i));
 	} else {
 		for (i = 0; i < 4; i++)
-			i2s_write_reg(dev->i2s_base, ROR(i), 0);
+			i2s_read_reg(dev->i2s_base, ROR(i));
 	}
 }
 
-- 
2.5.0
