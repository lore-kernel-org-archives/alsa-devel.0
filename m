From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cx2072x: mark PM function as __maybe_unused" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:29 +0100 (BST)
Message-ID: <20190617152430.031FB440046@finisterre.sirena.org.uk>
References: <20190617110615.2084748-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617110615.2084748-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, simon.ho@synaptics.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cx2072x: mark PM function as __maybe_unused

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 83ee240aad9147ed5dac5a7c7b4c559d134072e7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 13:06:15 +0200
Subject: [PATCH] ASoC: cx2072x: mark PM function as __maybe_unused

While the suspend function is already marked __maybe_unused,
the resume function is not, which leads to a warning when
CONFIG_PM is disabled:

sound/soc/codecs/cx2072x.c:1625:12: error: unused function 'cx2072x_runtime_resume' [-Werror,-Wunused-function]

Mark this one like the other one.

Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index f2cb35a50726..1c1ba7bea4d8 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1622,7 +1622,7 @@ static int __maybe_unused cx2072x_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cx2072x_runtime_resume(struct device *dev)
+static int __maybe_unused cx2072x_runtime_resume(struct device *dev)
 {
 	struct cx2072x_priv *cx2072x = dev_get_drvdata(dev);
 
-- 
2.20.1
