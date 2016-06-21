From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: make pcm support built-in when necessary" to the asoc tree
Date: Tue, 21 Jun 2016 19:52:39 +0100
Message-ID: <E1bFQmt-0008M4-24@debutante>
References: <20160620160131.2565092-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620160131.2565092-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: make pcm support built-in when necessary

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

>From 3276d0aa0bf475cc6cfb505487b2a2f3f762aebb Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Jun 2016 18:01:19 +0200
Subject: [PATCH] ASoC: dwc: make pcm support built-in when necessary

The new PIO mode for the dwc audio driver causes a link failure
when it is built as a loadable module but the audio driver is built-in:

sound/built-in.o: In function `i2s_irq_handler':
:(.text+0x58c64): undefined reference to `dw_pcm_push_tx'
sound/built-in.o: In function `dw_i2s_probe':
:(.text+0x593dc): undefined reference to `dw_pcm_register'

We could link both into a single module, but apparently the
author intended them to be separate, so this instead changes
the Makefile to force the pcm module to be built-in if the
base module is. This is a bit hacky but not as bad as trying
to work around it in Kconfig language.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 79361b2b98b7 ("ASoC: dwc: Add PIO PCM extension")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 1b48bcccbc51..38f1ca31c5fa 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,4 +1,5 @@
 # SYNOPSYS Platform Support
 obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
-obj-$(CONFIG_SND_DESIGNWARE_PCM) += designware_pcm.o
-
+ifdef CONFIG_SND_DESIGNWARE_PCM
+obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_pcm.o
+endif
-- 
2.8.1
