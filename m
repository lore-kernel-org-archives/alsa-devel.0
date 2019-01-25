From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] ASoC: rt5651: Variable "ret" in function rt5651_i2c_probe() could be uninitialized
Date: Fri, 25 Jan 2019 10:45:37 -0800
Message-ID: <20190125184537.13419-1-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In function rt5651_i2c_probe(), local variable "ret" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement. This is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt5651.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index da60b28ba3df..8d6cbc6b6ff0 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1734,6 +1734,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	struct rt5651_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5651_priv *rt5651;
 	int ret;
+	int err;
 
 	rt5651 = devm_kzalloc(&i2c->dev, sizeof(*rt5651),
 				GFP_KERNEL);
@@ -1755,7 +1756,10 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	err = regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	if (err)
+		return err;
+
 	if (ret != RT5651_DEVICE_ID_VALUE) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5651\n", ret);
-- 
2.17.1
