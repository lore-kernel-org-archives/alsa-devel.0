From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Remove superfluous
	snd_soc_jack_free_gpios() call" to the asoc tree
Date: Tue, 22 Aug 2017 13:47:30 +0100
Message-ID: <E1dk8ag-0008SN-Sr@finisterre>
References: <20170822115951.6679-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEAD267618
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:47:31 +0200 (CEST)
In-Reply-To: <20170822115951.6679-7-tiwai@suse.de>
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

   ASoC: pxa: Remove superfluous snd_soc_jack_free_gpios() call

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

>From 7676b40606666547544998e5bc9e7f492fa2e13f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 22 Aug 2017 13:59:49 +0200
Subject: [PATCH] ASoC: pxa: Remove superfluous snd_soc_jack_free_gpios() call

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
