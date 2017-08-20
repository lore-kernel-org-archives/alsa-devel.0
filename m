From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 04/12] ASoC: atmel: Remove unnecessary function call
Date: Sun, 20 Aug 2017 13:23:19 +0800
Message-ID: <1503206599-15212-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The function platform_set_drvdata copies the value the variable
card to card->dev->driver_data, then the address of &pdev->dev is
assigned to card->dev in atmel_classd_asoc_card_init, but when
calling snd_soc_register_card,the function
dev_set_drvdata(card->dev, card) will do the same copy operation,
so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/atmel/atmel-classd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index b7ef8c5..0cd7caa 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -652,7 +652,6 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	}
 
 	snd_soc_card_set_drvdata(card, dd);
-	platform_set_drvdata(pdev, card);
 
 	ret = atmel_classd_asoc_card_init(dev, card);
 	if (ret) {
-- 
1.9.1
