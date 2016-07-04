From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: Remove unused including <linux/version.h>" to the asoc tree
Date: Mon, 04 Jul 2016 17:39:11 +0200
Message-ID: <E1bK5xn-0000Sw-TZ@finisterre>
References: <1467645497-12547-1-git-send-email-weiyj_lk@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467645497-12547-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l33: Remove unused including <linux/version.h>

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

>From 37c520b96f27fb935c87d24e3ff49b343078638c Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 4 Jul 2016 15:18:17 +0000
Subject: [PATCH] ASoC: cs35l33: Remove unused including <linux/version.h>

Remove including <linux/version.h> that don't need it.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index a4cbb16d68ad..6f9c1addcd7f 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -12,7 +12,6 @@
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.8.1
