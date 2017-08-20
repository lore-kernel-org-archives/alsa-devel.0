From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 05/12] ASoC: atmel: Remove unnecessary function
	call
Date: Sun, 20 Aug 2017 13:25:25 +0800
Message-ID: <1503206725-15454-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id F11C2266BCF
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 07:25:30 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id 83so19543031pgb.4
 for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2017 22:25:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The function platform_set_drvdata copies the value the variable
card to card->dev->driver_data, then the address of &pdev->dev is
assigned to card->dev in atmel_pdmic_asoc_card_init, but when
calling snd_soc_register_card,the function
dev_set_drvdata(card->dev, card) will do the same copy operation,
so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/atmel/atmel-pdmic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index c917df7..8e3d34b 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -694,7 +694,6 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	}
 
 	snd_soc_card_set_drvdata(card, dd);
-	platform_set_drvdata(pdev, card);
 
 	ret = atmel_pdmic_asoc_card_init(dev, card);
 	if (ret) {
-- 
1.9.1
