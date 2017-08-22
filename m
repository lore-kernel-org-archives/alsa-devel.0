From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ASoC: omap: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:48 +0200
Message-ID: <20170822115951.6679-6-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADCBC2675E0
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:59:55 +0200 (CEST)
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
2.14.0
