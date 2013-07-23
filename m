From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 26/27] sound/soc/txx9: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:59 +0200
Message-ID: <1374602524-3398-27-git-send-email-wsa@the-dreams.de>
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

 sound/soc/txx9/txx9aclc-ac97.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 4bcce8a..e0305a1 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -184,9 +184,6 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -EBUSY;
-
 	drvdata->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
-- 
1.7.10.4
