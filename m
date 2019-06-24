From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: call snd_soc_unbind_card()
	under mutex_lock; " to the asoc tree
Date: Mon, 24 Jun 2019 17:32:14 +0100 (BST)
Message-ID: <20190624163214.88A0E44005F@finisterre.sirena.org.uk>
References: <878stywfjt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FD21F89705
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 11:53:59 +0200 (CEST)
In-Reply-To: <878stywfjt.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: call snd_soc_unbind_card() under mutex_lock;

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From b545542a0b866f7975254e41c595836e9bc0ff2f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:07:19 +0900
Subject: [PATCH] ASoC: soc-core: call snd_soc_unbind_card() under mutex_lock;

commit 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing
link components") added mutex_lock() at soc_remove_link_components().

Is is called from snd_soc_unbind_card()

	snd_soc_unbind_card()
=>		soc_remove_link_components()
		soc_cleanup_card_resources()
			soc_remove_dai_links()
=>				soc_remove_link_components()

And, there are 2 way to call it.

(1)
	snd_soc_unregister_component()
**		mutex_lock()
			snd_soc_component_del_unlocked()
=>				snd_soc_unbind_card()
**		mutex_unlock()

(2)
	snd_soc_unregister_card()
=>		snd_soc_unbind_card()

(1) case is already using mutex_lock() when it calles
snd_soc_unbind_card(), thus, we will get lockdep warning.

commit 495f926c68ddb90 ("ASoC: core: Fix deadlock in
snd_soc_instantiate_card()") tried to fixup it, but still not
enough. We still have lockdep warning when we try unbind/bind.

We need mutex_lock() under snd_soc_unregister_card()
instead of snd_remove_link_components()/snd_soc_unbind_card().

Fixes: 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing link components")
Fixes: 495f926c68ddb90 ("ASoC: core: Fix deadlock in snd_soc_instantiate_card()")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 41c0cfaf2db5..9138fcb15cd3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2837,14 +2837,12 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
 
-		mutex_lock(&client_mutex);
 		/* remove all components used by DAI links on this card */
 		for_each_comp_order(order) {
 			for_each_card_rtds(card, rtd) {
 				soc_remove_link_components(card, rtd, order);
 			}
 		}
-		mutex_unlock(&client_mutex);
 
 		soc_cleanup_card_resources(card);
 		if (!unregister)
@@ -2863,7 +2861,9 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
  */
 int snd_soc_unregister_card(struct snd_soc_card *card)
 {
+	mutex_lock(&client_mutex);
 	snd_soc_unbind_card(card, true);
+	mutex_unlock(&client_mutex);
 	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 
 	return 0;
-- 
2.20.1
