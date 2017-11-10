From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: mark PM functions as __maybe_unused" to the asoc tree
Date: Fri, 10 Nov 2017 21:29:38 +0000
Message-ID: <E1eDGrq-0004WS-NV@debutante>
References: <20171110145455.821805-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110145455.821805-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Chinyue Chen <chinyue@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Hsin-Yu Chao <hychao@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: mark PM functions as __maybe_unused

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

>From 7e6358ec3b6f69815a42af6203219584a80d4e22 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Nov 2017 15:54:42 +0100
Subject: [PATCH] ASoC: rt5514: mark PM functions as __maybe_unused

The new functions are only used when CONFIG_PM is enabled,
leading to a harmless warning:

sound/soc/codecs/rt5514-spi.c:474:12: error: 'rt5514_resume' defined but not used [-Werror=unused-function]
sound/soc/codecs/rt5514-spi.c:464:12: error: 'rt5514_suspend' defined but not used [-Werror=unused-function]

This marks them as __maybe_unused to make the build silent
again.

Fixes: 58f1c07d23cd ("ASoC: rt5514: Voice wakeup support.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 36e0a58ffc87..2df91db765ac 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -461,7 +461,7 @@ static int rt5514_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int rt5514_suspend(struct device *dev)
+static int __maybe_unused rt5514_suspend(struct device *dev)
 {
 	int irq = to_spi_device(dev)->irq;
 
@@ -471,7 +471,7 @@ static int rt5514_suspend(struct device *dev)
 	return 0;
 }
 
-static int rt5514_resume(struct device *dev)
+static int __maybe_unused rt5514_resume(struct device *dev)
 {
 	struct snd_soc_platform *platform = snd_soc_lookup_platform(dev);
 	struct rt5514_dsp *rt5514_dsp =
-- 
2.15.0
