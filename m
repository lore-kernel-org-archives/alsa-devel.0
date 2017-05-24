From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Fix use-after-free at card unregistration" to the asoc tree
Date: Wed, 24 May 2017 18:42:12 +0100
Message-ID: <E1dDaIW-0002vA-M4@debutante>
References: <20170524081945.29116-1-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170524081945.29116-1-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgMark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Fix use-after-free at card unregistration

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

>From 4efda5f2130da033aeedc5b3205569893b910de2 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 24 May 2017 10:19:45 +0200
Subject: [PATCH] ASoC: Fix use-after-free at card unregistration

soc_cleanup_card_resources() call snd_card_free() at the last of its
procedure.  This turned out to lead to a use-after-free.
PCM runtimes have been already removed via soc_remove_pcm_runtimes(),
while it's dereferenced later in soc_pcm_free() called via
snd_card_free().

The fix is simple: just move the snd_card_free() call to the beginning
of the whole procedure.  This also gives another benefit: it
guarantees that all operations have been shut down before actually
releasing the resources, which was racy until now.

Reported-and-tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aae099c0e502..754e3ef8d7ae 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2286,6 +2286,9 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	list_for_each_entry(rtd, &card->rtd_list, list)
 		flush_delayed_work(&rtd->delayed_work);
 
+	/* free the ALSA card at first; this syncs with pending operations */
+	snd_card_free(card->snd_card);
+
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
 	soc_remove_pcm_runtimes(card);
@@ -2300,9 +2303,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	if (card->remove)
 		card->remove(card);
 
-	snd_card_free(card->snd_card);
 	return 0;
-
 }
 
 /* removes a socdev */
-- 
2.11.0
