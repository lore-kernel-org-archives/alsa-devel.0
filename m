From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 33/33] sound/soc/kirkwood: don't check resource with devm_ioremap_resource
Date: Thu, 16 May 2013 13:16:01 +0200
Message-ID: <1368702961-4325-34-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/soc/kirkwood/kirkwood-i2s.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index befe68f..4c9dad3 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -471,11 +471,6 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "platform_get_resource failed\n");
-		return -ENXIO;
-	}
-
 	priv->io = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
-- 
1.7.10.4
