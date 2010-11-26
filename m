From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] ASoC: Fix resource leask in smdk_spdif.c
Date: Fri, 26 Nov 2010 14:54:42 +0800
Message-ID: <1290754482.25125.9.camel@mola>
References: <1290754245.25125.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290754245.25125.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Properly free allocated resources in smdk_init() error path.
Add missing platform_device_unregister() in smdk_exit().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/smdk_spdif.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
index fe43eaf..82d17dc 100644
--- a/sound/soc/samsung/smdk_spdif.c
+++ b/sound/soc/samsung/smdk_spdif.c
@@ -183,7 +183,7 @@ static int __init smdk_init(void)
 
 	ret = platform_device_add(smdk_snd_spdif_dit_device);
 	if (ret)
-		goto err2;
+		goto err1;
 
 	smdk_snd_spdif_device = platform_device_alloc("soc-audio", -1);
 	if (!smdk_snd_spdif_device) {
@@ -195,17 +195,21 @@ static int __init smdk_init(void)
 
 	ret = platform_device_add(smdk_snd_spdif_device);
 	if (ret)
-		goto err1;
+		goto err3;
 
 	/* Set audio clock hierarchy manually */
 	ret = set_audio_clock_heirachy(smdk_snd_spdif_device);
 	if (ret)
-		goto err1;
+		goto err4;
 
 	return 0;
-err1:
+err4:
+	platform_device_del(smdk_snd_spdif_device);
+err3:
 	platform_device_put(smdk_snd_spdif_device);
 err2:
+	platform_device_del(smdk_snd_spdif_dit_device);
+err1:
 	platform_device_put(smdk_snd_spdif_dit_device);
 	return ret;
 }
@@ -213,6 +217,7 @@ err2:
 static void __exit smdk_exit(void)
 {
 	platform_device_unregister(smdk_snd_spdif_device);
+	platform_device_unregister(smdk_snd_spdif_dit_device);
 }
 
 module_init(smdk_init);
-- 
1.7.2
