From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt298: fix wrong setting of gpio2_en
Date: Wed, 21 Oct 2015 16:18:18 +0800
Message-ID: <1445415499-29200-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 474292605B0
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 10:18:34 +0200 (CEST)
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

The register value to enable gpio2 was incorrect. So fix it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 56e5e1a..b3f795c 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1217,7 +1217,7 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	mdelay(10);
 
 	if (!rt298->pdata.gpio2_en)
-		regmap_write(rt298->regmap, RT298_SET_DMIC2_DEFAULT, 0x4000);
+		regmap_write(rt298->regmap, RT298_SET_DMIC2_DEFAULT, 0x40);
 	else
 		regmap_write(rt298->regmap, RT298_SET_DMIC2_DEFAULT, 0);
 
-- 
1.8.1.1.439.g50a6b54
