From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Remove superfluous
	snd_soc_jack_free_gpios() call" to the asoc tree
Date: Tue, 22 Aug 2017 13:47:41 +0100
Message-ID: <E1dk8ar-0008Uk-PC@finisterre>
References: <20170822115951.6679-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E59A726684C
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:47:42 +0200 (CEST)
In-Reply-To: <20170822115951.6679-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Remove superfluous snd_soc_jack_free_gpios() call

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2661112fcc5fe555130f383a21e6ce5152570403 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 22 Aug 2017 13:59:46 +0200
Subject: [PATCH] ASoC: simple-card: Remove superfluous
 snd_soc_jack_free_gpios() call

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
