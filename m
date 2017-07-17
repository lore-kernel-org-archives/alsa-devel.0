From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: Remove unneeded gpiod NULL
	check" to the asoc tree
Date: Mon, 17 Jul 2017 17:05:58 +0100
Message-ID: <E1dX8X0-0004xq-PK@debutante>
References: <1500239473-14886-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA92267428
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:06 +0200 (CEST)
In-Reply-To: <1500239473-14886-4-git-send-email-festevam@gmail.com>
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

   ASoC: cs35l33: Remove unneeded gpiod NULL check

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

>From c5660778b4851b1aea5d848ccfde3f27949f6418 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 16 Jul 2017 18:11:09 -0300
Subject: [PATCH] ASoC: cs35l33: Remove unneeded gpiod NULL check

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 6df29fa30fb9..1eea91271ebb 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -869,8 +869,7 @@ static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
 
 	ret = regulator_bulk_enable(cs35l33->num_core_supplies,
 		cs35l33->core_supplies);
@@ -881,8 +880,7 @@ static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
 
 	regcache_cache_only(cs35l33->regmap, false);
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
 
 	msleep(CS35L33_BOOT_DELAY);
 
@@ -1191,8 +1189,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 1);
 
 	msleep(CS35L33_BOOT_DELAY);
 	regcache_cache_only(cs35l33->regmap, false);
@@ -1262,8 +1259,7 @@ static int cs35l33_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 
-	if (cs35l33->reset_gpio)
-		gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l33->reset_gpio, 0);
 
 	pm_runtime_disable(&client->dev);
 	regulator_bulk_disable(cs35l33->num_core_supplies,
-- 
2.13.2
