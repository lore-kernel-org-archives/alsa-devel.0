From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: fsl: Fix error handling if platform_device_add fails
Date: Tue, 20 Sep 2011 15:09:00 +0800
Message-ID: <1316502540.4269.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Call platform_device_put() instead of platform_device_unregister() if
platform_device_add() fails.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/p1022_ds.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 358f0ba..31af405 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -505,7 +505,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	return 0;
 
 error_sound:
-	platform_device_unregister(sound_device);
+	platform_device_put(sound_device);
 error:
 	kfree(machine_data);
 error_alloc:
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index e8849ed..2c064a9 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -506,7 +506,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 
 error:
 	if (sound_device)
-		platform_device_unregister(sound_device);
+		platform_device_put(sound_device);
 
 	kfree(mdata);
 error_put:
-- 
1.7.4.1
