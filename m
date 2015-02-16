From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: Set RT5670_IRQ_CTRL1 non volatile
Date: Mon, 16 Feb 2015 13:06:45 +0800
Message-ID: <1424063205-4256-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C8FE260624
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 06:06:57 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT5670_IRQ_CTRL1(0xbd) is a non volatile register. And we need to
restore its value after suspend/resume.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 6aa4ab2..04ca247 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -225,7 +225,6 @@ static bool rt5670_volatile_register(struct device *dev, unsigned int reg)
 	case RT5670_ADC_EQ_CTRL1:
 	case RT5670_EQ_CTRL1:
 	case RT5670_ALC_CTRL_1:
-	case RT5670_IRQ_CTRL1:
 	case RT5670_IRQ_CTRL2:
 	case RT5670_INT_IRQ_ST:
 	case RT5670_IL_CMD:
-- 
1.8.1.1.439.g50a6b54
