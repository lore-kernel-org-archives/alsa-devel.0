From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tscs454: remove unused variable 'PLL_48K_RATE'" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:39 +0100 (BST)
Message-ID: <20190808203339.6ED712742EDC@ypsilon.sirena.org.uk>
References: <20190808032552.45360-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808032552.45360-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, steven.eckhoff.opensource@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tscs454: remove unused variable 'PLL_48K_RATE'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 8e082d8f42fabf9a4a0708d8012f4995765478fc Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 8 Aug 2019 11:25:52 +0800
Subject: [PATCH] ASoC: tscs454: remove unused variable 'PLL_48K_RATE'

The global variable 'PLL_48K_RATE' is never used
so just remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190808032552.45360-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs454.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 93d84e5ae2d5..c3587af9985c 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -22,7 +22,6 @@
 
 #include "tscs454.h"
 
-static const unsigned int PLL_48K_RATE = (48000 * 256);
 static const unsigned int PLL_44_1K_RATE = (44100 * 256);
 
 #define COEFF_SIZE 3
-- 
2.20.1
