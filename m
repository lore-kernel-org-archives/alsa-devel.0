From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: Fix incorrect register addresses" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:38 +0100
Message-ID: <E1bkDmc-0001fW-FG@debutante>
References: <1472061627-821-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472061627-821-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, bardliao@realtek.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: Fix incorrect register addresses

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

>From 8cc123671a08f35be6b00f6131d3bf8504372ae0 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Wed, 24 Aug 2016 11:00:27 -0700
Subject: [PATCH] ASoC: rt5659: Fix incorrect register addresses

According to the datasheets of Realtek ALC5658 (Rev. 0.9)
and ALC5659 (Rev. 0.13), the "IRQ Control 4" register is
located at MX-00BAh while the "IRQ control 5" register is
at MX-00BBh.

There is no "IRQ Control 6" register in the datasheets but
it is supposed to be behind the "IRQ Control 5" register.

So this patch corrects these addresses.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index d69b0eb5a334..8f1aeef08489 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -180,9 +180,9 @@
 #define RT5659_IRQ_CTRL_1			0x00b6
 #define RT5659_IRQ_CTRL_2			0x00b7
 #define RT5659_IRQ_CTRL_3			0x00b8
-#define RT5659_IRQ_CTRL_4			0x00b9
-#define RT5659_IRQ_CTRL_5			0x00ba
-#define RT5659_IRQ_CTRL_6			0x00bb
+#define RT5659_IRQ_CTRL_4			0x00ba
+#define RT5659_IRQ_CTRL_5			0x00bb
+#define RT5659_IRQ_CTRL_6			0x00bc
 #define RT5659_INT_ST_1				0x00be
 #define RT5659_INT_ST_2				0x00bf
 #define RT5659_GPIO_CTRL_1			0x00c0
-- 
2.8.1
