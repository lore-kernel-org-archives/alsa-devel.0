From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add new
	snd_soc_flush_all_delayed_work()" to the asoc tree
Date: Mon, 21 Jan 2019 19:20:27 +0000 (GMT)
Message-ID: <20190121192027.ECC2B1127D00@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1928F267466
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:20:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add new snd_soc_flush_all_delayed_work()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 65462e445f78cb2f9378443be7ba8b7e07300694 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Jan 2019 09:32:37 +0900
Subject: [PATCH] ASoC: soc-core: add new snd_soc_flush_all_delayed_work()

soc-core is calling flush_delayed_work() many times for same purpose.
Same code in many places makes code un-understandable.
This patch adds new snd_soc_flush_all_delayed_work() for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2c63921675d5..eeb794d8a262 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -425,6 +425,14 @@ struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
 
+static void snd_soc_flush_all_delayed_work(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	for_each_card_rtds(card, rtd)
+		flush_delayed_work(&rtd->delayed_work);
+}
+
 static void codec2codec_close_delayed_work(struct work_struct *work)
 {
 	/*
@@ -494,8 +502,7 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	/* close any waiting streams */
-	for_each_card_rtds(card, rtd)
-		flush_delayed_work(&rtd->delayed_work);
+	snd_soc_flush_all_delayed_work(card);
 
 	for_each_card_rtds(card, rtd) {
 
@@ -2228,11 +2235,8 @@ static int soc_probe(struct platform_device *pdev)
 
 static int soc_cleanup_card_resources(struct snd_soc_card *card)
 {
-	struct snd_soc_pcm_runtime *rtd;
-
 	/* make sure any delayed work runs */
-	for_each_card_rtds(card, rtd)
-		flush_delayed_work(&rtd->delayed_work);
+	snd_soc_flush_all_delayed_work(card);
 
 	/* free the ALSA card at first; this syncs with pending operations */
 	snd_card_free(card->snd_card);
@@ -2275,8 +2279,7 @@ int snd_soc_poweroff(struct device *dev)
 	 * Flush out pmdown_time work - we actually do want to run it
 	 * now, we're shutting down so no imminent restart.
 	 */
-	for_each_card_rtds(card, rtd)
-		flush_delayed_work(&rtd->delayed_work);
+	snd_soc_flush_all_delayed_work(card);
 
 	snd_soc_dapm_shutdown(card);
 
-- 
2.20.1
