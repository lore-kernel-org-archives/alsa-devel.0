From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 22/27] sound/soc/cirrus: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:55 +0200
Message-ID: <1374602524-3398-23-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 sound/soc/cirrus/ep93xx-ac97.c |    3 ---
 sound/soc/cirrus/ep93xx-i2s.c  |    3 ---
 2 files changed, 6 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index ac73c60..2a5cdae 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -363,9 +363,6 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	info->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 17ad70b..f23f331 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -376,9 +376,6 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	info->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
-- 
1.7.10.4
