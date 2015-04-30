From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/6] ASoC: rt5645: fix PLL source register
	definitions
Date: Thu, 30 Apr 2015 18:18:43 +0800
Message-ID: <1430389127-24609-2-git-send-email-bardliao@realtek.com>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EE1D72659BF
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:19:13 +0200 (CEST)
In-Reply-To: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Fix PLL source register definitions.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index fa5c560..1897889 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1063,13 +1063,14 @@
 #define RT5645_SCLK_SRC_SFT			14
 #define RT5645_SCLK_SRC_MCLK			(0x0 << 14)
 #define RT5645_SCLK_SRC_PLL1			(0x1 << 14)
-#define RT5645_SCLK_SRC_RCCLK			(0x2 << 14) /* 15MHz */
-#define RT5645_PLL1_SRC_MASK			(0x3 << 12)
-#define RT5645_PLL1_SRC_SFT			12
-#define RT5645_PLL1_SRC_MCLK			(0x0 << 12)
-#define RT5645_PLL1_SRC_BCLK1			(0x1 << 12)
-#define RT5645_PLL1_SRC_BCLK2			(0x2 << 12)
-#define RT5645_PLL1_SRC_BCLK3			(0x3 << 12)
+#define RT5645_SCLK_SRC_RCCLK			(0x2 << 14)
+#define RT5645_PLL1_SRC_MASK			(0x7 << 11)
+#define RT5645_PLL1_SRC_SFT			11
+#define RT5645_PLL1_SRC_MCLK			(0x0 << 11)
+#define RT5645_PLL1_SRC_BCLK1			(0x1 << 11)
+#define RT5645_PLL1_SRC_BCLK2			(0x2 << 11)
+#define RT5645_PLL1_SRC_BCLK3			(0x3 << 11)
+#define RT5645_PLL1_SRC_RCCLK			(0x4 << 11)
 #define RT5645_PLL1_PD_MASK			(0x1 << 3)
 #define RT5645_PLL1_PD_SFT			3
 #define RT5645_PLL1_PD_1			(0x0 << 3)
-- 
1.8.1.1.439.g50a6b54
