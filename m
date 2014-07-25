From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Do not ignore errors in
	aic31xx_device_init()
Date: Fri, 25 Jul 2014 13:12:54 +0300
Message-ID: <1406283174-32271-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6843C2610A6
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 12:12:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We need to return the error codes from aic31xx_device_init() and return
from the i2c_probe with the error code.
We will have kernel panic (NULL pointer dereference) in
regulator_register_notifier() in case the devm_regulator_bulk_get() fails
(with -EPROBE_DEFER for example).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Mark,

Would it be possible to get this patch into 3.16?

Thanks,
Peter

 sound/soc/codecs/tlv320aic31xx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 539d1dd3c5e6..095f4556ab1b 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1179,7 +1179,7 @@ static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
 }
 #endif /* CONFIG_OF */
 
-static void aic31xx_device_init(struct aic31xx_priv *aic31xx)
+static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 {
 	int ret, i;
 
@@ -1198,7 +1198,7 @@ static void aic31xx_device_init(struct aic31xx_priv *aic31xx)
 					    "aic31xx-reset-pin");
 		if (ret < 0) {
 			dev_err(aic31xx->dev, "not able to acquire gpio\n");
-			return;
+			return ret;
 		}
 	}
 
@@ -1211,6 +1211,7 @@ static void aic31xx_device_init(struct aic31xx_priv *aic31xx)
 	if (ret != 0)
 		dev_err(aic31xx->dev, "Failed to request supplies: %d\n", ret);
 
+	return ret;
 }
 
 static int aic31xx_i2c_probe(struct i2c_client *i2c,
@@ -1240,7 +1241,9 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 	aic31xx->pdata.codec_type = id->driver_data;
 
-	aic31xx_device_init(aic31xx);
+	ret = aic31xx_device_init(aic31xx);
+	if (ret)
+		return ret;
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_driver_aic31xx,
 				     aic31xx_dai_driver,
-- 
2.0.2
