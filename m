From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4] ASoC: Fix resource leask in goni_wm8994.c
Date: Fri, 26 Nov 2010 14:51:56 +0800
Message-ID: <1290754316.25125.2.camel@mola>
References: <1290754245.25125.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290754245.25125.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Properly free allocated resources in goni_init() error path.
Add missing snd_soc_unregister_dai() in goni_exit().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/goni_wm8994.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index dcfac54..cc8528c 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -283,20 +283,25 @@ static int __init goni_init(void)
 
 	/* register voice DAI here */
 	ret = snd_soc_register_dai(&goni_snd_device->dev, &voice_dai);
-	if (ret)
+	if (ret) {
+		platform_device_put(goni_snd_device);
 		return ret;
+	}
 
 	platform_set_drvdata(goni_snd_device, &goni);
 	ret = platform_device_add(goni_snd_device);
 
-	if (ret)
+	if (ret) {
+		snd_soc_unregister_dai(&goni_snd_device->dev);
 		platform_device_put(goni_snd_device);
+	}
 
 	return ret;
 }
 
 static void __exit goni_exit(void)
 {
+	snd_soc_unregister_dai(&goni_snd_device->dev);
 	platform_device_unregister(goni_snd_device);
 }
 
-- 
1.7.2
