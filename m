From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 6/8] ASoC: simone: fix resource leak in simone_init error
	path
Date: Thu, 25 Nov 2010 15:12:30 +0800
Message-ID: <1290669150.30158.18.camel@mola>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290668785.30158.7.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the error path to properly free allocated resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/ep93xx/simone.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
index 4b0d199..2868179 100644
--- a/sound/soc/ep93xx/simone.c
+++ b/sound/soc/ep93xx/simone.c
@@ -54,24 +54,26 @@ static int __init simone_init(void)
 
 	ret = platform_device_add(simone_snd_ac97_device);
 	if (ret)
-		goto fail;
+		goto fail1;
 
 	simone_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!simone_snd_device) {
 		ret = -ENOMEM;
-		goto fail;
+		goto fail2;
 	}
 
 	platform_set_drvdata(simone_snd_device, &snd_soc_simone);
 	ret = platform_device_add(simone_snd_device);
-	if (ret) {
-		platform_device_put(simone_snd_device);
-		goto fail;
-	}
+	if (ret)
+		goto fail3;
 
-	return ret;
+	return 0;
 
-fail:
+fail3:
+	platform_device_put(simone_snd_device);
+fail2:
+	platform_device_del(simone_snd_ac97_device);
+fail1:
 	platform_device_put(simone_snd_ac97_device);
 	return ret;
 }
-- 
1.7.2
