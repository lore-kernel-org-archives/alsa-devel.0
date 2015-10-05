From: Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 2/2] ASoC: rt298: Make rt298_index_def
	const
Date: Mon, 05 Oct 2015 21:23:48 +0800
Message-ID: <1444051428.13473.2.camel@ingics.com>
References: <1444051360.13473.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DA9E260547
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 15:23:55 +0200 (CEST)
Received: by pacfv12 with SMTP id fv12so180900679pac.2
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 06:23:54 -0700 (PDT)
In-Reply-To: <1444051360.13473.1.camel@ingics.com>
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

The index_cache is per instance run time state but rt298_index_def is not.
Make rt298_index_def const and make a copy of memory for index_cache rather
than directly use the rt298_index_def.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt298.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 2a6c2ba..83bbc62 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -48,7 +48,7 @@ struct rt298_priv {
 	int is_hp_in;
 };
 
-static struct reg_default rt298_index_def[] = {
+static const struct reg_default rt298_index_def[] = {
 	{ 0x01, 0xaaaa },
 	{ 0x02, 0x8aaa },
 	{ 0x03, 0x0002 },
@@ -1164,7 +1164,11 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	rt298->index_cache = rt298_index_def;
+	rt298->index_cache = devm_kmemdup(&i2c->dev, rt298_index_def,
+					  sizeof(rt298_index_def), GFP_KERNEL);
+	if (!rt298->index_cache)
+		return -ENOMEM;
+
 	rt298->index_cache_size = INDEX_CACHE_SIZE;
 	rt298->i2c = i2c;
 	i2c_set_clientdata(i2c, rt298);
-- 
2.1.4
