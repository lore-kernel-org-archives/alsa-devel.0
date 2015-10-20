From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8904: Correct number of EQ registers" to the asoc tree
Date: Tue, 20 Oct 2015 20:32:25 +0100
Message-ID: <E1Zoce1-0003bh-UV@debutante>
References: <1445333158-18580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1445333158-18580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: stable-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8904: Correct number of EQ registers

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

>From 97aff2c03a1e4d343266adadb52313613efb027f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 20 Oct 2015 10:25:58 +0100
Subject: [PATCH] ASoC: wm8904: Correct number of EQ registers

There are 24 EQ registers not 25, I suspect this bug came about because
the registers start at EQ1 not zero. The bug is relatively harmless as
the extra register written is an unused one.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 include/sound/wm8904.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/wm8904.h b/include/sound/wm8904.h
index 898be3a8db9a..6d8f8fba3341 100644
--- a/include/sound/wm8904.h
+++ b/include/sound/wm8904.h
@@ -119,7 +119,7 @@
 #define WM8904_MIC_REGS  2
 #define WM8904_GPIO_REGS 4
 #define WM8904_DRC_REGS  4
-#define WM8904_EQ_REGS   25
+#define WM8904_EQ_REGS   24
 
 /**
  * DRC configurations are specified with a label and a set of register
-- 
2.6.1
