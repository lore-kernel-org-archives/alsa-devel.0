From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: Remove superfluous
	snd_soc_jack_free_gpios() call" to the asoc tree
Date: Tue, 22 Aug 2017 13:47:34 +0100
Message-ID: <E1dk8ak-0008TD-Fp@finisterre>
References: <20170822115951.6679-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B56A267626
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:47:35 +0200 (CEST)
In-Reply-To: <20170822115951.6679-6-tiwai@suse.de>
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

   ASoC: omap: Remove superfluous snd_soc_jack_free_gpios() call

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

>From 90c265c65a3216ea236ed8e81d0a8d6411c26e88 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 22 Aug 2017 13:59:48 +0200
Subject: [PATCH] ASoC: omap: Remove superfluous snd_soc_jack_free_gpios() call

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/ams-delta.c    | 10 ----------
 sound/soc/omap/omap-twl4030.c | 13 -------------
 sound/soc/omap/rx51.c         |  9 ---------
 3 files changed, 32 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 16cc95fa4573..6c49f3d6fd96 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -513,15 +513,6 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int ams_delta_card_remove(struct snd_soc_card *card)
-{
-	snd_soc_jack_free_gpios(&ams_delta_hook_switch,
-			ARRAY_SIZE(ams_delta_hook_switch_gpios),
-			ams_delta_hook_switch_gpios);
-
-	return 0;
-}
-
 /* DAI glue - connects codec <--> CPU */
 static struct snd_soc_dai_link ams_delta_dai_link = {
 	.name = "CX20442",
@@ -540,7 +531,6 @@ static struct snd_soc_dai_link ams_delta_dai_link = {
 static struct snd_soc_card ams_delta_audio_card = {
 	.name = "AMS_DELTA",
 	.owner = THIS_MODULE,
-	.remove = ams_delta_card_remove,
 	.dai_link = &ams_delta_dai_link,
 	.num_links = 1,
 
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index a24b0dedabb9..cccc316743fa 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -208,18 +208,6 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int omap_twl4030_card_remove(struct snd_soc_card *card)
-{
-	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
-
-	if (priv->jack_detect > 0)
-		snd_soc_jack_free_gpios(&priv->hs_jack,
-					ARRAY_SIZE(hs_jack_gpios),
-					hs_jack_gpios);
-
-	return 0;
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 	{
@@ -247,7 +235,6 @@ static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 /* Audio machine driver */
 static struct snd_soc_card omap_twl4030_card = {
 	.owner = THIS_MODULE,
-	.remove = omap_twl4030_card_remove,
 	.dai_link = omap_twl4030_dai_links,
 	.num_links = ARRAY_SIZE(omap_twl4030_dai_links),
 
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 3aeb65feaea1..57448bd5ad77 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -311,14 +311,6 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
-static int rx51_card_remove(struct snd_soc_card *card)
-{
-	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios),
-				rx51_av_jack_gpios);
-
-	return 0;
-}
-
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link rx51_dai[] = {
 	{
@@ -361,7 +353,6 @@ static struct snd_soc_codec_conf rx51_codec_conf[] = {
 static struct snd_soc_card rx51_sound_card = {
 	.name = "RX-51",
 	.owner = THIS_MODULE,
-	.remove = rx51_card_remove,
 	.dai_link = rx51_dai,
 	.num_links = ARRAY_SIZE(rx51_dai),
 	.aux_dev = rx51_aux_dev,
-- 
2.13.2
