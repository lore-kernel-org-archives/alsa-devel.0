From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: work around link error" to the asoc tree
Date: Fri, 10 Nov 2017 21:29:32 +0000
Message-ID: <E1eDGrk-0004Ui-U1@debutante>
References: <20171110145455.821805-2-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110145455.821805-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: work around link error

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

>From c56308775b5b81683789f9ee03f009493b51e6ab Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Nov 2017 15:54:43 +0100
Subject: [PATCH] ASoC: rt5514: work around link error

The main rt5514 driver optionally calls into the SPI back-end to load
the firmware. This causes a link error when one driver selects rt5514
as built-in and another driver selects rt5514-spi as a loadable module:

sound/soc/codecs/rt5514.o: In function `rt5514_dsp_voice_wake_up_put':
rt5514.c:(.text+0xac8): undefined reference to `rt5514_spi_burst_write'

As a workaround, this adds another silent symbol, to force rt5514-spi
to be built-in for that configuration. I'm not overly happy with
that solution, but couldn't come up with anything better. Using
'IS_REACHABLE()' would break the case that relies on the loadable
module, and all other ideas would result in more complexity.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 4 ++++
 sound/soc/codecs/Makefile | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c367d11079bc..01f436cc14c6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -749,6 +749,10 @@ config SND_SOC_RT5514
 config SND_SOC_RT5514_SPI
 	tristate
 
+config SND_SOC_RT5514_SPI_BUILTIN
+	bool # force RT5514_SPI to be built-in to avoid link errors
+	default SND_SOC_RT5514=y && SND_SOC_RT5514_SPI=m
+
 config SND_SOC_RT5616
 	tristate "Realtek RT5616 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 77c18189c9ad..2dc42b296973 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -359,6 +359,7 @@ obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
 obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
 obj-$(CONFIG_SND_SOC_RT5514_SPI)	+= snd-soc-rt5514-spi.o
+obj-$(CONFIG_SND_SOC_RT5514_SPI_BUILTIN)	+= snd-soc-rt5514-spi.o
 obj-$(CONFIG_SND_SOC_RT5616)	+= snd-soc-rt5616.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
-- 
2.15.0
