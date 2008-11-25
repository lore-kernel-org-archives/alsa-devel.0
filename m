From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] [ASOC] tosa: move gpio probing to machine
	callbacks
Date: Tue, 25 Nov 2008 09:35:21 +0300
Message-ID: <1227594921-13390-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id CD0C41037EB
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 07:35:57 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so922519eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 22:35:57 -0800 (PST)
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/tosa.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index afefe41..69ca79b 100644
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
 static struct snd_soc_machine tosa = {
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
