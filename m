From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Fix PLL source register
	definitions" to the asoc tree
Date: Tue, 15 Jan 2019 19:08:24 +0000 (GMT)
Message-ID: <20190115190824.721021127848@debutante.sirena.org.uk>
References: <1547522859-16983-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8467A26747E
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 20:08:30 +0100 (CET)
In-Reply-To: <1547522859-16983-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Fix PLL source register definitions

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

>From ee7ea2a9a318a89d21b156dc75e54d53904bdbe5 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 15 Jan 2019 11:27:39 +0800
Subject: [PATCH] ASoC: rt5682: Fix PLL source register definitions

Fix typo which causes headphone no sound while using BCLK
as PLL source.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index d82a8301fd74..96944cff0ed7 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -849,18 +849,18 @@
 #define RT5682_SCLK_SRC_PLL2			(0x2 << 13)
 #define RT5682_SCLK_SRC_SDW			(0x3 << 13)
 #define RT5682_SCLK_SRC_RCCLK			(0x4 << 13)
-#define RT5682_PLL1_SRC_MASK			(0x3 << 10)
-#define RT5682_PLL1_SRC_SFT			10
-#define RT5682_PLL1_SRC_MCLK			(0x0 << 10)
-#define RT5682_PLL1_SRC_BCLK1			(0x1 << 10)
-#define RT5682_PLL1_SRC_SDW			(0x2 << 10)
-#define RT5682_PLL1_SRC_RC			(0x3 << 10)
-#define RT5682_PLL2_SRC_MASK			(0x3 << 8)
-#define RT5682_PLL2_SRC_SFT			8
-#define RT5682_PLL2_SRC_MCLK			(0x0 << 8)
-#define RT5682_PLL2_SRC_BCLK1			(0x1 << 8)
-#define RT5682_PLL2_SRC_SDW			(0x2 << 8)
-#define RT5682_PLL2_SRC_RC			(0x3 << 8)
+#define RT5682_PLL2_SRC_MASK			(0x3 << 10)
+#define RT5682_PLL2_SRC_SFT			10
+#define RT5682_PLL2_SRC_MCLK			(0x0 << 10)
+#define RT5682_PLL2_SRC_BCLK1			(0x1 << 10)
+#define RT5682_PLL2_SRC_SDW			(0x2 << 10)
+#define RT5682_PLL2_SRC_RC			(0x3 << 10)
+#define RT5682_PLL1_SRC_MASK			(0x3 << 8)
+#define RT5682_PLL1_SRC_SFT			8
+#define RT5682_PLL1_SRC_MCLK			(0x0 << 8)
+#define RT5682_PLL1_SRC_BCLK1			(0x1 << 8)
+#define RT5682_PLL1_SRC_SDW			(0x2 << 8)
+#define RT5682_PLL1_SRC_RC			(0x3 << 8)
 
 
 
-- 
2.20.1
