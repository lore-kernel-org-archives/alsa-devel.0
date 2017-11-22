From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: reset RT5645_AD_DA_MIXER at probe
Date: Wed, 22 Nov 2017 13:59:19 +0800
Message-ID: <1511330359-20702-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E3AD2671E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 06:59:34 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Akshu.Agrawal@amd.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT5645_AD_DA_MIXER (0x29) register will not be reset to default after
SW reset. So we have to write it to its default value in i2c_probe.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index b7eef6a..27a3d3d 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3815,6 +3815,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	regmap_read(regmap, RT5645_VENDOR_ID, &val);
 	rt5645->v_id = val & 0xff;
 
+	regmap_write(rt5645->regmap, RT5645_AD_DA_MIXER, 0x8080);
+
 	ret = regmap_register_patch(rt5645->regmap, init_list,
 				    ARRAY_SIZE(init_list));
 	if (ret != 0)
-- 
2.7.4
