From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ASoC: simple-card: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:46 +0200
Message-ID: <20170822115951.6679-4-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 74B4B2675DA
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
 sound/soc/generic/simple-card.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index dfaf48ff88b0..6959a74a6f49 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -104,12 +104,6 @@ static int asoc_simple_card_init_jack(struct snd_soc_card *card,
 	return 0;
 }
 
-static void asoc_simple_card_remove_jack(struct asoc_simple_jack *sjack)
-{
-	if (gpio_is_valid(sjack->gpio.gpio))
-		snd_soc_jack_free_gpios(&sjack->jack, 1, &sjack->gpio);
-}
-
 static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -493,10 +487,6 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 static int asoc_simple_card_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct simple_card_data *priv = snd_soc_card_get_drvdata(card);
-
-	asoc_simple_card_remove_jack(&priv->hp_jack);
-	asoc_simple_card_remove_jack(&priv->mic_jack);
 
 	return asoc_simple_card_clean_reference(card);
 }
-- 
2.14.0
