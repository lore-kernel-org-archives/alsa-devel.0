From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: Remove unneeded header file" to the asoc tree
Date: Sun, 26 Jun 2016 13:02:56 +0100
Message-ID: <E1bH8m8-0002VJ-RS@debutante>
References: <20160624062135.GA23457@amitoj-Inspiron-3542>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160624062135.GA23457@amitoj-Inspiron-3542>
Sender: linux-kernel-owner@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8753: Remove unneeded header file

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

>From 34c5cdbcbdfe8575ece87a48e04208fbcd0ad16f Mon Sep 17 00:00:00 2001
From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Fri, 24 Jun 2016 11:51:36 +0530
Subject: [PATCH] ASoC: wm8753: Remove unneeded header file

Drop redundant include of moduleparam.h

The Coccinelle semantic patch used to make this change is as follows:
@ includesmodule @
@@

@ depends on includesmodule @
@@

- #include <linux/moduleparam.h>

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8753.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 6f1024f48b19..b4e6893f5e3d 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -32,7 +32,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.8.1
