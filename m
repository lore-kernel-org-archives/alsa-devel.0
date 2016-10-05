From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: extend the t_i2c time to
	comply with TAS5721" to the asoc tree
Date: Wed, 05 Oct 2016 17:21:55 +0200
Message-ID: <E1bro15-0004ja-6z@finisterre>
References: <1475505650-8572-3-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A68DE266671
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 17:22:10 +0200 (CEST)
In-Reply-To: <1475505650-8572-3-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: extend the t_i2c time to comply with TAS5721

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

>From e54de7f555970915c3856e7709a7ff74d352f315 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <brain@jikos.cz>
Date: Mon, 3 Oct 2016 16:40:47 +0200
Subject: [PATCH] ASoC: tas571x: extend the t_i2c time to comply with TAS5721

TAS5721 datasheet recommends to wait at least 13.5ms after deasserting the
RESET signal. For TAS5717 this time is only 12ms, which was the original
value in the code.

Extend the wait time after deasserting RESET from 12 to 13.5ms to comply
with the TAS5721 specification.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 34e4ce6f23d8..512b9e663e89 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -747,7 +747,7 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 		/* pulse the active low reset line for ~100us */
 		usleep_range(100, 200);
 		gpiod_set_value(priv->reset_gpio, 0);
-		usleep_range(12000, 20000);
+		usleep_range(13500, 20000);
 	}
 
 	ret = regmap_write(priv->regmap, TAS571X_OSC_TRIM_REG, 0);
-- 
2.9.3
