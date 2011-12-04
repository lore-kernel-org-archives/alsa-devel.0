From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: uda1380: Convert to gpio_request_one()
Date: Mon, 05 Dec 2011 07:58:25 +0800
Message-ID: <1323043105.5179.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 623D41039A8
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 00:58:38 +0100 (CET)
Received: by yws1 with SMTP id 1so4421913yws.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 15:58:36 -0800 (PST)
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
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Using gpio_request_one can make the error handling simpler.

Also remove a redundant "Failed to issue reset" error message.
We already show the error message in uda1380_reset() error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/uda1380.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 3a238cb..c1b05b7 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -732,27 +732,21 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 
 	if (gpio_is_valid(pdata->gpio_reset)) {
-		ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
+		ret = gpio_request_one(pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
+				       "uda1380 reset");
 		if (ret)
 			goto err_out;
-		ret = gpio_direction_output(pdata->gpio_reset, 0);
-		if (ret)
-			goto err_gpio_reset_conf;
 	}
 
 	if (gpio_is_valid(pdata->gpio_power)) {
-		ret = gpio_request(pdata->gpio_power, "uda1380 power");
-		if (ret)
-			goto err_gpio;
-		ret = gpio_direction_output(pdata->gpio_power, 0);
+		ret = gpio_request_one(pdata->gpio_power, GPIOF_OUT_INIT_LOW,
+				   "uda1380 power");
 		if (ret)
-			goto err_gpio_power_conf;
+			goto err_free_gpio;
 	} else {
 		ret = uda1380_reset(codec);
-		if (ret) {
-			dev_err(codec->dev, "Failed to issue reset\n");
-			goto err_reset;
-		}
+		if (ret)
+			goto err_free_gpio;
 	}
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
@@ -776,13 +770,7 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 
 	return 0;
 
-err_reset:
-err_gpio_power_conf:
-	if (gpio_is_valid(pdata->gpio_power))
-		gpio_free(pdata->gpio_power);
-
-err_gpio_reset_conf:
-err_gpio:
+err_free_gpio:
 	if (gpio_is_valid(pdata->gpio_reset))
 		gpio_free(pdata->gpio_reset);
 err_out:
-- 
1.7.5.4
