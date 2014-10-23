From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH] ASoC: jack: update calls to gpiod_get*()
Date: Thu, 23 Oct 2014 17:15:18 +0900
Message-ID: <1414052118-19742-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Add the new flags argument to calls of (devm_)gpiod_get*() and
remove any direction setting code afterwards.

Currently both forms (with or without the flags argument)
are valid thanks to transitional macros in
<linux/gpio/consumer.h>. These macros will be removed once
all consumers are updated and the flags argument will become
compulsary.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 sound/soc/soc-jack.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index ab47fea997a3..f921d0098518 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -309,7 +309,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			/* GPIO descriptor */
 			gpios[i].desc = gpiod_get_index(gpios[i].gpiod_dev,
 							gpios[i].name,
-							gpios[i].idx);
+							gpios[i].idx, GPIOD_IN);
 			if (IS_ERR(gpios[i].desc)) {
 				ret = PTR_ERR(gpios[i].desc);
 				dev_err(gpios[i].gpiod_dev,
@@ -327,17 +327,14 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 				goto undo;
 			}
 
-			ret = gpio_request(gpios[i].gpio, gpios[i].name);
+			ret = gpio_request_one(gpios[i].gpio, GPIOF_IN,
+					       gpios[i].name);
 			if (ret)
 				goto undo;
 
 			gpios[i].desc = gpio_to_desc(gpios[i].gpio);
 		}
 
-		ret = gpiod_direction_input(gpios[i].desc);
-		if (ret)
-			goto err;
-
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
-- 
2.1.2
