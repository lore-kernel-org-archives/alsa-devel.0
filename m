From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 21/27] sound/soc/au1x: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:54 +0200
Message-ID: <1374602524-3398-22-git-send-email-wsa@the-dreams.de>
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

 sound/soc/au1x/psc-ac97.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a822ab8..986dcec 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -379,9 +379,6 @@ static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	mutex_init(&wd->lock);
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -ENODEV;
-
 	wd->mmio = devm_ioremap_resource(&pdev->dev, iores);
 	if (IS_ERR(wd->mmio))
 		return PTR_ERR(wd->mmio);
-- 
1.7.10.4
