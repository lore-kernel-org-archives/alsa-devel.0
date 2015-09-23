From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/4] ASoC: rt5645: Remove the repeated
	definitions
Date: Wed, 23 Sep 2015 14:35:27 +0800
Message-ID: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9082604BD
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 08:35:41 +0200 (CEST)
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
Cc: sy0704.lee@samsung.com, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 90325d9..f45861c 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -777,8 +777,6 @@
 #define RT5645_PWR_CLS_D_R_BIT			9
 #define RT5645_PWR_CLS_D_L			(0x1 << 8)
 #define RT5645_PWR_CLS_D_L_BIT			8
-#define RT5645_PWR_ADC_R			(0x1 << 1)
-#define RT5645_PWR_ADC_R_BIT			1
 #define RT5645_PWR_DAC_L2			(0x1 << 7)
 #define RT5645_PWR_DAC_L2_BIT			7
 #define RT5645_PWR_DAC_R2			(0x1 << 6)
-- 
1.8.1.1.439.g50a6b54
