From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Use IS_ENABLED() instead of checking for built-in or module" to the asoc tree
Date: Tue, 26 Apr 2016 12:07:59 +0100
Message-ID: <E1av0qV-0000UA-RS@debutante>
References: <1461627039-28547-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461627039-28547-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Use IS_ENABLED() instead of checking for built-in or module

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

>From de06f22f717b30641229036439b804ae79a7ad4d Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Mon, 25 Apr 2016 19:30:39 -0400
Subject: [PATCH] ASoC: cs42l56: Use IS_ENABLED() instead of checking for
 built-in or module

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 7cd5f769bb61..eec1ff853b98 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -56,7 +56,7 @@ struct  cs42l56_private {
 	u8 iface;
 	u8 iface_fmt;
 	u8 iface_inv;
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#if IS_ENABLED(CONFIG_INPUT)
 	struct input_dev *beep;
 	struct work_struct beep_work;
 	int beep_rate;
-- 
2.8.0.rc3
