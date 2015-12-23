From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8903: Be sure to clamp return value"
	to the asoc tree
Date: Wed, 23 Dec 2015 00:23:18 +0000
Message-ID: <E1aBXD4-0000VP-5n@debutante>
References: <1450795849-28642-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A63D266094
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:25 +0100 (CET)
In-Reply-To: <1450795849-28642-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8903: Be sure to clamp return value

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

>From b70381c35f65bbe1a2339e2833a574f0473162fa Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Dec 2015 15:50:49 +0100
Subject: [PATCH] ASoC: wm8903: Be sure to clamp return value

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8903.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index e4cc41e6c23e..2ed6419c181e 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1804,7 +1804,7 @@ static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 	regmap_read(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset, &reg);
 
-	return (reg & WM8903_GP1_LVL_MASK) >> WM8903_GP1_LVL_SHIFT;
+	return !!((reg & WM8903_GP1_LVL_MASK) >> WM8903_GP1_LVL_SHIFT);
 }
 
 static int wm8903_gpio_direction_out(struct gpio_chip *chip,
-- 
2.6.2
