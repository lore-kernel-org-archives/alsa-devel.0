From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] ASoC: rt5677: Remove unneeded goto in
	rt5677_i2c_probe
Date: Tue, 10 Jun 2014 11:37:24 +0800
Message-ID: <1402371444.16323.3.camel@phoenix>
References: <1402371356.16323.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F142651E4
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 05:37:29 +0200 (CEST)
Received: by mail-pa0-f48.google.com with SMTP id bj1so209505pad.35
 for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2014 20:37:29 -0700 (PDT)
In-Reply-To: <1402371356.16323.1.camel@phoenix>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5677.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index e7c401f..43c82cd 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3373,14 +3373,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5677->regmap, RT5677_IN1,
 					RT5677_IN_DF2, RT5677_IN_DF2);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5677,
-			rt5677_dai, ARRAY_SIZE(rt5677_dai));
-	if (ret < 0)
-		goto err;
-
-	return 0;
-err:
-	return ret;
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5677,
+				      rt5677_dai, ARRAY_SIZE(rt5677_dai));
 }
 
 static int rt5677_i2c_remove(struct i2c_client *i2c)
-- 
1.8.3.2
