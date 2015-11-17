From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: fix wrong bit def for pll src"
	to the asoc tree
Date: Tue, 17 Nov 2015 18:54:46 +0000
Message-ID: <E1ZylOw-00040j-Nv@debutante>
References: <1447749017-5958-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 922372652BF
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:52 +0100 (CET)
In-Reply-To: <1447749017-5958-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: fix wrong bit def for pll src

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

>From e71bf05554c9015bef8df3ffc386ccb37b153858 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 17 Nov 2015 16:30:17 +0800
Subject: [PATCH] ASoC: rt5670: fix wrong bit def for pll src

The bit allocation for PLL source is 0x80 [13:11] instead of [12:11]

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index dc2b46236c5c..3f1b0f1df809 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -973,12 +973,12 @@
 #define RT5670_SCLK_SRC_MCLK			(0x0 << 14)
 #define RT5670_SCLK_SRC_PLL1			(0x1 << 14)
 #define RT5670_SCLK_SRC_RCCLK			(0x2 << 14) /* 15MHz */
-#define RT5670_PLL1_SRC_MASK			(0x3 << 12)
-#define RT5670_PLL1_SRC_SFT			12
-#define RT5670_PLL1_SRC_MCLK			(0x0 << 12)
-#define RT5670_PLL1_SRC_BCLK1			(0x1 << 12)
-#define RT5670_PLL1_SRC_BCLK2			(0x2 << 12)
-#define RT5670_PLL1_SRC_BCLK3			(0x3 << 12)
+#define RT5670_PLL1_SRC_MASK			(0x7 << 11)
+#define RT5670_PLL1_SRC_SFT			11
+#define RT5670_PLL1_SRC_MCLK			(0x0 << 11)
+#define RT5670_PLL1_SRC_BCLK1			(0x1 << 11)
+#define RT5670_PLL1_SRC_BCLK2			(0x2 << 11)
+#define RT5670_PLL1_SRC_BCLK3			(0x3 << 11)
 #define RT5670_PLL1_PD_MASK			(0x1 << 3)
 #define RT5670_PLL1_PD_SFT			3
 #define RT5670_PLL1_PD_1			(0x0 << 3)
-- 
2.6.2
