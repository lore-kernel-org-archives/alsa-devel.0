From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: fixup references at soc_cleanup_card_resources()" to the asoc tree
Date: Tue, 28 May 2019 16:07:06 +0100 (BST)
Message-ID: <20190528150706.EEE96440046@finisterre.sirena.org.uk>
References: <87zhn8s60h.wl-kuninori.morimoto.gx@renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <87zhn8s60h.wl-kuninori.morimoto.gx@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.orgLinux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgstable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: fixup references at soc_cleanup_card_resources()

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

>From 29040d1ac569606fece70966179de272cfc0d4db Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 27 May 2019 16:51:34 +0900
Subject: [PATCH] ASoC: soc-core: fixup references at
 soc_cleanup_card_resources()

commit 53e947a0e1f7 ("ASoC: soc-core: merge card resources cleanup
method") merged cleanup method of snd_soc_instantiate_card() and
soc_cleanup_card_resources().

But, after this commit, if user uses unbind/bind to Component factor
drivers, Kernel might indicates refcount error at
soc_cleanup_card_resources().

The 1st reason is card->snd_card is still exist even though
snd_card_free() was called, but it is already cleaned.
We need to set NULL to it.

2nd is card->dapm and card create debugfs, but its dentry is still
exist even though it was removed. We need to set NULL to it.

Fixes: 53e947a0e1f7 ("ASoC: soc-core: merge card resources cleanup method")
Cc: stable@vger.kernel.org # for v5.1
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 7 ++++++-
 sound/soc/soc-dapm.c | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7c9415987ac7..46042d41b79b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -228,7 +228,10 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 {
+	if (!card->debugfs_card_root)
+		return;
 	debugfs_remove_recursive(card->debugfs_card_root);
+	card->debugfs_card_root = NULL;
 }
 
 static void snd_soc_debugfs_init(void)
@@ -2039,8 +2042,10 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 static int soc_cleanup_card_resources(struct snd_soc_card *card)
 {
 	/* free the ALSA card at first; this syncs with pending operations */
-	if (card->snd_card)
+	if (card->snd_card) {
 		snd_card_free(card->snd_card);
+		card->snd_card = NULL;
+	}
 
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 62e27defce56..5fc57af9cb6f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2192,7 +2192,10 @@ static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 
 static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 {
+	if (!dapm->debugfs_dapm)
+		return;
 	debugfs_remove_recursive(dapm->debugfs_dapm);
+	dapm->debugfs_dapm = NULL;
 }
 
 #else
-- 
2.20.1
