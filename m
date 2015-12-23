From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ac97: Be sure to clamp return value" to
	the asoc tree
Date: Wed, 23 Dec 2015 00:23:17 +0000
Message-ID: <E1aBXD3-0000Uw-8u@debutante>
References: <1450795899-28693-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A84A266085
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:26 +0100 (CET)
In-Reply-To: <1450795899-28693-1-git-send-email-linus.walleij@linaro.org>
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

   ASoC: ac97: Be sure to clamp return value

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

>From 34015f5e56c71bbdcf7189430ffb63ea67656a35 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Dec 2015 15:51:39 +0100
Subject: [PATCH] ASoC: ac97: Be sure to clamp return value

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index ae563e379a72..733f5128eeff 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -92,7 +92,7 @@ static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned offset)
 	dev_dbg(codec->dev, "get gpio %d : %d\n", offset,
 		ret < 0 ? ret : ret & (1 << offset));
 
-	return ret < 0 ? ret : ret & (1 << offset);
+	return ret < 0 ? ret : !!(ret & (1 << offset));
 }
 
 static void snd_soc_ac97_gpio_set(struct gpio_chip *chip, unsigned offset,
-- 
2.6.2
