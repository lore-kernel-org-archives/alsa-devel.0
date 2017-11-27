From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:41 +0000
Message-ID: <E1eJOWH-00071H-FD@debutante>
References: <20171120060517.7083-1-jc@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120060517.7083-1-jc@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Chan <jc@linux.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

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

>From 0cab20cec0b663b7be8e2be5998d5a4113647f86 Mon Sep 17 00:00:00 2001
From: Jesse Chan <jc@linux.com>
Date: Sun, 19 Nov 2017 23:45:49 -0800
Subject: [PATCH] ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm512x-spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/pcm512x-spi.c b/sound/soc/codecs/pcm512x-spi.c
index 25c63510ae15..7cdd2dc4fd79 100644
--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -70,3 +70,7 @@ static struct spi_driver pcm512x_spi_driver = {
 };
 
 module_spi_driver(pcm512x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC PCM512x codec driver - SPI");
+MODULE_AUTHOR("Mark Brown <broonie@kernel.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.15.0
