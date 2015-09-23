From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/4] ASoC: rt5645: Increase the delay time to
	remove the pop sound
Date: Wed, 23 Sep 2015 14:35:29 +0800
Message-ID: <1442990130-15801-3-git-send-email-oder_chiou@realtek.com>
References: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B7F72604A9
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 08:35:41 +0200 (CEST)
In-Reply-To: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
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
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 0249abc..4deedc4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1381,7 +1381,7 @@ static void hp_amp_power(struct snd_soc_codec *codec, int on)
 				regmap_write(rt5645->regmap, RT5645_PR_BASE +
 					RT5645_MAMP_INT_REG2, 0xfc00);
 				snd_soc_write(codec, RT5645_DEPOP_M2, 0x1140);
-				mdelay(5);
+				msleep(40);
 				rt5645->hp_on = true;
 			} else {
 				/* depop parameters */
-- 
1.8.1.1.439.g50a6b54
