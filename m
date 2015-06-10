From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v4 1/3] SoC: rt5645: make RT5650_TDM_CTRL_4
	readable
Date: Wed, 10 Jun 2015 14:27:56 +0800
Message-ID: <1433917678-13166-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3029626586D
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 08:28:07 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Register RT5650_TDM_CTRL_4(0x7A) is readable and used for mixer
setting. It should be added in rt5645_readable_register function.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d5f0f56..b86474a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -349,6 +349,7 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_TDM_CTRL_1:
 	case RT5645_TDM_CTRL_2:
 	case RT5645_TDM_CTRL_3:
+	case RT5650_TDM_CTRL_4:
 	case RT5645_GLB_CLK:
 	case RT5645_PLL_CTRL1:
 	case RT5645_PLL_CTRL2:
-- 
1.8.1.1.439.g50a6b54
