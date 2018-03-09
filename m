From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TSCS42xx: Add missing headers" to the asoc tree
Date: Fri, 09 Mar 2018 18:04:02 +0000
Message-ID: <E1euMN8-00022l-Dx@debutante>
References: <20180309031332.GA27764@t7-ThinkPad-E560>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309031332.GA27764@t7-ThinkPad-E560>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TSCS42xx: Add missing headers

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

>From 641eea3f8b95a47d5e5db28dd92a0f586cd85390 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Thu, 8 Mar 2018 21:13:40 -0600
Subject: [PATCH] ASoC: TSCS42xx: Add missing headers

Add missing headers

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index e915261fa1cb..cfc71b5411ee 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -3,14 +3,19 @@
 // Copyright 2017 Tempo Semiconductor, Inc.
 // Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
 
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
 #include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/string.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/mutex.h>
-#include <linux/regmap.h>
+#include <sound/tlv.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/tlv.h>
 
 #include "tscs42xx.h"
 
-- 
2.16.2
