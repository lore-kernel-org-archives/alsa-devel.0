From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: core: Remove pointless error on card
	registration failure
Date: Thu,  9 Aug 2012 18:51:42 +0100
Message-ID: <1344534702-3601-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1344534702-3601-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C3E22663E9
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 19:22:01 +0200 (CEST)
In-Reply-To: <1344534702-3601-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <linux@arm.linux.org.uk>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we fail to register the card we should say why somewhere else so there's
no point in repeating the same thing with less information.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 97fb881..049daca 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1832,13 +1832,7 @@ static int soc_probe(struct platform_device *pdev)
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to register card\n");
-		return ret;
-	}
-
-	return 0;
+	return snd_soc_register_card(card);
 }
 
 static int soc_cleanup_card_resources(struct snd_soc_card *card)
-- 
1.7.10.4
