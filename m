From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1977: Remove unneeded gpiod NULL
	check" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:04 +0100
Message-ID: <E1dX8X6-0004zQ-O2@debutante>
References: <1500239473-14886-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71D40267439
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:12 +0200 (CEST)
In-Reply-To: <1500239473-14886-3-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau1977: Remove unneeded gpiod NULL check

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

>From 68feed90070e5133c0bfe26648410a39e092018d Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 16 Jul 2017 18:11:08 -0300
Subject: [PATCH] ASoC: adau1977: Remove unneeded gpiod NULL check

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1977.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index b319db6a69f8..ccc5cf0e4f80 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -388,8 +388,7 @@ static int adau1977_power_disable(struct adau1977 *adau1977)
 
 	regcache_mark_dirty(adau1977->regmap);
 
-	if (adau1977->reset_gpio)
-		gpiod_set_value_cansleep(adau1977->reset_gpio, 0);
+	gpiod_set_value_cansleep(adau1977->reset_gpio, 0);
 
 	regcache_cache_only(adau1977->regmap, true);
 
@@ -420,8 +419,7 @@ static int adau1977_power_enable(struct adau1977 *adau1977)
 			goto err_disable_avdd;
 	}
 
-	if (adau1977->reset_gpio)
-		gpiod_set_value_cansleep(adau1977->reset_gpio, 1);
+	gpiod_set_value_cansleep(adau1977->reset_gpio, 1);
 
 	regcache_cache_only(adau1977->regmap, false);
 
-- 
2.13.2
