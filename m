From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: add MODULE_LICENSE tag" to the asoc tree
Date: Wed, 10 Jan 2018 16:42:51 +0000
Message-ID: <E1eZJSl-00089M-Kc@debutante>
References: <20180110163503.603206-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110163503.603206-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>, Donglin Peng <dolinux.peng@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Johan Hovold <johan@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ux500: add MODULE_LICENSE tag

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

>From 1783c9d7cb7bc3181b9271665959b87280d98d8e Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Jan 2018 17:34:45 +0100
Subject: [PATCH] ASoC: ux500: add MODULE_LICENSE tag

This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
platform drivers, to avoid these build warnings:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

The company no longer exists, so the email addresses of the authors
don't work any more, but I've added them anyway for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/mop500.c    | 4 ++++
 sound/soc/ux500/ux500_pcm.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 070a6880980e..c60a57797640 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -163,3 +163,7 @@ static struct platform_driver snd_soc_mop500_driver = {
 };
 
 module_platform_driver(snd_soc_mop500_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC MOP500 board driver");
+MODULE_AUTHOR("Ola Lilja");
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index f12c01dddc8d..d35ba7700f46 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -165,3 +165,8 @@ int ux500_pcm_unregister_platform(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
+
+MODULE_AUTHOR("Ola Lilja");
+MODULE_AUTHOR("Roger Nilsson");
+MODULE_DESCRIPTION("ASoC UX500 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
