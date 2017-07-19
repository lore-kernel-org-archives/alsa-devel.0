From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt274: correct comment style
Date: Wed, 19 Jul 2017 09:52:12 +0800
Message-ID: <1500429132-28583-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FD0E266A09
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 03:52:29 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, guneshwor.o.singh@intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There was a comment style issue in the driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 81e29ba..fb683ff 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1159,7 +1159,7 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt274->regmap, 0x6f, 0x3000, 0x2000);
 	/* HP DC Calibration */
 	regmap_update_bits(rt274->regmap, 0x6f, 0xf, 0x0);
-	//Set NID=58h.Index 00h [15]= 1b;
+	/* Set NID=58h.Index 00h [15]= 1b; */
 	regmap_write(rt274->regmap, RT274_COEF58_INDEX, 0x00);
 	regmap_write(rt274->regmap, RT274_COEF58_COEF, 0xb888);
 	msleep(500);
-- 
2.7.4
