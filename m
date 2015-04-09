From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Restore default in probe
Date: Thu, 9 Apr 2015 11:20:32 +0800
Message-ID: <1428549632-27893-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AD4C260478
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 05:20:44 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, han.lu@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT286 can't do register reset. If the hardware power is still existing
in power off, rt286 will keep the register settings. So, we need to
restore the default register value in probe to make sure the cache value
is the same as the real register value.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 842cfb9..87af81b 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1250,6 +1250,14 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	rt286->i2c = i2c;
 	i2c_set_clientdata(i2c, rt286);
 
+	/* restore codec default */
+	for (i = 0; i < INDEX_CACHE_SIZE; i++)
+		regmap_write(rt286->regmap, rt286->index_cache[i].reg,
+				rt286->index_cache[i].def);
+	for (i = 0; i < ARRAY_SIZE(rt286_reg); i++)
+		regmap_write(rt286->regmap, rt286_reg[i].reg,
+				rt286_reg[i].def);
+
 	if (pdata)
 		rt286->pdata = *pdata;
 
-- 
1.8.1.1.439.g50a6b54
