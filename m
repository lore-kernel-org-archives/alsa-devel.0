From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: sta529: Remove redundant
 I2C_FUNC_SMBUS_BYTE_DATA functionality check
Date: Fri, 24 Jul 2015 11:17:28 +0800
Message-ID: <1437707848.12634.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 96732260522
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 05:17:35 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so6335490pdj.3
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 20:17:34 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

This checking is done by regmap_get_i2c_bus() which is called in
devm_regmap_init_i2c().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/sta529.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 3430f44..2cdaca9 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -339,9 +339,6 @@ static int sta529_i2c_probe(struct i2c_client *i2c,
 	struct sta529 *sta529;
 	int ret;
 
-	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -EINVAL;
-
 	sta529 = devm_kzalloc(&i2c->dev, sizeof(struct sta529), GFP_KERNEL);
 	if (!sta529)
 		return -ENOMEM;
-- 
2.1.0
