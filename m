From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Export OF module alias information in
	missing codec drivers" to the asoc tree
Date: Sat, 01 Aug 2015 12:18:29 +0100
Message-ID: <E1ZLUo9-0008Kc-4p@finisterre>
References: <1438273132-20926-21-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD3D2606C7
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 13:18:46 +0200 (CEST)
In-Reply-To: <1438273132-20926-21-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Export OF module alias information in missing codec drivers

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

>From bf08f39e6088c52c6fc7cce2ef7fbbd7bf4692b9 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 30 Jul 2015 18:18:45 +0200
Subject: [PATCH] ASoC: Export OF module alias information in missing codec
 drivers

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da9055.c | 1 +
 sound/soc/codecs/wm8510.c | 1 +
 sound/soc/codecs/wm8523.c | 1 +
 sound/soc/codecs/wm8580.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 66bb446..ab39de6 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1533,6 +1533,7 @@ static const struct of_device_id da9055_of_match[] = {
 	{ .compatible = "dlg,da9055-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, da9055_of_match);
 
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index dac5beb..0617415 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -598,6 +598,7 @@ static const struct of_device_id wm8510_of_match[] = {
 	{ .compatible = "wlf,wm8510" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8510_of_match);
 
 static const struct regmap_config wm8510_regmap = {
 	.reg_bits = 7,
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 43ea8ae..483ec72 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -430,6 +430,7 @@ static const struct of_device_id wm8523_of_match[] = {
 	{ .compatible = "wlf,wm8523" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8523_of_match);
 
 static const struct regmap_config wm8523_regmap = {
 	.reg_bits = 8,
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 759a792..a9f3900 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -916,6 +916,7 @@ static const struct of_device_id wm8580_of_match[] = {
 	{ .compatible = "wlf,wm8580" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8580_of_match);
 
 static const struct regmap_config wm8580_regmap = {
 	.reg_bits = 7,
-- 
2.1.4
