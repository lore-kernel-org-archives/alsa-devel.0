From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH v2 2/2] ASoC: palm27x: register card in
	platform_driver probe
Date: Sat, 29 Dec 2012 10:53:18 -0800
Message-ID: <1356807198-14037-3-git-send-email-mikedunn@newsguy.com>
References: <1356807198-14037-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C77E261639
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 19:55:36 +0100 (CET)
In-Reply-To: <1356807198-14037-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marek Vasut <marex@denx.de>, Mike Dunn <mikedunn@newsguy.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Remove creation of an soc-audio device from the machine platform_driver probe
function, and add a call to snd_soc_register_card() instead.

The current code still works, but this mechanism has been deprecated, if I'm not
mistaken.  The ASoC core code produces the warning "ASoC: machine Palm/PXA27x
should use snd_soc_register_card()"

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 sound/soc/pxa/palm27x.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index bb062e6..e1ffcdd 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -144,8 +144,6 @@ static struct snd_soc_card palm27x_asoc = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map)
 };
 
-static struct platform_device *palm27x_snd_device;
-
 static int palm27x_asoc_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -162,27 +160,18 @@ static int palm27x_asoc_probe(struct platform_device *pdev)
 	hs_jack_gpios[0].gpio = ((struct palm27x_asoc_info *)
 			(pdev->dev.platform_data))->jack_gpio;
 
-	palm27x_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!palm27x_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(palm27x_snd_device, &palm27x_asoc);
-	ret = platform_device_add(palm27x_snd_device);
-
-	if (ret != 0)
-		goto put_device;
-
-	return 0;
-
-put_device:
-	platform_device_put(palm27x_snd_device);
+	palm27x_asoc.dev = &pdev->dev;
 
+	ret = snd_soc_register_card(&palm27x_asoc);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 	return ret;
 }
 
 static int palm27x_asoc_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(palm27x_snd_device);
+	snd_soc_unregister_card(&palm27x_asoc);
 	return 0;
 }
 
-- 
1.7.8.6
