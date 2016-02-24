From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: Don't enable IRQ in i2c_probe"
	to the asoc tree
Date: Wed, 24 Feb 2016 17:42:58 +0900
Message-ID: <E1aYV2A-0002xN-LK@finisterre>
References: <1455613956-14287-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEB4526687F
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 09:43:08 +0100 (CET)
In-Reply-To: <1455613956-14287-3-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: Don't enable IRQ in i2c_probe

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

>From 0ce58cd6ce5e706c70c7b038ef5ddde0cc7d7385 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 24 Feb 2016 15:51:27 +0800
Subject: [PATCH] ASoC: rt298: Don't enable IRQ in i2c_probe

The IRQ function should not be enabled before irq handler is registered.
In fact, it is done in rt298_probe. So remove it from rt298_i2c_probe.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index e67ef5f8d4f3..f0e6c06e89ac 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1224,7 +1224,6 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	regmap_write(rt298->regmap, RT298_MISC_CTRL1, 0x0000);
 	regmap_update_bits(rt298->regmap,
 				RT298_WIND_FILTER_CTRL, 0x0082, 0x0082);
-	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
 	regmap_write(rt298->regmap, RT298_UNSOLICITED_INLINE_CMD, 0x81);
 	regmap_write(rt298->regmap, RT298_UNSOLICITED_HP_OUT, 0x82);
-- 
2.7.0
