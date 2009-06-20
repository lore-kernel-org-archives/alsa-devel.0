From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin: convert internal names from
	bf52x to bf5xx
Date: Sat, 20 Jun 2009 11:29:56 -0400
Message-ID: <1245511797-19460-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DCCE24475
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 17:30:10 +0200 (CEST)
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

These drivers aren't BF52x specific, so don't use bf52x in the names.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ad73311.c |   16 ++++++++--------
 sound/soc/blackfin/bf5xx-ssm2602.c |   16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index edfbdc0..9825b71 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -203,23 +203,23 @@ static struct snd_soc_device bf5xx_ad73311_snd_devdata = {
 	.codec_dev = &soc_codec_dev_ad73311,
 };
 
-static struct platform_device *bf52x_ad73311_snd_device;
+static struct platform_device *bf5xx_ad73311_snd_device;
 
 static int __init bf5xx_ad73311_init(void)
 {
 	int ret;
 
 	pr_debug("%s enter\n", __func__);
-	bf52x_ad73311_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!bf52x_ad73311_snd_device)
+	bf5xx_ad73311_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf5xx_ad73311_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf52x_ad73311_snd_device, &bf5xx_ad73311_snd_devdata);
-	bf5xx_ad73311_snd_devdata.dev = &bf52x_ad73311_snd_device->dev;
-	ret = platform_device_add(bf52x_ad73311_snd_device);
+	platform_set_drvdata(bf5xx_ad73311_snd_device, &bf5xx_ad73311_snd_devdata);
+	bf5xx_ad73311_snd_devdata.dev = &bf5xx_ad73311_snd_device->dev;
+	ret = platform_device_add(bf5xx_ad73311_snd_device);
 
 	if (ret)
-		platform_device_put(bf52x_ad73311_snd_device);
+		platform_device_put(bf5xx_ad73311_snd_device);
 
 	return ret;
 }
@@ -227,7 +227,7 @@ static int __init bf5xx_ad73311_init(void)
 static void __exit bf5xx_ad73311_exit(void)
 {
 	pr_debug("%s enter\n", __func__);
-	platform_device_unregister(bf52x_ad73311_snd_device);
+	platform_device_unregister(bf5xx_ad73311_snd_device);
 }
 
 module_init(bf5xx_ad73311_init);
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index bc0cdde..3a00fa4 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -148,24 +148,24 @@ static struct snd_soc_device bf5xx_ssm2602_snd_devdata = {
 	.codec_data = &bf5xx_ssm2602_setup,
 };
 
-static struct platform_device *bf52x_ssm2602_snd_device;
+static struct platform_device *bf5xx_ssm2602_snd_device;
 
 static int __init bf5xx_ssm2602_init(void)
 {
 	int ret;
 
 	pr_debug("%s enter\n", __func__);
-	bf52x_ssm2602_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!bf52x_ssm2602_snd_device)
+	bf5xx_ssm2602_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf5xx_ssm2602_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf52x_ssm2602_snd_device,
+	platform_set_drvdata(bf5xx_ssm2602_snd_device,
 				&bf5xx_ssm2602_snd_devdata);
-	bf5xx_ssm2602_snd_devdata.dev = &bf52x_ssm2602_snd_device->dev;
-	ret = platform_device_add(bf52x_ssm2602_snd_device);
+	bf5xx_ssm2602_snd_devdata.dev = &bf5xx_ssm2602_snd_device->dev;
+	ret = platform_device_add(bf5xx_ssm2602_snd_device);
 
 	if (ret)
-		platform_device_put(bf52x_ssm2602_snd_device);
+		platform_device_put(bf5xx_ssm2602_snd_device);
 
 	return ret;
 }
@@ -173,7 +173,7 @@ static int __init bf5xx_ssm2602_init(void)
 static void __exit bf5xx_ssm2602_exit(void)
 {
 	pr_debug("%s enter\n", __func__);
-	platform_device_unregister(bf52x_ssm2602_snd_device);
+	platform_device_unregister(bf5xx_ssm2602_snd_device);
 }
 
 module_init(bf5xx_ssm2602_init);
-- 
1.6.3.1
