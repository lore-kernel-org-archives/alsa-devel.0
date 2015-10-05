From: Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 1/2] ASoC: rt286: Fix run time error while
 modifying const data
Date: Mon, 05 Oct 2015 21:22:40 +0800
Message-ID: <1444051360.13473.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C668260547
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 15:22:46 +0200 (CEST)
Received: by pablk4 with SMTP id lk4so176466759pab.3
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 06:22:45 -0700 (PDT)
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

Make a copy of memory for index_cache rather than directly use the
rt286_index_def to avoid run time error.

Fixes: c418a84a8c8f ("ASoC: Constify reg_default tables")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt286.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 1fbdb4f..af2ed77 100644
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
@@ -1160,7 +1160,11 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	rt286->index_cache = rt286_index_def;
+	rt286->index_cache = devm_kmemdup(&i2c->dev, rt286_index_def,
+					  sizeof(rt286_index_def), GFP_KERNEL);
+	if (!rt286->index_cache)
+		return -ENOMEM;
+
 	rt286->index_cache_size = INDEX_CACHE_SIZE;
 	rt286->i2c = i2c;
 	i2c_set_clientdata(i2c, rt286);
-- 
2.1.4
