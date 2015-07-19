From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs4349: Drop platform data support
Date: Sun, 19 Jul 2015 09:15:38 +0800
Message-ID: <1437268538.11309.3.camel@ingics.com>
References: <1437268463.11309.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C85F5260506
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 03:15:44 +0200 (CEST)
Received: by pdbbh15 with SMTP id bh15so36484414pdb.1
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 18:15:43 -0700 (PDT)
In-Reply-To: <1437268463.11309.1.camel@ingics.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The struct cs4349_platform_data should be defined in a public header in
include/sound/ rather than in sound/soc/codecs folder.
In additional, the platform data support is not properly handled in this
driver so remove it now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4349.c | 7 +------
 sound/soc/codecs/cs4349.h | 7 -------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index eb55889..7befc05 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -45,7 +45,6 @@ static const struct reg_default cs4349_reg_defaults[] = {
 /* Private data for the CS4349 */
 struct  cs4349_private {
 	struct regmap			*regmap;
-	struct cs4349_platform_data	pdata;
 	struct gpio_desc		*reset_gpio;
 	unsigned int			mode;
 	int				rate;
@@ -283,8 +282,7 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct cs4349_private *cs4349;
-	struct cs4349_platform_data *pdata = dev_get_platdata(&client->dev);
-	int ret = 0;
+	int ret;
 
 	cs4349 = devm_kzalloc(&client->dev, sizeof(*cs4349), GFP_KERNEL);
 	if (!cs4349)
@@ -297,9 +295,6 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (pdata)
-		cs4349->pdata = *pdata;
-
 	/* Reset the Device */
 	cs4349->reset_gpio = devm_gpiod_get_optional(&client->dev,
 		"reset", GPIOD_OUT_LOW);
diff --git a/sound/soc/codecs/cs4349.h b/sound/soc/codecs/cs4349.h
index 7effa0a..d58c06a 100644
--- a/sound/soc/codecs/cs4349.h
+++ b/sound/soc/codecs/cs4349.h
@@ -19,13 +19,6 @@
 #ifndef __CS4349_H__
 #define __CS4349_H__
 
-struct cs4349_platform_data {
-
-	/* GPIO for Reset */
-	unsigned int gpio_nreset;
-
-};
-
 /* CS4349 registers addresses */
 #define CS4349_CHIPID		0x01	/* Device and Rev ID, Read Only */
 #define CS4349_MODE		0x02	/* Mode Control */
-- 
2.1.0
