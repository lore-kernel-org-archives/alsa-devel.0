From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/8] ASoC: smdk_wm9713: fix resource leak in smdk_init
	error path
Date: Thu, 25 Nov 2010 15:11:45 +0800
Message-ID: <1290669105.30158.16.camel@mola>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290668785.30158.7.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jaswinder Singh Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the error path to properly free allocated resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/smdk_wm9713.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
index 7ce2430..238cb3a 100644
--- a/sound/soc/samsung/smdk_wm9713.c
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -70,24 +70,27 @@ static int __init smdk_init(void)
 
 	ret = platform_device_add(smdk_snd_wm9713_device);
 	if (ret)
-		goto err;
+		goto err1;
 
 	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
 	if (!smdk_snd_ac97_device) {
 		ret = -ENOMEM;
-		goto err;
+		goto err2;
 	}
 
 	platform_set_drvdata(smdk_snd_ac97_device, &smdk);
 
 	ret = platform_device_add(smdk_snd_ac97_device);
-	if (ret) {
-		platform_device_put(smdk_snd_ac97_device);
-		goto err;
-	}
+	if (ret)
+		goto err3;
 
 	return 0;
-err:
+
+err3:
+	platform_device_put(smdk_snd_ac97_device);
+err2:
+	platform_device_del(smdk_snd_wm9713_device);
+err1:
 	platform_device_put(smdk_snd_wm9713_device);
 	return ret;
 }
-- 
1.7.2
