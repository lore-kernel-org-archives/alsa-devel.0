From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5677: Modify the voltage level in
	the BIAS OFF stage
Date: Mon, 7 Jul 2014 15:37:00 +0800
Message-ID: <1404718621-15516-2-git-send-email-oder_chiou@realtek.com>
References: <1404718621-15516-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 38AD9265465
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 09:37:17 +0200 (CEST)
In-Reply-To: <1404718621-15516-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch modifies the voltage level in the BIAS OFF stage

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 98370ae..67f1455 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3124,7 +3124,7 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x1, 0x0);
 		regmap_write(rt5677->regmap, RT5677_PWR_DIG1, 0x0000);
 		regmap_write(rt5677->regmap, RT5677_PWR_DIG2, 0x0000);
-		regmap_write(rt5677->regmap, RT5677_PWR_ANLG1, 0x0000);
+		regmap_write(rt5677->regmap, RT5677_PWR_ANLG1, 0x0022);
 		regmap_write(rt5677->regmap, RT5677_PWR_ANLG2, 0x0000);
 		regmap_update_bits(rt5677->regmap,
 			RT5677_PR_BASE + RT5677_BIAS_CUR4, 0x0f00, 0x0000);
-- 
1.8.1.1.439.g50a6b54
