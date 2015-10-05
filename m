From: Axel Lin <axel.lin@ingics.com>
Subject: Regarding ASoC: rt286: Fix the runtime error in the
	booting
Date: Mon, 05 Oct 2015 18:08:59 +0800
Message-ID: <1444039739.8819.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4548B260504
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 12:09:07 +0200 (CEST)
Received: by pacfv12 with SMTP id fv12so176478974pac.2
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 03:09:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Order,
I just notice your patch on the ML:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/098390.html
I didn't subscribe the ML and I'm not in CC so I cannot directly reply to you.

I think you should make a copy of memory for index_cache rather than
directly use the rt286_index_def if the index_cache is necessary.

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 1fbdb4f..210ab415 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -37,7 +37,7 @@
 #define RT288_VENDOR_ID 0x10ec0288
 
 struct rt286_priv {
-	const struct reg_default *index_cache;
+	struct reg_default *index_cache;
 	int index_cache_size;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
@@ -1160,8 +1160,12 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	rt286->index_cache = rt286_index_def;
 	rt286->index_cache_size = INDEX_CACHE_SIZE;
+	rt286->index_cache = devm_kmalloc(&i2c->dev, INDEX_CACHE_SIZE,
+					  GFP_KERNEL);
+	if (!rt286->index_cache)
+		return -ENOMEM;
+
 	rt286->i2c = i2c;
 	i2c_set_clientdata(i2c, rt286);
 
