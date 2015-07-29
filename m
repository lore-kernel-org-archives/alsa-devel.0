From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Return error if
	devm_gpiod_get_optional return ERR_PTR" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:27 +0100
Message-ID: <E1ZKS6p-0004fB-PE@finisterre>
References: <1437791020.12775.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4E5A265914
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:38 +0200 (CEST)
In-Reply-To: <1437791020.12775.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Return error if devm_gpiod_get_optional return ERR_PTR

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

>From f8163c8673efaabb361281a2759b3167d181ecf6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 25 Jul 2015 10:23:40 +0800
Subject: [PATCH] ASoC: rt5677: Return error if devm_gpiod_get_optional return
 ERR_PTR

If devm_gpiod_get_optional() return ERR_PTR, it means something wrong
so request gpio fails. We had better return error in such case.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 62230e0..3f890a6 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5133,14 +5133,14 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(rt5677->pow_ldo2)) {
 		ret = PTR_ERR(rt5677->pow_ldo2);
 		dev_err(&i2c->dev, "Failed to request POW_LDO2: %d\n", ret);
-		rt5677->pow_ldo2 = 0;
+		return ret;
 	}
 	rt5677->reset_pin = devm_gpiod_get_optional(&i2c->dev,
 			"realtek,reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(rt5677->reset_pin)) {
 		ret = PTR_ERR(rt5677->reset_pin);
 		dev_err(&i2c->dev, "Failed to request RESET: %d\n", ret);
-		rt5677->reset_pin = 0;
+		return ret;
 	}
 
 	if (rt5677->pow_ldo2 || rt5677->reset_pin) {
-- 
2.1.4
