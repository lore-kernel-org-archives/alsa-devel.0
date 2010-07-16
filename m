From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2 4/4] ASoC: multi-component - S3C - Add WM9713
	platform device
Date: Fri, 16 Jul 2010 15:35:20 +0900
Message-ID: <1279262120-19054-1-git-send-email-sw.youn@samsung.com>
References: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 347ED10395A
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 08:44:58 +0200 (CEST)
In-Reply-To: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

As a requirement of multicodec changes, we need a platform device
for each CODEC. Instead of add that in machine init code, do it here
so a new device is added only if we choose to use it.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Reviewed-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/smdk_wm9713.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 001c2dd..f8aed14 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -60,22 +60,38 @@ static struct snd_soc_card smdk = {
 	.num_links = 1,
 };
 
+static struct platform_device *smdk_snd_wm9713_device;
 static struct platform_device *smdk_snd_ac97_device;
 
 static int __init smdk_init(void)
 {
 	int ret;
 
-	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk_snd_ac97_device)
+	smdk_snd_wm9713_device = platform_device_alloc("wm9713-codec", -1);
+	if (!smdk_snd_wm9713_device)
 		return -ENOMEM;
 
+	ret = platform_device_add(smdk_snd_wm9713_device);
+	if (ret)
+		goto err;
+
+	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_ac97_device) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	platform_set_drvdata(smdk_snd_ac97_device, &smdk);
 
 	ret = platform_device_add(smdk_snd_ac97_device);
-	if (ret)
+	if (ret) {
 		platform_device_put(smdk_snd_ac97_device);
+		goto err;
+	}
 
+	return 0;
+err:
+	platform_device_put(smdk_snd_wm9713_device);
 	return ret;
 }
 
-- 
1.6.2.5
