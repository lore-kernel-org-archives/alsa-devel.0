From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: fix wrong bit def for pll src
Date: Tue, 17 Nov 2015 16:30:17 +0800
Message-ID: <1447749017-5958-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3345B264F53
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 09:30:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The bit allocation for PLL source is 0x80 [13:11] instead of [12:11]

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index dc2b462..3f1b0f1 100644
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
1.8.1.1.439.g50a6b54
