From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: add I2C dependency" to the asoc
	tree
Date: Wed, 16 Mar 2016 10:00:56 +0000
Message-ID: <E1ag8G8-0005Tv-FJ@debutante>
References: <1458078220-551551-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F072265967
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:01:10 +0100 (CET)
In-Reply-To: <1458078220-551551-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: add I2C dependency

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

>From af139d5592bc812e7a1997727172ddba3e6be968 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Mar 2016 22:42:50 +0100
Subject: [PATCH] ASoC: rt5616: add I2C dependency

The rt5616 codec registers itself as an i2c driver, but can
be enabled even when i2c is turned off, which leads to a build
error:

codecs/rt5616.c:1419:1: error: data definition has no type or storage class [-Werror]
 module_i2c_driver(rt5616_i2c_driver);

This adds an explicit Kconfig dependency, like the other codec
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 288bc356a881 ("ASoC: rt5616: allow to build with CONFIG_SND_SOC_RT5616")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a252ae..7ef3a0c16478 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -629,6 +629,7 @@ config SND_SOC_RT5514
 
 config SND_SOC_RT5616
 	tristate "Realtek RT5616 CODEC"
+	depends on I2C
 
 config SND_SOC_RT5631
 	tristate "Realtek ALC5631/RT5631 CODEC"
-- 
2.7.0
