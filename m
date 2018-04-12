From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: mark PM functions __maybe_unused" to the asoc tree
Date: Thu, 12 Apr 2018 15:48:03 +0100
Message-ID: <E1f6dW7-00058g-TB@debutante>
References: <20180328145318.10136-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328145318.10136-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: mark PM functions __maybe_unused

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

>From 6f5427039c33e149b711c0f973fcac7f6875b768 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 16:53:10 +0200
Subject: [PATCH] ASoC: rsnd: mark PM functions __maybe_unused

The suspend/resume callbacks are now optional, leading to a warning
when they are unused:

sound/soc/sh/rcar/core.c:1548:12: error: 'rsnd_resume' defined but not used [-Werror=unused-function]
 static int rsnd_resume(struct device *dev)
            ^~~~~~~~~~~
sound/soc/sh/rcar/core.c:1539:12: error: 'rsnd_suspend' defined but not used [-Werror=unused-function]
 static int rsnd_suspend(struct device *dev)

This marks the as __maybe_unused to avoid the warning.

Fixes: f8a9a29c4fe9 ("ASoC: rsnd: set pm_ops in hibernate-compatible way")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6a76688a8ba9..94f081b93258 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1536,7 +1536,7 @@ static int rsnd_remove(struct platform_device *pdev)
 	return ret;
 }
 
-static int rsnd_suspend(struct device *dev)
+static int __maybe_unused rsnd_suspend(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
 
@@ -1545,7 +1545,7 @@ static int rsnd_suspend(struct device *dev)
 	return 0;
 }
 
-static int rsnd_resume(struct device *dev)
+static int __maybe_unused rsnd_resume(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
 
-- 
2.17.0
