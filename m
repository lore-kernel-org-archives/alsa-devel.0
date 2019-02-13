From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l36: Remove unused including <linux/version.h>" to the asoc tree
Date: Wed, 13 Feb 2019 11:53:33 +0000 (GMT)
Message-ID: <20190213115333.E6EA01128158@debutante.sirena.org.uk>
References: <20190213014332.148775-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213014332.148775-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l36: Remove unused including <linux/version.h>

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

>From 51bef0f378f39ed0604296354b964e3919161396 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 13 Feb 2019 01:43:32 +0000
Subject: [PATCH] ASoC: cs35l36: Remove unused including <linux/version.h>

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l36.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 4f880a678812..e374fffb7e17 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.20.1
