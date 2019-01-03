From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] In function rt274_i2c_probe(), if the regmap_read fails. The variable "val" could leave uninitialized but used in if statement.
Date: Wed,  2 Jan 2019 18:38:39 -0800
Message-ID: <20190103023839.15314-1-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 8f92e5c4dd9d..940658cac063 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1113,7 +1113,7 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 	struct rt274_priv *rt274;
 
 	int ret;
-	unsigned int val;
+	unsigned int val = ~0;
 
 	rt274 = devm_kzalloc(&i2c->dev,	sizeof(*rt274),
 				GFP_KERNEL);
@@ -1128,9 +1128,9 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt274->regmap,
+	ret = regmap_read(rt274->regmap,
 		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
-	if (val != RT274_VENDOR_ID) {
+	if (ret || val != RT274_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt274\n", val);
 		return -ENODEV;
-- 
2.17.1
