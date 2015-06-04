From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/22] ASoC: tas2552: Make the enable-gpio
	really optional
Date: Thu, 4 Jun 2015 15:22:25 +0300
Message-ID: <1433420571-5421-2-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 959E7266198
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:02 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Do not fail the probe if the enable-gpio is not specifiedbut handle
deferred probe case.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index dfb4ff5cc9ea..ff82f46ba504 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -486,8 +486,12 @@ static int tas2552_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(data->enable_gpio))
-		return PTR_ERR(data->enable_gpio);
+	if (IS_ERR(data->enable_gpio)) {
+		if (PTR_ERR(data->enable_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		data->enable_gpio = NULL;;
+	}
 
 	data->tas2552_client = client;
 	data->regmap = devm_regmap_init_i2c(client, &tas2552_regmap_config);
-- 
2.4.2
