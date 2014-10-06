From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs4265: Remove unused *dev field from
 struct cs4265_private
Date: Mon, 06 Oct 2014 23:14:23 +0800
Message-ID: <1412608463.4950.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BA289260579
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 17:14:31 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id hz1so5419285pad.36
 for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2014 08:14:28 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4265.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 4fdd47d..ce60868 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -32,7 +32,6 @@
 #include "cs4265.h"
 
 struct cs4265_private {
-	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
 	u8 format;
@@ -598,7 +597,6 @@ static int cs4265_i2c_probe(struct i2c_client *i2c_client,
 			       GFP_KERNEL);
 	if (cs4265 == NULL)
 		return -ENOMEM;
-	cs4265->dev = &i2c_client->dev;
 
 	cs4265->regmap = devm_regmap_init_i2c(i2c_client, &cs4265_regmap);
 	if (IS_ERR(cs4265->regmap)) {
-- 
1.9.1
