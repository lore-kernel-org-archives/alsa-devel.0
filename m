From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: uda1380: Convert to
	gpio_request_one()
Date: Sun, 04 Dec 2011 19:38:53 +0800
Message-ID: <1322998733.12391.4.camel@phoenix>
References: <1322998520.12391.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CD5C246D6
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 12:39:00 +0100 (CET)
Received: by iakr3 with SMTP id r3so2684382iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 03:38:59 -0800 (PST)
In-Reply-To: <1322998520.12391.1.camel@phoenix>
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

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/uda1380.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 7ebfbeb..17ae60f 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -732,21 +732,17 @@ static int uda1380_probe(struct snd_soc_codec *codec)
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
+		ret = gpio_request_one(pdata->gpio_power, GPIOF_OUT_INIT_LOW,
+				       "uda1380 power");
 		if (ret)
 			goto err_gpio;
-		ret = gpio_direction_output(pdata->gpio_power, 0);
-		if (ret)
-			goto err_gpio_power_conf;
 	}
 
 	ret = uda1380_reset(codec);
@@ -775,11 +771,9 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err_reset:
-err_gpio_power_conf:
 	if (gpio_is_valid(pdata->gpio_power))
 		gpio_free(pdata->gpio_power);
 
-err_gpio_reset_conf:
 err_gpio:
 	if (gpio_is_valid(pdata->gpio_reset))
 		gpio_free(pdata->gpio_reset);
-- 
1.7.5.4
