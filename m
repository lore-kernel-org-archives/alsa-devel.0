From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5665: fix define of
	RT5665_HP_DRIVER_5X
Date: Thu, 16 Mar 2017 13:58:40 +0800
Message-ID: <1489643921-29900-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B6182670D7
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 06:59:11 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

It is (0x3 << 2), not (0x2 << 2).

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index 12f7080..a30f5e6 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1106,7 +1106,7 @@
 #define RT5665_HP_DRIVER_MASK			(0x3 << 2)
 #define RT5665_HP_DRIVER_1X			(0x0 << 2)
 #define RT5665_HP_DRIVER_3X			(0x1 << 2)
-#define RT5665_HP_DRIVER_5X			(0x2 << 2)
+#define RT5665_HP_DRIVER_5X			(0x3 << 2)
 #define RT5665_LDO1_DVO_MASK			(0x3)
 #define RT5665_LDO1_DVO_09			(0x0)
 #define RT5665_LDO1_DVO_10			(0x1)
-- 
2.7.4
