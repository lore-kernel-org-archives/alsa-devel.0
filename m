From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5659: fix wrong bit define for ADC
	L2 power.
Date: Mon, 12 Mar 2018 19:50:07 +0800
Message-ID: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 4422226726B
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 12:50:22 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT5659_PWR_ADC_L2_BIT should be 2.

Signed-off-by: Zhong An <zhongan@pinecone.net>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5659.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index 73969ef..3b51c8a 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1008,7 +1008,7 @@
 #define RT5659_PWR_ADC_R1			(0x1 << 3)
 #define RT5659_PWR_ADC_R1_BIT			3
 #define RT5659_PWR_ADC_L2			(0x1 << 2)
-#define RT5659_PWR_ADC_L2_BIT			4
+#define RT5659_PWR_ADC_L2_BIT			2
 #define RT5659_PWR_ADC_R2			(0x1 << 1)
 #define RT5659_PWR_ADC_R2_BIT			1
 #define RT5659_PWR_CLS_D			(0x1)
-- 
2.7.4
