From: <shumingf@realtek.com>
Subject: [PATCH] ASoC: rt5682: Fix PLL source register
	definitions
Date: Tue, 15 Jan 2019 11:27:39 +0800
Message-ID: <1547522859-16983-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 71C722673FF
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 04:27:52 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, bard.liao@intel.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

Fix typo which causes headphone no sound while using BCLK
as PLL source.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index d82a830..96944cf 100644
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
2.7.4
