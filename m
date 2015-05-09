From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: sta32x: Use devm_gpiod_get_optional
 appropriate place
Date: Sat, 09 May 2015 21:38:41 +0800
Message-ID: <1431178721.23049.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F16260502
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 15:38:47 +0200 (CEST)
Received: by pacyx8 with SMTP id yx8so72756039pac.1
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 06:38:46 -0700 (PDT)
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
Cc: Johannes Stezenbach <js@sig21.net>, Sven Brandau <info@brandau.biz>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

devm_gpiod_get_optional() is equivalent to devm_gpiod_get(), except that
when no GPIO was assigned to the requested function it will return NULL.
This is convenient for drivers that need to handle optional GPIOs.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/sta32x.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 033b7d9..847fb20 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1095,16 +1095,10 @@ static int sta32x_i2c_probe(struct i2c_client *i2c,
 #endif
 
 	/* GPIOs */
-	sta32x->gpiod_nreset = devm_gpiod_get(dev, "reset");
-	if (IS_ERR(sta32x->gpiod_nreset)) {
-		ret = PTR_ERR(sta32x->gpiod_nreset);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return ret;
-
-		sta32x->gpiod_nreset = NULL;
-	} else {
-		gpiod_direction_output(sta32x->gpiod_nreset, 0);
-	}
+	sta32x->gpiod_nreset = devm_gpiod_get_optional(dev, "reset",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(sta32x->gpiod_nreset))
+		return PTR_ERR(sta32x->gpiod_nreset);
 
 	/* regulators */
 	for (i = 0; i < ARRAY_SIZE(sta32x->supplies); i++)
-- 
2.1.0
