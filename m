From: Randolph Chung <rchung42@gmail.com>
Subject: [PATCH] tlv32aic3x: Use driver_data to pass codec
	model id
Date: Sat, 21 Aug 2010 13:14:29 +0800
Message-ID: <1282367669-14099-1-git-send-email-rchung42@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EE9981037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Aug 2010 07:31:07 +0200 (CEST)
Received: by pwj5 with SMTP id 5so1976856pwj.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 22:31:06 -0700 (PDT)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Per Mark's suggestion, use a cleaner syntax for passing the model id.

Signed-off-by: Randolph Chung <tausq@parisc-linux.org>
---
 sound/soc/codecs/tlv320aic3x.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index c074657..fc07986 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1327,9 +1327,9 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
  */
 
 static const struct i2c_device_id aic3x_i2c_id[] = {
-	[AIC3X_MODEL_3X] = { "tlv320aic3x", 0 },
-	[AIC3X_MODEL_33] = { "tlv320aic33", 0 },
-	[AIC3X_MODEL_3007] = { "tlv320aic3007", 0 },
+	{ "tlv320aic3x", AIC3X_MODEL_3X },
+	{ "tlv320aic33", AIC3X_MODEL_33 },
+	{ "tlv320aic3007", AIC3X_MODEL_3007 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -1345,7 +1345,6 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	struct aic3x_setup_data *setup = pdata->setup;
 	struct aic3x_priv *aic3x;
 	int ret, i;
-	const struct i2c_device_id *tbl;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
 	if (aic3x == NULL) {
@@ -1366,11 +1365,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		gpio_direction_output(aic3x->gpio_reset, 0);
 	}
 
-	for (tbl = aic3x_i2c_id; tbl->name[0]; tbl++) {
-		if (!strcmp(tbl->name, id->name))
-			break;
-	}
-	aic3x->model = tbl - aic3x_i2c_id;
+	aic3x->model = id->driver_data;
 
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		aic3x->supplies[i].supply = aic3x_supply_names[i];
-- 
1.6.2.5
