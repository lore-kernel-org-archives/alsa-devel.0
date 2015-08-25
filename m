From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Remove the incorrect setting of
	the JD mode" to the asoc tree
Date: Tue, 25 Aug 2015 19:13:09 +0100
Message-ID: <E1ZUIib-0006Bp-Te@debutante>
References: <1440419579-9970-4-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C027265152
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 20:13:19 +0200 (CEST)
In-Reply-To: <1440419579-9970-4-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Remove the incorrect setting of the JD mode

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

>From 4aed4c9efb30253483869c58236ab00bdfa45630 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 24 Aug 2015 20:32:58 +0800
Subject: [PATCH] ASoC: rt5645: Remove the incorrect setting of the JD mode

The patch removes the incorrect setting of the JD mode. It will cause pop
sound in the booting time.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index bcb44de002c9..d9f34421414e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3373,8 +3373,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
 				   RT5645_IRQ_CLK_GATE_CTRL,
 				   RT5645_IRQ_CLK_GATE_CTRL);
-		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
-				   RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
 		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
 				   RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
-- 
2.5.0
