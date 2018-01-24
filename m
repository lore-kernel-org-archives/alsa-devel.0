From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH RESEND] sound: omap-twl4030: do not complain on
 -EPROBE_DEFER when initializing
Date: Wed, 24 Jan 2018 18:20:49 +0100
Message-ID: <20180124172048.GA2095@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBB6266A74
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 18:20:50 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990395AbeAXRUupA6pD (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Wed, 24 Jan 2018 18:20:50 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Don't complain on -EPROBE_DEFER when when initializing, the driver
probe will be retried later.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Note: Just a resend of patch from 9 Nov 2016 as there were no
       reply by then.

 sound/soc/omap/omap-twl4030.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index cccc316743fa..7c1f71884768 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -322,8 +322,10 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, priv);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
-			ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"devm_snd_soc_register_card() failed: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
2.15.1
