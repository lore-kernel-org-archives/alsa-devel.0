From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ASoC: intel: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:47 +0200
Message-ID: <20170822115951.6679-5-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 76CDD2675DC
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:59:54 +0200 (CEST)
In-Reply-To: <20170822115951.6679-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/boards/byt-max98090.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index 047be7fa0ce9..0f8b8209c020 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -173,20 +173,8 @@ static int byt_max98090_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int byt_max98090_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct byt_max98090_private *priv = snd_soc_card_get_drvdata(card);
-
-	snd_soc_jack_free_gpios(&priv->jack, ARRAY_SIZE(hs_jack_gpios),
-				hs_jack_gpios);
-
-	return 0;
-}
-
 static struct platform_driver byt_max98090_driver = {
 	.probe = byt_max98090_probe,
-	.remove = byt_max98090_remove,
 	.driver = {
 		.name = "byt-max98090",
 		.pm = &snd_soc_pm_ops,
-- 
2.14.0
