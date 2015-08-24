From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 5/5] ASoC: rt5645: Add the register
	RT5645_CHARGE_PUMP to readable check function
Date: Mon, 24 Aug 2015 20:32:59 +0800
Message-ID: <1440419579-9970-5-git-send-email-oder_chiou@realtek.com>
References: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D6B82606FC
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 14:33:10 +0200 (CEST)
In-Reply-To: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 53d5894..4917057 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -394,6 +394,7 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_DEPOP_M1:
 	case RT5645_DEPOP_M2:
 	case RT5645_DEPOP_M3:
+	case RT5645_CHARGE_PUMP:
 	case RT5645_MICBIAS:
 	case RT5645_A_JD_CTRL1:
 	case RT5645_VAD_CTRL4:
-- 
1.8.1.1.439.g50a6b54
