From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/6] ASoC: rt5640: Remove the unused or
	incorrect setting of clock source
Date: Fri, 28 Mar 2014 20:28:27 +0800
Message-ID: <1396009710-21324-3-git-send-email-oder_chiou@realtek.com>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E0DA2654E6
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:29:37 +0100 (CET)
In-Reply-To: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the unused or incorrect setting of clock source.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 8 +-------
 sound/soc/codecs/rt5640.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 2afce49..096edfe 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -487,7 +487,7 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 
 	val = snd_soc_read(source->codec, RT5640_GLB_CLK);
 	val &= RT5640_SCLK_SRC_MASK;
-	if (val == RT5640_SCLK_SRC_PLL1 || val == RT5640_SCLK_SRC_PLL1T)
+	if (val == RT5640_SCLK_SRC_PLL1)
 		return 1;
 	else
 		return 0;
@@ -1694,12 +1694,6 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 	case RT5640_SCLK_S_PLL1:
 		reg_val |= RT5640_SCLK_SRC_PLL1;
 		break;
-	case RT5640_SCLK_S_PLL1_TK:
-		reg_val |= RT5640_SCLK_SRC_PLL1T;
-		break;
-	case RT5640_SCLK_S_RCCLK:
-		reg_val |= RT5640_SCLK_SRC_RCCLK;
-		break;
 	default:
 		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 5e8df25a..cbd07b5 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -976,8 +976,6 @@
 #define RT5640_SCLK_SRC_SFT			14
 #define RT5640_SCLK_SRC_MCLK			(0x0 << 14)
 #define RT5640_SCLK_SRC_PLL1			(0x1 << 14)
-#define RT5640_SCLK_SRC_PLL1T			(0x2 << 14)
-#define RT5640_SCLK_SRC_RCCLK			(0x3 << 14) /* 15MHz */
 #define RT5640_PLL1_SRC_MASK			(0x3 << 12)
 #define RT5640_PLL1_SRC_SFT			12
 #define RT5640_PLL1_SRC_MCLK			(0x0 << 12)
-- 
1.8.1.1.439.g50a6b54
