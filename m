From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm1792a: Rename pcm1792a to pcm179x"
	to the asoc tree
Date: Sun, 10 Jan 2016 12:07:45 +0000
Message-ID: <E1aIEmf-0007QI-8l@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC91A260631
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:51 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm1792a: Rename pcm1792a to pcm179x

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

>From 0471cd938e244e22f3ead77d2b82230f83e35f69 Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Sun, 10 Jan 2016 00:38:04 +0100
Subject: [PATCH] ASoC: pcm1792a: Rename pcm1792a to pcm179x

pcm1792a is compatible with pcm1795 and pcm1796 so it's
better to have them under the common name pcm179x

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/{pcm1792a.txt => pcm179x.txt}         | 2 +-
 sound/soc/codecs/Kconfig                                            | 6 +++---
 sound/soc/codecs/Makefile                                           | 4 ++--
 sound/soc/codecs/{pcm1792a.c => pcm179x.c}                          | 0
 sound/soc/codecs/{pcm1792a.h => pcm179x.h}                          | 0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/sound/{pcm1792a.txt => pcm179x.txt} (88%)
 rename sound/soc/codecs/{pcm1792a.c => pcm179x.c} (100%)
 rename sound/soc/codecs/{pcm1792a.h => pcm179x.h} (100%)

diff --git a/Documentation/devicetree/bindings/sound/pcm1792a.txt b/Documentation/devicetree/bindings/sound/pcm179x.txt
similarity index 88%
rename from Documentation/devicetree/bindings/sound/pcm1792a.txt
rename to Documentation/devicetree/bindings/sound/pcm179x.txt
index 970ba1ed576f..4ae70d3462d6 100644
--- a/Documentation/devicetree/bindings/sound/pcm1792a.txt
+++ b/Documentation/devicetree/bindings/sound/pcm179x.txt
@@ -1,4 +1,4 @@
-Texas Instruments pcm1792a DT bindings
+Texas Instruments pcm179x DT bindings
 
 This driver supports the SPI bus.
 
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cfdafc4c11ea..b28060e55006 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -83,7 +83,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ML26124 if I2C
 	select SND_SOC_NAU8825 if I2C
 	select SND_SOC_PCM1681 if I2C
-	select SND_SOC_PCM1792A if SPI_MASTER
+	select SND_SOC_PCM179X if SPI_MASTER
 	select SND_SOC_PCM3008
 	select SND_SOC_PCM512x_I2C if I2C
 	select SND_SOC_PCM512x_SPI if SPI_MASTER
@@ -499,8 +499,8 @@ config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
 
-config SND_SOC_PCM1792A
-	tristate "Texas Instruments PCM1792A CODEC"
+config SND_SOC_PCM179X
+	tristate "Texas Instruments PCM179X CODEC"
 	depends on SPI_MASTER
 
 config SND_SOC_PCM3008
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f632fc42f59f..e4256039ff80 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -76,7 +76,7 @@ snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-pcm1681-objs := pcm1681.o
-snd-soc-pcm1792a-codec-objs := pcm1792a.o
+snd-soc-pcm179x-codec-objs := pcm179x.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
@@ -271,7 +271,7 @@ obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
-obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
+obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm179x.c
similarity index 100%
rename from sound/soc/codecs/pcm1792a.c
rename to sound/soc/codecs/pcm179x.c
diff --git a/sound/soc/codecs/pcm1792a.h b/sound/soc/codecs/pcm179x.h
similarity index 100%
rename from sound/soc/codecs/pcm1792a.h
rename to sound/soc/codecs/pcm179x.h
-- 
2.7.0.rc3
