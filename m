From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: don't call
	flush_delayed_work() many times in soc_pcm_private_free()" to
	the asoc tree
Date: Wed, 24 Jan 2018 12:10:56 +0000
Message-ID: <E1eeJtI-00088G-G9@debutante>
References: <87a7y7aaqc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 061EC267440
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 13:10:59 +0100 (CET)
In-Reply-To: <87a7y7aaqc.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: don't call flush_delayed_work() many times in soc_pcm_private_free()

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

>From f30a4c313eb6d5027a85869d1ccf626208218ed0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Jan 2018 05:18:46 +0000
Subject: [PATCH] ASoC: soc-pcm: don't call flush_delayed_work() many times in
 soc_pcm_private_free()

commit f523acebbb74 ("ASoC: add Component level pcm_new/pcm_free v2")
added component level pcm_new/pcm_free, but flush_delayed_work()
on soc_pcm_private_free() is called in for_each_rtdcom() loop.
It doesn't need to be called many times.
This patch moves it out of loop.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8075856668c2..998800cc44ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2831,10 +2831,9 @@ static void soc_pcm_private_free(struct snd_pcm *pcm)
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_component *component;
 
+	/* need to sync the delayed work before releasing resources */
+	flush_delayed_work(&rtd->delayed_work);
 	for_each_rtdcom(rtd, rtdcom) {
-		/* need to sync the delayed work before releasing resources */
-
-		flush_delayed_work(&rtd->delayed_work);
 		component = rtdcom->component;
 
 		if (component->pcm_free)
-- 
2.15.1
