From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] ASoC: rt5640: Remove unneeded goto in
	rt5640_i2c_probe
Date: Tue, 10 Jun 2014 11:35:56 +0800
Message-ID: <1402371356.16323.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 8802B2651AD
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 05:36:02 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id hz1so206653pad.18
 for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2014 20:36:00 -0700 (PDT)
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
 sound/soc/codecs/rt5640.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index de80e89..6bc6efd 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2215,14 +2215,8 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 
 	rt5640->hp_mute = 1;
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
-			rt5640_dai, ARRAY_SIZE(rt5640_dai));
-	if (ret < 0)
-		goto err;
-
-	return 0;
-err:
-	return ret;
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
+				      rt5640_dai, ARRAY_SIZE(rt5640_dai));
 }
 
 static int rt5640_i2c_remove(struct i2c_client *i2c)
-- 
1.8.3.2
