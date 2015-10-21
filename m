From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt298: fix remove unnedded clk
	setting
Date: Wed, 21 Oct 2015 16:18:19 +0800
Message-ID: <1445415499-29200-2-git-send-email-bardliao@realtek.com>
References: <1445415499-29200-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4617F2605A6
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 10:18:32 +0200 (CEST)
In-Reply-To: <1445415499-29200-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The bit is no longer present. So remove it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index b3f795c..30c6de6 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -855,8 +855,6 @@ static int rt298_set_dai_sysclk(struct snd_soc_dai *dai,
 		snd_soc_update_bits(codec,
 			RT298_I2S_CTRL2, 0x0100, 0x0100);
 		snd_soc_update_bits(codec,
-			RT298_PLL_CTRL, 0x4, 0x4);
-		snd_soc_update_bits(codec,
 			RT298_PLL_CTRL1, 0x20, 0x0);
 	}
 
-- 
1.8.1.1.439.g50a6b54
