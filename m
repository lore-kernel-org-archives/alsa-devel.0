From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 2/5] Sound: SOC: TAS571x: chip type detection
	via I2C name
Date: Thu, 10 Mar 2016 12:22:38 +0100
Message-ID: <1457608960-16913-2-git-send-email-petr@barix.com>
References: <1457608960-16913-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E2CD5261293
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 12:24:00 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id l68so25477059wml.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 03:24:00 -0800 (PST)
In-Reply-To: <1457608960-16913-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: cernekee@chromium.org, lgirdwood@gmail.com
Cc: petr@barix.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The chip selection was relying only on DT. It was not possible to use the
driver without DT.
This adds the chip type detection from the I2C name, which
allows to use the driver from the platform driver without DT.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Tested-by: Petr Kulhavy <petr@barix.com>
---
 sound/soc/codecs/tas571x.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 346d3da..2a63069 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -390,11 +390,10 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, priv);
 
 	of_id = of_match_device(tas571x_of_match, dev);
-	if (!of_id) {
-		dev_err(dev, "Unknown device type\n");
-		return -EINVAL;
-	}
-	priv->chip = of_id->data;
+	if (of_id)
+		priv->chip = of_id->data;
+	else
+		priv->chip = (void *) id->driver_data;
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk) && PTR_ERR(priv->mclk) != -ENOENT) {
@@ -495,9 +494,9 @@ static const struct of_device_id tas571x_of_match[] = {
 MODULE_DEVICE_TABLE(of, tas571x_of_match);
 
 static const struct i2c_device_id tas571x_i2c_id[] = {
-	{ "tas5711", 0 },
-	{ "tas5717", 0 },
-	{ "tas5719", 0 },
+	{ "tas5711", (kernel_ulong_t) &tas5711_chip },
+	{ "tas5717", (kernel_ulong_t) &tas5717_chip },
+	{ "tas5719", (kernel_ulong_t) &tas5717_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas571x_i2c_id);
-- 
1.9.1
