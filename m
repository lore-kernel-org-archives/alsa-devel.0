From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5665: fix GPIO6 pin function define
Date: Thu, 20 Jul 2017 13:07:49 +0800
Message-ID: <1500527271-11188-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 802D526738F
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 07:08:06 +0200 (CEST)
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

The GPIO6 pin function select value was wrong.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index 1db5c6a..d95249c 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1692,8 +1692,8 @@
 #define RT5665_GP6_PIN_MASK			(0x3 << 5)
 #define RT5665_GP6_PIN_SFT			5
 #define RT5665_GP6_PIN_GPIO6			(0x0 << 5)
-#define RT5665_GP6_PIN_BCLK3			(0x0 << 5)
-#define RT5665_GP6_PIN_PDM_SCL			(0x1 << 5)
+#define RT5665_GP6_PIN_BCLK3			(0x1 << 5)
+#define RT5665_GP6_PIN_PDM_SCL			(0x2 << 5)
 #define RT5665_GP7_PIN_MASK			(0x3 << 3)
 #define RT5665_GP7_PIN_SFT			3
 #define RT5665_GP7_PIN_GPIO7			(0x0 << 3)
-- 
2.7.4
