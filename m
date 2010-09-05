From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x: Fix null pointer
	dereference when pdata is not set
Date: Sun,  5 Sep 2010 19:10:22 +0300
Message-ID: <1283703022-3730-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 28ED31037F3
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Sep 2010 18:10:02 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1734158ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 05 Sep 2010 09:10:01 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jiri Slaby <jirislaby@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Null pointer dereference will occur from *setup = pdata->setup if pdata
is not set. Fix this by moving assignments from pdata inside non-null case.

Thanks to Jiri Slaby <jirislaby@gmail.com> for noticing.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 8577c50..b317586 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1360,7 +1360,6 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
 	struct aic3x_pdata *pdata = i2c->dev.platform_data;
-	struct aic3x_setup_data *setup = pdata->setup;
 	struct aic3x_priv *aic3x;
 	int ret, i;
 	const struct i2c_device_id *tbl;
@@ -1372,15 +1371,18 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	}
 
 	aic3x->control_data = i2c;
-	aic3x->setup = setup;
 	i2c_set_clientdata(i2c, aic3x);
+	if (pdata) {
+		aic3x->gpio_reset = pdata->gpio_reset;
+		aic3x->setup = pdata->setup;
+	} else {
+		aic3x->gpio_reset = -1;
+	}
 
-	aic3x->gpio_reset = -1;
-	if (pdata && pdata->gpio_reset >= 0) {
-		ret = gpio_request(pdata->gpio_reset, "tlv320aic3x reset");
+	if (aic3x->gpio_reset >= 0) {
+		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
 		if (ret != 0)
 			goto err_gpio;
-		aic3x->gpio_reset = pdata->gpio_reset;
 		gpio_direction_output(aic3x->gpio_reset, 0);
 	}
 
-- 
1.7.1
