From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4341: fix waring unused-function" to the asoc tree
Date: Mon, 14 Jan 2019 23:04:00 +0000 (GMT)
Message-ID: <20190114230400.64BF01127AD1@debutante.sirena.org.uk>
References: <20190114095540.22956-1-anders.roxell@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095540.22956-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4341: fix waring unused-function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3e8c45f57a90585cfc0b07ae81de8960a8366c1c Mon Sep 17 00:00:00 2001
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 14 Jan 2019 10:55:40 +0100
Subject: [PATCH] ASoC: cs4341: fix waring unused-function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver cs4341 can be built with SPI and/or I2C, but it has to be one
of them at least. When I2C is set as a module we see the warning below:

sound/soc/codecs/cs4341.c:213:12: warning: ‘cs4341_probe’
defined but not used [-Wunused-function]
 static int cs4341_probe(struct device *dev)
            ^~~~~~~~~~~~

Rework so that we use IS_ENABLED instead of defined. Also change so
SND_SOC_CS4341 depends on SND_SOC_I2C_AND_SPI to we dont' get a link
error when SND_SOC_CS4341=y, I2C=m and REGMAP_I2C=m is set.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 2 +-
 sound/soc/codecs/cs4341.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 87cb9c51e6f5..87ecb38e57f4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -546,7 +546,7 @@ config SND_SOC_CS43130
 
 config SND_SOC_CS4341
 	tristate "Cirrus Logic CS4341 CODEC"
-	depends on I2C || SPI_MASTER
+	depends on SND_SOC_I2C_AND_SPI
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
 
diff --git a/sound/soc/codecs/cs4341.c b/sound/soc/codecs/cs4341.c
index d2e616a89fd4..ade7477d04f1 100644
--- a/sound/soc/codecs/cs4341.c
+++ b/sound/soc/codecs/cs4341.c
@@ -223,7 +223,7 @@ static int cs4341_probe(struct device *dev)
 					       &cs4341_dai, 1);
 }
 
-#if defined(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_I2C)
 static int cs4341_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -317,7 +317,7 @@ static int __init cs4341_init(void)
 {
 	int ret = 0;
 
-#if defined(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&cs4341_i2c_driver);
 	if (ret)
 		return ret;
@@ -332,7 +332,7 @@ module_init(cs4341_init);
 
 static void __exit cs4341_exit(void)
 {
-#if defined(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&cs4341_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-- 
2.20.1
