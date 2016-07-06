From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: set RT5645_PRIV_INDEX as
	volatile
Date: Wed, 6 Jul 2016 09:55:14 +0800
Message-ID: <1467770115-16706-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id F25B9261A3D
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2016 03:55:25 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, PC.Liao@mediatek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT5645_PRIV_INDEX(0x6a) indicate the address of PR- registers. So,
it should be volatile.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 97bf96e..9251720 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -441,6 +441,7 @@ static bool rt5645_volatile_register(struct device *dev, unsigned int reg)
 
 	switch (reg) {
 	case RT5645_RESET:
+	case RT5645_PRIV_INDEX:
 	case RT5645_PRIV_DATA:
 	case RT5645_IN1_CTRL1:
 	case RT5645_IN1_CTRL2:
-- 
1.8.1.1.439.g50a6b54
