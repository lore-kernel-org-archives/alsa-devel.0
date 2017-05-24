From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: Fix use-after-free at card unregistration
Date: Wed, 24 May 2017 10:19:45 +0200
Message-ID: <20170524081945.29116-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D4B265142
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 10:19:48 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
2.13.0
