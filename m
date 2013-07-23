From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 23/27] sound/soc/nuc900: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:56 +0200
Message-ID: <1374602524-3398-24-git-send-email-wsa@the-dreams.de>
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

 sound/soc/nuc900/nuc900-ac97.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index f4c2417..8987bf9 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -333,9 +333,6 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	spin_lock_init(&nuc900_audio->lock);
 
 	nuc900_audio->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!nuc900_audio->res)
-		return ret;
-
 	nuc900_audio->mmio = devm_ioremap_resource(&pdev->dev,
 						   nuc900_audio->res);
 	if (IS_ERR(nuc900_audio->mmio))
-- 
1.7.10.4
