From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] ASoC: rt5645: Remove unneeded goto in
	rt5645_i2c_probe
Date: Tue, 10 Jun 2014 11:36:41 +0800
Message-ID: <1402371401.16323.2.camel@phoenix>
References: <1402371356.16323.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BDC32656FE
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 05:36:47 +0200 (CEST)
Received: by mail-pd0-f170.google.com with SMTP id g10so5643292pdj.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2014 20:36:46 -0700 (PDT)
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
 sound/soc/codecs/rt5645.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 02147be..a7762d0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2345,14 +2345,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
-			rt5645_dai, ARRAY_SIZE(rt5645_dai));
-	if (ret < 0)
-		goto err;
-
-	return 0;
-err:
-	return ret;
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
+				      rt5645_dai, ARRAY_SIZE(rt5645_dai));
 }
 
 static int rt5645_i2c_remove(struct i2c_client *i2c)
-- 
1.8.3.2
