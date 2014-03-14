From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: max98090: Remove unused control_data
	field
Date: Fri, 14 Mar 2014 09:33:36 +0100
Message-ID: <1394786016-29311-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6EC264FBB
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 09:33:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The driver assigns a value to the control_data field of the driver's state
struct, but never reads it again. Which means it is unused and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98090.c | 1 -
 sound/soc/codecs/max98090.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 390fba1..1baa12c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2343,7 +2343,6 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 
 	max98090->devtype = id->driver_data;
 	i2c_set_clientdata(i2c, max98090);
-	max98090->control_data = i2c;
 	max98090->pdata = i2c->dev.platform_data;
 	max98090->irq = i2c->irq;
 
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index 7e103f2..1a4e233 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1523,7 +1523,6 @@ struct max98090_priv {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 	enum max98090_type devtype;
-	void *control_data;
 	struct max98090_pdata *pdata;
 	unsigned int sysclk;
 	unsigned int bclk;
-- 
1.8.0
