From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: uda1380: Fix missed uda1380_reset
 call if pdata->gpio_power is a valid gpio
Date: Sun, 04 Dec 2011 19:37:32 +0800
Message-ID: <1322998652.12391.3.camel@phoenix>
References: <1322998520.12391.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B6435246D5
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 12:37:39 +0100 (CET)
Received: by iakr3 with SMTP id r3so2683370iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 03:37:39 -0800 (PST)
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

Current code does not call uda1380_reset() in uda1380_probe() if
pdata->gpio_power is a valid gpio. Fix it.

Also remove a redundant "Failed to issue reset" error message.
We already show error message in uda1380_reset() error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I don't has this hardware, I'd appreciate if someone can test this patch.
Axel
 sound/soc/codecs/uda1380.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 3a238cb..7ebfbeb 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -747,14 +747,12 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 		ret = gpio_direction_output(pdata->gpio_power, 0);
 		if (ret)
 			goto err_gpio_power_conf;
-	} else {
-		ret = uda1380_reset(codec);
-		if (ret) {
-			dev_err(codec->dev, "Failed to issue reset\n");
-			goto err_reset;
-		}
 	}
 
+	ret = uda1380_reset(codec);
+	if (ret)
+		goto err_reset;
+
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
 
 	/* power on device */
-- 
1.7.5.4
