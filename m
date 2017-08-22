From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ASoC: samsung: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:50 +0200
Message-ID: <20170822115951.6679-8-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD5042675DF
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
2.14.0
