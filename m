From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/8] ASoC: pxa: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:49 +0200
Message-ID: <20170822115951.6679-7-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C242675E4
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
 sound/soc/pxa/hx4700.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index a9ac881c2e14..6cdef5d4954e 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -138,13 +138,6 @@ static int hx4700_ak4641_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
-static int hx4700_card_remove(struct snd_soc_card *card)
-{
-	snd_soc_jack_free_gpios(&hs_jack, 1, &hs_jack_gpio);
-
-	return 0;
-}
-
 /* hx4700 digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link hx4700_dai = {
 	.name = "ak4641",
@@ -163,7 +156,6 @@ static struct snd_soc_dai_link hx4700_dai = {
 static struct snd_soc_card snd_soc_card_hx4700 = {
 	.name			= "iPAQ hx4700",
 	.owner			= THIS_MODULE,
-	.remove			= hx4700_card_remove,
 	.dai_link		= &hx4700_dai,
 	.num_links		= 1,
 	.dapm_widgets		= hx4700_dapm_widgets,
-- 
2.14.0
