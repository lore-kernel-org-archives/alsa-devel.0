From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: max98925: Return proper error if
	revision mismatch
Date: Fri, 13 Oct 2017 09:21:01 +0800
Message-ID: <20171013012101.17715-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FE2B266FAD
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 03:21:23 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id p87so7504791pfj.3
 for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2017 18:21:23 -0700 (PDT)
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
Cc: Anish Kumar <Anish.Kumar@maximintegrated.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Return proper error instead of 0 if the revision does not match.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98925.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 327eaa25c9bd..921f95fc396d 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -579,7 +579,7 @@ static int max98925_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(max98925->regmap);
 		dev_err(&i2c->dev,
 				"Failed to allocate regmap: %d\n", ret);
-		goto err_out;
+		return ret;
 	}
 
 	if (!of_property_read_u32(i2c->dev.of_node, "vmon-slot-no", &value)) {
@@ -596,16 +596,20 @@ static int max98925_i2c_probe(struct i2c_client *i2c,
 		}
 		max98925->i_slot = value;
 	}
-	ret = regmap_read(max98925->regmap,
-			MAX98925_REV_VERSION, &reg);
-	if ((ret < 0) ||
-		((reg != MAX98925_VERSION) &&
-		(reg != MAX98925_VERSION1))) {
-		dev_err(&i2c->dev,
-			"device initialization error (%d 0x%02X)\n",
+
+	ret = regmap_read(max98925->regmap, MAX98925_REV_VERSION, &reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Read revision failed\n");
+		return ret;
+	}
+
+	if ((reg != MAX98925_VERSION) && (reg != MAX98925_VERSION1)) {
+		ret = -ENODEV;
+		dev_err(&i2c->dev, "Invalid revision (%d 0x%02X)\n",
 			ret, reg);
-		goto err_out;
+		return ret;
 	}
+
 	dev_info(&i2c->dev, "device version 0x%02X\n", reg);
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98925,
@@ -613,7 +617,6 @@ static int max98925_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		dev_err(&i2c->dev,
 				"Failed to register codec: %d\n", ret);
-err_out:
 	return ret;
 }
 
-- 
2.11.0
