From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/13] ASoC: tosa: move gpio probing to machine
	callbacks
Date: Tue, 25 Nov 2008 15:44:49 +0000
Message-ID: <1227627889-8373-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-12-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18BCE24498
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:53 +0100 (CET)
In-Reply-To: <1227627889-8373-12-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/tosa.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 9d9be5a..48242b3 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -230,10 +230,32 @@ static struct snd_soc_dai_link tosa_dai[] = {
 },
 };
 
+static int tosa_probe(struct platform_device *dev)
+{
+	int ret;
+
+	ret = gpio_request(TOSA_GPIO_L_MUTE, "Headphone Jack");
+	if (ret)
+		return ret;
+	ret = gpio_direction_output(TOSA_GPIO_L_MUTE, 0);
+	if (ret)
+		gpio_free(TOSA_GPIO_L_MUTE);
+
+	return ret;
+}
+
+static int tosa_remove(struct platform_device *dev)
+{
+	gpio_free(TOSA_GPIO_L_MUTE);
+	return 0;
+}
+
 static struct snd_soc_card tosa = {
 	.name = "Tosa",
 	.dai_link = tosa_dai,
 	.num_links = ARRAY_SIZE(tosa_dai),
+	.probe = tosa_probe,
+	.remove = tosa_remove,
 };
 
 static struct snd_soc_device tosa_snd_devdata = {
@@ -251,11 +273,6 @@ static int __init tosa_init(void)
 	if (!machine_is_tosa())
 		return -ENODEV;
 
-	ret = gpio_request(TOSA_GPIO_L_MUTE, "Headphone Jack");
-	if (ret)
-		return ret;
-	gpio_direction_output(TOSA_GPIO_L_MUTE, 0);
-
 	tosa_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!tosa_snd_device) {
 		ret = -ENOMEM;
@@ -272,15 +289,12 @@ static int __init tosa_init(void)
 	platform_device_put(tosa_snd_device);
 
 err_alloc:
-	gpio_free(TOSA_GPIO_L_MUTE);
-
 	return ret;
 }
 
 static void __exit tosa_exit(void)
 {
 	platform_device_unregister(tosa_snd_device);
-	gpio_free(TOSA_GPIO_L_MUTE);
 }
 
 module_init(tosa_init);
-- 
1.5.6.5
