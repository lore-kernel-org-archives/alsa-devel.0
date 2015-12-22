From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5616: Return error if device ID
	mismatch
Date: Tue, 22 Dec 2015 10:16:35 +0800
Message-ID: <1450750595.14401.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B8B2614A6
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 03:16:41 +0100 (CET)
Received: by mail-pf0-f182.google.com with SMTP id n128so81211492pfn.0
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 18:16:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index f4005cb..0e9414a 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1314,7 +1314,7 @@ static int rt5616_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5616\n",
 			val);
-		ret = -ENODEV;
+		return -ENODEV;
 	}
 	regmap_write(rt5616->regmap, RT5616_RESET, 0);
 	regmap_update_bits(rt5616->regmap, RT5616_PWR_ANLG1,
-- 
2.1.4
