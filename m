From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Remove superfluous
	snd_soc_jack_free_gpios() call" to the asoc tree
Date: Tue, 22 Aug 2017 13:47:27 +0100
Message-ID: <E1dk8ad-0008Rc-Da@finisterre>
References: <20170822115951.6679-8-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C84E3267617
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:47:29 +0200 (CEST)
In-Reply-To: <20170822115951.6679-8-tiwai@suse.de>
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

   ASoC: samsung: Remove superfluous snd_soc_jack_free_gpios() call

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

>From 790b82898db2f42e3430ca84ac9bc3bd7ab474ce Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 22 Aug 2017 13:59:50 +0200
Subject: [PATCH] ASoC: samsung: Remove superfluous snd_soc_jack_free_gpios()
 call

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/h1940_uda1380.c  |  9 ---------
 sound/soc/samsung/rx1950_uda1380.c | 10 ----------
 sound/soc/samsung/smartq_wm8987.c  |  9 ---------
 3 files changed, 28 deletions(-)

diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 5f5825faeb2a..051935162d7b 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -170,14 +170,6 @@ static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int h1940_uda1380_card_remove(struct snd_soc_card *card)
-{
-	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
-		hp_jack_gpios);
-
-	return 0;
-}
-
 /* s3c24xx digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link h1940_uda1380_dai[] = {
 	{
@@ -197,7 +189,6 @@ static struct snd_soc_dai_link h1940_uda1380_dai[] = {
 static struct snd_soc_card h1940_asoc = {
 	.name = "h1940",
 	.owner = THIS_MODULE,
-	.remove = h1940_uda1380_card_remove,
 	.dai_link = h1940_uda1380_dai,
 	.num_links = ARRAY_SIZE(h1940_uda1380_dai),
 
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index fa096abe9e75..a064ca7d78c3 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -31,7 +31,6 @@
 #include "s3c24xx-i2s.h"
 
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd);
-static int rx1950_uda1380_card_remove(struct snd_soc_card *card);
 static int rx1950_startup(struct snd_pcm_substream *substream);
 static int rx1950_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params);
@@ -118,7 +117,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static struct snd_soc_card rx1950_asoc = {
 	.name = "rx1950",
 	.owner = THIS_MODULE,
-	.remove = rx1950_uda1380_card_remove,
 	.dai_link = rx1950_uda1380_dai,
 	.num_links = ARRAY_SIZE(rx1950_uda1380_dai),
 
@@ -219,14 +217,6 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int rx1950_uda1380_card_remove(struct snd_soc_card *card)
-{
-	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
-		hp_jack_gpios);
-
-	return 0;
-}
-
 static int __init rx1950_init(void)
 {
 	int ret;
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 425ee2ba37f0..cf0f54e652c1 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -160,14 +160,6 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
-static int smartq_wm8987_card_remove(struct snd_soc_card *card)
-{
-	snd_soc_jack_free_gpios(&smartq_jack, ARRAY_SIZE(smartq_jack_gpios),
-				smartq_jack_gpios);
-
-	return 0;
-}
-
 static struct snd_soc_dai_link smartq_dai[] = {
 	{
 		.name		= "wm8987",
@@ -186,7 +178,6 @@ static struct snd_soc_dai_link smartq_dai[] = {
 static struct snd_soc_card snd_soc_smartq = {
 	.name = "SmartQ",
 	.owner = THIS_MODULE,
-	.remove = smartq_wm8987_card_remove,
 	.dai_link = smartq_dai,
 	.num_links = ARRAY_SIZE(smartq_dai),
 
-- 
2.13.2
