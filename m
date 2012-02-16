From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Show device id in the debug message
Date: Thu, 16 Feb 2012 10:33:45 +0800
Message-ID: <1329359625.29391.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AAA30103F62
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 03:33:51 +0100 (CET)
Received: by dady9 with SMTP id y9so1587090dad.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 18:33:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Show the id we read when the id mismatch is detected.
This is useful for debugging.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8962.c |    2 +-
 sound/soc/codecs/wm8996.c |    2 +-
 sound/soc/codecs/wm9090.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 172dcac..5a6516e 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3718,7 +3718,7 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 	}
 	if (reg != 0x6243) {
 		dev_err(&i2c->dev,
-			"Device is not a WM8962, ID %x != 0x6243\n", ret);
+			"Device is not a WM8962, ID %x != 0x6243\n", reg);
 		ret = -EINVAL;
 		goto err_regmap;
 	}
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 759ea69..c3bde4a 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3185,7 +3185,7 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap;
 	}
 	if (reg != 0x8915) {
-		dev_err(&i2c->dev, "Device is not a WM8996, ID %x\n", ret);
+		dev_err(&i2c->dev, "Device is not a WM8996, ID %x\n", reg);
 		ret = -EINVAL;
 		goto err_regmap;
 	}
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index e8280ee..4b263b6 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -639,7 +639,7 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto err;
 	if (reg != 0x9093) {
-		dev_err(&i2c->dev, "Device is not a WM9090, ID=%x\n", ret);
+		dev_err(&i2c->dev, "Device is not a WM9090, ID=%x\n", reg);
 		ret = -ENODEV;
 		goto err;
 	}
-- 
1.7.5.4
