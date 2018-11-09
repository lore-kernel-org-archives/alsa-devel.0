From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: sun8i-codec: fix crash on module removal
Date: Thu,  8 Nov 2018 20:31:35 -0800
Message-ID: <20181109043135.26200-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B860C267B05
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 05:31:42 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so354181pff.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2018 20:31:42 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

drvdata is actually sun8i_codec, not snd_soc_card, so it crashes
when calling snd_soc_card_get_drvdata().

Drop card and scodec vars anyway since we don't need to
disable/unprepare clocks - it's already done by calling
runtime_suspend()

Drop clk_disable_unprepare() calls for the same reason.

Fixes: 36c684936fae7 ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 522a72fde78d..c4196d4e5915 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -605,16 +605,10 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 
 static int sun8i_codec_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct sun8i_codec *scodec = snd_soc_card_get_drvdata(card);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun8i_codec_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(scodec->clk_module);
-	clk_disable_unprepare(scodec->clk_bus);
-
 	return 0;
 }
 
-- 
2.19.1
