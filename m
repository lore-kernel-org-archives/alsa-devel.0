From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 4/4] ASoC: rt5645: Prevent the pop sound in
	case of playback and the jack is plugging
Date: Wed, 23 Sep 2015 14:35:30 +0800
Message-ID: <1442990130-15801-4-git-send-email-oder_chiou@realtek.com>
References: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A5E72604A4
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
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4deedc4..3eb184c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2835,6 +2835,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
+		regmap_update_bits(rt5645->regmap, RT5645_HP_VOL,
+			RT5645_L_MUTE | RT5645_R_MUTE,
+			RT5645_L_MUTE | RT5645_R_MUTE);
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
 			RT5645_CBJ_MN_JD, RT5645_CBJ_MN_JD);
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
-- 
1.8.1.1.439.g50a6b54
