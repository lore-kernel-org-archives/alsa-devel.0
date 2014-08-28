From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs35l32: Remove unneeded
 regulator_bulk_free call in cs35l32_i2c_remove
Date: Thu, 28 Aug 2014 17:54:38 +0800
Message-ID: <1409219678.21395.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 50392268E33
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 11:54:45 +0200 (CEST)
Received: by mail-ig0-f179.google.com with SMTP id r2so616307igi.0
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 02:54:44 -0700 (PDT)
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

The regulator_bulk_free() call is not required because current code is using
devm_regulator_bulk_get().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 380c212..718569f 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -548,8 +548,6 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_client)
 	if (cs35l32->reset_gpio)
 		gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
-	regulator_bulk_free(ARRAY_SIZE(cs35l32->supplies), cs35l32->supplies);
-
 	return 0;
 }
 
-- 
1.9.1
