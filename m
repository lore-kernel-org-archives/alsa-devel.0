From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: enable speaker protection
	features
Date: Tue, 27 Jun 2017 10:05:29 +0800
Message-ID: <1498529129-30647-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B4AEB26680F
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 04:05:41 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, alexlee@realtek.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch is uploaded for enabling the speaker protection features
of the audio codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
v2:
* modify register value by regmap_update_bits instead of regmap_register_patch
---
 sound/soc/codecs/rt5645.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 162044d..627e801 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -59,7 +59,7 @@ static const struct regmap_range_cfg rt5645_ranges[] = {
 
 static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x3d,	0x3600},
-	{RT5645_PR_BASE + 0x1c,	0xfd20},
+	{RT5645_PR_BASE + 0x1c,	0xfd70},
 	{RT5645_PR_BASE + 0x20,	0x611f},
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
@@ -3730,6 +3730,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 					   ret);
 	}
 
+	regmap_update_bits(rt5645->regmap, RT5645_CLSD_OUT_CTRL, 0xc0, 0xc0);
+
 	if (rt5645->pdata.in2_diff)
 		regmap_update_bits(rt5645->regmap, RT5645_IN2_CTRL,
 					RT5645_IN_DF2, RT5645_IN_DF2);
-- 
2.7.4
